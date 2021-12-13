prepare_base_infra:
	cd ./base-infra/my-vpc && \
	terraform init -reconfigure && \
	terraform plan -out=terraform.tfplan

apply_base_infra:
	cd ./base-infra/my-vpc && \
	terraform init -reconfigure && \
	terraform apply terraform.tfplan