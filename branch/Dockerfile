FROM ghcr.io/amutake/satysfi-base-image:opam-2.1.3-ocaml-4.14.0 AS build-env

ARG BRANCH=master

RUN apt-get update
RUN opam update

# Install Satyrographos
RUN git clone https://github.com/na4zagin3/satyrographos.git /root/satyrographos
WORKDIR /root/satyrographos
RUN opam pin add --no-action --kind local satyrographos .
RUN opam install satyrographos
RUN git describe --tags > /satyrographos-revision
# temporary fix
RUN eval $(opam env) && cp $(which satyrographos) /bin/

# Install SATySFi
# SATySFi (satysfi-dist) installation must be after satyrographos installation
# because $(opam var share)/satysfi is removed due to satysfi reinstallation caused by satyrographos.
# cf. https://github.com/amutake/docker-satysfi/pull/17
RUN git clone https://github.com/gfngfn/SATySFi.git /root/SATySFi
WORKDIR /root/SATySFi
RUN git checkout ${BRANCH}
RUN opam pin add --no-action --kind local satysfi .
RUN opam install satysfi
RUN apt-get update \
    && apt-get install -y wget \
    && ./download-fonts.sh
RUN sed -i -e "s!/usr/local/share!$(opam var share)!" install-libs.sh
RUN ./install-libs.sh $(opam var share)/satysfi
RUN git describe --tags > /satysfi-revision

# Copy binaries
RUN eval $(opam env) && \
    satyrographos install --copy && \
    cp $(which satysfi) / && \
    cp $(which satyrographos) /

# --

FROM ubuntu:24.04

# Copy from build-env
COPY --from=build-env /root/.satysfi /usr/local/share/satysfi
COPY --from=build-env /satysfi /usr/local/bin/satysfi
COPY --from=build-env /satyrographos /usr/local/bin/satyrographos
COPY --from=build-env /satysfi-revision /satysfi-revision
COPY --from=build-env /satyrographos-revision /satyrographos-revision

RUN date --iso-8601=seconds > /build-date

# Check all shared libraries installed
RUN for bin in satysfi satyrographos; do \
    ldd $(which $bin) | grep "not found"; \
    if [ $? -eq 0 ]; then \
    exit 1; \
    fi; \
    done

# Setup build directory
RUN mkdir /satysfi
WORKDIR /satysfi

# OCI Annotations (https://github.com/opencontainers/image-spec/blob/main/annotations.md)
ARG BUILD_DATE
ARG VERSION
ARG REVISION
ARG BRANCH=master
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
    org.opencontainers.image.title="SATySFi ${BRANCH} branch and Satyrographos image without opam environment" \
    org.opencontainers.image.description="SATySFi ${BRANCH} branch and Satyrographos image without opam environment" \
    org.opencontainers.image.ref.name="amutake/satysfi:${IMAGE_TAG}"
