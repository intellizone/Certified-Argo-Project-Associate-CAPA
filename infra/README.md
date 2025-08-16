# 🚀 Create a Kind Cluster with Preinstalled Istio and ArgoCD

This project helps you set up a local Kubernetes cluster using [Kind](https://kind.sigs.k8s.io/) with **Istio** and **ArgoCD** preinstalled. It's a great environment for testing GitOps workflows and service meshes locally.

---

## 📋 Prerequisites

Ensure you have the following installed on your machine:

- [Docker](https://docs.docker.com/engine/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [git](https://git-scm.com/)

---

## 📂 Clone the Repository

```bash

git clone https://github.com/intellizone/Certified-Argo-Project-Associate-CAPA.git

cd Certified-Argo-Project-Associate-CAPA
```

## ⚙️ Create the Cluster

Run the following script to create a Kind cluster with the name capa-lfs256. You can modify the script for custom configurations.

```sh

bash ./infra/scripts/init.sh create_cluster

# Set kubeconfig to access the new cluster
export KUBECONFIG=$(pwd)/.kube/config-capa-lfs256

# Add ArgoCD hostname to /etc/hosts for local access
echo "127.0.0.1	argocd.localhost" | sudo tee -a /etc/hosts

```

## 🔐 Access ArgoCD UI

Once the cluster is up and running, access ArgoCD at 
### 👉 http://argocd.localhost:31120/

### 🎫 Login Credentials

**Username**: admin

**Password**: Stored in infra/admin-pass.txt

To retrieve the login password:

```sh

bash ./infra/scripts/init.sh get_argocd_login

```


## 🧹 Cleanup

To delete the cluster and clean up resources:

```sh

bash ./infra/scripts/init.sh cleanup

```

## 📝 Notes

The scripts and configuration files are located in the infra/ directory.

Make sure Docker is running before creating the cluster.

The setup includes Istio and ArgoCD preconfigured for quick experimentation.

## 📧 Support

For issues or questions, feel free to open an issue on the GitHub repository.


---

### How to Save:

1. Open a terminal.
2. Run: `nano README.md` (or use your preferred editor).
3. Paste the above content.
4. Save and exit.

Let me know if you want to add diagrams, badges, a license, or contributor info.