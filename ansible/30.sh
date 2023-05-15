#!/bin/bash
ansible-playbook -i /ansible/inventario/inventario.ini -l 172.27.11.30 /ansible/roles/playbook-2.yml
