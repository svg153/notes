ARM_SUBSCRIPTION_ID=

b build:
	docker build \
		--build-arg TERRAFORMER_VERSION=$$(curl -s https://api.github.com/repos/GoogleCloudPlatform/terraformer/releases/latest | grep tag_name | cut -d '"' -f 4) \
		-t terraformer-azure \
		.

r run: 
	docker run -it \
		-e ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID} \
		-v $${HOME}/.azure:/root/.azure \
		-v $${HOME}/.ssh:/root/.ssh \
		terraformer-azure \
 		terraformer import azure -R PezaLab -r virtual_network,resource_group
