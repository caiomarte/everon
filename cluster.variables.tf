variable "cluster_resources" {
  description = "Minimum and maximum mount of CPU and memory for the cluster. Each value must be >= 0 or null. Minimum values must be <= corresponding maximum values. Maximum values are optional. Defaults to {cpu_min=1 cpu_max=1 memory_min=1 memory_max=1}."
  type = object({
    cpu_min    = number
    cpu_max    = number
    memory_min = number
    memory_max = number
  })

  default = {
    cpu_min    = 1
    cpu_max    = 1
    memory_min = 1
    memory_max = 1
  }

  validation {
    condition     = var.cluster_resources.cpu_min >= 0 && var.cluster_resources.cpu_max >= 0 && var.cluster_resources.cpu_max >= var.cluster_resources.cpu_min && var.cluster_resources.memory_min >= 0 && var.cluster_resources.memory_max >= 0 && var.cluster_resources.memory_max >= var.cluster_resources.memory_min
    error_message = "Invalid. Each value must be >= 0 or null, and minimum values must be <= corresponding maximum values. Maximum values are optional."
  }
}
