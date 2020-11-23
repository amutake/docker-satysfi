#!/bin/bash

set -eux -o pipefail

apt-get update
# - curl: to get opam binary and opam libraries
# - patch, unzip: to init opam (required)
# - make, gcc: to build ocaml compiler
# - m4, pkg-config: to build opam-bin, satysfi, etc
# - git: to add/update opam repositories
# - rsync: to pin local-bin packages
apt-get install -y curl patch unzip make m4 gcc git rsync
curl -sL -o /usr/local/bin/opam https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/opam-${OPAM_VERSION}-$(uname -m)-linux
chmod a+x /usr/local/bin/opam
opam init --no-setup --disable-sandboxing --bare

# opam-bin requires fresh switch (or all dependencies are in local-bin, maybe).
# In this Dockerfile, plugins switch, build switch, and installation switch are devided.

# === satysfi-plugins switch ===
opam switch create satysfi-plugins ${OCAML_VERSION}
opam install opam-depext
opam depext opam-bin
opam install opam-bin
opam exec -- opam-bin install

# === satysfi-build switch ===
opam switch create satysfi-build ${OCAML_VERSION}
opam repo add satysfi-external-repo https://github.com/gfngfn/satysfi-external-repo.git
opam repo add satyrographos-repo https://github.com/na4zagin3/satyrographos-repo.git
opam depext satysfi.${SATYSFI_VERSION} satysfi-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION}
opam install satysfi.${SATYSFI_VERSION} satysfi-dist.${SATYSFI_VERSION} satyrographos.${SATYROGRAPHOS_VERSION} \
  opam-file-format.2.1.0 # temporary fix. ref: https://github.com/ocaml/opam-file-format/issues/33

# === satysfi switch ===
opam switch create satysfi --empty --repositories=local-bin
opam bin config --base-url $HOME/.opam/plugins/opam-bin/store
opam update

function install_with_no_depends() {
  local package=$1
  local version=$2
  opam pin add ${package} $(opam info ${package} -f url.src: | sed -e 's/"//g') --no-action
  # HACK: force no dependencies
  sed -z 's/depends[^]]*]//' -i ~/.opam/satysfi/.opam-switch/overlay/${package}/opam
  # HACK: force original version
  sed 's/^version: .*$/version: "'"${version}"'"\' -i ~/.opam/satysfi/.opam-switch/overlay/${package}/opam
  opam install ${package}
}

install_with_no_depends satysfi ${SATYSFI_VERSION}
install_with_no_depends satyrographos ${SATYROGRAPHOS_VERSION}
install_with_no_depends satysfi-dist ${SATYSFI_VERSION}
opam config exec -- satyrographos install
opam repo add satyrographos-repo

# === clean ===
opam bin clean
opam bin uninstall
# HACK: restoring .opam/config because `opam bin uninstall` does not consider --disable-sandboxing.
# remove last 4 lines
cp $HOME/.opam/config /tmp/opam.config.bak && head -n -4 /tmp/opam.config.bak > $HOME/.opam/config
opam repo remove local-bin --all
opam repo remove default --all
opam switch remove satysfi-plugins
opam switch remove satysfi-build
opam clean -a -c -r --logs --unused-repositories
# HACK: sources directory contains binary files.
rm -rf $HOME/.opam/satysfi/.opam-switch/sources && mkdir ~/.opam/satysfi/.opam-switch/sources
# HACK: plugins directory contains plugins
rm -rf $HOME/.opam/plugins && mkdir ~/.opam/plugins
# HACK: remove packages that we probably won't use
# TODO: remove tzdata, mime in /usr/share/
apt-get autoremove -y gcc m4 pkg-config
rm -rf /var/lib/apt/lists/*
