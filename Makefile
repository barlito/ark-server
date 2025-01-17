stack_name=ark_server

app_container_id = $(shell docker ps --filter name="$(stack_name)" -q)

.PHONY: bash
bash:
	docker exec -it -u root $(app_container_id) bash

.PHONY: deploy
deploy:
	mkdir -p ark-server
	mkdir -p config
	docker-compose up -d

.PHONY: undeploy
undeploy:
	docker-compose down

.PHONY: restart
restart:
	make undeploy
	make deploy

.PHONY: restart-server
restart-server:
	docker exec ark_server arkmanager restart

.PHONY: update-server
update-server:
	docker exec ark_server arkmanager update --update-mods --backup --warn 

.PHONY: logs
logs:
	docker-compose logs -f
