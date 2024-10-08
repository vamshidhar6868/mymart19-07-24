provider "aws" {
  region = "ap-south-1"
}
resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  # Define ingress and egress rules for RDS
  
 # ssh for terraform remote exec
  ingress {
    description = "Allow remote SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

resource "aws_db_instance" "my_rds_instance" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.35"
  instance_class       = "db.t3.micro"
  identifier           = "my-rds-instance"
  db_name              = "mymart123"
  username             = "admin"
  password             = "admin123"
  skip_final_snapshot  = true
  publicly_accessible  = true
  }

resource "aws_instance" "name" {
  ami = "ami-0522ab6e1ddcc7055"
  instance_type = "t2.medium"
  key_name = "vamzi"
  vpc_security_group_ids = [ "sg-08100b54383ec4d0a" ]
  tags = {
    Name = "mymart"
  }
   
   provisioner "remote-exec" {
        inline = [
         "sudo apt-get update",
         "sudo apt-get upgrade -y",
         "sudo apt install python3-pip -y",
         "sudo apt install python3-venv -y",
         "sudo apt install python3-virtualenv -y",
         "python3 -m venv /home/ubuntu/venv",
         ". /home/ubuntu/venv/bin/activate",
         "git clone https://github.com/vamshidhar6868/mymart19-07-24.git",
         "cd mymart19-07-24",
         "sudo apt install openjdk-17-jdk -y",
         "sudo apt install spring -y",
         "sudo apt install gradle -y",
         "sudo apt install maven -y",
         "mvn clean package",
         "java -jar target/MyMart-0.0.1-SNAPSHOT.jar &"

        ]   

        connection {
         type     = "ssh"
         user     = "ubuntu"  
         private_key = file("vamzi.pem")  
         host     = self.public_ip  
        }
    }
}
  
