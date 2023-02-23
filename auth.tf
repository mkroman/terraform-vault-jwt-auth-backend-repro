resource "vault_jwt_auth_backend" "kubernetes" {
  type        = "jwt"
  path        = "/kubernetes"
  description = "Kubernetes service account authentication from a cluster."

  bound_issuer           = "https://kubernetes.default.svc.cluster.local"
  jwt_validation_pubkeys = var.jwt_validation_pubkeys
}
