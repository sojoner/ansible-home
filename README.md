# My ansible Run the playbooks

## Ubuntu

* `ansible-playbook playbook_ubuntu.yaml -e "action=update"`
* `ansible-playbook playbook_ubuntu.yaml -e "action=install"`
* `ansible-playbook playbook_ubuntu.yaml -e "action=shutdown"`

## Install K8s rke2

* `ansible-playbook playbook_rke2.yaml -e "action=cleanup"`
* `ansible-playbook playbook_rke2.yaml -e "action=create"`
* `ansible-playbook playbook_rke2.yaml -e "action=start"`
* `ansible-playbook playbook_rke2.yaml -e "action=stop"`
* `ansible-playbook playbook_rke2.yaml -e "action=start"`

## Install GPU operator

* `ansible-playbook playbook_rke2.yaml -e "action=add_nv_cnt_tk"`
* `ansible-playbook playbook_rke2.yaml -e "action=add_nv_gpu_op"`

## Kind ctrl K8s cluster

* `kind create cluster --name ctrl --config kind_ctrl.yaml`

### Argo CD

```bash
$kubectl create namespace argocd 
```

```bash
$kubectl apply \
  -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Fix ports

```bash
kubectl patch svc argocd-server -n argocd -p \
  '{"spec": {"type": "NodePort", "ports": [{"name": "http", "nodePort": 30080, "port": 80, "protocol": "TCP", "targetPort": 8080}, {"name": "https", "nodePort": 30443, "port": 443, "protocol": "TCP", "targetPort": 8080}]}}'
```
Get secret for _admin_ user.

```bash
kubectl get secret \
  -n argocd \
  argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" |
  base64 -d &&
  echo
```

Use argoCd cli

```bash
argocd login localhost:8080 \
  --insecure \
  --username admin \
  --password $(kubectl get secret \
  -n argocd \
  argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" |
  base64 -d)
```

Add an app

```bash
argocd app create ollama \
	--repo https://github.com/sojoner/ollama-helm.git \
	--path . \
	--dest-server https://192.168.178.147:6443 \
	--dest-namespace ollama \
	--sync-option CreateNamespace=true \
	--parameter namespace=ollama
```

### Check Workload

* `kubectl apply -f ./k8s_examples/pod_gpu.yaml`

```bash
import torch
torch.cuda.is_available()
torch.cuda.device_count()
torch.cuda.get_device_name(0)
```

---
 © 2024 Sojoner