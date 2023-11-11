# Création d'un Application Load Balancer
resource "aws_lb" "web_server_lb" {
  name               = var.aws_lb_web_server_lb.name
  internal           = var.aws_lb_web_server_lb.internal
  load_balancer_type = var.aws_lb_web_server_lb.load_balancer_type
  security_groups    = [aws_security_group.webserver_sg.id]

  enable_deletion_protection = var.aws_lb_web_server_lb.enable_deletion_protection

  access_logs {
    bucket  = aws_s3_bucket.log-loadbalancer-s3-esgi.bucket
    prefix  = var.aws_lb_web_server_lb.prefix
    enabled = var.aws_lb_web_server_lb.enabled
  }

  subnet_mapping {
    subnet_id = aws_subnet.public.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.public-backup.id
  }

  tags = {
    Environment = var.aws_lb_web_server_lb.Environment
  }
  depends_on = [aws_internet_gateway.gw, aws_route_table.internet]
}

# Création d'un Target Group
resource "aws_lb_target_group" "web_server_tg" {
  name     = var.aws_lb_target_group_web_server_tg.name
  port     = var.aws_lb_target_group_web_server_tg.port
  protocol = var.aws_lb_target_group_web_server_tg.protocol
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = var.aws_lb_target_group_web_server_tg.path
    interval            = var.aws_lb_target_group_web_server_tg.interval
    healthy_threshold   = var.aws_lb_target_group_web_server_tg.healthy_threshold
    unhealthy_threshold = var.aws_lb_target_group_web_server_tg.unhealthy_threshold
    timeout             = var.aws_lb_target_group_web_server_tg.timeout
  }
  depends_on = [aws_internet_gateway.gw, aws_route_table.internet]
}

# Attacher les instances au Target Group
resource "aws_lb_target_group_attachment" "link_instance" {
  for_each         = { for idx, instance in flatten([aws_instance.instance]) : idx => instance }
  target_group_arn = aws_lb_target_group.web_server_tg.arn
  target_id        = each.value.id
  port             = var.aws_lb_target_group_attachment_port
  depends_on      = [aws_instance.instance]
}

# Activer les logs d'accès pour le Load Balancer
resource "aws_lb_listener" "web_server_lb_listener" {
  load_balancer_arn = aws_lb.web_server_lb.arn
  port              = var.aws_lb_listener_web_server_lb_listener.port
  protocol          = var.aws_lb_listener_web_server_lb_listener.protocol

  default_action {
    type             = var.aws_lb_listener_web_server_lb_listener.type
    target_group_arn = aws_lb_target_group.web_server_tg.arn
    fixed_response {
      content_type = var.aws_lb_listener_web_server_lb_listener.content_type
      status_code  = var.aws_lb_listener_web_server_lb_listener.status_code
    }
  }  
}
