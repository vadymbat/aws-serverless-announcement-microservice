#!/usr/bin/env python
import logging
import helper


def create_announcement(event, context):
    status_code = 500
    try:
        item = helper.generate_announcement(event['body'])
        helper.dynamodb_put_item(item)
        status_code = 201
        response = helper.generate_response(status_code, item)
    except ValueError as e:
        error_message = "Received malformed announcement date."
        logging.error(error_message)
        logging.error(e)
        response = helper.generate_error(status_code, error_message)
    except Exception as e:
        error_message = "Some error happend, please check the" + \
            " announcement syntax or try again later."
        logging.error(error_message)
        logging.error(e)
        response = helper.generate_error(status_code, error_message)
    return response


def list_announcements(event, context):
    try:
        items = helper.dynamodb_list_items()
        status_code = 200
        response = helper.generate_response(status_code, items)
    except Exception as e:
        status_code = 500
        error_message = 'Cannot list announcements, some error happend.'
        logging.error(error_message)
        logging.error(e)
        response = helper.generate_error(status_code, error_message)
    return response
