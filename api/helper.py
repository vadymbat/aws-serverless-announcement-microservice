import os
import boto3
import logging

from botocore.exceptions import ClientError

REGION = os.environ['AWS_REGION']
ANNOUNCEMENT_TABLE_NAME = os.environ['AWS_REGION']


def get_dynamodb_client():
    session = boto3.Session(region_name=REGION)
    return session.client('dynamodb')

def dynamodb_put_item(item):
    dynamodb_client = get_dynamodb_client()
    table = dynamodb_client.Table(ANNOUNCEMENT_TABLE_NAME)
    try:
        table.put_item(
            Item=item
        )
    except ClientError as e:
        logging.error(e.response['Error']['Message'])


def dynamodb_list_items():
    dynamodb_client = get_dynamodb_client()
    table = dynamodb_client.Table(ANNOUNCEMENT_TABLE_NAME)
    try:
        response = table.scan()
    except ClientError as e:
        logging.error(e.response['Error']['Message'])
    data = response['Items']
    while 'LastEvaluatedKey' in response:
        try:
            response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
            data.extend(response['Items'])
        except ClientError as e:
            logging.error(e.response['Error']['Message'])
    return data