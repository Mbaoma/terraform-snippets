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

- Clean up when you're done:
```
$ terraform destroy
```

## Test
```bash
$ curl <alb_dns_name>
<h1>Hello, World</h1>
<p>DB address: using-s3-state20230821140834686300000001.cieyknjb154x.us-west-1.rds.amazonaws.com</p>
<p>DB port: 3306</p>
```

<img width="839" alt="image" src="https://github.com/Mbaoma/terraform-snippets/assets/49791498/21ef46db-0a7b-4073-a9e2-c1b02ef81870">

*Reference: Chapter 3 of [Terraform Up and Running](http://www.terraformupandrunning.com/)