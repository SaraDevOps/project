# Create the VPC with tags
resource "aws_vpc" "TF_VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sara-TF_VPC"
    Created_BY = "saraswathy"
    Project = "3-tier-architecture-SA" 
  }
}

# Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "TF_igw" {
  vpc_id = aws_vpc.TF_VPC.id

  tags = {
    Name = "sara-TF_igw"
    Created_BY = "saraswathy"
    Project = "3-tier-architecture-SA"
  }
}

# Create subnets with tags and enable auto-assign public IPs
resource "aws_subnet" "tf_pub1" {
  vpc_id                  = aws_vpc.TF_VPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "sara-tf_pub1"
    Created_BY = "saraswathy"
    Project = "3-tier-architecture-SA"
  }
}

resource "aws_subnet" "tf_pub2" {
  vpc_id                  = aws_vpc.TF_VPC.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "sara-tf_pub2"
    Created_BY = "saraswathy"
    Project = "3-tier-architecture-SA"
  }
}

resource "aws_subnet" "tf_pvt1" {
  vpc_id                  = aws_vpc.TF_VPC.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = false  # Private subnet

  tags = {
    Name = "sara-tf_pvt1"
    Created_BY = "saraswathy"
    Project = "3-tier-architecture-SA"
  }
}

resource "aws_subnet" "tf_pvt2" {
  vpc_id                  = aws_vpc.TF_VPC.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = false  # Private subnet

  tags = {
    Name = "sara-tf_pvt2"
    Created_BY = "saraswathy"
    Project = "3-tier-architecture-SA"
  }
}

resource "aws_subnet" "tf_pvt3" {
  vpc_id                  = aws_vpc.TF_VPC.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = false  # Private subnet

  tags = {
    Name = "sara-tf_pvt3"
    Created_BY = "saraswathy"
    Project = "3-tier-architecture-SA"
  }
}

resource "aws_subnet" "tf_pvt4" {
  vpc_id                  = aws_vpc.TF_VPC.id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = false  # Private subnet

  tags = {
    Name = "sara-tf_pvt4"
    Created_BY = "saraswathy"
    Project = "3-tier-architecture-SA"
  }
}

# Create a NAT Gateway with an Elastic IP and associate it with a public subnet
resource "aws_eip" "example" {}

resource "aws_nat_gateway" "tf_NAT" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.tf_pub1.id

  tags = {
    Name = "sara-tf_NAT"
    Created_BY = "saraswathy"
    Project = "3-tier-architecture-SA"
  }

  depends_on = [aws_internet_gateway.TF_igw]
}

# Create a public route table and associate it with public subnets
resource "aws_route_table" "tf_pubrt" {
  vpc_id = aws_vpc.TF_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TF_igw.id
  }

  tags = {
    Name = "sara-tf_pubrt"
    Created_BY = "saraswathy"
    Project = "3-tier-architecture-SA"
  }
}

resource "aws_route_table_association" "tf_pubrtassoc_pub1" {
  subnet_id      = aws_subnet.tf_pub1.id
  route_table_id = aws_route_table.tf_pubrt.id
}

resource "aws_route_table_association" "tf_pubrtassoc_pub2" {
  subnet_id      = aws_subnet.tf_pub2.id
  route_table_id = aws_route_table.tf_pubrt.id
}

# Create a private route table and associate it with private subnets
resource "aws_route_table" "tf_pvtrt" {
  vpc_id = aws_vpc.TF_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.tf_NAT.id
  }

  tags = {
    Name = "sara-tf_pvtrt"
    Created_BY = "saraswathy"
    Project = "3-tier-architecture-SA"
  }
}

resource "aws_route_table_association" "tf_pvtrtassoc_pvt1" {
  subnet_id      = aws_subnet.tf_pvt1.id
  route_table_id = aws_route_table.tf_pvtrt.id
}

resource "aws_route_table_association" "tf_pvtrtassoc_pvt2" {
  subnet_id      = aws_subnet.tf_pvt2.id
  route_table_id = aws_route_table.tf_pvtrt.id
}

resource "aws_route_table_association" "tf_pvtrtassoc_pvt3" {
  subnet_id      = aws_subnet.tf_pvt3.id
  route_table_id = aws_route_table.tf_pvtrt.id
}

resource "aws_route_table_association" "tf_pvtrtassoc_pvt4" {
  subnet_id      = aws_subnet.tf_pvt4.id
  route_table_id = aws_route_table.tf_pvtrt.id
}
