resource "aws_instance" "server_a" {
  provider       = aws.account_a
  ami            = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type  = "t2.micro"
  user_data      = file("server_a_userdata.sh")
  tags = {
    Name = "server-a"
  }
}
