resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "my-dashboard"
  
  count      = "${length(local.instance_id_var)}"
  InstanceId = "${element(aws_instance.example.id,count.index)}"

  dashboard_body = <<EOF
 {
   "widgets": [
       {
          "type":"metric",
          "x":0,
          "y":0,
          "width":12,
          "height":6,
          "properties":{
             "metrics":[
                [
                   "AWS/EC2",
                   "CPUUtilization",
                   "${InstanceId}",
                ]
             ],
             "period":300,
             "stat":"Average",
             region = "${var.AWS_REGION}",
             "title":"EC2 Instance CPU"
          }
       },
       {
          "type":"text",
          "x":0,
          "y":7,
          "width":3,
          "height":3,
          "properties":{
             "markdown":"CPU"
          }
       },
       {
                 "type":"metric",
                 "x":0,
                 "y":0,
                 "width":12,
                 "height":6,
                 "properties":{
                    "metrics":[
                       [
                          "AWS/EC2",
                          "MemoryUtilization",
                          "${InstanceId}",
                       ]
                    ],
                    "period":300,
                    "stat":"Average",
                    region = "${var.AWS_REGION}",
                    "title":"EC2 Instance Memory"
                 }
              },
              {
                 "type":"text",
                 "x":0,
                 "y":7,
                 "width":3,
                 "height":3,
                 "properties":{
                    "markdown":"Memory"
                 }
       }
   ]
 }
 EOF
}