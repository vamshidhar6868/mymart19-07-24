provider "aws" {
  region = "ap-south-1"
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
  
