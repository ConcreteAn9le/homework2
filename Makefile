prepare_base_infra:
	cd ./base-infra/my-vpc && \
	terraform init && \
	terraform plan -out=terraform.tfplan

apply_base_infra:
	cd ./base-infra/my-vpc && \
	terraform init && \
	terraform apply terraform.tfplan