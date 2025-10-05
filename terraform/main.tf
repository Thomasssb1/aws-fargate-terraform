module "vpc" {
  source            = "./modules/vpc"
  availability_zone = var.region // Automatically adds a & b for public and private
}