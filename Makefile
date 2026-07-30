.PHONY: up down restart status logs

# The single source of truth linking all 4 modules together
COMPOSE_COMMAND = docker compose -f compose/gateway.yml -f compose/bookstack.yml -f compose/gitea.yml -f compose/redmine.yml

up:
	@echo "Booting complete Enclave AI Cluster..."
	$(COMPOSE_COMMAND) up -d --remove-orphans

down:
	@echo "Stopping Enclave AI Cluster..."
	$(COMPOSE_COMMAND) down --remove-orphans

restart:
	@echo "Cycling Cluster..."
	$(COMPOSE_COMMAND) restart

status:
	$(COMPOSE_COMMAND) ps

logs:
	$(COMPOSE_COMMAND) logs -f --tail=100
