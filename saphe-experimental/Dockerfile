FROM ghcr.io/amutake/satysfi-base-image:opam-2.1.3-ocaml-4.14.0 AS build-env

ARG REVISION=44ff21be6ffb3675512f0599d5d139809f7c5786

# Install system dependencies
RUN apt-get update
RUN apt-get install -y autoconf

# Install SATySFi and Saphe
RUN git clone https://github.com/gfngfn/SATySFi.git /root/SATySFi
WORKDIR /root/SATySFi
RUN git checkout ${REVISION}
RUN opam pin add --no-action --kind local satysfi-util.dev .
RUN opam pin add --no-action --kind local satysfi-common.dev .
RUN opam pin add --no-action --kind local saphe.dev .
RUN opam pin add --no-action --kind local satysfi.dev .
RUN opam update
RUN opam install saphe satysfi
RUN ./install-libs.sh ~/.saphe install

# Generate metadata
RUN git describe --tags > /satysfi-revision
RUN date --iso-8601=seconds > /build-date

# Copy binaries
# NOTE:
#   This is a dynamic link binary, but there is no problem because the same shared
#   libraries are included even at the runtime stage. check `ldd $(which satysfi)`
RUN eval $(opam env) && \
    cp $(which saphe) / && \
    cp $(which satysfi) /

# --

FROM ubuntu:22.04

# Copy from build-env
COPY --from=build-env /root/.saphe /root/.saphe
COPY --from=build-env /saphe /usr/local/bin/saphe
COPY --from=build-env /satysfi /usr/local/bin/satysfi
COPY --from=build-env /satysfi-revision /satysfi-revision
COPY --from=build-env /build-date /build-date

# Setup runtime dependencies
RUN apt-get update && \
    apt-get install -y git wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Setup build directory
RUN mkdir /satysfi
WORKDIR /satysfi

# OCI Annotations (https://github.com/opencontainers/image-spec/blob/main/annotations.md)
ARG BUILD_DATE
ARG VERSION
ARG REVISION
ARG BRANCH=dev-0-1-0-separate-saphe-from-satysfi
ARG IMAGE_TAG
LABEL org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.authors="amutake" \
    org.opencontainers.image.url="https://github.com/amutake/docker-satysfi" \
    org.opencontainers.image.documentation="https://github.com/amutake/docker-satysfi" \
    org.opencontainers.image.source="https://github.com/amutake/docker-satysfi" \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.revision=$REVISION \
    org.opencontainers.image.vendor="amutake" \
    org.opencontainers.image.licenses="Apache-2.0" \
    org.opencontainers.image.title="SATySFi and Saphe" \
    org.opencontainers.image.description="SATySFi and Saphe" \
    org.opencontainers.image.ref.name="amutake/satysfi:${IMAGE_TAG}"
