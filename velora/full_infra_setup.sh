#!/bin/bash

METHOD=2  # mean install infra in docker
BECOME=true
HOSTS=bm
INVENTORY=ssh.ini

cd ../ansible/



start=$(date +%s)  # Время начала в секундах



# BASE_SETUP
figlet BASIC SETUP
ansible-playbook -i inventory/password.ini playbooks/basic_setup/basic_setup.yml -e "hosts=$HOSTS docker=true admins=['adminis','vadim']"


# FRONTEND
figlet NGINX
ansible-playbook -i inventory/$INVENTORY playbooks/apps/nginx/nginx.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"


# BALANCER
figlet BALANCER
ansible-playbook -i inventory/$INVENTORY playbooks/apps/haproxy/haproxy.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"


# DATA STORE
figlet MINIO
ansible-playbook -i inventory/$INVENTORY playbooks/apps/minio/minio.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"
figlet POSTGRES
ansible-playbook -i inventory/$INVENTORY playbooks/apps/postgresql/postgresql.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"


# LOGS
figlet LOKI
ansible-playbook -i inventory/$INVENTORY playbooks/apps/loki/loki.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"
figlet PROMTAIL
ansible-playbook -i inventory/$INVENTORY playbooks/apps/promtail/promtail.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"


# METRICS
figlet PROMETHEUS
ansible-playbook -i inventory/$INVENTORY playbooks/apps/prometheus/prometheus.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"
figlet CADVISOR
ansible-playbook -i inventory/$INVENTORY playbooks/apps/cadvisor/cadvisor.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"
figlet ALERTMANAGER
ansible-playbook -i inventory/$INVENTORY playbooks/apps/alertmanager/alertmanager.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"
figlet NODE EXPORTER
ansible-playbook -i inventory/$INVENTORY playbooks/apps/node_exporter/node_exporter.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"


# VISUAL
figlet GRAFANA
ansible-playbook -i inventory/$INVENTORY playbooks/apps/grafana/grafana.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"


# CACHE
figlet RABBITMQ
ansible-playbook -i inventory/$INVENTORY playbooks/apps/rabbitmq/rabbitmq.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"


# QUEUE
figlet REDIS
ansible-playbook -i inventory/$INVENTORY playbooks/apps/redis/redis.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"


# SECRETS
figlet VAULT
ansible-playbook -i inventory/$INVENTORY playbooks/apps/vault/vault.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD"


# BUILD 
# figlet JENKINS SERVER
# ansible-playbook -i inventory/$INVENTORY playbooks/apps/jenkins/jenkins_server.yml -e "hosts=$HOSTS method=$METHOD"
# figlet JENKINS AGENT
# ansible-playbook -i inventory/$INVENTORY playbooks/apps/jenkins/jenkins_agent.yml -e "hosts=$HOSTS -e js_ssh_pub_key='pub_key' method=$METHOD"

# figlen GITLAB-RUNNER
# ansible-playbook -i inventory/$INVENTORY playbooks/apps/git_repo/gitlab/gitlab-runner.yml -e "hosts=$HOSTS become=$BECOME method=$METHOD token="



end=$(date +%s)

duration=$((end - start))

# Преобразование в минуты и секунды
minutes=$((duration / 60))
seconds=$((duration % 60))

echo "Время выполнения: ${minutes} минут и ${seconds} секунд"