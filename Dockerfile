FROM cockroachdb/cockroach:latest

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
    echo "$(<kubectl.sha256) kubectl" | sha256sum --check && \
    rm kubectl.sha256
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN mkdir /k8-cockroach

WORKDIR /k8-cockroach

COPY create-certs.sh .
RUN chmod a+x ./create-certs.sh

CMD ./create-certs.sh
