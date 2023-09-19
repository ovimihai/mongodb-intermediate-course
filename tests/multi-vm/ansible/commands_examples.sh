#!/usr/bin/env bash

# docu
# https://stash.emag.network/projects/PS/repos/ansible-playbooks/browse

export ANSIBLE_HOST_KEY_CHECKING=False


#ansible ua-workers-ro -i ansible_hosts.ini -m shell -a 'ls'

#ansible-playbook -i ansible_hosts.ini copy_spider.yml #--check
#ansible-playbook -i ansible_hosts.ini copy_spider_and_stats.yml #--check



#ansible-playbook -i ansible_hosts.ini copy_async.yml #--check


#ansible-playbook -i ansible_hosts.ini copy_google_verify.yml #--check

#ansible-playbook -i ansible_hosts.ini copy_async.yml #--check


#ansible-playbook -i ansible_hosts.ini switch_mongo.yml #--check

#ansible-playbook -i ansible_hosts.ini copy_php_mysql.yml #--check

#ansible log-all -i ansible_hosts.ini -m shell -a "php mysql_test.php; php mysql_test_master.php"
#ansible ua-workers-all -i ansible_hosts.ini -m shell -a "php mysql_test.php; php mysql_test_master.php"

#ansible-playbook -i ansible_hosts.ini mysql_switch.yml #--check

#  -ba   - b to become root
#ansible ua-workers-all -i ansible_hosts.ini -m shell -a "supervisorctl -s http://127.0.0.1:8989  -u admin -p parolasupervisor1213 stop uaparse_kafka:*"

#ansible ua-workers-all -i ansible_hosts.ini -m shell -a "supervisorctl -s http://127.0.0.1:8989  -u admin -p parolasupervisor1213 start uaparse_kafka:*"


#ansible ua-workers-all -i ansible_hosts.ini -m shell -a "supervisorctl -s http://127.0.0.1:8989  -u admin -p parolasupervisor1213 status uaparse_kafka:*"


