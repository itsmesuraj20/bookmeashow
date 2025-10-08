# 🚀 BookMeAShow - Quick Command Reference

## 🎯 One-Line Setup
```bash
chmod +x setup.sh && ./setup.sh
```

## 🐳 Docker Commands

### Start Everything
```bash
docker-compose up -d
```

### View Logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f postgres
docker-compose logs -f redis
```

### Stop Everything
```bash
docker-compose down
```

### Stop and Remove Volumes (Fresh Start)
```bash
docker-compose down -v
```

### Restart Services
```bash
# All services
docker-compose restart

# Specific service
docker-compose restart backend
```

### Rebuild and Restart
```bash
docker-compose up -d --build
```

### Check Running Containers
```bash
docker-compose ps
```

### Resource Usage
```bash
docker stats
```

## 🔧 Backend Commands

### Development
```bash
cd backend

# Run locally
./mvnw spring-boot:run

# Run with specific profile
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev

# Build
./mvnw clean package

# Build without tests
./mvnw clean package -DskipTests

# Run tests
./mvnw test

# Run specific test
./mvnw test -Dtest=UserServiceTest
```

### Database Commands
```bash
# Connect to PostgreSQL
docker exec -it bookmeashow-postgres psql -U bookmeashow_user -d bookmeashow

# Run SQL file
docker exec -i bookmeashow-postgres psql -U bookmeashow_user -d bookmeashow < script.sql

# Backup database
docker exec bookmeashow-postgres pg_dump -U bookmeashow_user bookmeashow > backup.sql

# Restore database
docker exec -i bookmeashow-postgres psql -U bookmeashow_user -d bookmeashow < backup.sql
```

## 💻 Frontend Commands

### Development
```bash
cd frontend

# Install dependencies
npm install

# Run dev server
npm run dev

# Build for production
npm run build

# Run production build
npm run start

# Lint code
npm run lint

# Type check
npm run type-check
```

### Clean Build
```bash
# Remove all generated files
rm -rf node_modules .next package-lock.json

# Fresh install and build
npm install && npm run build
```

## 🗄️ Database Commands

### PostgreSQL
```bash
# Start PostgreSQL
docker-compose up -d postgres

# Connect to database
docker exec -it bookmeashow-postgres psql -U bookmeashow_user -d bookmeashow

# List databases
docker exec -it bookmeashow-postgres psql -U bookmeashow_user -c "\l"

# List tables
docker exec -it bookmeashow-postgres psql -U bookmeashow_user -d bookmeashow -c "\dt"

# Check table structure
docker exec -it bookmeashow-postgres psql -U bookmeashow_user -d bookmeashow -c "\d users"
```

### MongoDB
```bash
# Start MongoDB
docker-compose up -d mongodb

# Connect to MongoDB
docker exec -it bookmeashow-mongodb mongosh -u admin -p admin123

# List databases
docker exec -it bookmeashow-mongodb mongosh -u admin -p admin123 --eval "show dbs"

# Query collection
docker exec -it bookmeashow-mongodb mongosh -u admin -p admin123 bookmeashow_reviews --eval "db.reviews.find()"
```

### Redis
```bash
# Start Redis
docker-compose up -d redis

# Connect to Redis
docker exec -it bookmeashow-redis redis-cli -a redis123

# Test connection
docker exec -it bookmeashow-redis redis-cli -a redis123 ping

# Get all keys
docker exec -it bookmeashow-redis redis-cli -a redis123 KEYS '*'

# Clear all data
docker exec -it bookmeashow-redis redis-cli -a redis123 FLUSHALL

# Get cache stats
docker exec -it bookmeashow-redis redis-cli -a redis123 INFO stats
```

## 📊 Monitoring Commands

### Prometheus
```bash
# Access Prometheus UI
open http://localhost:9090

# Check targets
curl http://localhost:9090/api/v1/targets

# Query metrics
curl 'http://localhost:9090/api/v1/query?query=up'
```

### Grafana
```bash
# Access Grafana
open http://localhost:3001

# Default credentials: admin/admin
```

### Application Health
```bash
# Backend health check
curl http://localhost:8080/actuator/health

# Backend metrics
curl http://localhost:8080/actuator/metrics

# Prometheus metrics
curl http://localhost:8080/actuator/prometheus
```

## 🔍 Debugging Commands

### Check Port Usage
```bash
# Check if port is in use (macOS/Linux)
lsof -i :8080
lsof -i :3000
lsof -i :5432

# Kill process on port
kill -9 $(lsof -t -i:8080)
```

### Network Debugging
```bash
# Check if services can reach each other
docker exec bookmeashow-backend ping postgres
docker exec bookmeashow-backend ping redis

# Check DNS resolution
docker exec bookmeashow-backend nslookup postgres
```

### Container Debugging
```bash
# Execute command in container
docker exec -it bookmeashow-backend bash

# Copy file from container
docker cp bookmeashow-backend:/app/logs/app.log ./app.log

# Copy file to container
docker cp config.yml bookmeashow-backend:/app/config.yml

# Inspect container
docker inspect bookmeashow-backend
```

## 🧪 Testing Commands

### Load Testing
```bash
# Install Apache Bench
brew install ab  # macOS
apt-get install apache2-utils  # Ubuntu

