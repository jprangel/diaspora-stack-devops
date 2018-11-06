## Environments

1. For that example do you need to generate a user-key in AWS, I recommended created a specific user like `terraform`

2. You must have to generate de user-key-pair for you EC2, follow this documentation (https://docs.aws.amazon.com/en_us/AWSEC2/latest/UserGuide/ec2-key-pairs.html), with those names:
```
dev-cluster
dev-bastion
tools-bastion
tools-ci
```
3. The environment `tools-environment` it will be create with range IP 172.0.0.0/16, and `dev-environment` with range IP 10.10.0.0/16. You should check if that range is available on your aws account.

4. To install those environments, access the related directory and execute consecutively;

```
terraform init
terraform plan
terraform apply
```
