default: unprivileged_verilator

PROJECT_ROOT:=$(shell git rev-parse --show-toplevel)
include $(PROJECT_ROOT)/env.tools.mk

USER_ID:=$(shell id -u)
GROUP_ID:=$(shell id -g)
DOCKER:=docker
DOCKER_RUN:=$(DOCKER) run -it --rm -v $(PWD):/home/work -u $(USER_ID):$(GROUP_ID) verilator

DOCKER:=$(shell which docker)
.PHONY: all ubuntu verilator unprivileged_verilator clean default
all: ubuntu verilator local_verilator

# all packages are installed in ubuntu/Dockerfile
ubuntu: ./ubuntu/Dockerfile
	$(DOCKER) build -t ubuntu_shapechangeable \
		--progress=plain \
		--build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) \
		--build-arg VERILATOR_VERSION=$(VERILATOR_VERSION) \
		./ubuntu

# only verilator is installed in verilator/Dockerfile
verilator: ./verilator/Dockerfile
	$(DOCKER) build -t verilator_shapechangeable \
		--progress=plain \
		--build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) \
		--build-arg VERILATOR_VERSION=$(VERILATOR_VERSION) \
		./verilator

unprivileged_verilator: ./verilator/Dockerfile
	$(DOCKER) build -t unprivileged_verilator \
		--progress=plain \
		--build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) \
		--build-arg VERILATOR_VERSION=$(VERILATOR_VERSION) \
		--build-arg PROJECT_ROOT=$(PROJECT_ROOT) \
		./unprivileged_verilator

clean:
	$(DOCKER) rmi ubuntu_shapechangeable
	$(DOCKER) rmi verilator_shapechangeable
	$(DOCKER) rmi unprivileged_verilator
	$(DOCKER) builder prune -f
