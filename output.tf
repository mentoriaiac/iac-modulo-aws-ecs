output "loadbalance_dns_name" {
  value = aws_lb.iac_lb.dns_name
}

output "security_group_id" {
  value = aws_security_group.allow_access.id
}
