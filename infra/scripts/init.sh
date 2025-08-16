#!/bin/bash

export KUBECONFIG=.kube/config-capa-lfs256

create_cluster(){
  echo "creating cluster...."
  kubectl cluster-info --context capa-lfs256

  if [[ $? == 1 ]]; then
  kind create cluster --config infra/cluster-config.yaml
  fi

  if [[ $? == 0 ]]; then
    echo "local cluster creation successful"
    kubectl create ns argocd
#    helm upgrade -f infra/values.yaml -n argocd argocd argo/argo-cd --install
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    kubectl wait --for=create secret/argocd-initial-admin-secret -n argocd --timeout=180s
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > infra/admin-pass.txt
    # disable tls
    kubectl patch cm -n argocd argocd-cmd-params-cm -p '{"data": {"server.insecure": "true"}}'
    kubectl rollout restart deployment -n argocd argocd-server
    kubectl rollout status deployment -n argocd argocd-server
    cat infra/admin-pass.txt
    echo
    install_app istio
    kubectl wait applications istio -n argocd --for=jsonpath='{.status.health.status}=Healthy' --timeout=180s
    install_app argo-ingress
  else
    echo "Something went wrong please debug..."
    exit 1
  fi
  exit 0
}

cleanup(){
  echo "deleting cluster..."
  kind delete cluster --name capa-lfs256
}

install_app(){
  kubectl apply -f applications/$1.yaml
}

install_all_apps(){
  kubectl apply -f applications/
}

get_argocd_login(){
    echo "username: admin"
    echo "password: $(cat infra/admin-pass.txt)"
}

"$@"