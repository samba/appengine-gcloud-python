
PROJECT=sbriesemeister/appengine-gcloud-python

all: build


build:
	docker build --pull --target clean -t ${PROJECT}:test .


push-latest:
	docker build -t ${PROJECT}:latest .
	docker push ${PROJECT}:latest

