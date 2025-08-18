# Cross-platform Makefile for managing Docker Compose and Maven builds

# Detect OS
ifeq ($(OS),Windows_NT)
	SHELL := cmd.exe
	MVN := mvnw.cmd
	DOCKER_COMPOSE := docker-compose
else
	SHELL := /bin/bash
	MVN := ./mvnw
	DOCKER_COMPOSE := docker-compose
endif


# --- Maven Commands ---

# Cleans all modules and installs them into the local Maven repository.
build:
	@echo "Building all modules..."
	$(MVN) clean install

# Cleans and packages all modules into JAR files.
package:
	@echo "Packaging all modules..."
	$(MVN) clean package


# --- Development Environment ---

# Starts the development infrastructure (Postgres, Redis, RabbitMQ).
up-dev:
	@echo "Starting development infrastructure..."
	$(DOCKER_COMPOSE) -f docker-compose.dev.yml up -d

# Stops the development infrastructure.
down-dev:
	@echo "Stopping development infrastructure..."
	$(DOCKER_COMPOSE) -f docker-compose.dev.yml down

# Stops the development infrastructure AND removes persistent data volumes.
down-dev-v:
	@echo "Stopping development infrastructure and removing volumes..."
	$(DOCKER_COMPOSE) -f docker-compose.dev.yml down -v

# Shows the logs for the development infrastructure.
logs-dev:
	@echo "Showing development infrastructure logs..."
	$(DOCKER_COMPOSE) -f docker-compose.dev.yml logs -f


# --- Database Commands (for Development Environment) ---

# Seeds the user-service database with initial data.
db-seed:
	@echo "Seeding the user-service database..."
	$(DOCKER_COMPOSE) -f docker-compose.dev.yml exec -T postgres-user-db psql -U fm_user -d fm_user_service_db < ./scripts/seed.sql

# Truncates all tables in the user-service database.
db-clear:
	@echo "Clearing all data from user-service database tables..."
	$(DOCKER_COMPOSE) -f docker-compose.dev.yml exec -T postgres-user-db psql -U fm_user -d fm_user_service_db -c "TRUNCATE TABLE skill, freelancer_profile, employer_profile, app_user CASCADE;"


# --- Production Environment ---

# Builds and starts the entire application stack.
up-prod:
	@echo "Building and starting production stack..."
	$(DOCKER_COMPOSE) -f docker-compose.prod.yml up --build -d

# Stops and removes all production containers, networks, and volumes.
down-prod:
	@echo "Stopping production stack..."
	$(DOCKER_COMPOSE) -f docker-compose.prod.yml down -v

# Shows the logs for all production services.
logs-prod:
	@echo "Showing production stack logs..."
	$(DOCKER_COMPOSE) -f docker-compose.prod.yml logs -f


# --- General Commands ---

# Lists all running Docker containers.
ps:
	docker ps


# --- Standalone User Service Environment ---

# Builds and starts only the user service and its dependencies.
up-user-only:
	@echo "Building and starting standalone user service stack..."
	docker-compose -f docker-compose.user-only.yml up --build -d

# Stops the standalone user service stack.
down-user-only:
	@echo "Stopping standalone user service stack..."
	docker-compose -f docker-compose.user-only.yml down -v

.PHONY: build package up-dev down-dev down-dev-v logs-dev db-seed db-clear up-prod down-prod logs-prod ps up-user-only down-user-only
