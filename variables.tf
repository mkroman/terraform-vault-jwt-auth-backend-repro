variable "jwt_validation_pubkeys" {
  description = "List of JWKs to use for validating JWTs."
  type = set(string)
}
