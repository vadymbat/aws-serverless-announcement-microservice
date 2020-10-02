#!/usr/bin/env python
import logging
import helper


def create_announcement(event, context):
    item = helper.generate_announcement(event['body'])
    try:
        helper.dynamodb_put_item(item)
        status_code = 201
    except Exception as e:
        logging.error(e)
        status_code = 500
        helper.generate_response(status_code, { 'message': "Recieved malformed data!"})
    return helper.generate_response(status_code, item)


def list_announcements(event, context):
    try:
        items = helper.dynamodb_list_items()
        status_code = 200
    except Exception as e:
        status_code = 500
        logging.error(e)
        helper.generate_response(status_code, { 'message': "Cannot list announcements."})
    return helper.generate_response(status_code, items)
