# creating secret with tag "team"="extend"

resource "aws_secretsmanager_secret" "extend_secret" {
  name = "extend-interview/gulnaza"
  tags = {
    Team = "Extend"
  }
}

resource "aws_secretsmanager_secret_version" "extend_secret" {
  secret_id     = aws_secretsmanager_secret.extend_secret.id
  secret_string = formatdate("MM/DD/YYYY", timestamp())
}

#creating IAM role which will have access to the secret with specified tag "team"="extend"

resource "aws_iam_role" "interview-bot" {
  name = "interview-bot"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [ 
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Principal = {
          AWS = "arn:aws:iam::528844056107:root"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "extend_policy" {
  name = "extend_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { 
        Effect = "Allow"
        Action = "secretsmanager:GetSecretValue"
        Resource = "arn:aws:secretsmanager:us-east-1:528844056107:secret:extend-interview/gulnaza-4CBcbn"
        Condition = {
          StringEquals = {
            "aws:ResourceTag/Team" = "Extend"
            }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "extend-policy-attachment" {
  role       = aws_iam_role.interview-bot.name
  policy_arn = aws_iam_policy.extend_policy.arn
}