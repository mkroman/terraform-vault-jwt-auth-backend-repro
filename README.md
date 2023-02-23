# terraform-vault-jwt-auth-backend-repro

This repository contains a reproducible example of an issue I'm experiencing
with the Vault provider for Terraform.

## Prerequisites

The reproduction uses [Docker Compose (v2)](https://docs.docker.com/compose/) to
spin up an instance of Vault.

## Running

To start a Vault instance that listens on port 8200 and has a `development` root
token, run:

```
docker compose up --wait
```

Once the container is up and running (shouldn't take long), you can apply the
terraform resources.

First, set the necessary Vault parameters:

```sh
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=development
```

Then initialize the Terraform modules:

```sh
terraform init
```

And then apply the resources once:

```sh
terraform apply
```

Then if you apply the resources again, Terraform should say that
`jwt_validation_pubkeys` has changed:

```
Terraform will perform the following actions:

  # vault_jwt_auth_backend.kubernetes will be updated in-place
  ~ resource "vault_jwt_auth_backend" "kubernetes" {
        id                     = "kubernetes"
      ~ jwt_validation_pubkeys = [
          - <<-EOT
                -----BEGIN PUBLIC KEY-----
                MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwlsVQKeOENRE8U7uBvcB
                bgfyxIkmVZyAd8UCKyav7ET+Q0DZW+Iv63mMbnRXdfpK8so3gZ6ybz3hXBEILrXB
                Fnu0mR9VCe6V16eBAX2H85cqfqn9+0Q/OK0eUhcKkGNJxiVySj+dMqpMBYKBMpXD
                xDqz0bFCqFqmhgvyEhYOi1lj3T+TXMHxLNV7aLBHHJHDgmGw5pVbSbU5srcwbBCb
                DfzdwCDZZtoNjEzpmIKJiP0czbL8CEr6H7lFfgBdLJ17JZ9kd7vnith98cgvL/yd
                T2fpmows467Qrr1WWZnaD9U274OmfqGwFKMKFawtFfpwhqdFp4vq4nOdEcOCvKMl
                KQIDAQAB
                -----END PUBLIC KEY-----
            EOT,
          + <<-EOT
                -----BEGIN PUBLIC KEY-----
                MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwlsVQKeOENRE8U7uBvcB
                bgfyxIkmVZyAd8UCKyav7ET+Q0DZW+Iv63mMbnRXdfpK8so3gZ6ybz3hXBEILrXB
                Fnu0mR9VCe6V16eBAX2H85cqfqn9+0Q/OK0eUhcKkGNJxiVySj+dMqpMBYKBMpXD
                xDqz0bFCqFqmhgvyEhYOi1lj3T+TXMHxLNV7aLBHHJHDgmGw5pVbSbU5srcwbBCb
                DfzdwCDZZtoNjEzpmIKJiP0czbL8CEr6H7lFfgBdLJ17JZ9kd7vnith98cgvL/yd
                T2fpmows467Qrr1WWZnaD9U274OmfqGwFKMKFawtFfpwhqdFp4vq4nOdEcOCvKMl
                KQIDAQAB
                -----END PUBLIC KEY-----
            EOT,
        ]
        # (11 unchanged attributes hidden)
    }
```

## Rapid testing

Since the provider ends up mounting the auth engine at the expected path even
when it fails, I've added a `Makefile` with an `e2e` job for quickly recreating
and testing against Vault.

To recreate and apply the resources, run:

```sh
make e2e
```

This will destroy the Vault container, recreate it, and then run
`terraform apply -auto-approve`.

## Cleaning up

To remove the Vault container and its contents, run:

```
docker compose down
```
