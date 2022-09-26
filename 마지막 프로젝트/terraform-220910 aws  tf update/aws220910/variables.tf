variable "pub_sub_2a_id" {
  description = "public subnet 2a id"
  type        = string
  default     = "subnet-05ccd1b1e205bae9f"
}

variable "pub_sub_2c_id" {
  description = "public subnet 2c id"
  type        = string
  default     = "subnet-05f3ae637192ea6ff"
}

variable "private_sub_2a_id" {
  description = "private subnet 2a id"
  type        = string
  default     = "subnet-04c9e533b9a78883a"
}

variable "private_sub_2c_id" {
  description = "private subnet 2c id"
  type        = string
  default     = "subnet-064d5bd3269f87c1f"
}

variable "pub_key_name" {
  description = "public ssh key name"
  type        = string
  default     = "AWS-Front-key"
}

variable "pvt_key_name" {
  description = "private ssh key name"
  type        = string
  default     = "AWS-Back-Key"
}

variable "bmo_vpc_id" {
  description = "BMO-VPC id"
  type        = string
  default     = "vpc-035d769eef2b0bdb1"
}

variable "k8s_ver" {
  description = "k8s version"
  type        = string
  default     = "1.23"
}

variable "make_date" {
  description = "make date tag"
  type        = string
  default     = "20220906"
}

variable "eks_instance_type" {
  description = "eks_instance_type"
  type        = string
  default     = "t2.small"
}

variable "eks_pvt_scaling_max" {
  description = "private eks scaling max size"
  type        = number
  default     = 4
}

variable "eks_pvt_scaling_min" {
  description = "private eks scaling min size"
  type        = number
  default     = 2
}

variable "eks_pvt_scaling_des" {
  description = "private eks scaling desired size"
  type        = number
  default     = 2
}

variable "ami_amazon_linux" {
  description = "eks scaling desired size"
  type        = string
  default     = "AL2_x86_64"
}

variable "eks_pub_scaling_max" {
  description = "public eks scaling max size"
  type        = number
  default     = 6
}

variable "eks_pub_scaling_min" {
  description = "public eks scaling min size"
  type        = number
  default     = 3
}

variable "eks_pub_scaling_des" {
  description = "public eks scaling desired size"
  type        = number
  default     = 3
}
