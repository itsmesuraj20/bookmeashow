# Quick Start Guide

## Prerequisites

Before you begin, ensure you have the following installed:

- **Docker** (20.10+) and **Docker Compose** (2.0+)
- **Java 17** (optional, for local development)
- **Node.js 18+** (optional, for local development)
- **Maven 3.8+** (optional, for local development)

## Quick Setup (Recommended)

### 1. Clone the Repository

```bash
git clone <repository-url>
cd bookmeashow
```

### 2. Run Setup Script

```bash
chmod +x setup.sh
./setup.sh
```

This script will:
- Check prerequisites
- Build backend and frontend
- Start all Docker services
- Display access information

### 3. Access the Application

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8080
- **API Documentation**: http://localhost:8080/swagger-ui.html
- **Grafana Dashboard**: http://localhost:3001 (admin/admin)
- **Prometheus**: http://localhost:9090

## Manual Setup

### Backend Setup

```bash
cd backend

# Build with Maven
./mvnw clean install

# Run the application
./mvnw spring-boot:run
```

The backend will start on `http://localhost:8080`

### Frontend Setup

```bash
cd frontend

# Install dependencies
npm install

# Run development server
npm run dev
```

The frontend will start on `http://localhost:3000`

### Database Setup

#### PostgreSQL
```bash
docker run -d \
  --name bookmeashow-postgres \
  -e POSTGRES_DB=bookmeashow \
  -e POSTGRES_USER=bookmeashow_user \
  -e POSTGRES_PASSWORD=bookmeashow_pass \
  -p 5432:5432 \
  postgres:15-alpine
```

#### MongoDB
```bash
docker run -d \
  --name bookmeashow-mongodb \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=admin123 \
  -p 27017:27017 \
  mongo:7
```

#### Redis
```bash
docker run -d \
  --name bookmeashow-redis \
  -p 6379:6379 \
  redis:7-alpine redis-server --requirepass redis123
```

## Docker Compose Setup

### Start All Services

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
```

### Stop Services

```bash
docker-compose down
```

### Rebuild and Restart

```bash
docker-compose down
docker-compose up -d --build
```

## Environment Variables

### Backend (.env or environment variables)

```properties
# Database
SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/bookmeashow
SPRING_DATASOURCE_USERNAME=bookmeashow_user
SPRING_DATASOURCE_PASSWORD=bookmeashow_pass

# MongoDB
SPRING_DATA_MONGODB_URI=mongodb://admin:admin123@localhost:27017/bookmeashow_reviews?authSource=admin

# Redis
SPRING_REDIS_HOST=localhost
SPRING_REDIS_PORT=6379
SPRING_REDIS_PASSWORD=redis123

# JWT
JWT_SECRET=your-256-bit-secret-key-change-in-production
JWT_EXPIRATION=86400000
JWT_REFRESH_EXPIRATION=604800000

# Kafka
SPRING_KAFKA_BOOTSTRAP_SERVERS=localhost:9092
```

### Frontend (.env.local)

```env
NEXT_PUBLIC_API_URL=http://localhost:8080/api
NEXT_PUBLIC_WS_URL=ws://localhost:8080/ws
```

## Default Credentials

### Admin Account
- **Email**: admin@bookmeashow.com
- **Password**: admin123

### Test User Account
- **Email**: user@test.com
- **Password**: user123

## Common Commands

### Backend

```bash
# Build
./mvnw clean package

# Run tests
./mvnw test

# Run with specific profile
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev
```

### Frontend

```bash
# Development
npm run dev

# Build
npm run build

# Production
npm run start

# Lint
npm run lint

# Type check
npm run type-check
```

### Docker

```bash
# View running containers
docker-compose ps

# Restart a service
docker-compose restart backend

# Remove all containers and volumes
docker-compose down -v

# View resource usage
docker stats
```

## Troubleshooting

### Port Already in Use

If you get a "port already in use" error:

```bash
# Find process using port 8080 (macOS/Linux)
lsof -i :8080

# Kill the process
kill -9 <PID>

# Or change the port in application.properties
server.port=8081
```

### Database Connection Issues

```bash
# Check if PostgreSQL is running
docker-compose ps postgres

# View PostgreSQL logs
docker-compose logs postgres

# Connect to database
docker exec -it bookmeashow-postgres psql -U bookmeashow_user -d bookmeashow
```

### Redis Connection Issues

```bash
# Check if Redis is running
docker-compose ps redis

# Test Redis connection
docker exec -it bookmeashow-redis redis-cli -a redis123 ping
```

### Frontend Build Issues

```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json .next
npm install
npm run dev
```

## Development Workflow

### 1. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
```

### 2. Make Changes

- Update code
- Add tests
- Update documentation

### 3. Test Locally

```bash
# Backend tests
cd backend && ./mvnw test

# Frontend tests
cd frontend && npm test
```

### 4. Commit Changes

```bash
git add .
git commit -m "feat: your feature description"
```

### 5. Push and Create PR

```bash
git push origin feature/your-feature-name
```

## Production Deployment

### Build Production Images

```bash
# Backend
docker build -t bookmeashow-backend:latest ./backend

# Frontend
docker build -t bookmeashow-frontend:latest ./frontend
```

### Deploy to Kubernetes (Optional)

```bash
kubectl apply -f k8s/
```

### Deploy to Cloud

Refer to cloud-specific deployment guides:
- AWS ECS/EKS
- Google Cloud Run/GKE
- Azure Container Apps/AKS

## Performance Testing

### Load Testing with Apache Bench

```bash
# Test API endpoint
ab -n 1000 -c 100 http://localhost:8080/api/public/movies/now-showing
```

### Monitor Performance

- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3001

## Security Checklist

- [ ] Change default passwords
- [ ] Use environment variables for secrets
- [ ] Enable HTTPS in production
- [ ] Configure CORS properly
- [ ] Set up rate limiting
- [ ] Enable database encryption
- [ ] Set up backup strategy
- [ ] Configure monitoring and alerts

## Next Steps

1. Read [ARCHITECTURE.md](./ARCHITECTURE.md) for system design details
2. Check [API.md](./API.md) for API documentation
3. Review code structure and contribute
4. Set up CI/CD pipeline
5. Configure production deployment

## Support

For issues and questions:
- Create an issue on GitHub
- Check existing documentation
- Review Stack Overflow for common problems

## License

This project is licensed under the MIT License.
