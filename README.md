# inventree-helm-chart
WIP: Home of official InvenTree helm chart(s)


## Prerequisites

- docker - 27.3.1+ (https://docs.docker.com/engine/install/ubuntu/)

* kind - v0.25.0+ (https://kind.sigs.k8s.io/docs/user/quick-start/#installation)

* kubectl - (https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux)

- just - 1.42.3 (https://github.com/casey/just#pre-built-binaries)

- helm - v3.18.3

## Setup
- **Update variables in Justfile**

A `justfile` is provided in the repo to manage this project.

`cluster_name` is the name of the cluster.

- **Create a local dev kubernetes cluster**
```bash
just cluster-up
```

- **Install PG**
```bash
just install-pg
```