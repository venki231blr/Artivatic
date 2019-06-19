resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
   
    tags = {
      Name  = "TerraformTest-${count.index + 1}"
      Batch = "Test"
  }

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
  
  # the cloudwatch dashboard
  Dashboard_name = "${aws_cloudwatch_dashboard.main.dashboard_name}"
}


