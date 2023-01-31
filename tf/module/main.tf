terraform {
  backend "gcs" {
    bucket = "<project_id>-management"
    prefix = "terraform/state"
  }
  required_version = "1.3.6"
}

provider "google" {
  project = var.project_id
  region  = var.region
}


