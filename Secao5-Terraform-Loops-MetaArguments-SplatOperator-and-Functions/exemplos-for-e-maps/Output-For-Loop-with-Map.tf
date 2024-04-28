
# Output - For Loop with Map
output "for_output_map1" {
  description = "For Loop with Map"
  value       = { for instance in aws_instance.myec2vm : instance.id => instance.public_dns }
}
