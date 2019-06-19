========Sample script======
#!/bin/bash

USEDMEMORY=$(free -m | awk 'NR==2{printf "%.2f\t", $3*100/$2 }')
HOSTNAME=$(hostname)
KERNEL=$(hostnamectl | Kernel )
DISTRI=$(lsb_release -a | Description )
 
aws cloudwatch put-metric-data --metric-name memory-usage --dimensions Instance=$HOSTNAME  --namespace "Custom" --value $USEDMEMORY
aws cloudwatch put-metric-data --metric-name kernel-version --dimensions Instance=$HOSTNAME  --namespace "Custom" --value $KERNEL
aws cloudwatch put-metric-data --metric-name Distribution-name --dimensions Instance=$HOSTNAME  --namespace "Custom" --value $DISTRI
===============================================