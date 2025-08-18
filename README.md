# Freelancer Market Hub (fm-hub)

This is the parent project for the Freelancer Market, a microservices-based application simulating a freelance marketplace. This repository contains all the services and shared libraries required to run the application.

##  Cloning the Repository

This project uses Git submodules to manage dependencies. To ensure all modules are cloned correctly, use the `--recurse-submodules` flag:

```bash
git clone --recurse-submodules https://github.com/rahmasir/fm-hub
```

If you have already cloned the repository without this flag, you can initialize the submodules by running:

```bash
git submodule update --init --recursive
```

## 🚀 Architecture

The application follows a distributed microservice architecture. Each service is a self-contained Spring Boot application with its own responsibilities and database schema.

### Modules

* **`fm-user-service`**: Handles user registration, authentication (JWT), and profile management.
* **`fm-project-service`**: Manages projects, skills, and applications from freelancers.
* **`fm-notification-service`**: A background worker for sending notifications via RabbitMQ.
* **`fm-gateway-service`**: The single entry point (API Gateway) for all client requests.
* **`fm-shared-lib`**: A common Java library containing shared DTOs and enums.

## 🛠️ Getting Started

### Prerequisites

* Java 21
* Maven
* Docker and Docker Compose
* A Unix-like shell for running `make` commands (Git Bash or WSL on Windows).

### Build

To build all modules and install them into your local Maven repository, run the following command from this root directory:

```bash
make build
```

---

## 🏃 Running the Application

You can run the application in three modes:

### 1. Development Mode (IDE)

This mode is best for active development and debugging.

1.  **Start Infrastructure**: Run the required background services (PostgreSQL, Redis, RabbitMQ):
    ```bash
    make up-dev
    ```
2.  **Run Services from IDE**: Start each microservice (e.g., `FmUserServiceApplication`) directly from your IDE.

### 2. Standalone Service Mode (Docker Compose)

This mode is for running and testing the `fm-user-service` in complete isolation.

1.  **Build and Run**: Use a single command to build and start only the user service and its dependencies:
    ```bash
    make up-user-only
    ```
2.  **Access the Service**: The User Service API will be available at `http://localhost:8081`.

### 3. Production Mode (Docker Compose)

This mode builds and runs the entire application stack in Docker, simulating a production environment.

1.  **Build and Run**: Use a single command to build Docker images for all services and start the containers:
    ```bash
    make up-prod
    ```
2.  **Access the Application**: The API Gateway will be available at `http://localhost:8080`.

To stop the full stack, run:
```bash
make down-prod
