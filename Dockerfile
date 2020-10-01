FROM amutake/satysfi-base:opam-2.0.6-ocaml-4.10.0

# Versions
ENV SATYSFI_VERSION=0.0.5+dev2020.09.05
ENV SATYROGRAPHOS_VERSION=0.0.2.6

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

# Setup SATySFi & Satyrographos
RUN opam update
RUN opam depext satysfi.${SATYSFI_VERSION} satysfi-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN opam install satysfi.${SATYSFI_VERSION} satysfi-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN opam config exec -- satyrographos install

# Setup build directory
RUN mkdir /satysfi
WORKDIR /satysfi

# Setup entrypoint
ENTRYPOINT ["opam", "config", "exec", "--"]
