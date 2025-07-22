cluster_name := "inventree"

cluster-up:
    kind create cluster --name {{cluster_name}} --config ./kind-config.yaml
    sleep "10"
    kubectl wait --namespace kube-system --for=condition=ready pod --selector="tier=control-plane" --timeout=180s
    kubectl create ns inventree

cluster-down:
    kind delete cluster --name {{cluster_name}}

cluster-verify:
    kind get clusters
    kubectl get nodes

install-pg:
    helm repo add cnpg https://cloudnative-pg.github.io/charts
    helm upgrade --install cnpg --namespace cnpg-system --create-namespace cnpg/cloudnative-pg -f pg/cnpg.yaml
    kubectl rollout status deployment cnpg-cloudnative-pg -n cnpg-system
    kubectl apply -f pg/pg.yaml
    kubectl wait --for condition=Ready -n inventree cluster/inventree-pg-cluster --timeout=180s

all: cluster-up cluster-verify install-pg

down: cluster-down