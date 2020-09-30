#!/usr/bin/env python
import os

import boto3
from botocore.exceptions import ClientError

from api import helper


def create_announcement(event, context):
    try:
        item = {
            'title': event['body']['title'],
            'description' : event['body']['description'],
            'date' : event['body']['title']
        }
        helper.dynamodb_put_item(item)
        status_code = '201'
        message = 'Success'
    except Exception:
        status_code = '500'
        message = 'Some error happened'
    response = {
        'statusCode': status_code,
        'body': {'message': message}
    }
    return response


def list_announcements(event, context):
    try:
        items = helper.dynamodb_list_items()
        status_code = '200'
    except Exception:
        status_code = '500'

    response = {
        'statusCode': status_code,
        'body': items
    }
    return response