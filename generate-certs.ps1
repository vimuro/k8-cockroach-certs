docker pull ghcr.io/vimuro/k8-cockroach-certs:master
docker run -v $HOME/.kube/config:/root/.kube/config:ro `
    -e CLUSTER_NAME="uac-database" `
    -e CLUSTER_NAMESPACE="vis-uac-backend" `
    -e CLUSTER_DOMAIN="local" `
    -e CLUSTER_USERS="" `
    ghcr.io/vimuro/k8-cockroach-certs:master

# docker run -v $HOME/.kube/config:/root/.kube/config:ro k8-cockroach ./create-certs.sh