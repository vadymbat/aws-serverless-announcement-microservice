#!/usr/bin/env python
import logging
import helper


def create_announcement(event, context):
    try:
        item = helper.generate_announcement(event['body'])
        helper.dynamodb_put_item(item)
        response = helper.generate_response(status_code=201, body=item)
    except ValueError as e:
        error_message = "Received malformed announcement."
        logging.error(e)
        response = helper.generate_error(status_code=400, message=error_message)
    except Exception as e:
        error_message = "Unknown error happened, please contact the support team."
        logging.error(e)
        response = helper.generate_error(status_code=500, message=error_message)
    return response


def list_announcements(event, context):
    try:
        items = helper.dynamodb_list_items()
        response = helper.generate_response(status_code=200, body=items)
    except Exception as e:
        error_message = 'Cannot list announcements, please contact the support team.'
        logging.error(e)
        response = helper.generate_error(status_code=500, message=error_message)
    return response
