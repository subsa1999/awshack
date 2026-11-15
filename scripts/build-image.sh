
#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="awshack"
IMAGE_TAG="v1"

FULL_IMAGE="docker.io/library/${IMAGE_NAME}:${IMAGE_TAG}"
TAR_FILE="/tmp/${IMAGE_NAME}.tar"

cd "$(dirname "$0")"

echo "==> Building Java application..."
mvn clean package -DskipTests

echo "==> Building Docker image..."
docker build -t "$FULL_IMAGE" .

echo "==> Exporting Docker image..."
docker save "$FULL_IMAGE" -o "$TAR_FILE"

echo "==> Importing image into K3s..."
sudo k3s ctr -n k8s.io images import "$TAR_FILE"

echo "==> Removing temporary archive..."
rm -f "$TAR_FILE"

echo "==> Cleaning up dangling Docker images..."
docker image prune -f

echo "==> Build completed!"
echo "Image: $FULL_IMAGE"