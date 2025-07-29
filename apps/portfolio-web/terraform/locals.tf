locals {
  microservice_short_name = "powa"
  microservice_prefix = "${data.aws_caller_identity.current.account_id}-${terraform.workspace}-${local.microservice_short_name}"
}
