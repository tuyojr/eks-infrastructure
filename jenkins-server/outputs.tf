output "ec2_public_ip" {
  value = aws_instance.jenkins-server.public_ip
}

output "aws_vpc" {
  value = module.vpc.vpc_id
}

output "aws_subnet" {
  value = module.vpc.private_subnets
}