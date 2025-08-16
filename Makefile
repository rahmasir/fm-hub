# Makefile for managing Docker Compose environments

# --- Development Environment ---

# Starts the development infrastructure (Postgres, Redis, RabbitMQ) in detached mode
up-dev:
	@echo "Starting development infrastructure..."
	docker-compose -f docker-compose.dev.yml up -d

# Stops and removes the development infrastructure containers and network
down-dev:
	@echo "Stopping development infrastructure..."
	docker-compose -f docker-compose.dev.yml down

# Shows the logs for the development infrastructure
logs-dev:
	@echo "Showing development infrastructure logs..."
	docker-compose -f docker-compose.dev.yml logs -f

# --- Production Environment ---

# Builds and starts the entire application stack in detached mode
up-prod:
	@echo "Building and starting production stack..."
	docker-compose -f docker-compose.prod.yml up --build -d

# Stops and removes all production containers, networks, and volumes
down-prod:
	@echo "Stopping production stack..."
	docker-compose -f docker-compose.prod.yml down -v

# Shows the logs for all production services
logs-prod:
	@echo "Showing production stack logs..."
	docker-compose -f docker-compose.prod.yml logs -f

# --- General Commands ---

# Lists all running Docker containers
ps:
	docker ps

.PHONY: up-dev down-dev logs-dev up-prod down-prod logs-prod ps

