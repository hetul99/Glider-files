#!/bin/bash
yum update -y
yum install -y python3
pip3 install boto3
cat << 'EOL' > /home/ec2-user/publish_to_sns.py
import boto3
import datetime

sns_client = boto3.client('sns', region_name='us-east-1')

def publish_message():
    message = f"Hello from server A at {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
    sns_client.publish(
        TopicArn='arn:aws:sns:us-east-1:ACCOUNT_A_ID:sns-topic',  # replace ACCOUNT_A_ID
        Message=message
    )

if __name__ == "__main__":
    publish_message()
EOL
chmod +x /home/ec2-user/publish_to_sns.py
