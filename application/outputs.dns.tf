output "dns" {
  description = "The name of the Cloud DNS managed zone for the GKE's cluster."
  value       = google_dns_managed_zone.zone.dns_name
}

output "record" {
  description = "The name of the Cloud DNS record set for the GKE's cluster."
  value       = google_dns_record_set.record.name
}
