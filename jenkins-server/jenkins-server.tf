resource "aws_instance" "jenkins-server" {
    ami = "ami-09cd747c78a9add63"
    instance_type = var.instance_type
    key_name = "awsKeyPair"
    subnet_id = aws_subnet.public_subnets_1.id
    vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
    availability_zone = aws_subnet.public_subnets_1.availability_zone
    associate_public_ip_address = true
    user_data = file("ubuntu-script.sh")
    tags = {
        Name = "jenkins-server"
    }
}