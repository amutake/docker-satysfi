FROM ghcr.io/amutake/satysfi-base-image:opam-2.0.7-ocaml-4.11.1

# Versions
ENV SATYSFI_VERSION=0.0.5+dev2020.09.05
ENV SATYROGRAPHOS_VERSION=0.0.2.6

# Setup SATySFi & Satyrographos
RUN apt-get update
RUN opam update
RUN opam depext satysfi.${SATYSFI_VERSION} satysfi-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN opam install satysfi.${SATYSFI_VERSION} satysfi-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN opam config exec -- satyrographos install

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
      org.opencontainers.image.title="SATySFi and Satyrographos image with full opam environment" \
      org.opencontainers.image.description="SATySFi and Satyrographos image with full opam environment"
# TODO: add `org.opencontainers.image.ref.name` (but what is this?)

# Setup entrypoint
ENTRYPOINT ["opam", "config", "exec", "--"]
