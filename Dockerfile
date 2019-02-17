FROM ocaml/opam2:ubuntu-18.04-ocaml-4.07

# Setup SATySFi
RUN opam repository add satysfi-external https://github.com/gfngfn/satysfi-external-repo.git
RUN opam repository add satyrographos-repo https://github.com/na4zagin3/satyrographos-repo.git
RUN opam update
RUN opam depext satysfi satysfi-lib-dist satyrographos
RUN opam install satysfi satysfi-lib-dist satyrographos
RUN eval $(opam env) && satyrographos install

# Setup build directory
RUN mkdir /home/opam/satysfi
WORKDIR /home/opam/satysfi

# Setup entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
