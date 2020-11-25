FROM ubuntu:20.04

# Versions
ENV OCAML_VERSION=4.11.1
ENV OPAM_VERSION=2.0.7

# avoid tzdata hung: https://serverfault.com/a/992421
ENV DEBIAN_FRONTEND=noninteractive

# opam's config vars
# suppress `Running as root is not recommended` warning
ENV OPAMROOTISOK=true
# always `yes`
ENV OPAMYES=true

# Setup opam & OCaml
# cf. https://opam.ocaml.org/doc/Install.html#Binary-distribution
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl patch unzip make m4 gcc git rsync
# currently, x86_64 and arm64 are supported
RUN curl -fsL -o /usr/local/bin/opam https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/opam-${OPAM_VERSION}-$([ $(uname -m) = aarch64 ] && echo arm64 || uname -m)-linux
RUN chmod a+x /usr/local/bin/opam
RUN opam init --no-setup --disable-sandboxing --compiler=${OCAML_VERSION}
RUN opam install depext

# Setup external repository
RUN opam repository add satysfi-external https://github.com/gfngfn/satysfi-external-repo.git
RUN opam repository add satyrographos-repo https://github.com/na4zagin3/satyrographos-repo.git

# Setup document-writing-related packages
RUN apt-get install -y fontconfig wget
