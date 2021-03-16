output "cluster_id" {
  description = "The ID of the created ECS cluster."
  value = concat(aws_ecs_cluster.cluster.*.id, [""])[0]
}

output "cluster_name" {
  description = "The name of the created ECS cluster."
  value = aws_ecs_cluster.cluster.name
}

output "cluster_arn" {
  description = "The ARN of the created ECS cluster."
  value = aws_ecs_cluster.cluster.arn
}