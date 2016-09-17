#!/bin/bash
#
# $1 : SIDE ; blue/green
# $2 : LB Name

# blue / green
SIDE=$1
# LB Name
LB_NAME=$2

INSTANCES=$(aws ec2 describe-instances --filters "Name=tag:ServerType,Values=web" "Name=tag:Side,Values=${SIDE}" --query "Reservations[].Instances[].[InstanceId]" --output text)

for i in `echo ${INSTANCES}` ;do
  aws elb deregister-instances-from-load-balancer --load-balancer-name ${LB_NAME} --instances $i
done
