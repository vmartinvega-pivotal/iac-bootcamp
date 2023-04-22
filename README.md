# IaC Bootcamp

This repo contains all info needed to run the lab3

## Configure the VM with the right tools
* Deploy **8ks**
```
ansible-playbook -i 127.0.0.1, deploy-8ks.yml
```
* Deploy **nfs** and csi implementation
```
ansible-playbook -i 127.0.0.1, deploy-nfs.yml
```
* Deploy **Jenkins**.
```
ansible-playbook -i 127.0.0.1, deploy-jenkins.yml
```