provider "aws" {
        access_key = "xxxxxxxxxxxxxxxxxxxxxx"
        secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        region = "us-west-2"
}

resource "aws_instance" "example" {
        ami = "ami-aa5ebdd2"
	associate_public_ip_address = true
	availability_zone = "us-west-2a"
        instance_type = "t2.micro"
        key_name = "AWSInstancesKeyPair"
        security_groups= ["sg-96540eec"]
        tags {
         Name = "terraform-instance"
        }
	#root_block_device {
	 #device_name = "/dev/xvda"
	 #delete_on_termination = true # default value is true
	 #volume_type = "gp2" #default value is gp2 only general purpose ssd
	 #volume_size = 5
	#}
	#ebs_block_device {
	 #device_name = "/dev/sdg"
	 #delete_on_termination = true # default value is true
	 #volume_type = "gp2" #default value is gp2 only general purpose ssd
	 #volume_size = 5
	#}
	subnet_id = "subnet-b88d64f0"
	user_data = <<-EOF
		    #!/bin/bash
		    yum install httpd -y
		    echo "Welcome to First Terraform example" > /var/www/html/index.html
		    service start httpd
  		    EOF
		
}
