PWD=$(shell pwd)

all: restart

start: prepare
	docker-compose -f docker-compose-tmp.yml up

stop:
	docker-compose -f docker-compose-tmp.yml down

restart: stop clean start

clean:
	rm -rf mysql/*

prepare:
	#sed "s/carawonga.com/192.168.99.100:9000/g" shared/dump.sql > shared/dump-tmp.sql
	#sed -i "s|https://192|http://192|g" shared/dump-tmp.sql
	sed 's|- \./|- $(PWD)/|' docker-compose.yml > docker-compose-tmp.yml
	sed -i 's/NEW_HOST=localhost/NEW_HOST=192.168.99.100/' docker-compose-tmp.yml
	# sed -i 's/dump.sql/dump-tmp.sql/' docker-compose-tmp.yml

# $(shell sed -i '1 s/^.*\$/USE carawonga;/' shared/dump-tmp.sql)
# -- INSERT INTO `wp_wf