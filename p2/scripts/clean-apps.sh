#!/usr/bin/env sh

set -eu;

VAGRANTFILE_PWD="$(realpath "$(dirname "$0")/../confs")"

cd "${VAGRANTFILE_PWD}"

ETC_HOSTS_ENTRY='192.168.56.110 app1.com app2.com app3.com'
printf "Removing /etc/hosts entry\n"
grep -vF "${ETC_HOSTS_ENTRY}" /etc/hosts | sudo tee /etc/hosts > /dev/null

printf "Downing the cluster nodes\n"
vagrant destroy -f

printf "\n"
printf "Success!\n"
printf "\n"
