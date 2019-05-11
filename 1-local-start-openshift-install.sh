#!/bin/bash
for node in master infra compute; do 
  ssh-copy-id -o StrictHostKeyChecking=no root@$node
done

for node in master infra compute; do
  scp install-openshift.sh root@${node}:~
done

scp hosts-inventory root@master:~/inventory
