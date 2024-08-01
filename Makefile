MAKEQ := $(MAKE) --no-print-directory
BINARY_NAME=SyncChatServer

ifeq (, $(shell which docker-compose))
    DOCKER_COMPOSE=docker compose
else
    DOCKER_COMPOSE=docker-compose
endif

default: run

.PHONY: dev-backend

dev-backend:
	@echo "Starting database"
	${DOCKER_COMPOSE} up database-dev
	@echo "Starting server"
	go run ./backend/

.PHONY: run

run: 
	${DOCKER_COMPOSE} up database
	${DOCKER_COMPOSE} up backend
	${DOCKER_COMPOSE} up frontend


.PHONY: check_clean

check_clean:
	@echo "This will reset the database volume. This action is irreversible."
	@echo -n "Are you sure you want to proceed? [y/N] " && read ans; \
    if [ $${ans:-N} != y ] && [ $${ans:-N} != Y ]; then \
        echo "Operation canceled."; \
        exit 1; \
    fi

.PHONY: reset

reset: check_clean
	@echo ${DB_UNAME}
