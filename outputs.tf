output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.main.id
}

output "public_ip" {
  description = "Public IP of the WordPress instance"
  value       = aws_instance.main.public_ip
}
