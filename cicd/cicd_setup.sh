#!/bin/bash

# The token is needed to configure webhook
# export GITHUB_PERSONAL_TOKEN=''
CF_STACK_NAME='announcment-app-cicd'

aws cloudformation deploy \
    --template-file cicd/cicd.yaml \
    --stack-name ${CF_STACK_NAME} \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
    --parameter-overrides GitHubOAuthToken="${GITHUB_PERSONAL_TOKEN}"

echo "Application CICD deploy is finished!"