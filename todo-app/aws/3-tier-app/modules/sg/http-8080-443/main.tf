module "sg_http_8080_443" {
  source                                                   = "terraform-aws-modules/security-group/aws//modules/http-8080"
  version                                                  = "3.17.0"
  name                                                     = "${var.app.name}-${var.app.env}${var.app.suffix != "" ? "-${var.app.suffix}" : ""}"
  vpc_id                                                   = var.vpc_id
  description                                              = var.description
  ingress_cidr_blocks                                      = var.ingress_cidr
  use_name_prefix                                          = false
  auto_ingress_with_self                                   = []
  auto_ingress_rules                                       = length(var.ingress_cidr) > 0 ? concat(["http-8080-tcp"], var.http443enable ? ["https-443-tcp"] : []) : []
  computed_ingress_with_source_security_group_id           = var.ingress_with_sg_id
  number_of_computed_ingress_with_source_security_group_id = length(var.ingress_with_sg_id)

  tags = {
    AppId       = var.app.id
    App         = var.app.name
    Version     = var.app.version
    Role        = "infra"
    Environment = var.app.env
    #Time        = formatdate("YYYYMMDDhhmmss", timestamp())
  }
}