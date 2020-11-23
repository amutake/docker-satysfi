FROM ubuntu:20.04

# Versions
ENV OCAML_VERSION=4.11.1
ENV OPAM_VERSION=2.0.7
ENV SATYSFI_VERSION=0.0.5+dev2020.09.05
ENV SATYROGRAPHOS_VERSION=0.0.2.8

# avoid tzdata hung: https://serverfault.com/a/992421
ENV DEBIAN_FRONTEND=noninteractive

# opam's config vars
# suppress `Running as root is not recommended` warning
ENV OPAMROOTISOK=true
# always `yes`
ENV OPAMYES=true

# Run init script
COPY init.sh /tmp/init.sh
RUN /tmp/init.sh

# Setup build directory
RUN mkdir /satysfi
WORKDIR /satysfi

# OCI Annotations (https://github.com/opencontainers/image-spec/blob/master/annotations.md)
ARG BUILD_DATE
ARG VERSION
ARG REVISION
LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.authors="amutake" \
      org.opencontainers.image.url="https://github.com/amutake/satysfi-docker" \
      org.opencontainers.image.documentation="https://github.com/amutake/satysfi-docker" \
      org.opencontainers.image.source="https://github.com/amutake/satysfi-docker" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.revision=$REVISION \
      org.opencontainers.image.vendor="amutake" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.title="SATySFi and Satyrographos image with empty opam environment" \
      org.opencontainers.image.description="SATySFi and Satyrographos image with empty opam environment"
# TODO: add `org.opencontainers.image.ref.name` (but what is this?)

# Setup entrypoint
ENTRYPOINT ["opam", "exec", "--"]
