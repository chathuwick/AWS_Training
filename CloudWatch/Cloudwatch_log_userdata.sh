#!/bin/bash
yum -y update
yum -y install httpd php
chkconfig httpd on
/etc/init.d/httpd start

mkdir /var/awslogs
mkdir /var/awslogs/state

yum -y install awslogs

cat > /etc/awslogs/awslogs.conf <<EOF
[general]
state_file = /var/awslogs/state/agent-state

[HttpAccessLog]
file = /var/log/httpd/access_log
log_group_name = HttpAccessLog
log_stream_name = {instance_id}
datetime_format = %b %d %H:%M:%S

[HttpErrorLog]
file = /var/log/httpd/error_log
log_group_name = HttpErrorLog
log_stream_name = {instance_id}
datetime_format = %b %d %H:%M:%S
EOF

REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed -n 's/.$//p')
sed -i "s/us-east-1/$REGION/g" /etc/awslogs/awscli.conf

service awslogs start
chkconfig awslogs on
