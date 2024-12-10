// ALB Listenet
resource "aws_lb" "alb_bia" {
  name               = "bia-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids

  tags = {
    Name = "TF - Aplication Load Balancer BIA"
  }
}

//Listener
resource "aws_lb_listener" "alb_bia_listener" {
  load_balancer_arn = aws_lb.alb_bia.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_bia.arn
  }
}

// Target group
resource "aws_lb_target_group" "tg_bia" {
  name                              = "tg-bia"
  target_type                       = "instance"
  deregistration_delay              = 30
  load_balancing_algorithm_type     = "round_robin"
  load_balancing_anomaly_mitigation = "off"
  load_balancing_cross_zone_enabled = "use_load_balancer_configuration"
  port                              = 80
  protocol                          = "HTTP"
  vpc_id                            = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

/*
// Target group attachment
resource "aws_lb_target_group_attachment" "attach_tg_bia" {
  target_group_arn = aws_lb_target_group.tg_bia.arn
  target_id        = var.instance_id
  port             = 80
}


