$CLUSTER_NAME = Read-Host "Name of the cockroachdb-cluster: "
$CLUSTER_NAMESPACE = Read-Host "Namespace of the cockroachdb-cluster (e.g. default): "
$CLUSTER_DOMAIN = Read-Host "Domain of the kubernetes-cluster (e.g. local): "
$CLUSTER_USERS = Read-Host "Users for which the certificates should be generated (all users different from root, e.g. admin): "

docker pull ghcr.io/vimuro/k8-cockroach-certs:master
docker run -v $HOME/.kube/config:/root/.kube/config:ro `
    -e CLUSTER_NAME="$CLUSTER_NAME" `
    -e CLUSTER_NAMESPACE="$CLUSTER_NAMESPACE" `
    -e CLUSTER_DOMAIN="$CLUSTER_DOMAIN" `
    -e CLUSTER_USERS="$CLUSTER_USERS" `
    ghcr.io/vimuro/k8-cockroach-certs:master

# docker run -v $HOME/.kube/config:/root/.kube/config:ro k8-cockroach ./create-certs.sh
