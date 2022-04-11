# References:
# kms_crypto_key resource - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key

resource "google_kms_key_ring" "key_ring" {
  name     = "${lower(var.author.name)}-${var.environment}-key-ring"
  location = "global"
}

resource "google_kms_crypto_key" "key" {
  name            = "${lower(var.author.name)}-${var.environment}-key"
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = "2592000s" #30 days

  lifecycle {
    prevent_destroy = true
  }
}
