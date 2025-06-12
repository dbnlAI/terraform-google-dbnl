# OIDC deployment

Thiss example shows how to create a dbnl deployment that uses OIDC for authentication.

**!!!DO NOT USE THIS EXAMPLE IN PRODUCTION!!!**

## Usage

  1. Have a Google Cloud account and a project set up
  2. Have `gcloud` CLI installed and configured, with `gke-gcloud-auth-plugin` installed
  3. Coordinate with your OIDC provider to get the necessary configuration values (`audience`, `issuer`, `client_id`)
  4. Run `terraform apply` specifying your OIDC values, domain, registry credentials, and GCP project / region:

```
$ terraform apply -var-file={TF_VARS_FILE}
```

  5. Update your DNS to point an A record to the `load balancer static IP` output value
