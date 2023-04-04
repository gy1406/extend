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
        ],
        Principal = {
          AWS = "arn:aws:iam::528844056107:root"
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
        Action = [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:ListSecrets"
        ]
        Resource = "arn:aws:secretsmanager:us-east-1:528844056107:secret:extend-interview/gulnaza-4CBcbn"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "extend-policy-attachment" {
  role       = aws_iam_role.interview-bot.name
  policy_arn = aws_iam_policy.extend_policy.arn
}


