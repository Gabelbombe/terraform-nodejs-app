STATE_DIR = _state
REGION 		= us-west-2

check:
	@if test "$(aws_access_key)" = "" ; then echo "AWS Access key is not set.." ; exit 1 ; fi
	@if test "$(aws_secret_key)" = "" ; then echo "AWS Secret key is not set.." ; exit 1 ; fi

# Clean terraform modules if they exist...
clean:
	rm -rf ./.terraform

# Dry run.
plan-app: check
	terraform init
	terraform plan -state=$(STATE_DIR)/$(REGION)_nodejs-app.tfstate 	\
		-var region=$(REGION) 																					\
		-var access_key="$$(aws_access_key)" 														\
		-var secret_key="$$(aws_secret_key)"


# Deploy resources.
apply-app: check
	terraform apply -state=$(STATE_DIR)/$(REGION)_nodejs-app.tfstate 	\
		-var region=$(REGION) 																					\
		-var access_key="$$(aws_access_key)" 														\
		-var secret_key="$$(aws_secret_key)"


# Destroy resources.
destroy-app: check
	terraform destroy -state=$(STATE_DIR)/$(REGION)_nodejs-app.tfstate 	\
		-var region=$(REGION) 																						\
		-var access_key="$$(aws_access_key)" 															\
		-var secret_key="$$(aws_secret_key)"
