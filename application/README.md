# nginxdemos/hello:latest in zonal GKE cluster
This Terraform module deploys
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
| `cluster_endpoint` | The IP address of the GKE cluster's Kubernetes master. | `string` | N/A | <span style="color: red">Required</span> |
| `application` | Application's Docker image name, source repository, port number, and replica count. | `object({`<br />`image=string`<br />`repo=string`<br />`port=number`<br />`replicas=number`<br />`})` | N/A | <span style="color: red">Required</span> |

### Example
```hlc
module "application" {
  source = "./application"
  
  # GLOBAL
  project    = var.project
  region     = var.region
  zone       = var.zone
  network    = var.network
  subnetwork = var.subnetwork
  ip_ranges = var.ip_ranges
  cluster_endpoint = module.cluster.endpoint

  # APPLICATION
  application = var.application
}
```

### Outputs
| Name | Description |
|------|-------------|
| `dns` | The name of the Cloud DNS managed zone for the GKE's cluster. |
| `record` | The name of the Cloud DNS record set for the GKE's cluster. |

---

## References
- [helm_release resource](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)
- [Recommended Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/)
- [dynamic Blocks](https://www.terraform.io/language/expressions/dynamic-blocks)
- [Setting up a Google-managed certificate](https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs#setting_up_a_google-managed_certificate)
- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
- [Service](https://kubernetes.io/docs/concepts/services-networking/service/)