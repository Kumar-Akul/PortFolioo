from storages.backends.s3boto3 import S3Boto3Storage

class StaticStorage(S3Boto3Storage):
    location = 'static' # Folder name in your S3 bucket
    default_acl = 'public-read' # Make static files publicly readable

class MediaStorage(S3Boto3Storage):
    location = 'media' # Folder name in your S3 bucket
    default_acl = 'private' # Keep media files private by default
    file_overwrite = False # Don't overwrite existing files with same name