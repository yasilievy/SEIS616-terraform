# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "instance1_ip" {
  value = aws_instance.instance1_name.public_ip
}
output "instance1_dns" {
  value = aws_instance.instance1_name.public_ip
}
output "instance2_ip" {
  value = aws_instance.instance2_name.public_dns
}
output "instance2_dns" {
  value = aws_instance.instance2_name.public_dns
}

output "aws_db_instance" {
    value = aws_db_instance.infrastructure.endpoint
}