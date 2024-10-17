# dk_app_python_template

> Info: This repo provides a guideline to build a docker image for your SDV python app running on dreamkit.

## Prerequisites:
Install dreamSW.     

## Build docker image
Local-arch build  
```
docker build -t dk_app_coffee_machine_outin:latest --file Dockerfile .
```

Multi-arch build and push to docker hub  
```
docker buildx create --name dk_app_coffee_machine_outin_multiarch_build --use
docker buildx build --platform linux/amd64,linux/arm64 -t phongbosch/dk_app_coffee_machine_outin:latest --push .
```

## Run local built docker container
```
docker stop dk_app_coffee_machine_outin ; docker rm dk_app_coffee_machine_outin ; docker run -d -it --name dk_app_coffee_machine_outin --log-opt max-size=10m --log-opt max-file=3 -v ~/.dk/dk_vssgeneration/vehicle_gen:/home/vss/vehicle_gen:ro --network dk_network dk_app_coffee_machine_outin:latest
```

## Run docker container from docker hub
```
docker pull phongbosch/dk_app_coffee_machine_outin:latest
docker stop dk_app_coffee_machine_outin ; docker rm dk_app_coffee_machine_outin ; docker run -d -it --name dk_app_coffee_machine_outin --log-opt max-size=10m --log-opt max-file=3 -v ~/.dk/dk_vssgeneration/vehicle_gen:/home/vss/vehicle_gen:ro --network dk_network phongbosch/dk_app_coffee_machine_outin:latest
```
