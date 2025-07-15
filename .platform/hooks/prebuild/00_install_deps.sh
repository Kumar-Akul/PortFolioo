#!/bin/bash
# Ensure pip is up to date
/usr/bin/python3 -m pip install --upgrade pip

# Install dependencies from requirements.txt
/usr/bin/python3 -m pip install -r /var/app/staging/requirements.txt