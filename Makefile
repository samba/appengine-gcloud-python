
all: build


build:
	docker build -t sbriesemeister/appengine-gcloud-python:test .

