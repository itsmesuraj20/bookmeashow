# API Documentation

## Base URL

```
Development: http://localhost:8080/api
Production: https://api.bookmeashow.com/api
```

## Authentication

Most endpoints require JWT authentication. Include the token in the Authorization header:

```
Authorization: Bearer <your-jwt-token>
```

## Response Format

### Success Response
```json
{
  "success": true,
  "data": { ... },
  "message": "Operation successful"
}
```

### Error Response
```json
{
  "success": false,
  "error": "Error message",
  "code": "ERROR_CODE",
  "timestamp": "2024-01-01T12:00:00Z"
}
```

## Endpoints

### Authentication

#### Register User
```http
POST /api/auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123",
  "firstName": "John",
  "lastName": "Doe",
  "phone": "1234567890"
}
```

**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "role": "USER"
  }
}
```

#### Login
```http
POST /api/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

#### Refresh Token
```http
POST /api/auth/refresh
Content-Type: application/json

{
  "refreshToken": "eyJhbGciOiJIUzI1NiIs..."
}
```

### Movies

#### Get Now Showing Movies
```http
GET /api/public/movies/now-showing?page=0&size=10
```

**Response:**
```json
{
  "content": [
    {
      "id": 1,
      "title": "Sample Movie",
      "description": "Movie description",
      "duration": 150,
      "language": "English",
      "genre": "Action",
      "certification": "UA",
      "releaseDate": "2024-01-01",
      "posterUrl": "https://...",
      "trailerUrl": "https://...",
      "director": "Director Name",
      "cast": ["Actor 1", "Actor 2"],
      "rating": 4.5,
      "totalRatings": 1000
    }
  ],
  "totalElements": 50,
  "totalPages": 5,
  "size": 10,
  "number": 0
}
```

#### Get Coming Soon Movies
```http
GET /api/public/movies/coming-soon?page=0&size=10
```

#### Get Movie by ID
```http
GET /api/public/movies/{id}
```

#### Search Movies
```http
GET /api/public/movies/search?keyword=action&page=0&size=10
```

### Theaters

#### Get Cities
```http
GET /api/public/theaters/cities
```

**Response:**
```json
["Mumbai", "Delhi", "Bangalore", "Chennai", "Hyderabad"]
```

#### Get Theaters by City
```http
GET /api/public/theaters?city=Mumbai
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "PVR Cinemas",
    "address": "123 Main St",
    "city": "Mumbai",
    "state": "Maharashtra",
    "zipCode": "400001"
  }
]
```

### Shows

#### Get Shows by Movie and Date
```http
GET /api/public/shows?movieId=1&city=Mumbai&date=2024-01-01
```

**Response:**
```json
[
  {
    "id": 1,
    "showTime": "2024-01-01T14:00:00",
    "basePrice": 250.00,
    "availableSeats": 150,
    "status": "AVAILABLE",
    "theater": {
      "id": 1,
      "name": "PVR Cinemas",
      "city": "Mumbai"
    },
    "screen": {
      "id": 1,
      "name": "Screen 1",
      "type": "IMAX"
    }
  }
]
```

#### Get Show Details
```http
GET /api/public/shows/{showId}
```

#### Get Seats for Show
```http
GET /api/public/shows/{showId}/seats
```

**Response:**
```json
[
  {
    "id": 1,
    "rowNumber": "A",
    "seatNumber": "1",
    "type": "STANDARD",
    "price": 250.00,
    "status": "AVAILABLE"
  },
  {
    "id": 2,
    "rowNumber": "A",
    "seatNumber": "2",
    "type": "PREMIUM",
    "price": 350.00,
    "status": "BOOKED"
  }
]
```

### Bookings

#### Lock Seats (Authenticated)
```http
POST /api/shows/{showId}/lock-seats
Authorization: Bearer <token>
Content-Type: application/json

{
  "seatIds": [1, 2, 3]
}
```

**Response:**
```json
{
  "success": true,
  "lockedUntil": "2024-01-01T14:10:00",
  "message": "Seats locked for 10 minutes"
}
```

#### Create Booking (Authenticated)
```http
POST /api/bookings
Authorization: Bearer <token>
Content-Type: application/json

{
  "showId": 1,
  "seatIds": [1, 2, 3],
  "paymentMethod": "CREDIT_CARD"
}
```

**Response:**
```json
{
  "id": 1,
  "bookingReference": "BK123456",
  "totalAmount": 750.00,
  "status": "PENDING",
  "seats": [
    {
      "rowNumber": "A",
      "seatNumber": "1",
      "price": 250.00
    }
  ]
}
```

