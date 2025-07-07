#!/usr/bin/env sh

set -eu;

VAGRANTFILE_PWD="$(realpath "$(dirname "$0")/../confs")"
CTRL_PLANE_VM_NAME="sasaicicS"

cd "${VAGRANTFILE_PWD}"

printf "Booting the cluster nodes\n"
vagrant up --no-provision

printf "Provisioning the cluster nodes\n"
vagrant provision

printf "Applying application ingress\n"
vagrant ssh "${CTRL_PLANE_VM_NAME}" -- -q <<EOF
kubectl apply -f /vagrant/p2.yaml
EOF

printf "Waiting for deployments to be ready\n"
vagrant ssh "${CTRL_PLANE_VM_NAME}" -- -q <<EOF
kubectl wait deployment app{1,2,3}-deployment --for=condition=available --timeout=60s
EOF

ETC_HOSTS_ENTRY='192.168.56.110 app1.com app2.com app3.com'
if grep "${ETC_HOSTS_ENTRY}" /etc/hosts
then
	printf "/etc/hosts file already up-to-date\n"
else
	printf "Updating /etc/hosts file\n"
	echo "${ETC_HOSTS_ENTRY}" | sudo tee -a /etc/hosts > /dev/null
fi

printf "\n"
printf "Success!\n"
printf "You may now go to the different apps!\n"
printf "\n"
printf "app1:\thttp://app1.com\n"
printf "app2:\thttp://app2.com\n"
printf "app3:\thttp://app3.com\n"
printf "\n"
