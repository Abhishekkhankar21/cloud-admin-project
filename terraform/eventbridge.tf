# EventBridge Rule for EC2 Creation

resource "aws_cloudwatch_event_rule" "ec2_create_rule" {

  name = "ec2-instance-create-rule"

  description = "Trigger Lambda when EC2 instance is launched"

  event_pattern = jsonencode({

    "source": ["aws.ec2"],

    "detail-type": ["AWS API Call via CloudTrail"],

    "detail": {

      "eventSource": ["ec2.amazonaws.com"],

      "eventName": ["RunInstances"]

    }

  })

}

# EventBridge Target

resource "aws_cloudwatch_event_target" "lambda_target" {

  rule = aws_cloudwatch_event_rule.ec2_create_rule.name

  target_id = "AutoTagLambda"

  arn = aws_lambda_function.auto_tag_lambda.arn

}

# Permission for EventBridge to invoke Lambda

resource "aws_lambda_permission" "allow_eventbridge" {

  statement_id  = "AllowExecutionFromEventBridge"

  action        = "lambda:InvokeFunction"

  function_name = aws_lambda_function.auto_tag_lambda.function_name

  principal     = "events.amazonaws.com"

  source_arn    = aws_cloudwatch_event_rule.ec2_create_rule.arn

}