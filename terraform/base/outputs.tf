output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_public_a_id" {
  value = aws_subnet.public_a.id
}

output "subnet_public_b_id" {
  value = aws_subnet.public_b.id
}

output "subnet_private_a_id" {
  value = aws_subnet.private_a.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.main.name
}

output "ami_id" {
  value = data.aws_ami.amazon_linux.id
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

output "codebuild_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}

output "eks_role_arn" {
  value = aws_iam_role.eks_role.arn
}
