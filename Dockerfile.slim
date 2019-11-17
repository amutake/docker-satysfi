FROM amutake/satysfi-base:opam-2.0.5-ocaml-4.09.0 AS build-env

# Versions
ENV SATYSFI_VERSION=0.0.3+dev2019.11.16
ENV SATYROGRAPHOS_VERSION=0.0.2.1

# Setup SATySFi & Satyrographos
RUN opam update
RUN opam depext satysfi.${SATYSFI_VERSION} satysfi-lib-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN opam install satysfi.${SATYSFI_VERSION} satysfi-lib-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN eval $(opam env) && \
  satyrographos install -copy && \
  cp $(which satysfi) / && \
  cp $(which satyrographos) /

# --

FROM ubuntu:18.04

# Copy from build-env
COPY --from=build-env /root/.satysfi /usr/local/share/satysfi
COPY --from=build-env /satysfi /usr/local/bin/satysfi
COPY --from=build-env /satyrographos /usr/local/bin/satyrographos

# Setup build directory
RUN mkdir /satysfi
WORKDIR /satysfi
