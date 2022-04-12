resource "google_dns_managed_zone" "zone" {
  name        = lower(var.author.name)
  dns_name    = "${lower(var.author.name)}.${lower(var.project)}.com."
  description = "${title(var.author.name)}'s DNS zone."
  labels = {
    author = "${lower(var.author.name)}-${lower(var.author.surname)}"
  }
}

resource "google_dns_record_set" "record" {
  name         = "${local.values["name"]}.${google_dns_managed_zone.zone.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.zone.name
  rrdatas      = [var.cluster_endpoint]
}
