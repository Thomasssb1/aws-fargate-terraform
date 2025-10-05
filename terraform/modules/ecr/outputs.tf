output "repository_url" {
  description = "URL of the ECR repository"
  value       = try(aws_ecr_repository.main.repository_url, null)
}