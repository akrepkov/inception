NAME = inception

all:
	@printf "Start containers"
	@docker-compose -f ./docker-compose.yml up -d

build:
	@printf "Build images before starting containers"
	@docker-compose -f ./docker-compose.yml up -d --build

down:
	@printf "Stop containers"
	@docker-compose -f ./docker-compose.yml down

re: down
	@printf "Restart containers"
	@docker-compose -f ./docker-compose.yml up -d --build

clean: down
	@printf "Remove unused networks, containers, images, volumes"
	@docker system prune -a

fclean:
	@printf "Remove all containers, volumes, networks and images"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force

.PHONY : all build down re clean fclean
