FROM mcr.microsoft.com/azure-cli:2.28.0

ARG TERRAFORMER_VERSION=0.8.19
ARG TERRAFORMER_PROVIDER=azure
RUN curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/${TERRAFORMER_VERSION}/terraformer-${TERRAFORMER_PROVIDER}-linux-amd64 \
    && chmod +x terraformer-${TERRAFORMER_PROVIDER}-linux-amd64 \
    && mv terraformer-${TERRAFORMER_PROVIDER}-linux-amd64 /usr/local/bin/terraformer

ENTRYPOINT [ "/bin/bash" ]