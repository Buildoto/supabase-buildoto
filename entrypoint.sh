#!/bin/sh
set -e

# Wait for MinIO to be ready
until mc alias set myminio http://supabase-minio:9000 "$MINIO_ROOT_USER" "$MINIO_ROOT_PASSWORD"; do
  echo "Waiting for MinIO..."
  sleep 2
done

# Create the 'stub' bucket if it doesn't exist
if ! mc ls myminio/stub > /dev/null 2>&1; then
  mc mb myminio/stub
  echo "Bucket 'stub' created."
else
  echo "Bucket 'stub' already exists."
fi
