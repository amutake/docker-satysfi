FROM ubuntu:18.04

# Versions
ENV OCAML_VERSION=4.09.0
ENV OPAM_VERSION=2.0.5
ENV SATYSFI_VERSION=0.0.3+dev2019.07.14
ENV SATYROGRAPHOS_VERSION=0.0.2.1

# opam's config vars
# suppress `Running as root is not recommended` warning
ENV OPAMROOTISOK=true

# Setup opam & OCaml
# cf. https://opam.ocaml.org/doc/Install.html#Binary-distribution
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl patch unzip make m4 gcc git
RUN curl -sL -o /usr/local/bin/opam https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/opam-${OPAM_VERSION}-$(uname -m)-linux
RUN chmod a+x /usr/local/bin/opam
RUN opam init --no-setup --disable-sandboxing --compiler=${OCAML_VERSION}
RUN opam install -y depext

# Setup SATySFi & Satyrographos
RUN opam repository add satysfi-external https://github.com/gfngfn/satysfi-external-repo.git
RUN opam repository add satyrographos-repo https://github.com/na4zagin3/satyrographos-repo.git
RUN opam depext satysfi.${SATYSFI_VERSION} satysfi-lib-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN opam install -y satysfi.${SATYSFI_VERSION} satysfi-lib-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN opam config exec -- satyrographos install

# Setup document-writing-related packages
RUN apt-get install -y fontconfig

# Setup build directory
RUN mkdir /satysfi
WORKDIR /satysfi

# Setup entrypoint
ENTRYPOINT ["opam", "config", "exec", "--"]
