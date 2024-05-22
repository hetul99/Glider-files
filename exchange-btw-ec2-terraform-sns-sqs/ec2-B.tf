resource "aws_instance" "server_b" {
  provider       = aws.account_b
  ami            = "ami-0c55b159cbfafe1f0"
  instance_type  = "t2.micro"
  user_data      = file("server_b_userdata.sh")
  tags = {
    Name = "server-b"
  }
}
