resource "aws_sns_topic" "alarm" {
  name = "alarms-topic"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF

  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.alarms_email}"
  }
}


resource "aws_cloudwatch_metric_alarm" "cpu" {
  count  		    = "${length(local.instance_id_var)}"
  alarm_name                = "${element(split(",",join(",",aws_instance.example.*.id)),count.index)}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "90"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions             = [ "${aws_sns_topic.alarm.arn}" ]

  dimensions {
    InstanceId = "${element(aws_instance.example.id,count.index)}"
  }
}

resource "aws_cloudwatch_metric_alarm" "memory" {
    count  		    = "${length(local.instance_id_var)}"
    alarm_name = "${element(split(",",join(",",aws_instance.example.*.id)),count.index)}"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "MemoryUtilization"
    namespace = "System/Linux"
    period = "300"
    statistic = "Average"
    threshold = "80"
    alarm_description = "This metric monitors ec2 memory for high utilization on agent hosts"
    alarm_actions = [ "${aws_sns_topic.alarm.arn}" ]
    
    dimensions {
        InstanceId = "${element(aws_instance.example.id,count.index)}"
    }
}