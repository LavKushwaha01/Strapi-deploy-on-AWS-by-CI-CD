output "ec2_instance_id" {
  description = "ID of the EC2 instance running the Strapi container"
  value       = aws_instance.first_ec2_from_terraform.id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.first_ec2_from_terraform.public_ip
}

