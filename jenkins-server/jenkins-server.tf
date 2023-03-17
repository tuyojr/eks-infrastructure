resource "aws_instance" "jenkins-server" {
    ami = "ami-0557a15b87f6559cf"
    instance_type = "t2.micro"
    key_name = "awsKeyPair"
    subnet_id = module.vpc.public_subnets[0]
    vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
    availability_zone = module.vpc.azs[0]
    associate_public_ip_address = true
    tags = {
        Name = "jenkins-server"
    }
}