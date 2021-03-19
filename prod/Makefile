export HOSTNAME?=carawonga.infra
export PUB_KEY?="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAQEegZ89+oYcWf8le3SxyvSdiQUhkp5SfhUdltf78lxWlUVnHrsfLfRfAX2CnRKndnXjKj0ScaAGq2+duqKVTyVQrqtYvb9xC7kQMwMq2Z0SjPATN1EaKm6FQnLAZsw4Q6uKEuXVCEQ0s7bbz3z8f6YXG3sAno8cciuLDTiMjtu/O/71yfrRmG29vs5kvl/k1lX9OfquWlHIOhjREO3y0BNN9K6WjnCgAdEsJZdJ+PPTFq/2ciWqrVxi29ooGZ4lhmUDAzJnSD4btHjuh33FnuDGi7IfHbX9jOUsxRyDG+huwh3hSP/gV4Va1jdBqijswha9uWAwioA0HyLMgrmqD rkovacs@Richard-Kovacs-MBP.local"

SSH_USER?=root
SSH_HOST?=carawonga.com

_sync-www:
	rsync -az --delete --progress --exclude ShortpixelBackups --exclude .gitignore --exclude wp-content/uploads/cache --exclude wp-content/cache/cache-enabler $(SSH_USER)@$(SSH_HOST):/var/www/ tmp/www/
	(cd tmp/www ; rm -rf ../www.tar ; tar -cvf ../www.tar *)

_sync-db:
ifndef MYSQL_USER
	$(error missing MYSQL_USER)
endif
ifndef MYSQL_PWD
	$(error missing MYSQL_PWD)
endif
	ssh $(SSH_USER)@$(SSH_HOST) mysqldump -u$(MYSQL_USER) -p$(MYSQL_PWD) --all-databases > tmp/database.sql

sync: _sync-www _sync-db

serv:
ifndef AUTH_TOKEN
	$(error missing AUTH_TOKEN)
endif
ifndef AUTH_USER
	$(error missing AUTH_USER)
endif
ifndef AUTH_PWD
	$(error missing AUTH_PWD)
endif
	docker run --rm -v $(PWD)/tmp:/www -it node:current-alpine sh -c "npm install ngrok -g ; ngrok http --authtoken="$(AUTH_TOKEN)" --auth='$(AUTH_USER):$(AUTH_PWD)' --bind-tls=true file:///www"

render:
ifndef HOSTNAME
	$(error missing HOSTNAME)
endif
ifndef AUTH_USER
	$(error missing AUTH_USER)
endif
ifndef AUTH_PWD
	$(error missing AUTH_PWD)
endif
ifndef NGROK_HOST
	$(error missing NGROK_HOST)
endif
ifndef MYSQL_USER
	$(error missing MYSQL_USER)
endif
ifndef MYSQL_PWD
	$(error missing MYSQL_PWD)
endif
ifndef MYSQL_ROOT_PASSWORD
	$(error missing MYSQL_ROOT_PASSWORD)
endif
	@eval "echo \"$$(cat infra.yml)\"" > infra-tmp.yml

transpile-fcct: render
	docker run -i --rm quay.io/coreos/fcct:release --pretty --strict < infra-tmp.yml > infra.ign