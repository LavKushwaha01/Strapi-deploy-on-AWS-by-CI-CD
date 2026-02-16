variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "key_name" {
  type = string
  default = "lav-key"
}
variable "ports" {
      type = list(number)
      default = [22, 80, 443, 1337]
}
variable "environment" {
  type = string
  default = "prod"
  description = "Environment tag"
}
variable "dockerhub_repo" {
  type        = string
  description = "Docker Hub repo (e.g., username/strapi-app)"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag"
}
