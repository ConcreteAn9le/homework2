setup_vpc:
	cd ./base-infra/my-vpc && \
	terraform init  && \
	terraform plan  -out=terraform.tfplan && \
	terraform apply terraform.tfplan