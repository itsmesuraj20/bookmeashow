#!/bin/bash

# BookMeAShow - Verification Script
# This script verifies the setup and displays system information

set -e

echo "🔍 BookMeAShow - System Verification"
echo "===================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check Docker
echo -e "${YELLOW}Checking Docker...${NC}"
if docker --version > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Docker installed:${NC} $(docker --version)"
else
    echo -e "${RED}✗ Docker not found${NC}"
fi

# Check Docker Compose
if docker-compose --version > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Docker Compose installed:${NC} $(docker-compose --version)"
else
    echo -e "${RED}✗ Docker Compose not found${NC}"
fi

echo ""

# Check running containers
echo -e "${YELLOW}Checking running containers...${NC}"
CONTAINERS=$(docker ps --format "table {{.Names}}\t{{.Status}}" | grep bookmeashow || true)

if [ -z "$CONTAINERS" ]; then
    echo -e "${YELLOW}⚠ No BookMeAShow containers running${NC}"
    echo -e "${BLUE}Run: ./setup.sh to start all services${NC}"
else
    echo -e "${GREEN}✓ Running containers:${NC}"
    echo "$CONTAINERS"
fi

echo ""

# Check Java
echo -e "${YELLOW}Checking development tools...${NC}"
if java --version > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Java installed:${NC} $(java --version 2>&1 | head -1)"
else
    echo -e "${YELLOW}⚠ Java not found (optional for local dev)${NC}"
fi

# Check Node.js
if node --version > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Node.js installed:${NC} $(node --version)"
else
    echo -e "${YELLOW}⚠ Node.js not found (optional for local dev)${NC}"
fi

echo ""

# Check port availability
echo -e "${YELLOW}Checking ports...${NC}"

check_port() {
    if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
        echo -e "${GREEN}✓ Port $1:${NC} In use (service running)"
    else
        echo -e "${YELLOW}⚠ Port $1:${NC} Available (service not running)"
    fi
}

check_port 3000  # Frontend
check_port 8080  # Backend
check_port 5432  # PostgreSQL
check_port 6379  # Redis
check_port 27017 # MongoDB
check_port 9092  # Kafka
check_port 9200  # Elasticsearch

echo ""

# Project structure
echo -e "${YELLOW}Checking project structure...${NC}"

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1"
    else
        echo -e "${RED}✗${NC} $1"
    fi
}

check_file "docker-compose.yml"
check_file "setup.sh"
check_file "backend/pom.xml"
check_file "frontend/package.json"
check_file "README.md"

echo ""

# Display access URLs
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${GREEN}📱 Access Points:${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""
echo -e "🌐 Frontend:        ${GREEN}http://localhost:3000${NC}"
echo -e "🔌 Backend API:     ${GREEN}http://localhost:8080${NC}"
echo -e "📚 API Docs:        ${GREEN}http://localhost:8080/swagger-ui.html${NC}"
echo -e "📊 Prometheus:      ${GREEN}http://localhost:9090${NC}"
echo -e "📈 Grafana:         ${GREEN}http://localhost:3001${NC} (admin/admin)"
echo ""
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${GREEN}🗄️  Database Access:${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""
echo -e "PostgreSQL:  ${GREEN}localhost:5432${NC}"
echo -e "  Database:  ${GREEN}bookmeashow${NC}"
echo -e "  User:      ${GREEN}bookmeashow_user${NC}"
echo -e "  Password:  ${GREEN}bookmeashow_pass${NC}"
echo ""
echo -e "MongoDB:     ${GREEN}localhost:27017${NC}"
echo -e "  User:      ${GREEN}admin${NC}"
echo -e "  Password:  ${GREEN}admin123${NC}"
echo ""
echo -e "Redis:       ${GREEN}localhost:6379${NC}"
echo -e "  Password:  ${GREEN}redis123${NC}"
echo ""
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${GREEN}📝 Quick Commands:${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""
echo -e "Start all:       ${GREEN}docker-compose up -d${NC}"
echo -e "View logs:       ${GREEN}docker-compose logs -f${NC}"
echo -e "Stop all:        ${GREEN}docker-compose down${NC}"
echo -e "Restart:         ${GREEN}docker-compose restart${NC}"
echo ""
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${GREEN}📖 Documentation:${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""
echo -e "Quick Start:     ${GREEN}docs/QUICKSTART.md${NC}"
echo -e "Architecture:    ${GREEN}docs/ARCHITECTURE.md${NC}"
echo -e "API Docs:        ${GREEN}docs/API.md${NC}"
echo -e "Development:     ${GREEN}docs/DEVELOPMENT.md${NC}"
echo -e "Commands:        ${GREEN}COMMANDS.md${NC}"
echo -e "Project Status:  ${GREEN}STATUS.md${NC}"
echo ""
echo -e "${GREEN}✨ Verification complete!${NC}"
