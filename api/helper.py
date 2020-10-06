import os
import json
import boto3
import uuid
import logging
from datetime import datetime

from botocore.exceptions import ClientError


REGION = os.environ['AWS_REGION']
LOG_LEVEL = os.environ['LOG_LEVEL']
ANNOUNCEMENT_TABLE_NAME = os.environ['ANNOUNCEMENT_TABLE_NAME']
UNKNOWN_ERROR_MESSAGE = "Unknown error happened, please contact the support team."
COMMON_HEADERS = {
    'content': 'application/json'
}
logging.basicConfig()
logging.getLogger().setLevel(LOG_LEVEL)


def get_dynamodb_client():
    session = boto3.Session(region_name=REGION)
    return session.client('dynamodb')


def get_dynamodb_resource():
    session = boto3.Session(region_name=REGION)
    return session.resource('dynamodb')


def dynamodb_put_item(item):
    dynamodb_resource = get_dynamodb_resource()
    table = dynamodb_resource.Table(ANNOUNCEMENT_TABLE_NAME)
    try:
        table.put_item(
            Item=item
        )
    except ClientError as e:
        logging.error(e.response['Error']['Message'])
        raise e


def dynamodb_list_items():
    data = None
    dynamodb_resource = get_dynamodb_resource()
    table = dynamodb_resource.Table(ANNOUNCEMENT_TABLE_NAME)
    try:
        response = table.scan()
        data = response['Items']
    except ClientError as e:
        logging.error(f"Failed to scan {ANNOUNCEMENT_TABLE_NAME}")
        raise e
    while 'LastEvaluatedKey' in response:
        try:
            response = table.scan(
                ExclusiveStartKey=response
                ['LastEvaluatedKey'])
            data.extend(response['Items'])
        except ClientError as e:
            logging.error(e)
            raise e
    return data


def generate_announcement(request_body):
    body = json.loads(request_body)
    logging.debug(f"The announcement create request body is {request_body}.")
    logging.info(f"The date is {body['date']}")
    announcement_date = datetime.fromisoformat(body['date'])
    item = {
        'id': f"{uuid.uuid4().hex}",
        'title': body['title'],
        'description': body.get('description'),
        'date': datetime.isoformat(announcement_date)
    }
    return item


def generate_response(status_code, body, custom_headers={}, is_base64=False):
    headers = {**COMMON_HEADERS, **custom_headers}
    response = {
        'statusCode': status_code,
        'body': json.dumps(body),
        'headers': headers,
        'isBase64Encoded': is_base64
    }
    return response


def generate_error(status_code, message):
    error_body = {
        'message': message,
        'code': status_code
    }
    return generate_response(
        status_code,
        error_body
    )
