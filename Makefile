
PROJECT=sbriesemeister/appengine-gcloud-python
LABEL=$(shell head -n 1 ./imagelabel.txt)
DEPS:=$(shell find ./ -type f -name '*.sh' -o -name '*.txt')

all: build


build: $(DEPS)
	docker build --pull --target clean -t $(PROJECT):test .


push-latest:
	docker build -t $(PROJECT):$(LABEL) .
	docker push $(PROJECT):$(LABEL)

