#sudo systemctl restart docker 
docker build -t wordpress .
docker run -d  --mount source=test,target=/var/www/html --network=inception --name=wordpress --privileged -it wordpress
