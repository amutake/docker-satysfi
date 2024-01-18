# saphe-experimental

This image contains SATySFi and **Saphe** -- new SATySFi package manager.

## Usage

```sh
cd /path/to/docker-satysfi/saphe-experimental
docker build -t amutake/satysfi:saphe-experimental .

cd /path/to/SATySFi/demo
docker run --rm -it amutake/satysfi:saphe-experimental sh -c "saphe solve demo.saty && saphe build demo.saty"
```
