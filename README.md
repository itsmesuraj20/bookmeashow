# 🎬 BookMeAShow - Production-Ready Movie Ticket Booking Platform

> A highly scalable, production-grade movie ticket booking system built with Next.js and Spring Boot, designed to handle **1 million+ concurrent users**.

[![Java](https://img.shields.io/badge/Java-17-orange.svg)](https://www.oracle.com/java/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Next.js](https://img.shields.io/badge/Next.js-14-black.svg)](https://nextjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.3-blue.svg)](https://www.typescriptlang.org/)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 🚀 Quick Start (One Command!)

```bash
chmod +x setup.sh && ./setup.sh
```

**That's it!** The script will set up everything and display access URLs.

## 🎯 What You Get

This is a **complete, production-ready system** with:

✅ **Modern Tech Stack** - Next.js 14 + Spring Boot 3.2  
✅ **Highly Scalable** - Designed for 1M+ concurrent users  
✅ **Microservices Ready** - Event-driven architecture  
✅ **Complete Infrastructure** - Database, Cache, Message Queue, Monitoring  
✅ **Production Security** - JWT, BCrypt, CORS, Rate Limiting  
✅ **Real-time Updates** - WebSocket for live seat availability  
✅ **Comprehensive Monitoring** - Prometheus + Grafana  
✅ **One-Command Setup** - Docker Compose for everything  
✅ **Full Documentation** - Architecture, API, Development guides  

## 🏗️ Architecture Overview

### Technology Stack

**Frontend:**
- Next.js 14+ (App Router)
- TypeScript
- TailwindCSS
- Redux Toolkit (State Management)
- React Query (Data Fetching)
- Shadcn/ui (Component Library)

**Backend:**
- Java Spring Boot 3.x
- Spring Security (JWT Authentication)
- Spring Data JPA
- Spring Cloud (Microservices)
- Spring WebFlux (Reactive Programming)

**Databases:**
- PostgreSQL (Primary Database)
- MongoDB (Reviews, Ratings, Analytics)
- Redis (Caching & Session Management)

**Message Queue:**
- Apache Kafka (Event Streaming)

**Search Engine:**
- Elasticsearch (Movie/Theater Search)

**Infrastructure:**
- Docker & Docker Compose
- Nginx (Reverse Proxy & Load Balancer)
- Prometheus & Grafana (Monitoring)

## 🚀 Features

### User Features
- User Registration & Authentication (JWT)
- Browse Movies (Now Showing, Coming Soon)
- Advanced Search & Filters
- Theater & Showtime Selection
- Interactive Seat Selection
- Multiple Payment Options
- Booking History
- Reviews & Ratings
- Email/SMS Notifications

### Admin Features
- Movie Management
- Theater Management
- Show Scheduling
- Dynamic Pricing
- Analytics Dashboard
- Revenue Reports

## 📁 Project Structure

```
bookmeashow/
├── frontend/                 # Next.js Frontend
├── backend/                  # Spring Boot Backend
├── docker/                   # Docker configurations
├── infrastructure/           # Infrastructure as Code
└── docs/                     # Documentation
```

## 🔧 Setup Instructions

### Prerequisites
- Node.js 18+
- Java 17+
- Docker & Docker Compose
- PostgreSQL 15+
- Redis
- MongoDB

### Quick Start with Docker

```bash
# Clone the repository
git clone <repository-url>
cd bookmeashow

# Start all services
docker-compose up -d

# Frontend will be available at: http://localhost:3000
# Backend API will be available at: http://localhost:8080
```

### Manual Setup

#### Backend Setup
```bash
cd backend
./mvnw clean install
./mvnw spring-boot:run
```

#### Frontend Setup
```bash
cd frontend
npm install
npm run dev
```

## 🏛️ System Design

### Scalability Features
- **Horizontal Scaling:** Load balanced microservices
- **Caching Strategy:** Multi-level caching (Redis, CDN)
- **Database Optimization:** Read replicas, Connection pooling
- **Async Processing:** Kafka for event-driven architecture
- **CDN Integration:** Static asset delivery
- **Rate Limiting:** API throttling and DDoS protection

### High Availability
- Database replication
- Redis Sentinel for cache failover
- Circuit breaker pattern
- Health checks and auto-recovery

## 📊 Performance Targets

- Response Time: < 200ms (p95)
- Throughput: 10,000+ requests/second
- Availability: 99.9% uptime
- Concurrent Users: 1M+

## 🔐 Security

- JWT Authentication
- Rate Limiting
- SQL Injection Prevention
- XSS Protection
- CORS Configuration
- Data Encryption at Rest & Transit

## 📝 API Documentation

API documentation is available at:
- Swagger UI: http://localhost:8080/swagger-ui.html
- OpenAPI Spec: http://localhost:8080/v3/api-docs

## 🧪 Testing

```bash
# Backend tests
cd backend
./mvnw test

# Frontend tests
cd frontend
npm run test
```

## 📈 Monitoring

- Prometheus: http://localhost:9090
- Grafana: http://localhost:3001
- Application Logs: Centralized logging with ELK stack

## 🤝 Contributing

Please read CONTRIBUTING.md for details on our code of conduct and the process for submitting pull requests.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

Built as a production-ready showcase project demonstrating scalable architecture and modern development practices.
