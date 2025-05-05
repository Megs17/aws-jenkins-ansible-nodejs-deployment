import boto3
import json
from datetime import datetime

ses_client = boto3.client("ses", region_name="us-east-1")  

SENDER = "ahmedfec2000@gmail.com"  
RECIPIENT = "ahmedfec2000@gmail.com"  

def lambda_handler(event, context):
    try:
        email_body = ""

        for record in event["Records"]:
            bucket_name = record["s3"]["bucket"]["name"]
            object_key = record["s3"]["object"]["key"]
            event_time = record["eventTime"]  
            formatted_time = datetime.strptime(event_time, "%Y-%m-%dT%H:%M:%S.%fZ").strftime("%Y-%m-%d %H:%M:%S")

            
            if "dev" in object_key:
                environment = "Development (env:/dev)"
            elif "prod" in object_key:
                environment = "Production (env:/prod)"
            else:
                environment = "Unknown"

           
            email_body += f"""
            S3 Bucket: {bucket_name}
            File Changed: {object_key}
            Change Detected At: {formatted_time} UTC
            Environment: {environment}
            -------------------------------
            """

        subject = "S3 State File Change Notification"
        response = ses_client.send_email(
            Source=SENDER,
            Destination={"ToAddresses": [RECIPIENT]},
            Message={
                "Subject": {"Data": subject},
                "Body": {"Text": {"Data": email_body.strip()}},
            },
        )

        return {"statusCode": 200, "body": json.dumps("Email sent successfully!")}

    except Exception as e:
        print(f"Error: {str(e)}")
        return {"statusCode": 500, "body": json.dumps(f"Error: {str(e)}")}
