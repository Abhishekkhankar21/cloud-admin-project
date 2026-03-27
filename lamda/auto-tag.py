import boto3

def lambda_handler(event, context):

    ec2 = boto3.client('ec2')

    response = ec2.describe_instances()

    for r in response['Reservations']:
        for instance in r['Instances']:

            ec2.create_tags(
                Resources=[instance['InstanceId']],
                Tags=[
                    {'Key': 'Project', 'Value': 'CloudAdmin'}
                ]
            )

    return "Tagging Complete"