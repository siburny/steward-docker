docker build -f Dockerfile-base --build-arg version=  -t siburny/steward-docker-base-rpi .
docker build -f Dockerfile-base --build-arg version=2 -t siburny/steward-docker-base-rpi2 .
docker build -f Dockerfile-base --build-arg version=3 -t siburny/steward-docker-base-rpi3 .
