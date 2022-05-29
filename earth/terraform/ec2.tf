resource "aws_key_pair" "nikolai" {
  key_name   = "nikolai-pubkey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCr83a2UQs7f7WPT61OP2BFAulkiiEpT87XY/sg9WknovoLvvoyUoGaKW+BGi135Q76fXCok6ZI/aiEd5liRFGnraItnLidIfVSSgSjAxu53ck4ckGmMpMIynpYZvkqUP7Q9vkv506s0BNqBr/v1u5Jb90S2OFOXDCh6PO3ychTNUOPb2shdg04aAfNu3fyo1wpVcdgchqR/Qt/CXhZQUt5qyKcmZkWOh+xLIlhxa3iDe3DcSQihRsL5sep3neDr+r2vO0g5tVi0X2yuKhV/IxuqnlyHV13OLujrhDKjnlwSFJ6Vsk+3dsZ2KOy6Rfoow/sz7udcbcVZfsKAVbi3TWWD4ufYv6uffjxNlUNRonLBvmJLPeKpScqOcPLjAzBTLoBDUKXaRpHwqjEyeA9ga9PhdAuswgWJpZumRbT/Nqz1SONQHNagYpqBFtELGU5+Td8X6JK+Y58OiqhIDvRNAj3nusqKKJWH6OJQDmnEZHeQcznohE+AmrSaOiKIyV4UZM= nikolairahimi@macbook-pro.lan"
}

resource "aws_security_group" "earth" {
  name        = "earth_security"
  description = "allow ssh to earth"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "earth" {
  ami = "ami-0b49a4a6e8e22fa16" # Canonical Ubuntu server 20.04 ARM64
  #ami                         = "ami-0b6705f88b1f688c1" # Amazon Linux 2 ARM64
  instance_type               = "t4g.nano"
  key_name                    = aws_key_pair.nikolai.key_name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.earth.name]
  ebs_block_device {
    device_name = "/dev/sda1"
    iops        = 3000
    throughput  = 125
    volume_type = "gp3"
    volume_size = 40
    encrypted   = true
  }
  tags = {
    Name = "earth"
  }
}

resource "aws_eip" "earth" {
  instance = aws_instance.earth.id
}
