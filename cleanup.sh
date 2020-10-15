#!/bin/bash

# the script expect to get aws-cli configs via Environment variables
# export AWS_DEFAULT_REGION='eu-central-1'
# export AWS_ACCESS_KEY_ID=''
# export AWS_SECRET_ACCESS_KEY=''
# export AWS_SESSION_TOKEN='''

CONFIG_S3_BUCKET='aws-serverless-announcement-microservice'
CF_STACK_NAME='announcement-app'
log_group_name_patern='announcement-app'


aws cloudformation delete-stack \
    --stack-name "${CF_STACK_NAME}" > /dev/null
echo "Wait to stack ${CF_STACK_NAME} to be deleted..."

aws cloudformation wait stack-delete-complete \
    --stack-name "${CF_STACK_NAME}" > /dev/null
echo "deleted stack ${CF_STACK_NAME}"

log_groups_to_delete=$(aws logs describe-log-groups \
    --query "logGroups[? contains(logGroupName, '${log_group_name_patern}')].logGroupName" \
    --output text)
for log_group in ${log_groups_to_delete}; do
    aws logs delete-log-group --log-group-name "${log_group}" > /dev/null
    echo "deleted log group ${log_group}"
done

set +e
aws s3 rb s3://${CONFIG_S3_BUCKET} --force
echo "Application cleanup is finished!"