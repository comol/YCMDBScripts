# Scripts for Yandex Cloud CLI services

1) PostgresClusterCreate.ps - PowerShell script to create a 1C Enterprise adopted instance of PostgreSQL
2) PostgresClusterCreate.sh - Bash script to create a 1C Enterprise adopted instance of PostgreSQL

# Teraform
Terraform folder - Terraform configs
ProdPostgres - for production cluster on local SSD
TestPostgres - minumum resources postgres for test

##commands:
###windows:
```
choco install terraform
```

###ubuntu:
```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform
```


after install:

```
terraform init
terraform validate
terraform plan
terraform apply
```

