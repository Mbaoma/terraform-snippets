#LAUNCH CONFIG
resource "aws_launch_configuration" "lc" {
  image_id        = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hi, loadbalancer is up and runnning" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  # Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
  }
}

#AUTOSCALING GROUP
resource "aws_autoscaling_group" "lc" {
  launch_configuration = aws_launch_configuration.lc.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.target-group-asg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-lc"
    propagate_at_launch = true
  }
} 

resource "aws_autoscaling_policy" "auto-scaling-policy" {
  name                   = "auto-scaling-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.lc.name

  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}

resource "aws_security_group" "sg" {
  name = var.instance_security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
  default = true
}

#SUBNETS
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

#SECURITY GROUP FOR ALB
resource "aws_lb" "lb" {

  name               = var.alb_name

  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.sg-alb.id]
}

resource "aws_lb_listener" "lb-listner" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

#TARGET GROUP
resource "aws_lb_target_group" "target-group-asg" {

  name = var.alb_name

  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

#LISTENER RULE
resource "aws_lb_listener_rule" "listener-rule-asg" {
  listener_arn = aws_lb_listener.lb-listner.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-asg.arn
  }
}

#SECURITY GROUP
resource "aws_security_group" "sg-alb" {

  name = var.alb_security_group_name

  # Allow inbound HTTP requests
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}