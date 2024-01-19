# branch-saphe

This image contains SATySFi and **Saphe** -- new SATySFi package manager.

## Usage

```sh
cd /path/to/docker-satysfi/branch-saphe
docker build -t amutake/satysfi:saphe .

cd /path/to/SATySFi/demo
docker run --rm -it amutake/satysfi:saphe sh -c "saphe solve demo.saty && saphe build demo.saty"
```
