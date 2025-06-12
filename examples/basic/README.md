# Basic deployment

Thiss example shows how to create a basic dbnl deployment to get familiar with the infrastructure and app.

**!!!DO NOT USE THIS EXAMPLE IN PRODUCTION!!!**

## Usage

  1. Have a Google Cloud account and a project set up
  2. Have `gcloud` CLI installed and configured, with `gke-gcloud-auth-plugin` installed
  3. Run `terraform apply` specifying your admin password, domain, registry credentials, and GCP project / region:

```
$ terraform apply -var-file={TF_VARS_FILE}
```

  4. Update your DNS to point an A record to the `load balancer static IP` output value
