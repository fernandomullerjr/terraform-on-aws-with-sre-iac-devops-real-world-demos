
# Output - For Loop with Map Advanced

## Neste exemplo o "c" representa um valor único, que é definido como chave neste map. Neste caso ele pega um valor como identificador único e atribui a esta chave. Está pegando o index do count neste caso

output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value       = { for c, instance in aws_instance.myec2vm : c => instance.public_dns }
}
