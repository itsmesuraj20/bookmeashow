# BookMeAShow - Development Guide

## Project Structure

```
bookmeashow/
├── backend/                          # Spring Boot Backend
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/bookmeashow/
│   │   │   │   ├── config/          # Configuration classes
│   │   │   │   ├── controller/      # REST Controllers
│   │   │   │   ├── model/           # JPA Entities
│   │   │   │   ├── repository/      # Data Repositories
│   │   │   │   ├── service/         # Business Logic
│   │   │   │   ├── security/        # Security & JWT
│   │   │   │   ├── dto/             # Data Transfer Objects
│   │   │   │   ├── exception/       # Custom Exceptions
│   │   │   │   └── kafka/           # Kafka Consumers/Producers
│   │   │   └── resources/
│   │   │       ├── application.properties
│   │   │       └── db/init.sql
│   │   └── test/                    # Unit & Integration Tests
│   ├── pom.xml
│   └── Dockerfile
│
├── frontend/                         # Next.js Frontend
│   ├── src/
│   │   ├── app/                     # App Router pages
│   │   │   ├── (auth)/              # Auth pages
│   │   │   ├── movies/              # Movie pages
│   │   │   ├── booking/             # Booking flow
│   │   │   └── profile/             # User profile
│   │   ├── components/              # React Components
│   │   │   ├── ui/                  # UI Components
│   │   │   ├── layout/              # Layout Components
│   │   │   ├── home/                # Home Components
│   │   │   └── booking/             # Booking Components
│   │   ├── lib/                     # Utilities
│   │   │   ├── api/                 # API clients
│   │   │   ├── hooks/               # Custom hooks
│   │   │   └── utils/               # Helper functions
│   │   └── store/                   # Redux store
│   ├── public/                      # Static assets
│   ├── package.json
│   ├── tsconfig.json
│   ├── tailwind.config.js
│   └── Dockerfile
│
├── docker-compose.yml               # Docker Compose configuration
├── nginx/                           # Nginx configuration
├── monitoring/                      # Prometheus/Grafana configs
├── docs/                            # Documentation
│   ├── ARCHITECTURE.md
│   ├── API.md
│   ├── QUICKSTART.md
│   └── DEVELOPMENT.md
├── setup.sh                         # Setup script
└── README.md
```

## Technology Decisions

### Why Spring Boot?
- **Mature Ecosystem**: Large community, extensive libraries
- **Performance**: High throughput, low latency
- **Enterprise Ready**: Battle-tested in production
- **Spring Data JPA**: Simplifies database operations
- **Spring Security**: Robust authentication/authorization
- **Spring Cloud**: Easy microservices integration

### Why Next.js?
- **Server-Side Rendering**: Better SEO and initial load
- **App Router**: Modern routing with layouts
- **Image Optimization**: Automatic image optimization
- **TypeScript Support**: Type-safe development
- **API Routes**: Backend-for-frontend pattern
- **Performance**: Excellent Core Web Vitals

### Why PostgreSQL?
- **ACID Compliance**: Strong consistency guarantees
- **Performance**: Excellent for read-heavy workloads
- **JSON Support**: Flexible schema when needed
- **Full-Text Search**: Built-in search capabilities
- **Reliability**: Proven in production at scale

### Why Redis?
- **Speed**: In-memory data store
- **Versatility**: Cache, session store, message broker
- **Data Structures**: Rich data type support
- **Persistence**: Optional data persistence
- **Clustering**: Horizontal scalability

### Why Kafka?
- **High Throughput**: Millions of events per second
- **Durability**: Persistent event log
- **Scalability**: Horizontal scaling
- **Real-time**: Low-latency event processing
- **Decoupling**: Loose coupling between services

## Key Features Implementation

### 1. Seat Locking Mechanism

**Problem**: Multiple users selecting same seats simultaneously

**Solution**: Optimistic locking with timeout
```java
@Scheduled(fixedRate = 60000) // Run every minute
public void releaseExpiredLocks() {
    showSeatRepository.releaseExpiredLocks(LocalDateTime.now());
}
```

**Frontend**: Real-time updates via WebSocket

### 2. High Availability

**Database**:
- Primary-Replica setup
- Connection pooling (HikariCP)
- Read/Write splitting

**Application**:
- Multiple instances
- Load balancer (Nginx)
- Health checks

**Cache**:
- Redis Sentinel
- Cache-aside pattern
- TTL-based expiration

### 3. Performance Optimization

**Backend**:
- N+1 query prevention with `@EntityGraph`
- Batch operations for bulk inserts
- Database indexing on frequently queried columns
- Query result caching with `@Cacheable`

**Frontend**:
- Image optimization with Next.js Image
- Code splitting and lazy loading
- React Query for data caching
- Virtual scrolling for large lists

### 4. Security

**Authentication**:
- JWT tokens (short-lived)
- Refresh tokens (long-lived)
- HttpOnly cookies for sensitive data

**Authorization**:
- Role-based access control (RBAC)
- Method-level security with `@PreAuthorize`

