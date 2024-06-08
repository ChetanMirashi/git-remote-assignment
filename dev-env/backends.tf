terraform {
 backend "s3" {
  bucket = "chetan-tfstate"
  key = "tfstate/dev-env-assignment.tfstate"
  region = "ap-south-1"
 }
}
