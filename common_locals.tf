locals {
  pub_split_cidr  = split(".", var.public_address_space)
  pub_subnet_base = "${local.pub_split_cidr[0]}.${local.pub_split_cidr[1]}"

  priv_split_cidr  = split(".", var.private_address_space)
  priv_subnet_base = "${local.priv_split_cidr[0]}.${local.priv_split_cidr[1]}"
}