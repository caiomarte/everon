# nginxdemos/hello:latest in zonal GKE cluster
This Terraform module deploys
- A zonal, VPC-native GKE cluster
- A DNS zone to expose the GKE cluster
- A GKE node pool with autoscaling and shielding
- A Helm Chart for the `nginxdemos/hello:latest` Docker image, including deployment, service, and ingress
---
## Usage
### Input Variables
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project` | Default GCP project resources are associated with. | `string` | N/A | <span style="color: red">Required</span> |
| `region` | Default location regional resources are deployed to. | `string` | N/A | <span style="color: red">Required</span> |
| `zone` | Default location zonal resources are deployed to. | `string` | N/A/ | <span style="color: red">Required</span> |
| `network` | Default VPC resources are deployed to. | `string` | N/A | <span style="color: red">Required</span> |
| `subnetwork` | Default VPC subnetwork resources are deployed to. | `string` | N/A | <span style="color: red">Required</span> |
| `ip_ranges` | CIDR blocks for VPC subnetwork, pods, services, and cluster master, one for each. They cannot overlap. Cluster master's must be /28. | `object({`<br />`network=string`<br />`pods=string`<br />`services=string`<br />`master=string`<br />`})` | `{`<br />`network='10.10.0.0/16'`<br />`pods='10.30.0.0/16'`<br />`services='10.50.0.0/16'`<br />`master='10.70.0.0/28'`<br />`}` | <span style="color: green">Optional</span> |
| `cluster_resources` | Minimum and maximum mount of CPU and memory for the cluster. Each value must be >= 0 or null. Minimum values must be <= corresponding maximum values. Maximum values are optional. | `object({`<br />`cpu_min=number`<br />`cpu_max=number`<br />`memory_min=number`<br />`memory_max=number`<br />`})` | `{` <br />`cpu_min=50`<br />`cpu_max=100`<br />`memory_min=250`<br />`memory_max=500`<br />`}` | <span style="color: green">Optional</span> |
| `node_count` | Minimum and maximum node count for the cluster's node pool. Minimum count must be >= 0 and <= maximum count. | `object({`<br />`min=number`<br />`max=number`<br />`})` | `{`<br />`min=3`<br />`max=4`<br />`}` | <span style="color: green">Optional</span> |
| `node_availability` | Maximum surge and unavailable count for the cluster's node pool. Both must be >=0, at least one must be >0, and the sum must be <=20. | `object({`<br />`surge=number`<br />`unavailable=number`<br />`})` | `{`<br />`surge=3`<br />`unavailable=1`<br />`}` | <span style="color: green">Optional</span> |
| `node_disk` | Type and size of the disk attached to each node. Type must be either `"pd-standard"`, `"pd-balanced"`, or `"pd-ssd"`. Size must be >= 10, specified in GB. | `object({`<br />`type=string`<br />`size=number`<br />`})` | `{`<br />`type="pd-standard"`<br />`size=500`<br />`}` | <span style="color: green">Optional</span> |
| `node_machine` | Default Google Compute Engine machine type for the cluster's node pool. Check [About machine families](https://cloud.google.com/compute/docs/machine-types) for valid machine types. | `string` | `"e2-medium"` | <span style="color: green">Optional</span> |
| `node_image` | Default image type for the cluster's node pool. Must be either `"COS_CONTAINERD"` or `"UBUNTU_CONTAINERD"`. | `string` | `"COS_CONTAINERD"` | <span style="color: green">Optional</span> |
| `application` | Application's Docker image name, source repository, port number, and replica count. | `object({`<br />`image=string`<br />`repo=string`<br />`port=number`<br />`replicas=number`<br />`})` | N/A | <span style="color: red">Required</span> |

### Example
```hlc
module "everon" {
    source = "everon"

    # GLOBAL
    project    = "evbox-infrastructure"
    region     = "europe-west-1"
    zone       = "europe-west1-d"
    network    = "default"
    subnetwork = "default"

    ip_ranges = {
        network  = "10.10.0.0/16"
        pods     = "10.30.0.0/16"
        services = "10.50.0.0/16"
        master   = "10.70.0.0/28"
    }

    # CLUSTER
    cluster_resources = {
        cpu_min    = 200
        cpu_max    = 600
        memory_min = 200
        memory_max = 600
    }

    # CLUSTER NODE POOL
    node_count = {
        min = 3
        max = 9
    }

    node_availability = {
        surge       = 1
        unavailable = 6
    }

    node_disk = {
        type = "pd-standard"
        size = 10
    }

    node_machine = "n1-standard-1"
    node_image   = "COS_CONTAINERD"

    # APPLICATION
    application = {
        image    = "hello"
        repo     = "nginxdemos"
        port     = 3000
        replicas = 3
    }
}
```

### Outputs
| Name | Description |
|------|-------------|
| `cluster_endpoint` | GKE cluster's endpoint. |