# Simple load test
ab -n 1000 -c 100 http://localhost:8080/api/public/movies/now-showing

# With authentication
ab -n 1000 -c 100 -H "Authorization: Bearer YOUR_TOKEN" http://localhost:8080/api/bookings/my-bookings
```

### API Testing
```bash
# Test user registration
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"test123","firstName":"Test","lastName":"User","phone":"1234567890"}'

# Test login
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"test123"}'

# Get movies
curl http://localhost:8080/api/public/movies/now-showing?page=0&size=10
```

## 🛠️ Maintenance Commands

### Clean Up
```bash
# Remove stopped containers
docker container prune -f

# Remove unused images
docker image prune -a -f

# Remove unused volumes
docker volume prune -f

# Remove everything
docker system prune -a -f --volumes
```

### Backup
```bash
# Backup all databases
docker exec bookmeashow-postgres pg_dump -U bookmeashow_user bookmeashow > backup_$(date +%Y%m%d).sql

# Backup MongoDB
docker exec bookmeashow-mongodb mongodump --archive=backup_$(date +%Y%m%d).archive

# Backup Redis
docker exec bookmeashow-redis redis-cli -a redis123 --rdb /data/backup.rdb
```

### Update Dependencies
```bash
# Backend - Update Maven dependencies
cd backend && ./mvnw versions:use-latest-releases

# Frontend - Update npm packages
cd frontend && npm update

# Check outdated packages
cd frontend && npm outdated
```

## 🚀 Deployment Commands

### Build Production Images
```bash
# Build backend image
docker build -t bookmeashow-backend:latest ./backend

# Build frontend image
docker build -t bookmeashow-frontend:latest ./frontend

# Build all services
docker-compose build
```

### Push to Registry
```bash
# Tag images
docker tag bookmeashow-backend:latest your-registry/bookmeashow-backend:v1.0
docker tag bookmeashow-frontend:latest your-registry/bookmeashow-frontend:v1.0

# Push to registry
docker push your-registry/bookmeashow-backend:v1.0
docker push your-registry/bookmeashow-frontend:v1.0
```

### Environment Management
```bash
# Copy example env files
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env.local

# Edit environment variables
nano backend/.env
nano frontend/.env.local
```

## 📝 Git Commands

### Initial Setup
```bash
git init
git add .
git commit -m "Initial commit: BookMeAShow project"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```

### Development Workflow
```bash
# Create feature branch
git checkout -b feature/seat-selection

# Commit changes
git add .
git commit -m "feat: Add seat selection component"

# Push to remote
git push origin feature/seat-selection

# Merge to main
git checkout main
git merge feature/seat-selection
git push origin main
```

## 🔑 Quick Access URLs

### Application
- Frontend: http://localhost:3000
- Backend API: http://localhost:8080
- API Documentation: http://localhost:8080/swagger-ui.html
- Health Check: http://localhost:8080/actuator/health

### Monitoring
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3001 (admin/admin)

### Databases
- PostgreSQL: localhost:5432 (bookmeashow_user/bookmeashow_pass)
- MongoDB: localhost:27017 (admin/admin123)
- Redis: localhost:6379 (password: redis123)
- Elasticsearch: http://localhost:9200

### Message Queue
- Kafka: localhost:9092

## 💡 Troubleshooting

### Port Already in Use
```bash
# Find and kill process
lsof -i :8080 | grep LISTEN | awk '{print $2}' | xargs kill -9
```

### Docker Issues
```bash
# Restart Docker daemon
sudo systemctl restart docker  # Linux
# Restart Docker Desktop on macOS/Windows

# Reset Docker
docker system prune -a -f --volumes
```

### Database Connection Issues
```bash
# Check if database is running
docker-compose ps postgres

# View database logs
docker-compose logs postgres

# Restart database
docker-compose restart postgres
```

### Build Issues
```bash
# Clear Maven cache
rm -rf ~/.m2/repository

# Clear npm cache
npm cache clean --force

# Rebuild everything
docker-compose down -v
docker-compose up -d --build
```

## 📚 Additional Resources

- [QUICKSTART.md](./docs/QUICKSTART.md) - Detailed setup guide
- [API.md](./docs/API.md) - API documentation
- [ARCHITECTURE.md](./docs/ARCHITECTURE.md) - System architecture
- [DEVELOPMENT.md](./docs/DEVELOPMENT.md) - Development guide

## 🎯 Common Workflows

### Daily Development
```bash
# Start services
docker-compose up -d

# Run backend in IDE or:
cd backend && ./mvnw spring-boot:run

# Run frontend
cd frontend && npm run dev

# View logs
docker-compose logs -f postgres redis kafka
```

### Before Committing
```bash
# Run tests
cd backend && ./mvnw test
cd frontend && npm test

# Check code style
cd frontend && npm run lint

# Type check
cd frontend && npm run type-check
```

### Deployment Preparation
```bash
# Build production images
docker-compose build

# Test production build
docker-compose -f docker-compose.prod.yml up

# Tag and push
docker tag bookmeashow-backend:latest registry/backend:v1.0
docker push registry/backend:v1.0
```

---

**Pro Tip**: Save this file and use it as your quick reference guide! 📖
