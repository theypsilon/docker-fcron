.PHONY: docker-image docker-push docker-pull docker-test docker-run

REGISTRY=localhost
PROJECT=fcrontest
TAG=latest
IMAGE=$(REGISTRY)/$(PROJECT):$(TAG)

docker-image:
	docker build -t $(IMAGE) .

docker-push:
	docker push $(IMAGE)

docker-pull:
	docker pull $(IMAGE)

NAME=$(PROJECT)_container
PORT=6767

docker-run: docker-image
	docker run --rm -it --name $(NAME)_server $(IMAGE)

docker-test: docker-image
	docker run --name $(NAME)_test --rm  $(IMAGE) true
