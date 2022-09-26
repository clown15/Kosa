variable "k8s_ver" {
  description = "gke k8s version"
  type        = string
  default     = "1.23.8-gke.1900"
}
variable "node_vm_type" {
  description = "gke k8s version"
  type        = string
  default     = "e2-small"
}
variable "svc_account" {
  description = "gke k8s version"
  type        = string
  default     = "terraform-access@bmo-project-361100.iam.gserviceaccount.com"
}
variable "min_node" {
  description = "node autoscaling min count/zone"
  type        = number
  default     = 1
}
variable "max_node" {
  description = "node autoscaling max count/zone"
  type        = number
  default     = 2
}
variable "region_seoul" {
  description = "gcp seoul code"
  type        = string
  default     = "asia-northeast3"
}
