#!/usr/bin/env sh

set -eu;

VAGRANTFILE_PWD="$(realpath "$(dirname "$0")/../confs")"

cd "${VAGRANTFILE_PWD}"

printf "Downing the cluster nodes\n"
vagrant destroy -f

printf "\n"
printf "Success!\n"
printf "\n"
