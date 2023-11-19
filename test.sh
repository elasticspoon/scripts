#!/usr/bin/env bash

start_time=$(date +%s.%N)
sleep 1.5
end_time=$(date +%s.%N)

# Calculate elapsed time in milliseconds using shell arithmetic
elapsed_time=$(awk "BEGIN { print int(($end_time - $start_time) * 1000) }")

notify-send "Nix Rebuild" "Nix flake rebuild has completed in ${elapsed_time} milliseconds."
