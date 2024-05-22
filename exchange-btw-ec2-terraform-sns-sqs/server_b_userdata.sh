#!/bin/bash
yum update -y
yum install -y python3
pip3 install boto3
cat << 'EOL' > /home/ec2-user/process_sqs_and_upload.py
import boto3
import time

sqs_client = boto3.client('sqs', region_name='us-east-1')
s3_client = boto3.client('s3', region_name='us-east-1')

def process_messages():
    queue_url = 'https://sqs.us-east-1.amazonaws.com/ACCOUNT_B_ID/sqs-queue'  # replace ACCOUNT_B_ID
    s3_bucket = 'message-log-bucket'  # replace with actual S3 bucket name in Account A

    while True:
        messages = sqs_client.receive_message(
            QueueUrl=queue_url,
            MaxNumberOfMessages=1,
            WaitTimeSeconds=20
        )

        if 'Messages' in messages:
            for message in messages['Messages']:
                body = message['Body']
                receipt_handle = message['ReceiptHandle']
                timestamp = time.strftime('%Y-%m-%d-%H:%M:%S', time.gmtime())
                file_name = f"{timestamp}-message.log"

                with open(file_name, 'w') as file:
                    file.write(body)

                s3_client.upload_file(file_name, s3_bucket, file_name)
                sqs_client.delete_message(QueueUrl=queue_url, ReceiptHandle=receipt_handle)

if __name__ == "__main__":
    process_messages()
EOL
chmod +x /home/ec2-user/process_sqs_and_upload.py
cat << 'EOL' > /etc/systemd/system/process_sqs_and_upload.service
[Unit]
Description=Process SQS Messages and Upload to S3
After=network.target

[Service]
ExecStart=/usr/bin/python3 /home/ec2-user/process_sqs_and_upload.py
Restart=always
User=ec2-user
WorkingDirectory=/home/ec2-user

[Install]
WantedBy=multi-user.target
EOL
systemctl daemon-reload
systemctl enable process_sqs_and_upload.service
systemctl start process_sqs_and_upload.service
