#!/usr/bin/env sh

set -eu;

ARGOCD_NAMESPACE=argocd
APP_NAMESPACE=dev

printf "Creating k3d cluster\n"
k3d cluster create -p "80:80@loadbalancer"

printf "Creating '%s' namespace\n" "${ARGOCD_NAMESPACE}"
kubectl create namespace "${ARGOCD_NAMESPACE}" || true

printf "Applying kustomize configuration\n"
kubectl apply -k confs -n "${ARGOCD_NAMESPACE}"

printf "Waiting for ArgoCD to be ready\n"
kubectl wait deployment argocd-applicationset-controller --for=condition=available --timeout=60s -n "${ARGOCD_NAMESPACE}"

printf "Applying application configuration\n"
kubectl apply -f confs/app.yaml -n "${ARGOCD_NAMESPACE}"

printf "Applying application ingress\n"
kubectl apply -f confs/app-ingress.yaml -n "${APP_NAMESPACE}"

printf "Waiting for deployment to be ready\n"
kubectl wait deployment argocd-server --for=condition=available --timeout=60s -n "${ARGOCD_NAMESPACE}"

DEFAULT_ARGOCD_USER=admin
DEFAULT_ARGOCD_PASS="$(kubectl -n "${ARGOCD_NAMESPACE}" get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"
ARGOCD_HOST=argocd.localhost

printf "\n"
printf "Success!\n"
printf "You may now go to the ArgoCD Web UI!\n"
printf "\n"
printf "\tLocal:\thttp://%s\n" "${ARGOCD_HOST}"
printf "\n"
printf "Credentials:\n"
printf "user: %s\n" "${DEFAULT_ARGOCD_USER}"
printf "pass: %s\n" "${DEFAULT_ARGOCD_PASS}"
printf "\n"
