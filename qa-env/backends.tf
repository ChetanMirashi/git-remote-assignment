terraform {
 backend "s3" {
  bucket = "chetan-tfstate"
  key = "tfstate/qa-env-assignment.tfstate"
  region = "ap-south-1"
 }
}
