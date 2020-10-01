#!/usr/bin/env python
import os
import json
import logging
import boto3
import uuid
from botocore.exceptions import ClientError

import helper

COMMON_HEADERS = {
    'content': 'application/json'
}


def create_announcement(event, context):
    body = json.loads(event['body'])
    try:
        item = {
            'id': f"{uuid.uuid4().hex}",
            'title': body['title'],
            'description': body['description'],
            'date': body['date']
        }

        helper.dynamodb_put_item(item)
        status_code = 201
    except Exception as e:
        logging.error(e)
        status_code = 500
        raise e
    response = {
        'statusCode': status_code,
        'body': json.dumps(item),
        'headers': COMMON_HEADERS,
        'isBase64Encoded': False
    }
    return response


def list_announcements(event, context):
    try:
        items = helper.dynamodb_list_items()
        status_code = 200
    except Exception as e:
        status_code = 500
        raise e
    response = {
        'statusCode': status_code,
        'body': json.dumps(items),
        'headers': COMMON_HEADERS,
        'isBase64Encoded': False
    }
    return response
