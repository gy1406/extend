resource "aws_secretsmanager_secret" "extend_secret" {
  name = "extend_interview/gulnaza"
}

resource "aws_secretsmanager_secret_version" "extend_secret" {
  secret_id     = aws_secretsmanager_secret.extend_secret.id
  secret_string = formatdate("MM/DD/YYYY", timestamp())
}

