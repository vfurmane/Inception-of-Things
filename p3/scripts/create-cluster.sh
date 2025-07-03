#!/usr/bin/env sh

set -eu;

LOAD_BALANCER_PORT=8081
k3d cluster create -p "${LOAD_BALANCER_PORT}:80@loadbalancer"
