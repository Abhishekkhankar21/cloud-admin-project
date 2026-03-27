# Start EC2 Instance

resource "aws_cloudwatch_event_rule" "start_ec2" {

  name = "start-ec2-rule"

  schedule_expression = "cron(0 9 * * ? *)"

}

# Stop EC2 Instance

resource "aws_cloudwatch_event_rule" "stop_ec2" {

  name = "stop-ec2-rule"

  schedule_expression = "cron(0 19 * * ? *)"

}