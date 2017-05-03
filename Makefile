all: docker


.PHONY: all


docker:
	git submodule update --init
	docker build -t informjs/inform .


.PHONY: docker
