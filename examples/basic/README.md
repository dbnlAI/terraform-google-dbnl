# Basic deployment

This example shows how to create a basic dbnl deployment on GCP (GKE) using username/password authentication.

**!!!DO NOT USE THIS EXAMPLE IN PRODUCTION!!!**

## Prerequisites

- [Google Cloud CLI](https://cloud.google.com/sdk/docs/install) installed and authenticated (`gcloud auth login`)
- `gke-gcloud-auth-plugin` installed (`gcloud components install gke-gcloud-auth-plugin`)

## Required variables

| Variable | Description |
|---|---|
| `admin_password` | Password for the dbnl admin user |
| `domain` | Domain to deploy dbnl to |
| `gcp_project` | GCP project ID |
| `gcp_region` | GCP region to deploy into |

## Usage

1. Run `terraform apply` with your variables:

    ```bash
    terraform apply -var-file={TF_VARS_FILE}
    ```

2. Update your DNS to point an A record to the `load_balancer_ip` output by Terraform.
