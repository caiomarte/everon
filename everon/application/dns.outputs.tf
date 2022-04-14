output "dns" {
  description = "The Cloud DNS managed zone for the GKE's cluster."
  value       = local.dns_zone
}