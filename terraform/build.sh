#!/bin/bash

# the script expect to get aws-cli configs via Environment variables
# export AWS_DEFAULT_REGION='eu-central-1'
# export AWS_ACCESS_KEY_ID=''
# export AWS_SECRET_ACCESS_KEY=''
# export AWS_SESSION_TOKEN='''

CONFIG_S3_BUCKET='aws-serverless-announcement-microservice'
PACKAGE_DIR_PATH='./package'
SOURCE_DIR_PATH='../api'
ARTIFACT_NAME='announcement-app.zip'


mkdir $PACKAGE_DIR_PATH

cp ${SOURCE_DIR_PATH}/* ${PACKAGE_DIR_PATH}

pip3 install -r ${SOURCE_DIR_PATH}/requirements.txt --target ${PACKAGE_DIR_PATH}

aws s3 mb s3://${CONFIG_S3_BUCKET}

cd ${PACKAGE_DIR_PATH}

zip -r9 ../${ARTIFACT_NAME} . -x *.pyc 

cd ..

aws s3 cp ${ARTIFACT_NAME} s3://${CONFIG_S3_BUCKET}/

rm -r $PACKAGE_DIR_PATH ${ARTIFACT_NAME}