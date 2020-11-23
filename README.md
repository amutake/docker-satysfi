satysfi-docker
==============

[![Build Status](https://github.com/amutake/satysfi-docker/workflows/build/badge.svg)](https://github.com/amutake/satysfi-docker/actions?query=workflow%3Abuild)
[![Nightly Build Status](https://github.com/amutake/satysfi-docker/workflows/nightly/badge.svg)](https://github.com/amutake/satysfi-docker/actions?query=workflow%3Anightly)

This repository provides a docker image for [SATySFi](https://github.com/gfngfn/SATySFi) and [Satyrographos](https://github.com/na4zagin3/satyrographos).

Images are available at [Docker Hub - amutake/satysfi](https://hub.docker.com/r/amutake/satysfi/).

| tag | size | description |
| --- | ---- | ----------- |
| `latest` | [![Custom badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fdocker-hub-shields-io-xvyqxicwkq-uc.a.run.app%2Famutake%2Fsatysfi%2Flatest)](https://microbadger.com/images/amutake/satysfi "Get your own image badge on microbadger.com") | same as `0.0.5-dev2020.09.05` |
| `slim` | [![Custom badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fdocker-hub-shields-io-xvyqxicwkq-uc.a.run.app%2Famutake%2Fsatysfi%2Fslim)](https://microbadger.com/images/amutake/satysfi:slim "Get your own image badge on microbadger.com") | same as `0.0.5-dev2020.09.05-slim` |
| `opam-slim` | [![Custom badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fdocker-hub-shields-io-xvyqxicwkq-uc.a.run.app%2Famutake%2Fsatysfi%2Fopam-slim)](https://microbadger.com/images/amutake/satysfi:opam-slim "Get your own image badge on microbadger.com") | **EXPERIMENTAL** same as `0.0.5-dev2020.09.05-opam-slim` |
| `nightly` | [![Custom badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fdocker-hub-shields-io-xvyqxicwkq-uc.a.run.app%2Famutake%2Fsatysfi%2Fnightly)](https://microbadger.com/images/amutake/satysfi:nightly "Get your own image badge on microbadger.com") | nightly (00:00 in UTC) build of HEAD SATySFi and Satyrographos |
| `0.0.5-dev2020.09.05` | [![Custom badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fdocker-hub-shields-io-xvyqxicwkq-uc.a.run.app%2Famutake%2Fsatysfi%2F0.0.5-dev2020.09.05)](https://microbadger.com/images/amutake/satysfi:0.0.5-dev2020.09.05 "Get your own image badge on microbadger.com") | an image for `satysfi.0.0.5+dev2020.09.05` and `satyrographos`, containing full opam environment |
| `0.0.5-dev2020.09.05-slim` | [![Custom badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fdocker-hub-shields-io-xvyqxicwkq-uc.a.run.app%2Famutake%2Fsatysfi%2F0.0.5-dev2020.09.05-slim)](https://microbadger.com/images/amutake/satysfi:0.0.5-dev2020.09.05-slim "Get your own image badge on microbadger.com") | an image for `satysfi.0.0.5+dev2020.09.05` and `satyrographos`, without opam environment |
| `0.0.5-dev2020.09.05-opam-slim` | [![Custom badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fdocker-hub-shields-io-xvyqxicwkq-uc.a.run.app%2Famutake%2Fsatysfi%2F0.0.5-dev2020.09.05-opam-slim)](https://microbadger.com/images/amutake/satysfi:0.0.5-dev2020.09.05-opam-slim "Get your own image badge on microbadger.com") | **EXPERIMENTAL** an image for `satysfi.0.0.5+dev2020.09.05` and `satyrographos`, containing empty opam environment |
| `0.0.5` | [![Custom badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fdocker-hub-shields-io-xvyqxicwkq-uc.a.run.app%2Famutake%2Fsatysfi%2F0.0.5)](https://microbadger.com/images/amutake/satysfi:0.0.5 "Get your own image badge on microbadger.com") | an image for `satysfi.0.0.5` and `satyrographos`, containing full opam environment |
| `0.0.5-slim` | [![Custom badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fdocker-hub-shields-io-xvyqxicwkq-uc.a.run.app%2Famutake%2Fsatysfi%2F0.0.5-slim)](https://microbadger.com/images/amutake/satysfi:0.0.5-slim "Get your own image badge on microbadger.com") | an image for `satysfi.0.0.5` and `satyrographos`, without opam environment |


How to use
----------

```
$ docker run --rm -v $(pwd):/satysfi amutake/satysfi:${TAG} satysfi demo.saty
```

latest and opam-slim tag:

```
$ docker run --rm -v $(pwd):/satysfi amutake/satysfi:${TAG} sh -c "opam update && opam install satysfi-base && satyrographos install && satysfi demo.saty"
```

nightly tag:

```
$ docker run --rm amutake/satysfi:nightly cat /satysfi-revision
v0.0.3-397-g6137f5c
$ docker run --rm amutake/satysfi:nightly cat /satyrographos-revision
v0.0.1.6-4-geaf14c8
$ docker run --rm amutake/satysfi:nightly cat /build-date
2019-04-19T00:00:00+00:00
```
