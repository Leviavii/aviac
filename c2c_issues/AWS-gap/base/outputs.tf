output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "region" {
  value = data.aws_region.current.region
}

output "vpc_id" {
  value = data.aws_vpc.main.id
}

output "subnet_public_a_id" {
  value = data.aws_subnet.public_a.id
}

output "subnet_public_b_id" {
  value = data.aws_subnet.public_b.id
}

output "subnet_private_a_id" {
  value = data.aws_subnet.private_a.id
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}
