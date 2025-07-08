#!/usr/bin/env sh

set -eu;

GITLAB_CLUSTER=gitlab
GITLAB_NAMESPACE=gitlab

printf "Creating the %s namespace\n" "${GITLAB_NAMESPACE}"
kubectl create namespace "${GITLAB_NAMESPACE}"

printf "Adding gitlab helm repository\n"
helm repo add gitlab https://charts.gitlab.io/
helm repo update

printf "Installing gitlab helm chart\n"
helm upgrade --install gitlab gitlab/gitlab -f /vagrant/bonus/confs/gitlab-values.yaml --namespace "${GITLAB_NAMESPACE}"

printf "Waiting for all gitlab deployments to be ready\n"
kubectl wait --for=condition=available --all deployments -n "${GITLAB_NAMESPACE}" --timeout=600s

DEFAULT_GITLAB_USER=root
DEFAULT_GITLAB_PASS="$(kubectl get secret -n ${GITLAB_NAMESPACE} gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 -d)"
GITLAB_HOST=gitlab.localhost

printf "\n"
printf "Success!\n"
printf "You may now go to the GitLab Web Service!\n"
printf "\n"
printf "\tLocal:\thttps://%s\n" "${GITLAB_HOST}"
printf "\n"
printf "Credentials:\n"
printf "user: %s\n" "${DEFAULT_GITLAB_USER}"
printf "pass: %s\n" "${DEFAULT_GITLAB_PASS}"
printf "\n"
