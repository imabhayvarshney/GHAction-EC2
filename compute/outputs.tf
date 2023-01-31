# Output variable: Public IP address
output "public_ip_control" {
  value = "${aws_instance.control.public_ip}"
}

output "public_ip_worker" {
  value = "${aws_instance.worker.public_ip}"
}
