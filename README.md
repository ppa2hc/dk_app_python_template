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
docker stop dk_app_python_template; docker rm dk_app_python_template;docker run -d -it --name dk_app_python_template -v ~/.dk/generated/vss/vehicle_gen/:/home/vss/vehicle_gen:ro --network dk_network dk_app_python_template:latest
```

## Run docker container from docker hub
```
docker stop dk_app_python_template; docker rm dk_app_python_template;docker run -d -it --name dk_app_python_template -v ~/.dk/generated/vss/vehicle_gen/:/home/vss/vehicle_gen:ro --network dk_network phongbosch/dk_app_python_template:latest
```
