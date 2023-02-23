resource "vault_jwt_auth_backend" "kubernetes" {
  type        = "jwt"
  path        = "kubernetes"
  description = "Kubernetes service account authentication from a cluster."

  jwt_validation_pubkeys = ["-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwlsVQKeOENRE8U7uBvcB\nbgfyxIkmVZyAd8UCKyav7ET+Q0DZW+Iv63mMbnRXdfpK8so3gZ6ybz3hXBEILrXB\nFnu0mR9VCe6V16eBAX2H85cqfqn9+0Q/OK0eUhcKkGNJxiVySj+dMqpMBYKBMpXD\nxDqz0bFCqFqmhgvyEhYOi1lj3T+TXMHxLNV7aLBHHJHDgmGw5pVbSbU5srcwbBCb\nDfzdwCDZZtoNjEzpmIKJiP0czbL8CEr6H7lFfgBdLJ17JZ9kd7vnith98cgvL/yd\nT2fpmows467Qrr1WWZnaD9U274OmfqGwFKMKFawtFfpwhqdFp4vq4nOdEcOCvKMl\nKQIDAQAB\n-----END PUBLIC KEY-----\n"]
}
