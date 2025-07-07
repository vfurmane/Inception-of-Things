#!/usr/bin/env sh

set -eu;

printf "Cleaning all created clusters...\n"
k3d cluster delete all --all

printf "Removing gitlab repo from helm...\n"
helm repo remove gitlab

printf "\n"
printf "Success!\n"
printf "\n"
