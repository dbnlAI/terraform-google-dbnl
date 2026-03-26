# OIDC deployment

This example shows how to create a dbnl deployment on GCP (GKE) using OIDC for authentication.

**!!!DO NOT USE THIS EXAMPLE IN PRODUCTION!!!**

## Prerequisites

- [Google Cloud CLI](https://cloud.google.com/sdk/docs/install) installed and authenticated (`gcloud auth login`)
- `gke-gcloud-auth-plugin` installed (`gcloud components install gke-gcloud-auth-plugin`)
- An OIDC provider configured with a client application

## Required variables

| Variable | Description |
|---|---|
| `domain` | Domain to deploy dbnl to |
| `gcp_project` | GCP project ID |
| `gcp_region` | GCP region to deploy into |
| `oidc_issuer` | OIDC issuer URL |
| `oidc_client_id` | OIDC client ID |
| `oidc_audience` | OIDC audience |
| `oidc_scopes` | OIDC scopes (default: `openid email profile`) |

## Usage

1. Run `terraform apply` with your variables:

    ```bash
    terraform apply -var-file={TF_VARS_FILE}
    ```

2. Update your DNS to point an A record to the `load_balancer_ip` output by Terraform.
