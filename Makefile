.DEFAULT_GOAL := help

DOCKER_COMPOSE := docker compose
DOCKER_COMPOSE_FILE := srcs/docker-compose.yml

.PHONY: help
help:
	@echo "\033[32m --------------- INCEPTION --------------- \033[0m"
	@echo "\033[31m Available targets:\033[0m"
	@echo "\033[34m  up        :\033[0m Start the Docker containers"
	@echo "\033[34m  down      :\033[0m Stop and remove the Docker containers"
	@echo "\033[34m  restart   :\033[0m Restart the Docker containers"
	@echo "\033[34m  logs      :\033[0m View the logs of the Docker containers"
	@echo "\033[34m  clean     :\033[0m Clean up the Docker containers and volumes"
	@echo "\033[34m  fclean    :\033[0m Force clean up all Docker containers, volumes, and prune system"

.PHONY: up
up:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d --build 

.PHONY: down
down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

.PHONY: restart
restart: down up

.PHONY: set_host
set_host:
	sudo echo "127.0.0.1	atoukmat.42.fr" >> /etc/hosts

.PHONY: logs
logs:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f 

.PHONY: clean
clean:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v

.PHONY: fclean
fclean: clean
	docker system prune -a --volumes -f
