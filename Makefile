# Coffee Tasting API Makefile
# Cross-platform Development and Operations Commands

.PHONY: help setup start stop restart build test clean logs health db-up db-down db-logs db-reset install update docker-start docker-stop docker-logs

# Default target - show help
help:
	@echo "Coffee Tasting API - Available Commands:"
	@echo ""
	@echo "Application Management:"
	@echo "  make setup       Initial setup (DB start + install dependencies)"
	@echo "  make start       Start application (dev mode)"
	@echo "  make start-prod  Start application (prod mode)"  
	@echo "  make stop        Stop application"
	@echo "  make restart     Restart application"
	@echo ""
	@echo "Build and Test:"
	@echo "  make build       Build application"
	@echo "  make test        Run tests"
	@echo "  make test-int    Run integration tests"
	@echo "  make clean       Clean build artifacts"
	@echo "  make install     Install dependencies"
	@echo "  make update      Check dependency updates"
	@echo ""
	@echo "Database Management:"
	@echo "  make db-up       Start database (dev profile)"
	@echo "  make db-down     Stop database"
	@echo "  make db-logs     Show database logs"
	@echo "  make db-reset    Reset database"
	@echo "  make db-connect  Connect to database"
	@echo "  make db-check    Check database connection"
	@echo ""
	@echo "Docker Management:"
	@echo "  make docker-start   Start full stack (app + db)"
	@echo "  make docker-stop    Stop full stack"
	@echo "  make docker-logs    Show all container logs"
	@echo "  make docker-build   Build application Docker image"
	@echo ""
	@echo "Monitoring:"
	@echo "  make logs        Show application logs"
	@echo "  make health      Health check"
	@echo "  make status      System status check"
	@echo ""
	@echo "Maintenance:"
	@echo "  make clean-all   Clean all resources"
	@echo "  make format      Format code"

# Initial setup
setup: db-up install
	@echo "Setup completed! Run 'make start' to start the application"

# Start application (dev mode)
start:
	@echo ""
	@echo "Starting application in development mode..."
	@echo ""
	mvn spring-boot:run

# Start application (prod mode)
start-prod:
	@echo "Starting application in production mode..."
	mvn spring-boot:run -Dspring-boot.run.profiles=prod

# Stop application (cross-platform)
stop:
	@echo "Stopping application..."
	@if command -v powershell >/dev/null 2>&1; then \
		powershell -Command "Get-NetTCPConnection -LocalPort 8080 -ErrorAction SilentlyContinue | ForEach-Object { Stop-Process -Id \$$_.OwningProcess -Force -ErrorAction SilentlyContinue }"; \
	elif command -v netstat >/dev/null 2>&1 && command -v taskkill >/dev/null 2>&1; then \
		netstat -ano | grep :8080 | awk '{print $$5}' | xargs -r taskkill //F //PID 2>/dev/null || echo "No process found on port 8080"; \
	elif command -v pkill >/dev/null 2>&1; then \
		pkill -f "spring-boot:run" 2>/dev/null || pkill -f "java.*8080" 2>/dev/null || echo "No Java process found"; \
	else \
		echo "Unable to stop application - trying alternative method..."; \
		ps aux | grep java | grep 8080 | awk '{print $$2}' | xargs -r kill -9 2>/dev/null || echo "No Java process found"; \
	fi
	@echo "Application stopped"

# Restart application
restart: stop
	@echo "Restarting application..."
	@timeout /t 3 /nobreak >nul 2>&1 || sleep 3
	@$(MAKE) start

# Build
build:
	@echo "Building application..."
	mvn clean compile

# Run tests
test:
	@echo "Running tests..."
	mvn test

# Run integration tests
test-int:
	@echo "Running integration tests..."
	mvn integration-test

# Clean
clean:
	@echo "Cleaning build artifacts..."
	mvn clean

# Install dependencies
install:
	@echo "Installing dependencies..."
	mvn clean install -DskipTests

