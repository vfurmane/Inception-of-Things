#!/usr/bin/env sh

set -eu;

VAGRANTFILE_PWD="$(realpath "$(dirname "$0")/../confs")"
CTRL_PLANE_VM_NAME="sasaicicS"

cd "${VAGRANTFILE_PWD}"

printf "Booting the cluster nodes\n"
vagrant up --no-provision

printf "Provisioning the cluster nodes\n"
vagrant provision

printf "\n"
printf "Success!\n"
printf "You may now inspect the cluster!\n"
printf "\n"
printf "\`\`\`\n"
printf "(\n"
printf "cd %s &&\n" "${VAGRANTFILE_PWD}"
printf "vagrant ssh %s -- -q <<EOF\n" "${CTRL_PLANE_VM_NAME}"
printf "echo\n"
printf "set -x\n"
printf "kubectl get nodes -o wide\n"
printf "ip a show eth1\n"
printf "EOF\n"
printf ")\n"
printf "\`\`\`\n"
printf "\n"
