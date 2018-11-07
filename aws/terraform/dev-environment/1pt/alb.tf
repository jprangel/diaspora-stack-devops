resource "aws_alb_target_group" "dev-alb" {
  name     = "dev-diaspora"
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

resource "aws_alb" "main" {
  name            = "dev-alb"
  subnets         = ["${aws_subnet.us-east-1b-public.id}","${aws_subnet.us-east-1c-public.id}"]
  security_groups = ["${aws_security_group.dev-alb.id}"]
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = "${aws_alb.main.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = "${aws_alb_target_group.dev-alb.arn}"
    type             = "forward"
  }
}