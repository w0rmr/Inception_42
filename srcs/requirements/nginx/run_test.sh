sudo systemctl restart docker 
docker build -t test .
docker run -d --privileged -it test /bin/bash
