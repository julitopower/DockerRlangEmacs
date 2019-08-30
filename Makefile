all:

.PHONY: build run
build:
	docker build -t julitopower/dockerremacs .

run:
	docker run -it --rm -v $(shell pwd)/../:/opt/src/ julitopower/dockerremacs /bin/bash
