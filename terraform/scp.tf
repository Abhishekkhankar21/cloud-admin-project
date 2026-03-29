# Service Control Policy to restrict unsafe actions

resource "aws_organizations_policy" "security_policy" {

  name        = "SecurityGuardrails"
  description = "Prevent public S3 and open security groups"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Sid = "DenyPublicS3"

        Effect = "Deny"

        Action = [
          "s3:PutBucketAcl",
          "s3:PutBucketPolicy"
        ]

        Resource = "*"

        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "public-read"
          }
        }
      },

      {
        Sid = "DenyOpenSecurityGroup"

        Effect = "Deny"

        Action = [
          "ec2:AuthorizeSecurityGroupIngress"
        ]

        Resource = "*"

        Condition = {
          IpAddress = {
            "aws:SourceIp" = "0.0.0.0/0"
          }
        }
      }

    ]

  })

}
