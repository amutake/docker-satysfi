FROM ghcr.io/amutake/satysfi-base-image:opam-2.0.7-ocaml-4.11.1 AS build-env

# Versions
ENV SATYSFI_VERSION=0.0.6-43-ga86452bc
ENV SATYROGRAPHOS_VERSION=0.0.2.10

# Setup SATySFi & Satyrographos
RUN apt-get update
RUN opam update
RUN opam depext satysfi.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN opam install satysfi.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
RUN eval $(opam env) && cp $(which satysfi) / && cp $(which satyrographos) /

# --

FROM ubuntu:20.04

# Versions
ENV OPAM_VERSION=2.0.7
ENV SATYSFI_VERSION=0.0.6-43-ga86452bc
ENV SATYROGRAPHOS_VERSION=0.0.2.10

# opam's config vars
# suppress `Running as root is not recommended` warning
ENV OPAMROOTISOK=true
# always `yes`
ENV OPAMYES=true

# Setup empty opam environment with satyrographos-repo
RUN apt-get update \
      # - curl: to get opam binary and opam libraries
      # - patch, unzip: to init opam (required)
      # - make: to build satyrographos packages
      # - git: to add/update opam repositories
      # - rsync: to pin local-bin packages
      && apt-get install -y curl patch unzip make git rsync \
      && rm -rf /var/lib/apt/lists/*
RUN curl -fsL -o /usr/local/bin/opam https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/opam-${OPAM_VERSION}-$([ $(uname -m) = aarch64 ] && echo arm64 || uname -m)-linux \
      && chmod a+x /usr/local/bin/opam
RUN opam init --no-setup --disable-sandboxing --bare satyrographos-repo https://github.com/na4zagin3/satyrographos-repo.git
RUN opam switch create satysfi --empty

# Force-install satysfi and satyrographos
# HACK: overwrites build, install, remove, and depends field empty.
# This will be broken when the field order of satysfi/satyrographos's opam file is changed.
RUN opam pin add satysfi $HOME/.opam/repo/satyrographos-repo/packages/satysfi/satysfi.${SATYSFI_VERSION} --no-action \
      && sed -z 's/build.*\n]//' -i ~/.opam/satysfi/.opam-switch/overlay/satysfi/opam \
      && opam install satysfi \
      && opam clean -a -c -r --logs --unused-repositories
# Because satyrographos is in default repo, add and remove default repo in a RUN to reduce image size.
RUN opam repo add default https://opam.ocaml.org \
      && opam pin add satyrographos $HOME/.opam/repo/default/packages/satyrographos/satyrographos.${SATYROGRAPHOS_VERSION} --no-action \
      && sed -z 's/build.*\n]//' -i ~/.opam/satysfi/.opam-switch/overlay/satyrographos/opam \
      && opam install satyrographos \
      && opam repo remove default \
      && opam clean -a -c -r --logs --unused-repositories

# Copy binaries from build-env
COPY --from=build-env /satysfi /usr/local/bin/satysfi
COPY --from=build-env /satyrographos /usr/local/bin/satyrographos

# Install satysfi-dist
RUN opam install satysfi-dist.${SATYSFI_VERSION} \
      && opam clean -a -c -r --logs --unused-repositories \
      # HACK: sources directory contains duplicated dist files
      && rm -rf $HOME/.opam/satysfi/.opam-switch/sources/satysfi-dist.${SATYSFI_VERSION}
RUN satyrographos install

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
      org.opencontainers.image.title="SATySFi and Satyrographos image with empty opam environment" \
      org.opencontainers.image.description="SATySFi and Satyrographos image with empty opam environment"
# TODO: add `org.opencontainers.image.ref.name` (but what is this?)

# Setup entrypoint
ENTRYPOINT ["opam", "exec", "--"]
