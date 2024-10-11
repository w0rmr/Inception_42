#sudo systemctl restart docker 
docker build -t mariadb_test .
docker run --env-file .env --mount source=test,target=/var/www/html --network=inception -d --name=mariadb_test --privileged -it mariadb_test
