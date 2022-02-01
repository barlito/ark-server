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

.Phone: restart
restart:
	make undeploy
	make deploy

.PHONY: logs
logs:
	docker-compose logs -f
