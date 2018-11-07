#!/bin/bash
${ecs_config}
{
  echo "ECS_CLUSTER=${cluster_name}"
  echo 'ECS_AVAILABLE_LOGGING_DRIVERS=${ecs_logging}'
} >> /etc/ecs/ecs.config

yum install -y awslogs jq vim mysql

cat > /etc/awslogs/awslogs.conf <<- EOF
[general]
state_file = /var/lib/awslogs/agent-state

[/var/log/dmesg]
file = /var/log/dmesg
log_group_name = ${cloudwatch_prefix}/var/log/dmesg
log_stream_name = ${cluster_name}/{instance_id}
initial_position = start_of_file

[/var/log/messages]
file = /var/log/messages
log_group_name = ${cloudwatch_prefix}/var/log/messages
log_stream_name = ${cluster_name}/{instance_id}
datetime_format = %b %d %H:%M:%S
initial_position = start_of_file

[/var/log/docker]
file = /var/log/docker
log_group_name = ${cloudwatch_prefix}/var/log/docker
log_stream_name = ${cluster_name}/{instance_id}
datetime_format = %Y-%m-%dT%H:%M:%S.%f
initial_position = start_of_file

[/var/log/ecs/ecs-init.log]
file = /var/log/ecs/ecs-init.log.*
log_group_name = ${cloudwatch_prefix}/var/log/ecs/ecs-init.log
log_stream_name = ${cluster_name}/{instance_id}
datetime_format = %Y-%m-%dT%H:%M:%SZ
initial_position = start_of_file

[/var/log/ecs/ecs-agent.log]
file = /var/log/ecs/ecs-agent.log.*
log_group_name = ${cloudwatch_prefix}/var/log/ecs/ecs-agent.log
log_stream_name = ${cluster_name}/{instance_id}
datetime_format = %Y-%m-%dT%H:%M:%SZ
initial_position = start_of_file

[/var/log/ecs/audit.log]
file = /var/log/ecs/audit.log.*
log_group_name = ${cloudwatch_prefix}/var/log/ecs/audit.log
log_stream_name = ${cluster_name}/{instance_id}
datetime_format = %Y-%m-%dT%H:%M:%SZ

[/var/log/ecs/secure]
file = /var/log/secure
log_group_name = ${cloudwatch_prefix}/var/log/secure
log_stream_name = ${cluster_name}/{instance_id}
datetime_format = %Y-%m-%dT%H:%M:%SZ

EOF

# Set the region to send CloudWatch Logs data to (the region where the container instance is located)
region=$(curl 169.254.169.254/latest/meta-data/placement/availability-zone | sed s'/.$//')
sed -i -e "s/region = us-west-2/region = us-west-2/g" /etc/awslogs/awscli.conf

# Set the ip address of the node
hostname=$(curl 169.254.169.254/latest/meta-data/hostname)
sed -i -e "s/{instance_id}/$hostname/g" /etc/awslogs/awslogs.conf

sudo service awslogs start
sudo chkconfig awslogs on
