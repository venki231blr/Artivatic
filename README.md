Terraform has been my infrastructure automation tool of choice for couple of years.
It helps me provide a declarative syntax for deploying infrastructure, and it allows me to create and connect infrastructure across multiple different providers.
Although, we are going to stick with AWS for time being witht this DEVOPS Task given out.
In this case, we’re going to use it to create and deploy a typical EC2 instance.

PreRequisites:

Before we jump into the details, make sure you have the following software and services installed and configured.
Terraform
AWS CLI

You'll also need to make sure you have a public and private key created and stored in the path where the other files are unzipped as part of the email attachment.
we'll being using these key pairs to SSH to the instances.

and lastly, all the commands in this task were being used in Linux.

Step1: Terraform install

We will have to setup terraform before we create anything.
Let's initialize a terraform project

mkdir awsdemo
cd awsdemo
terraform init

Place all the files from the attachment to the root of the folder "awsdemo"

next, you are going to need a S3 bucket to store the state.

aws s3api put-bucket-versioning --bucket terraform-artifacts-bucket --versioning-configuration Status=Enabled

Now lets store the terraform artifacts in the bucket.

in this case, terraform.tf is the file

Now run " terraform init "

it should create a .terraform folder in the root of the project

Now that we have backed up the project, let jump into the files used in this Task.
Also please note that since this being a small task, have refrained myself from using module. But, it is highly recommended that we use Terraform Modules so that it can being used in other places and will act as components for future works in the project.

1. alarms.tf
2. dashboard.tf
3. instance.tf
4. key.tf
5. provider.tf
6. script.sh
7. securitygroup.tf
8. terraform.tf
9. vars.tf
10. vpc.tf

do create a .gitignore file in the project, incase if you want to store the project in a git or github with the below exclusions added in the file

**/.terraform/*
*.tfstate
*.tfstate.*
crash.log
*.tfvars

also create the terraform.tfvars for storing the API keys of AWS

Step2: 

To implement the task, run " terraform plan " and then " terraform apply"

PLEASE Ensure to run " terraform destroy " once you have done playing with the AWS task.


