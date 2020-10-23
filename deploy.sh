#!/bin/bash

# the script expect to get aws-cli configs via Environment variables
# export AWS_DEFAULT_REGION='eu-central-1'
# export AWS_ACCESS_KEY_ID=''
# export AWS_SECRET_ACCESS_KEY=''
# export AWS_SESSION_TOKEN='''

CONFIG_S3_BUCKET='aws-serverless-announcement-microservice'
CF_STACK_NAME='announcement-app'

aws s3 mb s3://${CONFIG_S3_BUCKET}

aws cloudformation package \
    --template-file announcement_app.yaml \
    --s3-bucket $CONFIG_S3_BUCKET \
    --output-template-file processed_template.yaml

aws cloudformation deploy \
    --template-file processed_template.yaml \
    --stack-name ${CF_STACK_NAME} \
    --capabilities CAPABILITY_IAM

api_endpoint=$(aws cloudformation describe-stacks --stack-name "${CF_STACK_NAME}" \
    --query "Stacks[].Outputs[? OutputKey == 'ApiUrl'].OutputValue" \
    --output text)

echo "Application deploy is finished!"

echo "The API is available at ${api_endpoint}"