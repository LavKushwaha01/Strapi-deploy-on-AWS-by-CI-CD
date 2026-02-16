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
  
}
variable "environment" {
  type = string
  default = "prod"
  description = "Environment tag"
}
variable "ecr_repo" {
  type = string
}
variable "image_tag" {
  type = string
}
