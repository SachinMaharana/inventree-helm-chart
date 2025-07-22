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

-  **Verify cluster is up**
```bash
$ kind get clusters
gitter

$ kubectl get nodes
NAME                   STATUS   ROLES    AGE     VERSION
gitter-control-plane   Ready    master   2m41s   v1.19.1
gitter-worker          Ready    <none>   2m9s    v1.19.1
gitter-worker2         Ready    <none>   2m9s    v1.19.1
gitter-worker3         Ready    <none>   2m15s   v1.19.1
```
