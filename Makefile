.PHONY: setup_state_bucket check_tenant check_environment

prepare_base_infra:
	cd ./base-infra/my-vpc && \
	terraform init && \
	terraform plan -out=terraform.tfplan && \
	terraform apply terraform.tfplan

check_environment:
ifndef environment
	$(error environment is undefined)
endif
check_tenant:
ifndef tenant
	$(error tenant is undefined)
endif