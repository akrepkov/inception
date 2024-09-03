NAME = inception

all:
	@echo "Start containers\n"
	@docker-compose -f ./docker-compose.yml up -d

build:
	@echo "Build images before starting containers\n"
	@docker-compose -f ./docker-compose.yml up -d --build

down:
	@echo "Stop containers\n"
	@docker-compose -f ./docker-compose.yml down

re: down
	@echo "Restart containers\n"
	@docker-compose -f ./docker-compose.yml up -d --build

clean: down
	@echo "Remove unused networks, containers, images, volumes\n"
	@docker system prune --all --force

fclean:
	@echo "Remove all containers, volumes, networks and images\n"
	@docker stop $(docker ps -aq) || true 
	@docker-compose down 
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force

#Stop all running containers; `|| true` to avoid errors if no containers are running
#kill mariadb???
#refresh firefox?
#@docker-compose down  do I need it in fclean?

.PHONY : all build down re clean fclean
