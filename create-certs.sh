mkdir ./safe-directory

cockroach cert create-ca \
    --certs-dir=certs \
    --ca-key=./safe-directory/ca.key

cockroach cert create-client \
    root \
    --certs-dir=certs \
    --ca-key=./safe-directory/ca.key

kubectl create secret \
    generic $CLUSTER_NAME.client.root \
    --namespace=$CLUSTER_NAMESPACE \
    --from-file=tls.key=certs/client.root.key \
    --from-file=tls.crt=certs/client.root.crt \
    --from-file=ca.crt=certs/ca.crt

cockroach cert create-node \
    localhost 127.0.0.1 \
    $CLUSTER_NAME \
    $CLUSTER_NAME.$CLUSTER_NAMESPACE \
    $CLUSTER_NAME.$CLUSTER_NAMESPACE.$CLUSTER_DOMAIN \
    *.$CLUSTER_NAME \
    *.$CLUSTER_NAME.$CLUSTER_NAMESPACE \
    *.$CLUSTER_NAME.$CLUSTER_NAMESPACE.$CLUSTER_DOMAIN \
    --certs-dir=certs \
    --ca-key=./safe-directory/ca.key

kubectl create secret \
    generic $CLUSTER_NAME.node \
    --namespace=$CLUSTER_NAMESPACE \
    --from-file=tls.key=certs/node.key \
    --from-file=tls.crt=certs/node.crt \
    --from-file=ca.crt=certs/ca.crt

USERS=$(echo $CLUSTER_USERS | tr "," "\n")
for USER in $USERS; do 
    cockroach cert create-client \
        $USER \
        --certs-dir=certs \
        --ca-key=./safe-directory/ca.key

    kubectl create secret \
        generic $CLUSTER_NAME.client.$USER \
        --namespace=$CLUSTER_NAMESPACE \
        --from-file=tls.key=certs/client.$USER.key \
        --from-file=tls.crt=certs/client.$USER.crt \
        --from-file=ca.crt=certs/ca.crt
done
