#!/bin/bash
docker pull elixir:1.5.2
docker run -it --rm \
  -v "$PWD":/usr/src/studio_superadmin \
  -w /usr/src/studio_superadmin \
  elixir:1.5.2 \
  ./build_inside_container.sh
