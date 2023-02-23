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

And then apply the resources:

```sh
terraform apply
```

## Cleaning up

To remove the Vault container and its contents, run:

```
docker compose down
```
