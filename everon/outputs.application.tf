output "dns" {
  description = "The name of the Cloud DNS managed zone for the GKE's cluster."
  value       = module.application.dns
}