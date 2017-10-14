#!/bin/bash
mix local.hex --force &&
mix local.rebar --force &&
rm -rf ./_build &&
rm -rf ./deps &&
mix deps.get &&
MIX_ENV=prod mix release
