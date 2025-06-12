resource "google_project_service" "container_api" {
  project = var.project
  service = "container.googleapis.com"

  disable_on_destroy = false
}

module "kubernetes" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "~> 31.0"


  name       = "${var.prefix}-gke-cluster"
  region     = var.region
  project_id = var.project

  deletion_protection = var.terraform_deletion_protection

  network                = var.network_name
  subnetwork             = var.private_subnet_name
  enable_private_nodes   = true
  master_ipv4_cidr_block = var.kubernetes_control_plane_cidr
  kubernetes_version     = var.gke_version
  # values required, but GKE will make defaults
  ip_range_pods     = ""
  ip_range_services = ""

  remove_default_node_pool = true
  node_pools = [
    {
      name         = "gke-node-pool-01"
      machine_type = var.instance_type
      preemptible  = true

      initial_node_count = 1
      min_count          = var.desired_size
      max_count          = 4
    }
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ],
    "default-node-pool" : []
  }

  depends_on = [
    google_project_service.container_api,
  ]
}
