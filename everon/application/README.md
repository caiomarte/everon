# nginxdemos/hello:latest in zonal GKE cluster
This Terraform module deploys
- A Helm Chart for the `nginxdemos/hello:latest` Docker image, including deployment, service, and ingress
- A DNS zone and A record to expose the underlying GKE cluster

---

## Input Variables
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project` | Default GCP project resources are associated with. | `string` | N/A | <span style="color: red">Required</span> |
| `region` | Default location regional resources are deployed to. | `string` | N/A | <span style="color: red">Required</span> |
| `zone` | Default location zonal resources are deployed to. | `string` | N/A/ | <span style="color: red">Required</span> |
| `network` | Default VPC resources are deployed to. | `string` | N/A | <span style="color: red">Required</span> |
| `subnetwork` | Default VPC subnetwork resources are deployed to. | `string` | N/A | <span style="color: red">Required</span> |
| `dns_zone` | The DNS zone to use to expose Kubernetes services in the GKE Cluster. | `string` | N/A | <span style="color: red">Required</span> |
| `ip_ranges` | CIDR blocks for VPC subnetwork, pods, services, and cluster master, one for each. They cannot overlap. Cluster master's must be /28. | `object({`<br />`network=string`<br />`pods=string`<br />`services=string`<br />`master=string`<br />`})` | `{`<br />`network='10.10.0.0/16'`<br />`pods='10.30.0.0/16'`<br />`services='10.50.0.0/16'`<br />`master='10.70.0.0/28'`<br />`}` | <span style="color: green">Optional</span> |
| `application` | Application's Docker image name, source repository, version, port number, and replica count. | `object({`<br />`image=string`<br />`repo=string`<br />` version=string`<br />`port=number`<br />`replicas=number`<br />`})` | N/A | <span style="color: red">Required</span> |

## Usage example
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

## Output values
| Name | Description |
|------|-------------|
| `application_endpoint` | The public endpoint to access the Kubernetes service in the GKE Cluster. |
| `application_url` | The URL to access the Kubernetes service in the GKE Cluster. |

---

## Check resources
1. Authenticate into Google Cloud

`gcloud auth activate-service-account --key-file="credentials.json"`

2. Authenticate into the GKE Cluster

`gcloud container clusters get-credentials cluster --zone europe-west1-d --project evbox-infrastructure`

3. Check pods, services, replica sets, ingress, and configmap

`kubectl get pods,services,rs,ingress,configmap --namespace=nginx-namespace`

4. Check service endpoint

`kubectl describe services nginx-service --namespace=nginx-namespace`

---

## References
- [helm_release resource](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)
- [Recommended Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/)
- [dynamic Blocks](https://www.terraform.io/language/expressions/dynamic-blocks)
- [Setting up a Google-managed certificate](https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs#setting_up_a_google-managed_certificate)
- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
- [Service](https://kubernetes.io/docs/concepts/services-networking/service/)