# nginxdemos/hello:latest in zonal GKE cluster
This Terraform module deploys
- A zonal, VPC-native GKE cluster
- A GKE node pool with autoscaling and shielding
- A Helm Chart for the `nginxdemos/hello:latest` Docker image, including deployment, service, and ingress
- A DNS zone and A record to expose the underlying GKE cluster

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
| `application` | Application's Docker image name, source repository, version, port number, and replica count. | `object({`<br />`image=string`<br />`repo=string`<br />` version=string`<br />`port=number`<br />`replicas=number`<br />`})` | N/A | <span style="color: red">Required</span> |

### Example
```hlc
module "everon" {
  source = "./everon"

  # GLOBAL
  project    = var.project
  region     = var.region
  zone       = var.zone
  network    = var.network
  subnetwork = var.subnetwork
  ip_ranges  = var.ip_ranges

  # CLUSTER
  cluster_resources = var.cluster_resources

  # CLUSTER NODE POOL
  node_count        = var.node_count
  node_availability = var.node_availability
  node_disk         = var.node_disk
  node_machine      = var.node_machine
  node_image        = var.node_image

  # APPLICATION
  application = var.application
}
```

### Outputs
| Name | Description |
|------|-------------|
| `endpoint` | The IP address of the GKE cluster's Kubernetes master. |
| `link` | The server-defined URL for the GKE cluster. |
| `dns` | The name of the Cloud DNS managed zone for the GKE's cluster. |
| `record` | The name of the Cloud DNS record set for the GKE's cluster. |

---

## Check resources
1. Authenticate into Google Cloud
`gcloud auth activate-service-account --key-file="credentials.json"`

2. Authenticate into the GKE Cluster
`gcloud container clusters get-credentials cluster --zone europe-west1-d --project evbox-infrastructure`

3. List pods, services, and replica sets
`kubectl get pods,sv,rs --namespace=${application_name}-namespace`

## References
- [Backend Types - GCS](https://www.terraform.io/language/settings/backends/gcs)
- [Google Provider Configuration Reference](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#configuration-reference)
- [Kubernetes Provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)
- [Helm Provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs)
- [google_container_cluster resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster)
- [GKE best practices: Designing and building highly available clusters](https://cloud.google.com/blog/products/containers-kubernetes/best-practices-for-creating-a-highly-available-gke-cluster)
- [Using node auto-provisioning](https://cloud.google.com/kubernetes-engine/docs/how-to/node-auto-provisioning)
- [Configuring Cloud Operations for GKE](https://cloud.google.com/stackdriver/docs/solutions/gke/installing#controlling_the_collection_of_application_logs)
- [Using Cloud DNS for GKE](https://cloud.google.com/kubernetes-engine/docs/how-to/cloud-dns)
- [container_node_pool resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool)
- [Provision a GKE Cluster (Google Cloud)](https://learn.hashicorp.com/tutorials/terraform/gke)
- [helm_release resource](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)
- [Recommended Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/)
- [dynamic Blocks](https://www.terraform.io/language/expressions/dynamic-blocks)
- [Setting up a Google-managed certificate](https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs#setting_up_a_google-managed_certificate)
- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
- [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
- [google_dns_managed_zone resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone)