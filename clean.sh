docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker volume rm $(docker volume ls -q)
#docker network rm $(docker network ls -q)
docker system prune -a --volumes