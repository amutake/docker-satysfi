#!/usr/bin/env bash

eval $(opam env)
ls -la
exec "$@"
