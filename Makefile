.PHONY: docker-image docker-push docker-pull docker-test

REGISTRY=theypsilon
PROJECT=fcron
FCRON_VERSION=3.2.0
FCRON_MIRROR=http://fcron.free.fr/archives
IMAGE=$(REGISTRY)/$(PROJECT):$(FCRON_VERSION)

docker-image:
	docker build \
	--build-arg FCRON_VERSION=$(FCRON_VERSION) \
	--build-arg FCRON_MIRROR=$(FCRON_MIRROR) \
	-t $(IMAGE) .

docker-push:
	docker push $(IMAGE)

docker-pull:
	docker pull $(IMAGE)

docker-test: docker-image
	docker run --rm -it --name $(PROJECT)_test -v `pwd`:/fcron/ $(IMAGE)
