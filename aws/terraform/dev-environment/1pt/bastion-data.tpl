#!/bin/bash

yum install -y awslogs jq vim

cat > /etc/awslogs/awslogs.conf <<- EOF
[general]
state_file = /var/lib/awslogs/agent-state

[/var/log/dmesg]
file = /var/log/dmesg
log_group_name = ${cloudwatch_prefix}/var/log/dmesg
log_stream_name = {instance_id}
initial_position = start_of_file

[/var/log/messages]
file = /var/log/messages
log_group_name = ${cloudwatch_prefix}/var/log/messages
log_stream_name = {instance_id}
datetime_format = %b %d %H:%M:%S
initial_position = start_of_file

[/var/log/secure]
file = /var/log/secure
log_group_name = ${cloudwatch_prefix}/var/log/secure
log_stream_name = {instance_id}
datetime_format = %b %d %H:%M:%S
initial_position = start_of_file
EOF

# Set the region to send CloudWatch Logs data to (the region where the container instance is located)
region=$(curl 169.254.169.254/latest/meta-data/placement/availability-zone | sed s'/.$//')
sed -i -e "s/region = us-west-2/region = us-west-2/g" /etc/awslogs/awscli.conf

# Set the ip address of the node
hostname=$(curl 169.254.169.254/latest/meta-data/hostname)
sed -i -e "s/{instance_id}/$hostname/g" /etc/awslogs/awslogs.conf

sudo service awslogs start
sudo chkconfig awslogs on
