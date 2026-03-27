resource "aws_cloudwatch_metric_alarm" "jenkins_recovery" {

  alarm_name = "jenkins-auto-recovery"

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"

  metric_name = "StatusCheckFailed_System"
  namespace   = "AWS/EC2"
  period      = "60"
  statistic   = "Minimum"
  threshold   = "0"

  dimensions = {
    InstanceId = aws_instance.jenkins.id
  }

  alarm_actions = ["arn:aws:automate:ap-south-1:ec2:recover"]

}

resource "aws_cloudwatch_metric_alarm" "ansible_recovery" {

  alarm_name = "ansible-auto-recovery"

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"

  metric_name = "StatusCheckFailed_System"
  namespace   = "AWS/EC2"
  period      = "60"
  statistic   = "Minimum"
  threshold   = "0"

  dimensions = {
    InstanceId = aws_instance.ansible.id
  }

  alarm_actions = ["arn:aws:automate:ap-south-1:ec2:recover"]

}

resource "aws_cloudwatch_metric_alarm" "monitoring_recovery" {

  alarm_name = "monitoring-auto-recovery"

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"

  metric_name = "StatusCheckFailed_System"
  namespace   = "AWS/EC2"
  period      = "60"
  statistic   = "Minimum"
  threshold   = "0"

  dimensions = {
    InstanceId = aws_instance.monitoring.id
  }

  alarm_actions = ["arn:aws:automate:ap-south-1:ec2:recover"]

}
