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

variable "node_count" {
  description = "Minimum and maximum node count for the cluster's node pool. Minimum count must be >= 0 and <= maximum count. Defaults to {min=1 max=1}."
  type = object({
    min = number
    max = number
  })

  default = {
    min = 1
    max = 1
  }

  validation {
    condition     = var.node_count.min >= 0 && var.node_count.max >= 0 && var.node_count.max >= var.node_count.min
    error_message = "Invalid. Minimum count must be >= 0 and <= maximum count."
  }
}

variable "node_availability" {
  description = "Maximum surge and unavailable count for the cluster's node pool. Both must be >=0, at least one must be >0, and the sum must be <=20. Defaults to {surge=1 unavailable=0}."
  type = object({
    surge       = number
    unavailable = number
  })

  default = {
    surge       = 1
    unavailable = 0
  }

  validation {
    condition     = var.node_availability.surge >= 0 && var.node_availability.unavailable >= 0 && (var.node_availability.surge > 0 || var.node_availability.unavailable > 0) && (var.node_availability.surge + var.node_availability.unavailable <= 20)
    error_message = "Invalid. Both must be >=0, at least one must be >0, and the sum must be <=20."
  }
}

variable "node_disk" {
  description = "Type and size of the disk attached to each node. Type must be either 'pd-standard', 'pd-balanced', or 'pd-ssd'. Size must be >= 10, specified in GB. Defaults to {type='pd-standard' size=10}."
  type = object({
    type = string
    size = number
  })

  default = {
    type = "pd-standard"
    size = 10
  }

  validation {
    condition = contains([
      "pd-standard",
      "pd-balanced",
      "pd-ssd"
    ], var.node_disk.type) && var.node_disk.size >= 10
    error_message = "Invalid. Type must be either 'pd-standard', 'pd-balanced', or 'pd-ssd'. Size must be >= 10, specified in GB."
  }
}

variable "node_machine" {
  description = "Default Google Compute Engine machine type for the cluster's node pool. Check https://cloud.google.com/compute/docs/machine-types for valid machine types. Defaults to 'e2-medium'."
  type        = string
  default     = "e2-medium"
}

variable "node_image" {
  description = "Default image type for the cluster's node pool. Must be either 'COS_CONTAINERD' or 'UBUNTU_CONTAINERD'. Defaults to 'COS_CONTAINERD'."
  type        = string
  default     = "COS_CONTAINERD"

  validation {
    condition = contains([
      "COS_CONTAINERD",
      "UBUNTU_CONTAINERD"
    ], var.node_image)
    error_message = "Invalid. Must be either 'COS_CONTAINERD' or 'UBUNTU_CONTAINERD'."
  }
}
