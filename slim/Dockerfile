FROM ghcr.io/amutake/satysfi-base-image:opam-2.1.3-ocaml-4.14.0 AS build-env

# Versions
ENV SATYSFI_VERSION=0.0.8
ENV SATYROGRAPHOS_VERSION=0.0.2.11

# Setup SATySFi & Satyrographos
RUN apt-get update
RUN opam update
RUN opam install satysfi.${SATYSFI_VERSION} satysfi-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN eval $(opam env) && \
  satyrographos install --copy && \
  cp $(which satysfi) / && \
  cp $(which satyrographos) /

# --

FROM ubuntu:22.04

# Copy from build-env
COPY --from=build-env /root/.satysfi /usr/local/share/satysfi
COPY --from=build-env /satysfi /usr/local/bin/satysfi
COPY --from=build-env /satyrographos /usr/local/bin/satyrographos

# Setup build directory
RUN mkdir /satysfi
WORKDIR /satysfi

# OCI Annotations (https://github.com/opencontainers/image-spec/blob/master/annotations.md)
ARG BUILD_DATE
ARG VERSION
ARG REVISION
LABEL org.opencontainers.image.created=$BUILD_DATE \
  org.opencontainers.image.authors="amutake" \
  org.opencontainers.image.url="https://github.com/amutake/docker-satysfi" \
  org.opencontainers.image.documentation="https://github.com/amutake/docker-satysfi" \
  org.opencontainers.image.source="https://github.com/amutake/docker-satysfi" \
  org.opencontainers.image.version=$VERSION \
  org.opencontainers.image.revision=$REVISION \
  org.opencontainers.image.vendor="amutake" \
  org.opencontainers.image.licenses="Apache-2.0" \
  org.opencontainers.image.title="SATySFi and Satyrographos image without opam environment" \
  org.opencontainers.image.description="SATySFi and Satyrographos image without opam environment"
# TODO: add `org.opencontainers.image.ref.name` (but what is this?)
