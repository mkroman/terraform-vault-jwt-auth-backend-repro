DOCKER_COMPOSE ?= docker compose
TERRAFORM ?= terraform

.PHONY: all
all: up apply

.PHONY: up
up:
	$(DOCKER_COMPOSE) up --wait

.PHONY: down
down:
	$(DOCKER_COMPOSE) down

# Hack for automatically initializing providers.
.terraform/providers:
	$(TERRAFORM) init

.PHONY: apply
apply: up .terraform/providers
	VAULT_ADDR=http://localhost:8200 VAULT_TOKEN=development $(TERRAFORM) apply -auto-approve

.PHONY: e2e
e2e: down apply

.PHONY: clean
clean:
	$(DOCKER_COMPOSE) down --rmi=all
	rm -rf .terraform
	rm -f terraform.tfstate
