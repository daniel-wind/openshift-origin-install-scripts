# Openshift Origin 3.9.0 installation

Openshift Origin 3.9.0 install instructions build on the Linuxacademy scripts. This installation can be usefull to train for the Red Hat EX280 exam.

## Getting Started

The used setup is a Centos 7 workstation with KVM.

On the workstation create a KVM NAT network to be used with the vms.

On the workstation create 3 vms with the minimal requirements:
- 1 vcpu
- 4gb memory
- 40gb disk (os)
- 10gb disk (docker storage)

(The scripts assume that the second disk will be vdb, if not, change it in the install-openshift.sh script)

Install minimal Centos 7
Hostnames:
- master.lan
- infra.lan
- compute.lan

Connect to the created virtual nat network.

Use the root password redhat to use the scripts out-of-the-box or choose your own and edit the sshpass line in the install-openshift.sh script with your password of choise.
Use auto partion and give static IP-addresses.

### Prerequisites

DNS
The 3 vms need to be in DNS, also the wildcard apps.lan, it has to point to the ip of the infra node.
In my network there is a pi-hole which services DNS, in his hosts file the 3 vms are present. Also in /etc/dnsmasq.d on the pi-hole is a simple conf file 50-lan.conf. This makes sure that the apps.lan is a wildcard subdomain so that *.apps.lan resolves to the infra node.
```
address=/apps.lan/x.x.x.x (infra node ip)
```

### Installing
Before installing, make sure the hosts-inventory file is in the same directory as the scripts on the workstation.
Steps to install:

1. On the workstation run:
```
bash 1-local-start-openshift-install.sh
```
2. Om the 3 vms run:
```
bash install-openshift.sh
```
After this, run the Ansible playbooks shipped with openshift-ansible (will be installed)
```
ansible-playbook  /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml
```
And
```
ansible-playbook  /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
```

## After installing
To login to https://master.lan:8443
Create a htpasswd user: (on the master as root)
```
htpasswd -b /etc/origin/master/htpasswd <username> <password> && \
oc adm policy add-cluster-role-to-user cluster-admin <username> 
```
Use this username and password to login to the webconsole

