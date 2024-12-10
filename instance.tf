#Creating EC2 resources
resource "aws_instance" "pub_instnce" {
  ami                    = "ami-00eb69d236edcfaf8"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.tf_pub1.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  key_name               = "Ohio_Sara"


  tags = {
    Name        = "pub_instance"
    Created_BY  = "saraswathy"
    Project     = "3-tier-architecture-SA"
  }
}

resource "aws_instance" "pvt_instnce_1" {
  ami                    = "ami-00eb69d236edcfaf8"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.tf_pvt1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = "Ohio_Sara"


  tags = {
    Name        = "pvt_instance"
    Created_BY  = "saraswathy"
    Project     = "3-tier-architecture-SA"
  }
}

#  resource "aws_instance" "pvt_instnce_2" {
#    ami                    = "ami-0ea3c35c5c3284d82"
#    instance_type          = "t2.micro"
#    subnet_id              = aws_subnet.tf_pvt1.id
#    vpc_security_group_ids = [aws_security_group.ec2_sg.id]
#    key_name               = "Ohio_sara"


#    tags = {
#      Name = "pvt_instnce_2"
#    }
#  }

resource "aws_instance" "ansible_instance" {
  ami                    = "ami-00eb69d236edcfaf8"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.tf_pub1.id
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]
  key_name               = "Ohio_Sara"

  tags = {
    Name        = "ansible_instance-SA"
    Created_BY  = "saraswathy"
    Project     = "3-tier-architecture-SA"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y software-properties-common
              sudo add-apt-repository --yes --update ppa:ansible/ansible
              sudo apt install -y ansible
              EOF
}
