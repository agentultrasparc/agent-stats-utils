import requests
import logging

from secrets import slack_token
from slack_sdk import WebClient

def slack_post(file_name, file_bytes, slack_channels=None, title=None):
    client = WebClient(slack_token)
    channel = slack_channels.pop(0)   # first one is the primary one
    new_file = client.files_upload_v2(
        title=title,
        filename=file_name,
        content=file_bytes.lstrip(),
        channel=channel,
        )

    if not slack_channels:
        return

    file_url = new_file.get("file").get("permalink")
    for channel in slack_channels:
        new_message = client.chat_postMessage(
            channel=channel,
            text=f"{title}: {file_url}",
            )
