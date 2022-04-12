variable "application" {
  description = "Application's Docker image name, source repository, port number, and replica count."
  type = object({
    image    = string
    repo     = string
    port     = number
    replicas = number
  })
}
