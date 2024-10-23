output "public_address_bastion_k8s" {
  description = "The public IP address for bastion"
  value       = aws_instance.public_instance_bastion_k8s.public_ip
}

output "private_address_instance_k8s" {
  description = "The private IP address for k8s"
  value       = aws_instance.private_instance_k8s.private_ip
}