**Data Protection**:
- Password hashing with BCrypt
- SQL injection prevention
- XSS protection
- CORS configuration

### 5. Monitoring

**Application Metrics**:
- Custom metrics with Micrometer
- JVM metrics (heap, threads, GC)
- API endpoint metrics
- Database query metrics

**Business Metrics**:
- Booking success rate
- Average response time
- Active users
- Revenue tracking

## Development Workflow

### 1. Local Development

```bash
# Terminal 1: Start infrastructure
docker-compose up -d postgres mongodb redis kafka

# Terminal 2: Run backend
cd backend && ./mvnw spring-boot:run

# Terminal 3: Run frontend
cd frontend && npm run dev
```

### 2. Adding a New Feature

#### Backend
1. Create entity in `model/`
2. Create repository in `repository/`
3. Create service in `service/`
4. Create controller in `controller/`
5. Add tests in `test/`

#### Frontend
1. Create API client in `lib/api/`
2. Create components in `components/`
3. Create page in `app/`
4. Add Redux slice if needed
5. Add tests

### 3. Database Migrations

Using JPA, schema is auto-updated (dev only).

For production, use Flyway:
```sql
-- V1__initial_schema.sql
CREATE TABLE users (...);

-- V2__add_booking_table.sql
CREATE TABLE bookings (...);
```

### 4. Testing Strategy

**Unit Tests**:
- Service layer logic
- Utility functions
- Component logic

**Integration Tests**:
- API endpoints
- Database operations
- Redis operations

**E2E Tests**:
- User flows
- Booking process
- Payment integration

## Deployment

### Development
```bash
docker-compose up -d
```

### Production (Kubernetes)
```bash
# Build images
docker build -t bookmeashow-backend:v1.0 ./backend
docker build -t bookmeashow-frontend:v1.0 ./frontend

# Push to registry
docker push bookmeashow-backend:v1.0
docker push bookmeashow-frontend:v1.0

# Deploy to Kubernetes
kubectl apply -f k8s/
```

### Environment Variables

**Production Checklist**:
- [ ] Change JWT secret
- [ ] Use strong database passwords
- [ ] Configure SSL/TLS
- [ ] Set up CDN
- [ ] Configure backup strategy
- [ ] Set up monitoring alerts
- [ ] Enable rate limiting
- [ ] Configure CORS for production domain

## Performance Benchmarks

### Target Metrics
- **API Response Time**: < 200ms (p95)
- **Database Query Time**: < 50ms (p95)
- **Cache Hit Ratio**: > 80%
- **Throughput**: 10,000 req/sec
- **Concurrent Users**: 100,000+

### Load Testing
```bash
# Install k6
brew install k6

# Run load test
k6 run loadtest.js
```

## Troubleshooting

### Common Issues

**Issue**: Backend can't connect to database
```bash
# Check if PostgreSQL is running
docker-compose ps postgres

# Check logs
docker-compose logs postgres

# Test connection
docker exec -it bookmeashow-postgres psql -U bookmeashow_user
```

**Issue**: Frontend can't reach backend
```bash
# Check CORS configuration
# Check API_URL in .env.local
# Check backend is running on port 8080
```

**Issue**: Redis connection timeout
```bash
# Increase timeout in application.properties
spring.data.redis.timeout=60000

# Check Redis is running
docker exec -it bookmeashow-redis redis-cli ping
```

## Best Practices

### Code Style

**Java**:
- Follow Google Java Style Guide
- Use Lombok to reduce boilerplate
- Document public APIs with Javadoc

**TypeScript**:
- Use ESLint and Prettier
- Prefer functional components
- Use TypeScript strict mode

### Git Workflow

**Branches**:
- `main`: Production code
- `develop`: Development code
- `feature/*`: Feature branches
- `hotfix/*`: Hotfix branches

**Commits**:
```
feat: Add seat selection component
fix: Fix booking confirmation email
docs: Update API documentation
test: Add booking service tests
```

### Code Review Checklist

- [ ] Code follows style guide
- [ ] All tests pass
- [ ] No security vulnerabilities
- [ ] Documentation updated
- [ ] Performance impact considered
- [ ] Error handling implemented
- [ ] Logging added where appropriate

## Resources

### Documentation
- [Spring Boot Docs](https://spring.io/projects/spring-boot)
- [Next.js Docs](https://nextjs.org/docs)
- [PostgreSQL Docs](https://www.postgresql.org/docs/)
- [Redis Docs](https://redis.io/documentation)
- [Kafka Docs](https://kafka.apache.org/documentation/)

### Tools
- **API Testing**: Postman, Insomnia
- **Database**: DBeaver, pgAdmin
- **Monitoring**: Prometheus, Grafana
- **Logging**: ELK Stack
- **CI/CD**: GitHub Actions, Jenkins

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## Support

For questions and support:
- GitHub Issues
- Stack Overflow (tag: bookmeashow)
- Documentation in `/docs`

## License

MIT License - See LICENSE file for details
