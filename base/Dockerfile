FROM ubuntu:20.04

# Versions
ENV OCAML_VERSION=4.13.1
ENV OPAM_VERSION=2.1.0

# avoid tzdata hung: https://serverfault.com/a/992421
ENV DEBIAN_FRONTEND=noninteractive

# opam's config vars
# suppress `Running as root is not recommended` warning
ENV OPAMROOTISOK=true
# always `yes`
ENV OPAMYES=true

# Setup opam & OCaml
# cf. https://opam.ocaml.org/doc/Install.html#Binary-distribution
RUN apt-get update \
	&& apt-get install -y curl patch unzip make m4 gcc git rsync pkg-config \
	&& rm -rf /var/lib/apt/lists/*
# currently, x86_64 and arm64 are supported
RUN curl -fsL -o /usr/local/bin/opam https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/opam-${OPAM_VERSION}-$([ $(uname -m) = aarch64 ] && echo arm64 || uname -m)-linux \
	&& chmod a+x /usr/local/bin/opam
RUN opam init --no-setup --disable-sandboxing --compiler=${OCAML_VERSION}
RUN opam install depext

# Setup external repository
RUN opam repo add satysfi-external https://github.com/gfngfn/satysfi-external-repo.git
RUN opam repo add satyrographos-repo https://github.com/na4zagin3/satyrographos-repo.git
