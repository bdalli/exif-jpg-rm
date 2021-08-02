

# Local state maintained in repo for demo. 

# No constraint pulls the latest version v3.52.0
provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "tf_demo"
  region                  = "eu-west-1"

}




