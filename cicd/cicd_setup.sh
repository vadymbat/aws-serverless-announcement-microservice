# create Codepipeline
# the token is needed to clone the even the public repo
# export GITHUB_PERSONAL_TOKEN=''
CF_STACK_NAME='announcment-app-cicd'

# aws secretsmanager create-secret --name github-announcement-app \
#     --description "The personal github token to clone the repo" \
#     --secret-string "{\"token\":\"${GITHUB_PERSONAL_TOKEN}\"}"
aws cloudformation deploy \
    --template-file cicd.yaml \
    --stack-name ${CF_STACK_NAME} \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
    --parameter-overrides GitHubOAuthToken="${GITHUB_PERSONAL_TOKEN}"