#!/usr/bin/env sh

set -eu;

printf "Cleaning all created clusters...\n"
k3d cluster delete all --all

printf "\n"
printf "Success!\n"
printf "\n"