# Check dependency updates
update:
	@echo "Checking dependency updates..."
	mvn versions:display-dependency-updates
	mvn versions:display-plugin-updates

# Start database (dev profile)
db-up:
	@echo ""
	@echo "Starting database (dev profile)..."
	docker-compose --profile dev up -d
	@echo "Waiting for database to be ready..."
	@timeout /t 15 /nobreak >nul 2>&1 || sleep 15
	@echo "Database started successfully"
	@echo "  PostgreSQL: localhost:5432"
	@echo "  Database: coffee_tasting"
	@echo "  User: postgres"
	@echo "  pgAdmin: http://localhost:5050"
	@echo ""

# Stop database
db-down:
	@echo "Stopping database..."
	docker-compose --profile dev down

# Show database logs
db-logs:
	@echo "Showing database logs..."
	docker-compose --profile dev logs -f postgres

# Reset database
db-reset:
	@echo "Resetting database..."
	docker-compose --profile dev down -v
	docker-compose --profile dev up -d
	@echo "Waiting for database to be ready..."
	@timeout /t 15 /nobreak >nul 2>&1 || sleep 15
	@echo "Database reset completed"

# Connect to database
db-connect:
	@echo "Connecting to database..."
	docker exec -it coffee-tasting-postgres psql -U postgres -d coffee_tasting

# Check database connection
db-check:
	@echo "Checking database connection..."
	@docker exec coffee-tasting-postgres pg_isready -U postgres -d coffee_tasting >nul 2>&1 && echo "Database connection OK" || echo "Database not ready"

# Start full stack (app + db via Docker)
docker-start:
	@echo "Starting full stack (Docker)..."
	docker-compose --profile full up -d
	@echo "Waiting for services to be ready..."
	@timeout /t 20 /nobreak >nul 2>&1 || sleep 20
	@echo "Full stack started successfully"
	@echo "  Application: http://localhost:8080"
	@echo "  Health Check: http://localhost:8080/api/public/health"
	@echo "  PostgreSQL: localhost:5432"
	@echo "  pgAdmin: http://localhost:5050"

# Stop full stack
docker-stop:
	@echo "Stopping full stack..."
	docker-compose --profile full down

# Show all container logs
docker-logs:
	@echo "Showing all container logs..."
	docker-compose logs -f

# Build Docker image
docker-build:
	@echo "Building Docker image..."
	docker build -t coffee-tasting-api:latest .

# Show logs
logs:
	@echo "Showing application logs..."
	@if exist logs\application.log (type logs\application.log) else (echo "Log file not found. Start the application first.")

# Health check
health:
	@echo "Running health check..."
	@curl -s http://localhost:8080/api/public/health 2>nul || echo "Application is not running"

# System status
status:
	@echo "System Status Check:"
	@echo ""
	@echo "Database Status:"
	@docker-compose ps 2>nul || echo "Docker Compose not running"
	@echo ""
	@echo "Application Status:"
	@tasklist /FI "IMAGENAME eq java.exe" 2>nul | findstr java >nul && echo "Application is running" || echo "Application is stopped"
	@echo ""
	@echo "Health Check:"
	@$(MAKE) health

# Clean all resources
clean-all: db-down docker-stop clean
	@echo "Cleaning all resources..."
	docker system prune -f
	@echo "All resources cleaned"

# Format code
format:
	@echo "Formatting code..."
	@mvn spotless:apply 2>nul || echo "Spotless plugin not configured"

# Complete development reset
dev-reset: clean-all setup
	@echo "Development environment reset completed"

# Production build
build-prod:
	@echo "Building for production..."
	mvn clean package -Pprod -DskipTests

# Start development environment
dev-start: db-up
	@echo "Starting development environment..."
	@timeout /t 5 /nobreak >nul 2>&1 || sleep 5
	@$(MAKE) start

# Aliases for common commands
s: start
b: build
t: test
h: health
d: db-up
r: restart
ds: docker-start 