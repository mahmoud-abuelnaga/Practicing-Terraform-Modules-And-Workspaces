# ----------- Variables ----------- #
env := 
tf_args := 

# ----------- Targets ----------- #
keys/ec2-key:
	@mkdir -p keys
	@echo "Generating EC2 key pair..."
	@ssh-keygen -t rsa -b 4096 -f keys/ec2-key -N "" -C "ec2-key"
	@echo "EC2 key pair generated at keys/ec2-key and keys/ec2-key.pub"

.PHONY: terraform-init
terraform-init:
	@echo "Initializing Terraform..."
	@terraform init

.PHONY: terraform-apply
terraform-apply: workspace-switch keys/ec2-key
	@echo "Applying Terraform configuration..."
	@terraform apply -var="environment=$(env)" $(tf_args) -auto-approve

.PHONY: terraform-destroy
terraform-destroy: workspace-switch
	@echo "Destroying Terraform-managed infrastructure..."
	@terraform destroy -var="environment=$(env)" $(tf_args) -auto-approve

.PHONY: terraform-plan
terraform-plan: workspace-switch keys/ec2-key
	@echo "Planning Terraform changes..."
	@terraform plan -var="environment=$(env)" $(tf_args)

.PHONY: terraform-format
terraform-format:
	@echo "Formatting Terraform files..."
	@terraform fmt

.PHONY: terraform-validate
terraform-validate:
	@echo "Validating Terraform configuration..."
	@terraform validate

.PHONY: validate-env
validate-env:
	@if [[ "$(env)" != "dev" && "$(env)" != "prod" && "$(env)" != "staging" ]]; then \
		echo "Error: Invalid environment specified. Use 'dev', 'prod', or 'staging'. Environment is set using 'env' make variable"; \
		exit 1; \
	fi

.PHONY: workspace-switch
workspace-switch: validate-env
	@echo "Switching to Terraform workspace for environment: $(env)"
	@if terraform workspace list | grep $(env); then \
		terraform workspace select $(env); \
	else \
		terraform workspace new $(env); \
	fi