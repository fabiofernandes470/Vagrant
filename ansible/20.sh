#!/bin/bash
ansible-playbook -i /ansible/inventario/inventario.ini -l 172.27.11.20 /ansible/roles/playbook-1.yml
