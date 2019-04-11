satysfi-docker
==============

This repository provides a docker image for [SATySFi](https://github.com/gfngfn/SATySFi) and [Satyrographos](https://github.com/na4zagin3/satyrographos).

Images are available at [Docker Hub - amutake/satysfi](https://hub.docker.com/r/amutake/satysfi/).

| tag | size | description |
| --- | ---- | ----------- |
| `latest` | [![](https://images.microbadger.com/badges/image/amutake/satysfi.svg)](https://microbadger.com/images/amutake/satysfi "Get your own image badge on microbadger.com") | same as `0.0.3-dev2019.03.10` |
| `slim` | | slim image containing only satysfi and satyrographos binary |
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
