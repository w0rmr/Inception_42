sudo systemctl restart docker 
docker docker build -t test .
docker run --privileged -it test /bin/bash
