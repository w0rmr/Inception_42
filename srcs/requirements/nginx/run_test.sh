sudo systemctl restart docker 
docker build -t nginx .
docker run -p 8080:8080 -p 443:443 -d --privileged -it nginx 
