CONFIG_S3_BUCKET=''
export AWS_DEFAULT_REGION=''

aws cloudformation package \
    --template-file microservice.yaml \
    --s3-bucket $CONFIG_S3_BUCKET \
    --output-template-file processed_template.yaml

aws cloudformation deploy \
    --template-file processed_template.yaml \
    --stack-name anouncment-app \
    --capabilities CAPABILITY_IAM