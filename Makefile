PWD=$(shell pwd)

IP=192.168.99.100

all: restart

start: _prepare
	docker-compose -f docker-compose-tmp.yml up

stop: _prepare
	docker-compose -f docker-compose-tmp.yml down

restart: stop start 

_prepare:
	sed 's|- \./|- $(PWD)/|' docker-compose.yml > docker-compose-tmp.yml
	sed -i 's/NEW_HOST=localhost/NEW_HOST=$(IP)/' docker-compose-tmp.yml

post-install:
	docker-compose exec cli wp --allow-root search-replace https://carawonga.com http://$(IP):9000
	docker-compose exec cli wp --allow-root plugin deactivate analytics-tracker cache-enabler cdn-enabler http-https-remover wordfence

sync:
	rsync -az --delete --progress --exclude ShortpixelBackups --exclude .gitignore --exclude wp-content/uploads/cache --exclude wp-content/cache/cache-enabler carawonga:/var/www/html/ www/

open:
	open http://$(IP):9000

admin:
	open http://$(IP):9000/wp-admin/admin.php

myadmin:
	open http://$(IP):9001
