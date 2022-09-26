resource "google_container_cluster" "bmo-pvt-cluster" {
  name     = "bmo-pvt-cluster"
  location = var.region_seoul
  node_locations = [
    "asia-northeast3-a",
    "asia-northeast3-b"
  ]
  network = "bmo-vpc"
  subnetwork = "bmo-pvt-subnet"

  min_master_version = var.k8s_ver


  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  master_authorized_networks_config {
     cidr_blocks {
       cidr_block = "10.0.0.0/8"
       display_name = "internal"
     }
   }

  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = true
    master_ipv4_cidr_block = "10.31.0.0/28"
 }

  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
 }

}

resource "google_container_node_pool" "bmo-pvt-node-pool" {
  name       = "bmo-pvt-node-pool"
  location   = var.region_seoul
  cluster    = google_container_cluster.bmo-pvt-cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.node_vm_type
    disk_size_gb = 20

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.svc_account
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  autoscaling {
    min_node_count = var.min_node
    max_node_count = var.max_node
  }
}
