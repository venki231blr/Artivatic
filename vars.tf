variable "AWS_REGION" {
  default = "eu-west-1"
}
variable "instance_count" {
  default = "2"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}
variable "alarms_email" {
  default = "your@email.here"
}
