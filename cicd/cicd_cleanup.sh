#!/bin/bash

# the token is needed to clone the even the public repo
# export GITHUB_PERSONAL_TOKEN=''
CF_STACK_NAME='announcment-app-cicd'


codepipeline_bucket=$(aws cloudformation describe-stack-resource \
    --stack-name "${CF_STACK_NAME}" \
    --logical-resource-id CodePipelineArtifactsS3Bucket\
    --query StackResourceDetail.PhysicalResourceId --output text)

# empty codepipeline bucket
aws s3 rm "s3://${codepipeline_bucket}" --recursive

aws cloudformation delete-stack \
    --stack-name "${CF_STACK_NAME}" > /dev/null

aws cloudformation wait stack-delete-complete \
    --stack-name "${CF_STACK_NAME}" > /dev/null

echo "deleted stack ${CF_STACK_NAME}"

echo "Application CICD cleanup is finished!"