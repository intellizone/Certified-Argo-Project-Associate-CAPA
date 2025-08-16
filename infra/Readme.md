# Create a Kind cluster with preinstalled istio and argocd

## Prerequisite
- Docker

## Clone code
```sh
# clone the repo
git clone https://github.com/intellizone/Certified-Argo-Project-Associate-CAPA.git
```

## create cluster 
```sh
# create cluster with name capa-lfs256, for customn changes make changes to the script
bash ./infra/scripts/init.sh create_cluster

export KUBECONFIG=$(pwd)/.kube/config-capa-lfs256

echo "127.0.0.1	argocd.localhost" >> /etc/hosts
```

## Login to argocd ui
- username: admin
- password: check_in_file -> infra/admin-pass.txt
```sh
bash ./infra/scripts/init.sh get_argocd_login
```


## cleanup 

```sh
bash ./infra/scripts/init.sh cleanup
```