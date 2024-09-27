#sudo systemctl restart docker 
docker build -t mariadb .
docker run -d --privileged -it mariadb 
