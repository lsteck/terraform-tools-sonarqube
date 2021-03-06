module "dev_tools_sonarqube" {
  source = "./module"

  cluster_type             = module.dev_cluster.type_code
  cluster_ingress_hostname = module.dev_cluster.ingress_hostname
  cluster_config_file      = module.dev_cluster.config_file_path
  releases_namespace       = module.dev_capture_state.namespace
  service_account_name     = "sonarqube"
  tls_secret_name          = module.dev_cluster.tls_secret_name
  postgresql               = {
    external      = false
    username      = ""
    password      = ""
    hostname      = ""
    port          = ""
    database_name = ""
  }
}

module "dev_serviceaccount_sonarqube" {
  source = "github.com/ibm-garage-cloud/terraform-cluster-serviceaccount.git?ref=v1.3.0"

  cluster_type             = module.dev_cluster.type_code
  cluster_config_file_path = module.dev_cluster.config_file_path
  namespace                = module.dev_tools_sonarqube.namespace
  service_account_name     = module.dev_tools_sonarqube.service_account
  sscs                     = ["anyuid", "privileged"]
}
