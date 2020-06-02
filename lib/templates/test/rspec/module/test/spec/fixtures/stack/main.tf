resource "random_pet" "bucket" {
  length = 2
}

module "bucket" {
  source     = "../../modules/example"
  bucket     = "bucket-${random_pet.bucket.id}"
  acl        = var.acl
}
