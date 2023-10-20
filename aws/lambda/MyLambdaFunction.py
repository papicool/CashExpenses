import os
import json
import boto3

rekognition = boto3.client('rekognition')

def lambda_handler(event, context):
    # Get the uploaded object information from the S3 event
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    # Detect text within the image using Amazon Rekognition
    response = rekognition.detect_text(
        Image={
            'S3Object': {
                'Bucket': bucket,
                'Name': key
            }
        }
    )

    # Extract and process detected text
    detected_text = [item['DetectedText'] for item in response['TextDetections']]
    extracted_text = '\n'.join(detected_text)

    # Log the extracted text
    print(f'Extracted text from the image:\n{extracted_text}')

    # You can further process or store the extracted text as needed
    # For example, save it to a database, store it in an S3 object, or trigger other actions

    return {
        "statusCode": 200,
        "body": json.dumps(f"Extracted text:\n{extracted_text}")
    }
