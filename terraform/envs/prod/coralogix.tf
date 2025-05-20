/* Commented out due to no alert webhook being entered in platform init
module "app-alerts-module" {
  source                         = "xometry.scalr.io/acc-v0oegra2vkqd3nn90/app-alerts-module/coralogix"
  version                        = "0.0.26"
  domain                         = "mktp"
  env                            = local.env
  alert_runbooks                 = []
  terraform_workspace            = "service-test-service-prod"
  team_alert_webhook_id          = "" # Lookup at https://github.com/xometry/terraform-coralogix-app-alerts-module#webhook-mapping
  additional_webhook_ids         = [] # Lookup at https://github.com/xometry/terraform-coralogix-app-alerts-module#webhook-mapping
  app_labels                     = ["test-service"]
  severity                       = "Critical"
## Please see https://app.terraform.io/app/xometry/registry/modules/private/xometry/app-alerts-module/coralogix/0.0.11 for additional options
}
*/
