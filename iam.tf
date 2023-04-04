resource "aws_iam_role" "interview-bot" {
  name = "interview-bot"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::528844056107:user/Gulnaza"
        }
      },
    ]
  })
}
resource "aws_iam_role" "interview-developer" {
  name = "interview-developer"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::528844056107:user/Gulnaza"
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
      { Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:secretsmanager:us-east-1:528844056107:secret:extend-interview/gulnaza"

      }
    ]
  })
}

resource "aws_iam_policy_attachment" "extend-attach-policy" {
    name = "extend-attach-policy"
    roles = [aws_iam_role.interview-bot.name]
    policy_arn = aws_iam_policy.extend_policy.arn
}


