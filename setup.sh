#!/bin/bash

# BookMeAShow - Setup Script
# This script sets up the entire development environment

set -e

echo "🎬 BookMeAShow - Complete Setup Script"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check prerequisites
check_prerequisites() {
    echo -e "\n${YELLOW}Checking prerequisites...${NC}"
    
    command -v docker >/dev/null 2>&1 || { echo -e "${RED}Docker is required but not installed.${NC}" >&2; exit 1; }
    command -v docker-compose >/dev/null 2>&1 || { echo -e "${RED}Docker Compose is required but not installed.${NC}" >&2; exit 1; }
    command -v java >/dev/null 2>&1 || { echo -e "${YELLOW}Java is not installed. Will use Docker for backend.${NC}"; }
    command -v node >/dev/null 2>&1 || { echo -e "${YELLOW}Node.js is not installed. Will use Docker for frontend.${NC}"; }
    
    echo -e "${GREEN}✓ Prerequisites check complete${NC}"
}

# Setup backend
setup_backend() {
    echo -e "\n${YELLOW}Setting up Backend...${NC}"
    
    cd backend
    
    if command -v java &> /dev/null && command -v mvn &> /dev/null; then
        echo "Building with Maven..."
        ./mvnw clean install -DskipTests || mvn clean install -DskipTests
    else
        echo "Skipping local Maven build (will use Docker)"
    fi
    
    cd ..
    echo -e "${GREEN}✓ Backend setup complete${NC}"
}

# Setup frontend
setup_frontend() {
    echo -e "\n${YELLOW}Setting up Frontend...${NC}"
    
    cd frontend
    
    if command -v node &> /dev/null; then
        echo "Installing npm dependencies..."
        npm install
        
        # Create .env.local if it doesn't exist
        if [ ! -f .env.local ]; then
            cat > .env.local << EOL
NEXT_PUBLIC_API_URL=http://localhost:8080/api
NEXT_PUBLIC_WS_URL=ws://localhost:8080/ws
EOL
            echo "Created .env.local file"
        fi
    else
        echo "Skipping npm install (will use Docker)"
    fi
    
    cd ..
    echo -e "${GREEN}✓ Frontend setup complete${NC}"
}

# Start Docker services
start_docker() {
    echo -e "\n${YELLOW}Starting Docker services...${NC}"
    
    docker-compose down -v
    docker-compose up -d postgres mongodb redis elasticsearch zookeeper kafka
    
    echo "Waiting for services to be ready..."
    sleep 30
    
    echo -e "${GREEN}✓ Infrastructure services started${NC}"
}

# Start application services
start_application() {
    echo -e "\n${YELLOW}Starting Application services...${NC}"
    
    docker-compose up -d backend frontend nginx
    
    echo "Waiting for application to start..."
    sleep 20
    
    echo -e "${GREEN}✓ Application services started${NC}"
}

# Display information
display_info() {
    echo -e "\n${GREEN}========================================${NC}"
    echo -e "${GREEN}🎉 BookMeAShow Setup Complete! 🎉${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "${YELLOW}Access your application:${NC}"
    echo -e "  🌐 Frontend:     ${GREEN}http://localhost:3000${NC}"
    echo -e "  🔌 Backend API:  ${GREEN}http://localhost:8080${NC}"
    echo -e "  📚 API Docs:     ${GREEN}http://localhost:8080/swagger-ui.html${NC}"
    echo -e "  📊 Prometheus:   ${GREEN}http://localhost:9090${NC}"
    echo -e "  📈 Grafana:      ${GREEN}http://localhost:3001${NC} (admin/admin)"
    echo ""
    echo -e "${YELLOW}Database Access:${NC}"
    echo -e "  PostgreSQL:  ${GREEN}localhost:5432${NC} (bookmeashow/bookmeashow_user/bookmeashow_pass)"
    echo -e "  MongoDB:     ${GREEN}localhost:27017${NC} (admin/admin123)"
    echo -e "  Redis:       ${GREEN}localhost:6379${NC} (password: redis123)"
    echo ""
    echo -e "${YELLOW}Default Credentials:${NC}"
    echo -e "  Admin:  ${GREEN}admin@bookmeashow.com${NC} / ${GREEN}admin123${NC}"
    echo -e "  User:   ${GREEN}user@test.com${NC} / ${GREEN}user123${NC}"
    echo ""
    echo -e "${YELLOW}Useful Commands:${NC}"
    echo -e "  View logs:           ${GREEN}docker-compose logs -f${NC}"
    echo -e "  Stop services:       ${GREEN}docker-compose down${NC}"
    echo -e "  Restart:             ${GREEN}docker-compose restart${NC}"
    echo -e "  View running:        ${GREEN}docker-compose ps${NC}"
    echo ""
    echo -e "${YELLOW}Development:${NC}"
    echo -e "  Run backend locally:  ${GREEN}cd backend && ./mvnw spring-boot:run${NC}"
    echo -e "  Run frontend locally: ${GREEN}cd frontend && npm run dev${NC}"
    echo ""
}

# Main execution
main() {
    check_prerequisites
    setup_backend
    setup_frontend
    start_docker
    start_application
    display_info
}

# Run main function
main
