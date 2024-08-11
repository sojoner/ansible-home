# Ansible playbooks learnings

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

---
 © 2024 Sojoner
