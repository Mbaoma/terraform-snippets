# Create a cluster of web servers

This folder contains Terraform configuration that deploys a cluster of web servers (using EC2 and Auto Scaling) and a load balancer (using ELB) in an Amazon Web Services (AWS) account. 

## Deploy the code
```bash
$ terraform init
$ terraform fmt
$ terraform validate
$ terraform plan
$ terraform apply
```

- When the ```apply``` command completes, it will output the DNS name of the load balancer. To test the load balancer:
```bash
$ curl -i <alb_dns_name>
```

<img width="564" alt="image" src="https://github.com/Mbaoma/terraform-snippets/assets/49791498/ce866ed4-fce0-4ed5-b335-4c326e69e7f0">

<img width="1158" alt="image" src="https://github.com/Mbaoma/terraform-snippets/assets/49791498/1b2e8ac7-0302-4fbb-b255-6f7933b8f6e6">

- Clean up when you're done:
```
$ terraform destroy
```

*Reference: Chapter 2 of [Terraform Up and Running](http://www.terraformupandrunning.com/)

