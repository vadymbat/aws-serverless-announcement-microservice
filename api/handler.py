#!/usr/bin/env python
import os, json
import logging
import boto3
import datetime
from botocore.exceptions import ClientError

import helper

COMMON_HEADERS =  {
   'content': 'application/json'
}

def create_announcement(event, context):
    body = json.loads(event['body'])
    try:
        item = {
            'id': f"{datetime.datetime.now().timestamp()}",
            'title': body['title'],
            'description' : body['description'],
            'date' : body['date']
        }

        helper.dynamodb_put_item(item)
        status_code = '201'
        message = 'Success'
    except Exception as e:
        logging.error(e)
        status_code = '500'
        message = 'Some error happened'
        raise e
    response = {
        'statusCode': status_code,
        'body': item,
        'headers': COMMON_HEADERS
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
        'body': items,
        'headers' : COMMON_HEADERS
    }
    return response