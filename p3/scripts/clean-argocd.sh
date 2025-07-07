#!/usr/bin/env sh

set -eu;

printf "Deleting k3d cluster\n"
k3d cluster delete
