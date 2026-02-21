#!/usr/bin/env bash

plugin_path="$HOME/.config/zellij/zjstatus.wasm"
if [[ -f $plugin_path ]]; then
    exit
fi

curl -L -o $plugin_path https://github.com/dj95/zjstatus/releases/download/v0.17.0/zjstatus.wasm
