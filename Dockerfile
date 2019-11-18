FROM amutake/satysfi-base:opam-2.0.5-ocaml-4.09.0

# OCI image-spec (https://github.com/opencontainers/image-spec/blob/master/annotations.md)
ARG REVISION
LABEL org.opencontainers.image.revision=$REVISION \
      org.opencontainers.image.source="https://github.com/amutake/satysfi-docker"

# Versions
ENV SATYSFI_VERSION=0.0.3+dev2019.11.16
ENV SATYROGRAPHOS_VERSION=0.0.2.1

# Setup SATySFi & Satyrographos
RUN opam update
RUN opam depext satysfi.${SATYSFI_VERSION} satysfi-lib-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN opam install satysfi.${SATYSFI_VERSION} satysfi-lib-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN opam config exec -- satyrographos install

# Setup build directory
RUN mkdir /satysfi
WORKDIR /satysfi

# Setup entrypoint
ENTRYPOINT ["opam", "config", "exec", "--"]
