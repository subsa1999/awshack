
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "==> Deploying Kafka consumer..."

sudo k3s kubectl apply -f k8s/deployment.yaml

echo "==> Restarting consumer Pods..."
sudo k3s kubectl rollout restart deployment/kafka-consumer

echo "==> Waiting for rollout..."
sudo k3s kubectl rollout status deployment/kafka-consumer \
    --timeout=120s

echo "==> Current Pods:"
sudo k3s kubectl get pods -l app=kafka-consumer

echo "==> Deployment completed!"