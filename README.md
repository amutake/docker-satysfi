satysfi-docker
==============

[![Build Status](https://github.com/amutake/satysfi-docker/workflows/build/badge.svg)](https://github.com/amutake/satysfi-docker/actions?query=workflow%3Abuild)
[![Nightly Build Status](https://github.com/amutake/satysfi-docker/workflows/nightly/badge.svg)](https://github.com/amutake/satysfi-docker/actions?query=workflow%3Anightly)

This repository provides a docker image for [SATySFi](https://github.com/gfngfn/SATySFi) and [Satyrographos](https://github.com/na4zagin3/satyrographos).

Images are available at [Docker Hub - amutake/satysfi](https://hub.docker.com/r/amutake/satysfi/).

| tag | size | description |
| --- | ---- | ----------- |
| `latest` | [![](https://images.microbadger.com/badges/image/amutake/satysfi.svg)](https://microbadger.com/images/amutake/satysfi "Get your own image badge on microbadger.com") | same as `0.0.3-dev2019.11.16` |
| `slim` | [![](https://images.microbadger.com/badges/image/amutake/satysfi:slim.svg)](https://microbadger.com/images/amutake/satysfi:slim "Get your own image badge on microbadger.com") | same as `0.0.3-dev2019.11.16-slim` |
| `nightly` | [![](https://images.microbadger.com/badges/image/amutake/satysfi:nightly.svg)](https://microbadger.com/images/amutake/satysfi:nightly "Get your own image badge on microbadger.com") | nightly (00:00 in UTC) build of HEAD SATySFi and Satyrographos |
| `0.0.3-dev2019.11.16` | [![](https://images.microbadger.com/badges/image/amutake/satysfi:0.0.3-dev2019.11.16.svg)](https://microbadger.com/images/amutake/satysfi:0.0.3-dev2019.11.16 "Get your own image badge on microbadger.com") | an image for `satysfi.0.0.3+dev2019.11.16` and `satyrographos`, containing full opam environment |
| `0.0.3-dev2019.11.16-slim` | [![](https://images.microbadger.com/badges/image/amutake/satysfi:0.0.3-dev2019.11.16-slim.svg)](https://microbadger.com/images/amutake/satysfi:0.0.3-dev2019.11.16-slim "Get your own image badge on microbadger.com") | an image for `satysfi.0.0.3+dev2019.11.16` and `satyrographos`, without opam environment |
| `0.0.3` | [![](https://images.microbadger.com/badges/image/amutake/satysfi:0.0.3.svg)](https://microbadger.com/images/amutake/satysfi:0.0.3 "Get your own image badge on microbadger.com") | an image for `satysfi.0.0.3` and `satyrographos`, containing full opam environment |
| `0.0.3-slim` | [![](https://images.microbadger.com/badges/image/amutake/satysfi:0.0.3-slim.svg)](https://microbadger.com/images/amutake/satysfi:0.0.3-slim "Get your own image badge on microbadger.com") | an image for `satysfi.0.0.3` and `satyrographos`, without opam environment |


How to use
----------

```
$ docker run --rm -v $(pwd):/satysfi amutake/satysfi:TAG satysfi demo.saty
```

until `0.0.3-dev2019.07.14` (except for `0.0.3`):

```
$ docker run --rm -v $(pwd):/home/opam/satysfi amutake/satysfi:TAG satysfi demo.saty
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
