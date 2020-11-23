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

COPY init.sh /tmp/init.sh
RUN /tmp/init.sh

RUN mkdir /satysfi
WORKDIR /satysfi

# Setup entrypoint
ENTRYPOINT ["opam", "exec", "--"]
