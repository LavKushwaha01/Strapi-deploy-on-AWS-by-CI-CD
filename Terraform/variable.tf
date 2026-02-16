variable "instance_type" {
  type = string
}
variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}
variable "key_name" {
  type = string
  default = "lav-key"
}
variable "image_name" {
  type = string
}
variable "ports" {
      type = list(number)
  
}
variable "environment" {
  type = string
  default = "prod"
  description = "Environment tag"
}

variable "docker_images" {
  type = string
   description = "ECR image URI"
}
variable "ecr_url" {
 type = string
}

variable "ecr_repo" {
  type = string
}
variable "image_tag" {
  type = string
}