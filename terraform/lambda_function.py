def lambda_handler(event, context):
    print("Auto tagging resources")
    return {
        'statusCode': 200,
        'body': 'Lambda executed successfully'
    }