#### Get User Bookings (Authenticated)
```http
GET /api/bookings/my-bookings?page=0&size=10
Authorization: Bearer <token>
```

#### Get Booking by Reference (Authenticated)
```http
GET /api/bookings/{bookingReference}
Authorization: Bearer <token>
```

#### Cancel Booking (Authenticated)
```http
POST /api/bookings/{bookingReference}/cancel
Authorization: Bearer <token>
```

### Admin Endpoints

All admin endpoints require `ADMIN` role.

#### Create Movie (Admin)
```http
POST /api/admin/movies
Authorization: Bearer <admin-token>
Content-Type: application/json

{
  "title": "New Movie",
  "description": "Movie description",
  "duration": 150,
  "language": "English",
  "genre": "Action",
  "certification": "UA",
  "releaseDate": "2024-06-01",
  "posterUrl": "https://...",
  "trailerUrl": "https://...",
  "director": "Director Name",
  "cast": ["Actor 1", "Actor 2"]
}
```

#### Update Movie (Admin)
```http
PUT /api/admin/movies/{id}
Authorization: Bearer <admin-token>
```

#### Delete Movie (Admin)
```http
DELETE /api/admin/movies/{id}
Authorization: Bearer <admin-token>
```

#### Create Theater (Admin)
```http
POST /api/admin/theaters
Authorization: Bearer <admin-token>
Content-Type: application/json

{
  "name": "PVR Cinemas",
  "address": "123 Main St",
  "city": "Mumbai",
  "state": "Maharashtra",
  "zipCode": "400001",
  "latitude": 19.0760,
  "longitude": 72.8777
}
```

#### Create Show (Admin)
```http
POST /api/admin/shows
Authorization: Bearer <admin-token>
Content-Type: application/json

{
  "movieId": 1,
  "screenId": 1,
  "showTime": "2024-01-01T14:00:00",
  "basePrice": 250.00
}
```

## Error Codes

| Code | Description |
|------|-------------|
| `AUTH_001` | Invalid credentials |
| `AUTH_002` | Token expired |
| `AUTH_003` | Unauthorized access |
| `BOOK_001` | Seats already booked |
| `BOOK_002` | Seat lock expired |
| `BOOK_003` | Invalid show |
| `BOOK_004` | Payment failed |
| `SHOW_001` | Show not found |
| `SHOW_002` | Show full |
| `SHOW_003` | Show cancelled |
| `MOVIE_001` | Movie not found |
| `THEATER_001` | Theater not found |
| `USER_001` | User not found |
| `USER_002` | Email already exists |
| `VALIDATION_001` | Invalid input data |

## Rate Limits

- **Anonymous users**: 100 requests/minute
- **Authenticated users**: 500 requests/minute
- **Admin users**: 1000 requests/minute

Exceeding rate limits returns `429 Too Many Requests`.

## Pagination

All list endpoints support pagination:

```
?page=0&size=10&sort=createdAt,desc
```

## WebSocket Events

Connect to: `ws://localhost:8080/ws`

### Subscribe to Seat Updates
```javascript
stompClient.subscribe('/topic/show/{showId}/seats', function(message) {
  // Handle seat status updates
  console.log(JSON.parse(message.body));
});
```

### Events
- `SEAT_LOCKED`: Seat temporarily locked
- `SEAT_BOOKED`: Seat permanently booked
- `SEAT_RELEASED`: Seat became available

## SDKs and Client Libraries

### JavaScript/TypeScript
```typescript
import { BookMeAShowClient } from '@bookmeashow/client';

const client = new BookMeAShowClient({
  apiUrl: 'http://localhost:8080/api',
  token: 'your-jwt-token'
});

const movies = await client.movies.getNowShowing();
```

### cURL Examples

```bash
# Get now showing movies
curl -X GET "http://localhost:8080/api/public/movies/now-showing?page=0&size=10"

# Login
curl -X POST "http://localhost:8080/api/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"email":"user@test.com","password":"user123"}'

# Create booking
curl -X POST "http://localhost:8080/api/bookings" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "showId": 1,
    "seatIds": [1, 2, 3],
    "paymentMethod": "CREDIT_CARD"
  }'
```

## Testing

Use the Swagger UI for interactive API testing:
```
http://localhost:8080/swagger-ui.html
```

## Support

For API issues:
- Check [QUICKSTART.md](./QUICKSTART.md)
- Review error codes above
- Contact support team
