resource "aws_instance" "jenkins" {
  ami                         = "ami-0866a3c8686eaeeba" #Ubuntu
  instance_type               = "t2.large"
  key_name                    = var.aws_key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "Jenkins"
  }
}

resource "time_sleep" "wait_30s" {
  depends_on      = [aws_instance.jenkins]
  create_duration = "30s"
}

resource "null_resource" "run_playbook" {
  depends_on = [time_sleep.wait_30s]
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${aws_instance.jenkins.public_ip},' -u ubuntu --private-key /Users/rickho/Desktop/AWS-keys/devops-key.pem /Users/rickho/Desktop/github-projects/Fullstack-blogging-app/playbooks/main.yml"
  }
}

resource "aws_security_group" "jenkins_sg" {
  tags = {
    Name = "jenkins-sg"
  }
}

resource "aws_security_group_rule" "ig-allow-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_security_group_rule" "ig-allow-jenkins" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_security_group_rule" "ig-allow-nexus" {
  type              = "ingress"
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_security_group_rule" "ig-allow-sonarqube" {
  type              = "ingress"
  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
}

resource "aws_security_group_rule" "eg-allow-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jenkins_sg.id
}
