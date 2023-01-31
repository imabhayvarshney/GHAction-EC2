# Output variable: Public IP address
output "public_ip" {
  value = "${aws_instance.Control.public_ip}"
}

output "public_ip" {
  value = "${aws_instance.worker.public_ip}"
}
