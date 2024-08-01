provider "aws" {
  region = "us-east-1"
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

   # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
  }

# enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
  }
}

 resource "aws_instance" "name" {
  ami = "ami-04a81a99f5ec58529"
  instance_type = "t2.medium"
  key_name = "vamshi"
  vpc_security_group_ids = [ "sg-0c5b7284384684629" ]
  tags = {
    Name = "vamshi"
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
         "sudo apt install maven -y",
         "sudo apt install gradle -y",
         "sudo apt install maven -y",
         "mvn clean package",
         "java -jar target/MyMart-0.0.1-SNAPSHOT.jar",
         "nohup java -jar target/MyMart-0.0.1-SNAPSHOT.jar > spring_boot.log 2>&1 &",

        ]   

        connection {
         type     = "ssh"
         user     = "ubuntu"  
         private_key = file("vamshi.pem")  
         host     = self.public_ip  
        }
    }
}
  
