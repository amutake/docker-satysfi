satysfi-docker
==============

[![Build Status](https://travis-ci.com/amutake/satysfi-docker.svg?branch=master)](https://travis-ci.com/amutake/satysfi-docker) [![CircleCI](https://circleci.com/gh/amutake/satysfi-docker.svg?style=svg)](https://circleci.com/gh/amutake/satysfi-docker)

This repository provides a docker image for [SATySFi](https://github.com/gfngfn/SATySFi) and [Satyrographos](https://github.com/na4zagin3/satyrographos).

Images are available at [Docker Hub - amutake/satysfi](https://hub.docker.com/r/amutake/satysfi/).

| tag | size | description |
| --- | ---- | ----------- |
| `latest` | [![](https://images.microbadger.com/badges/image/amutake/satysfi.svg)](https://microbadger.com/images/amutake/satysfi "Get your own image badge on microbadger.com") | same as `0.0.3-dev2019.03.10` |
| `slim` | [![](https://images.microbadger.com/badges/image/amutake/satysfi:slim.svg)](https://microbadger.com/images/amutake/satysfi:slim "Get your own image badge on microbadger.com") | slim image containing only satysfi and satyrographos binary, the version is same as `latest` |
| `nightly` | [![](https://images.microbadger.com/badges/image/amutake/satysfi:nightly.svg)](https://microbadger.com/images/amutake/satysfi:nightly "Get your own image badge on microbadger.com") | nightly (00:00 in UTC) build of HEAD SATySFi and Satyrographos |
| `0.0.3-dev2019.03.10` | [![](https://images.microbadger.com/badges/image/amutake/satysfi:0.0.3-dev2019.03.10.svg)](https://microbadger.com/images/amutake/satysfi:0.0.3-dev2019.03.10 "Get your own image badge on microbadger.com") | an image for `satysfi.0.0.3+dev2019.03.10`, containing full opam environment |
| `0.0.3` | [![](https://images.microbadger.com/badges/image/amutake/satysfi:0.0.3.svg)](https://microbadger.com/images/amutake/satysfi:0.0.3 "Get your own image badge on microbadger.com") | an image for `satysfi.0.0.3`, containing full opam environment |


How to use
----------

non-slim tags:

```
$ docker run --rm -v $(pwd):/home/opam/satysfi amutake/satysfi satysfi demo.saty
```

slim tags:

```
$ docker run --rm -v $(pwd):/satysfi amutake/satysfi:slim satysfi demo.saty
```

nightly tag:

```
$ docker run --rm amutake/satysfi:nightly cat /satysfi-revision
v0.0.3-397-g6137f5c
$ docker run --rm amutake/satysfi:nightly cat /satyrographos-revision
v0.0.1.6-4-geaf14c8
$ docker run --rm amutake/satysfi:nightly cat /build-date
2019-04-19T00:00:00+00:00
$ docker run --rm -v $(pwd):/satysfi amutake/satysfi:nightly satysfi demo.saty
```
