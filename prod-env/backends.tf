terraform {
 backend "s3" {
  bucket = "chetan-tfstate"
  key = "tfstate/prod-env-assignment.tfstate"
  region = "ap-south-1"
 }
}
