#!/usr/bin/env bash

ansible-playbook copy_repo.yml

ansible mongo_all -m shell -a "sudo yum install -y mongodb-org"

