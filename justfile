cluster_name := "inventree"
inventreee_namespace := "inventree"
pg_namespace := "cnpg-system"

cluster-up:
    kind create cluster --name {{cluster_name}} --config ./deploy/kind-config.yaml
    sleep "10"
    kubectl wait --namespace kube-system --for=condition=ready pod --selector="tier=control-plane" --timeout=180s
    kubectl wait --namespace kube-system --for=condition=ready pod --selector="tier=node" --timeout=180s

prep:
    kubectl get ns {{inventreee_namespace}} || kubectl create ns {{inventreee_namespace}}
    kubectl get ns {{pg_namespace}} || kubectl create ns {{pg_namespace}}
    just cluster-status
    helm repo add cnpg https://cloudnative-pg.github.io/charts

cluster-status:
    kind get clusters
    kubectl get nodes

cluster-down:
    kind delete cluster --name {{cluster_name}}

install-pg:
    helm upgrade --install cnpg --namespace cnpg-system cnpg/cloudnative-pg -f deploy/pg/cnpg.yaml
    kubectl rollout status deployment cnpg-cloudnative-pg -n cnpg-system
    kubectl apply -f deploy/pg/pg.yaml
    kubectl wait --for condition=Ready -n {{inventreee_namespace}} cluster/inventree-pg-cluster --timeout=300s

up: cluster-up prep install-pg

down: cluster-down