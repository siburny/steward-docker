docker stop steward-dev
docker rm steward-dev
docker run -d -v c:\Projects\nodejs\steward-docker\db:/usr/src/app/db --net host --name steward-dev siburny/steward-docker