#!/bin/bash

set -eux -o pipefail

# opam-bin requires fresh switch (or all dependencies are in local-bin, maybe).
# In this Dockerfile, plugins switch, build switch, and installation switch are devided.

# === plugins switch ===
opam switch create plugins ${OCAML_VERSION}
opam install opam-depext
apt-get update && opam depext opam-bin && rm -rf /var/lib/apt/lists/*
opam install opam-bin
opam exec -- opam-bin install

# === $OCAML_VERSION switch ===
opam switch create ${OCAML_VERSION}
opam repo add satysfi-external-repo https://github.com/gfngfn/satysfi-external-repo.git
opam repo add satyrographos-repo https://github.com/na4zagin3/satyrographos-repo.git
apt-get update && \
  opam depext satysfi.${SATYSFI_VERSION} satysfi-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION} && \
  rm -rf /var/lib/apt/lists/*
opam install satysfi.${SATYSFI_VERSION} satysfi-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION} \
  opam-file-format.2.1.0 # temporary fix. ref: https://github.com/ocaml/opam-file-format/issues/33

# === satysfi switch ===
opam switch create satysfi --empty --repositories=local-bin
opam bin config --base-url $HOME/.opam/plugins/opam-bin/store
opam update

function install_with_no_depends() {
  local package=$1
  opam pin add ${package} $(opam info ${package} -f url.src: | sed -e 's/"//g') --no-action
  sed -z 's/depends[^]]*]//' -i ~/.opam/satysfi/.opam-switch/overlay/${package}/opam
  opam install ${package}
}

install_with_no_depends satysfi
install_with_no_depends satyrographos
opam install satysfi-dist
opam config exec -- satyrographos install

# === clean ===

opam bin clean
# NOTE: I want to run `opam bin uninstall` but `opam bin uninstall` does not consider --disable-sandboxing
# hack.
# `opam bin install` creates config.1, `opam bin uninstall` creates config.2, so
# `cp config.2 config` means reset to before opam-bin
# cp ~/.opam/config.2 ~/.opam/config
opam repo add satyrographos-repo
opam repo remove local-bin --all
opam repo remove default --all
opam switch remove plugins
opam switch remove ${OCAML_VERSION}
opam clean -a -c -r --logs --unused-repositories
# hack. sources directory contains binary files.
rm -rf $HOME/.opam/satysfi/.opam-switch/sources && mkdir ~/.opam/satysfi/.opam-switch/sources
