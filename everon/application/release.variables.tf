variable "application" {
  description = "Application's Docker image name, source repository, version, port number, and replica count."
  type = object({
    image    = string
    repo     = string
    version  = string
    port     = number
    replicas = number
  })
}
