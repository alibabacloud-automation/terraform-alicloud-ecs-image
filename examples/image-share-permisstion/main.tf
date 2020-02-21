module "image_share_permission" {
  source = "../../modules/image-share-permission"

  share       = true
  account_ids = ["59101469315*****"]
  image_ids   = ["m-uf6gkgbv29y10478****", "m-uf6h1sru8yot0uyx****", "m-uf628ggdhhit5c4q****"]
}