# dk_app_python_template

> Info: This repo provides a guideline to build a docker image for your SDV python app running on dreamkit.

## Prerequisites:
Install dreamSW.     

## Build docker image
Local-arch build  
```
docker build -t dk_app_python_template:latest --file Dockerfile .
```

Multi-arch build and push to docker hub  
```
docker buildx create --name dk_multiarch_build --use
docker buildx build --platform linux/amd64,linux/arm64 -t phongbosch/dk_app_python_template:latest --push .
```

## Run local built docker container
```
docker stop dk_app_python_template ; docker rm dk_app_python_template ; docker run -d -it --name dk_app_python_template --log-opt max-size=10m --log-opt max-file=3 -v ~/.dk/generated/vss/vehicle_gen/:/home/vss/vehicle_gen:ro --network dk_network dk_app_python_template:latest
```

## Run docker container from docker hub
```
docker pull phongbosch/dk_app_python_template:latest
docker stop dk_app_python_template ; docker rm dk_app_python_template ; docker run -d -it --name dk_app_python_template --log-opt max-size=10m --log-opt max-file=3 -v ~/.dk/generated/vss/vehicle_gen/:/home/vss/vehicle_gen:ro --network dk_network phongbosch/dk_app_python_template:latest
```

## Notes
This image build is based on python:3.12-bookworm. The template is a simple app which uses python default libs. If the app wants to use 3rd libs that can be extensibly installed by pip, 3rd libs should be put into app-requirements.txt before docker build.  
  
Testing: Using common SDK for every app. Currently built (Dockerfile.PrebuiltSdk) for amd64 and arm64. It helps to reduce the app docker image size.  
Local build:  
```
docker build -t dk_app_python_template:latest --file Dockerfile.PrebuiltSdk .
docker stop dk_app_python_template ; docker rm dk_app_python_template ; docker run -d -it --name dk_app_python_template --log-opt max-size=10m --log-opt max-file=3 -v ~/.dk/generated/vss/vehicle_gen/:/home/vss/vehicle_gen:ro -v ~/.dk/dk_app_python_template/target/amd64/python-packages:/home/python-packages:ro --network dk_network  dk_app_python_template:latest
```
Multi-arch build and push to docker hub:    
```
docker buildx create --name dk_multiarch_build --use
docker buildx build --platform linux/amd64,linux/arm64 -t phongbosch/dk_app_python_template:mountsdk --push -f Dockerfile.PrebuiltSdk .
```
Run docker container from docker hub:  
```
docker stop dk_app_python_template ; docker rm dk_app_python_template ; docker run -d -it --name dk_app_python_template --log-opt max-size=10m --log-opt max-file=3 -v ~/.dk/generated/vss/vehicle_gen/:/home/vss/vehicle_gen:ro -v ~/.dk/dk_app_python_template/target/amd64/python-packages:/home/python-packages:ro --network dk_network phongbosch/dk_app_python_template:mountsdk
```
