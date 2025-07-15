#!/bin/bash

# Log start of script
echo "--- Starting 00_install_deps.sh script ---"

# Output current Python version
echo "Python version on EB instance:"
/usr/bin/python3 --version

# Ensure pip is up to date (use full path to avoid ambiguity)
echo "Upgrading pip..."
/usr/bin/python3 -m pip install --upgrade pip 2>&1 | tee /tmp/pip_upgrade.log
if [ $? -ne 0 ]; then
    echo "ERROR: pip upgrade failed. See /tmp/pip_upgrade.log"
    exit 1
fi
echo "Pip upgrade complete."

# Install dependencies from requirements.txt
# Use full path for pip and requirements.txt
# Redirect stdout and stderr to a log file for debugging
echo "Installing dependencies from requirements.txt..."
/usr/bin/python3 -m pip install -r /var/app/staging/requirements.txt --no-deps 2>&1 | tee /tmp/pip_install.log
# --no-deps is an advanced option for debugging, use this if pip install without it also fails.
# If the problem is dependencies pulling other dependencies, --no-deps will isolate it.
# If it's still failing, revert to:
# /usr/bin/python3 -m pip install -r /var/app/staging/requirements.txt 2>&1 | tee /tmp/pip_install.log


# Check exit code of pip install
if [ $? -ne 0 ]; then
    echo "ERROR: pip install failed. See /tmp/pip_install.log for details."
    cat /tmp/pip_install.log # Print the log to stdout/eb-engine.log directly
    exit 1 # Fail the deployment if pip install fails
fi
echo "Dependencies installed successfully."

echo "--- 00_install_deps.sh script finished ---"