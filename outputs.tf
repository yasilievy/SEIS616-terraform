# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "instance1_ip" {
  value = aws_instance1.instance1_name.ip
}
output "instance2_ip" {
  value = aws_instance2.instance2_name.ip
}

output "aws_db_instance" {
    value = aws_db_instance.infrastructure.endpoint
}