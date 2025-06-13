output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ec2.id
}

output "ec2_instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = one(aws_eip.eip[*].public_ip)
}

output "ec2_instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.ec2.private_ip
}

output "ec2_name" {
  description = "The name of the EC2 instance"
  value       = module.naming.ec2_instance
}

output "eip_name" {
  description = "The name of the Elastic IP"
  value       = one(aws_eip.eip[*].tags["Name"])
}
