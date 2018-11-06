resource "aws_alb" "main" {
  name            = "tools-alb"
  subnets         = ["${aws_subnet.us-east-1b-public.id}","${aws_subnet.us-east-1c-public.id}"]
  security_groups = ["${aws_security_group.tools_alb.id}"]
}

resource "aws_alb_target_group" "tools-alb" {
  name     = "tools-ci"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.default.id}"
  health_check {
    interval            = "30"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "25"
    healthy_threshold   = "5"
    unhealthy_threshold = "5"
    matcher             = "200"
}
}
resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.main.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = "${aws_alb_target_group.tools-alb.arn}"
    type             = "forward"
  }
}
resource "aws_lb_target_group_attachment" "tools_ci" {
  target_group_arn = "${aws_lb_target_group.tools_ci.arn}"
  target_id        = "${aws_instance.tools-ci.id}"
  port             = 8080
}



resource "aws_alb_target_group" "tools_monitor" {
  name     = "tools-monitor"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.aws_vpc}"
}
resource "aws_alb_listener_rule" "tools_monitor" {
  listener_arn = "${var.alb_http}"
  priority = 70
  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.tools_monitor.arn}"
  }
  condition {
    field = "host-header"
    values = ["tools-monitor.copiloto.cloud"]
  }
}
resource "aws_lb_target_group_attachment" "tools_monitor" {
  target_group_arn = "${aws_lb_target_group.tools_monitor.arn}"
  target_id        = "${aws_instance.tools-monitor.id}"
  port             = 80
}



resource "aws_alb_target_group" "tools_logs" {
  name     = "tools-logs"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.aws_vpc}"
}
resource "aws_alb_listener_rule" "tools_logs" {
  listener_arn = "${var.alb_http}"
  priority = 70
  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.tools_logs.arn}"
  }
  condition {
    field = "host-header"
    values = ["tools-logs.copiloto.cloud"]
  }
}
resource "aws_lb_target_group_attachment" "tools_logs" {
  target_group_arn = "${aws_lb_target_group.tools_logs.arn}"
  target_id        = "${aws_instance.tools-logs.id}"
  port             = 80
}