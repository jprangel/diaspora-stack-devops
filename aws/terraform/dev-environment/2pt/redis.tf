resource "aws_elasticache_cluster" "default" {
  cluster_id           = "dev-redis"
  replication_group_id = "${aws_elasticache_replication_group.default.id}"
}

resource "aws_elasticache_replication_group" "default" {
  replication_group_id          = "dev-diaspora"
  replication_group_description = "dev environment"
  node_type                     = "cache.t2.medium"
  port                          = 6379
  parameter_group_name          = "${aws_elasticache_parameter_group.default.name}"
  subnet_group_name             = "${aws_elasticache_subnet_group.default.name}"
  engine_version                = "4.0.10"
  maintenance_window            = "sun:05:00-sun:09:00"
 /* snapshot_window               = "04:00-05:00"
  snapshot_retention_limit      = 1*/
  security_group_ids            = ["${var.aws_elasticache_sg}"]
  automatic_failover_enabled    = false
  number_cache_clusters         = "1"
}

resource "aws_elasticache_parameter_group" "default" {
  name   = "dev-diaspora"
  family = "redis4.0"
}

resource "aws_elasticache_subnet_group" "default" {
  name       = "dev-redis-subnet-group"
  subnet_ids = ["${var.aws_elasticache_subnet_1}","${var.aws_elasticache_subnet_2}"]
}
