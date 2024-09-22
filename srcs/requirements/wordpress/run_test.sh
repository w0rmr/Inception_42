#sudo systemctl restart docker 
docker build -t wordpress .
docker run -d --privileged -it wordpress
