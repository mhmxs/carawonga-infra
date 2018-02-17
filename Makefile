PWD=$(shell pwd)
IP=192.168.64.4

all: clean restart

start: prepare
	docker-compose -f docker-compose-tmp.yml up

stop:
	docker-compose -f docker-compose-tmp.yml down

restart: stop start

clean:
	rm -rf mysql/*

prepare:
	sed 's|- \./|- $(PWD)/|' docker-compose.yml > docker-compose-tmp.yml
	sed -i 's/NEW_HOST=localhost/NEW_HOST=$(IP)/' docker-compose-tmp.yml

post-install:
	docker exec -t carawongainfra_cli_1 wp --allow-root search-replace https://carawonga.com http://$(IP):9000
	docker exec -t carawongainfra_cli_1 wp --allow-root plugin deactivate analytics-tracker cache-enabler cdn-enabler http-https-remover wordfence
	docker exec -t carawongainfra_cli_1 wp --allow-root plugin deactivate analytics-tracker cache-enabler cdn-enabler http-https-remover wordfence

sync:
	rsync -az --delete --progress --exclude .gitignore carawonga:/var/www/html/ www/