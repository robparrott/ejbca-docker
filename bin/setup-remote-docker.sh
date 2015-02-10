#!/bin/bash
#
# Simple script to setup a docker host using "docker-machine"
#
# Assumes
#  1) docker-machine is in your path (get it from https://github.com/docker/machine/)
#  2) You've setup the AWS CLI with the `aws configure` step and entered in your credentials
#  3) The account is the first in the credentials file (if you have more than one AWS profile)
#  4) 
#

ENVIRONMENT_NAME=dockerdev

AWS_ID=$( cat ~/.aws/credentials | grep aws_access_key_id  | head -1 | awk '{print $3}')
AWS_KEY=$( cat ~/.aws/credentials | grep aws_secret_access_key  |  head -1 |awk '{print $3}')
DEF_VPC_ID=$( aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --output text | awk '{print $7}')
SUBNET_RESULTS=$( aws ec2 describe-subnets \
	          --filters Name=vpc-id,Values=${DEF_VPC_ID}  \
	          --output text  | grep "^SUBNETS" | head -1 )
echo 
SUBNET_ID=$( echo ${SUBNET_RESULTS} | awk '{print $8}' )
AZ=$( echo ${SUBNET_RESULTS} | awk '{print $2}' | sed -e 's/\(^.*\)\(.$\)/\2/' )


INSTANCE_TYPE=m3.medium
DISK=32

ARGS=" -d amazonec2 \
       --amazonec2-access-key ${AWS_ID} \
       --amazonec2-secret-key ${AWS_KEY} \
       --amazonec2-instance-type ${INSTANCE_TYPE} \
       --amazonec2-vpc-id ${DEF_VPC_ID} \
       --amazonec2-subnet-id ${SUBNET_ID} \
       --amazonec2-zone ${AZ} \
       --amazonec2-root-size ${DISK} " 

echo docker-machine create ${ARGS} ${ENVIRONMENT_NAME}
docker-machine create ${ARGS} ${ENVIRONMENT_NAME}

#
# Report the 
#
echo "---------------------------------------------------------------------"
echo "To automatically use this remote docker instance, set the shell alias"
echo 
echo "  alias docker=\"docker \$(docker-machine config ${ENVIRONMENT_NAME} )\""
echo 
echo "To login:    docker-machine ssh ${ENVIRONMENT_NAME}"
echo "To shutdown: docker-machine stop "
echo



