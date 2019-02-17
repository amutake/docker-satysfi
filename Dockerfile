FROM ocaml/opam2:ubuntu-18.04-ocaml-4.07

# Setup SATySFi
ENV SATYSFI_VERSION=0.0.3
RUN opam repository add satysfi-external https://github.com/gfngfn/satysfi-external-repo.git
RUN opam repository add satyrographos-repo https://github.com/na4zagin3/satyrographos-repo.git
RUN opam update
RUN opam depext satysfi.${SATYSFI_VERSION} satysfi-lib-dist.${SATYSFI_VERSION} satyrographos
RUN sudo apt-get install -y ruby
RUN opam install satysfi.${SATYSFI_VERSION} satysfi-lib-dist.${SATYSFI_VERSION} satyrographos
RUN eval $(opam env) && satyrographos install

# Setup build directory
RUN mkdir /home/opam/satysfi
WORKDIR /home/opam/satysfi

# Setup entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
