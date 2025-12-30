# Flavorique Backend

Spring Boot backend for the Flavorique recipe management application.

## Technologies

- Java 17
- Spring Boot 3.2.1
- Spring Security with JWT
- Spring Data JPA
- PostgreSQL / H2
- Lombok
- MapStruct
- OpenAPI/Swagger

## Setup

### Prerequisites

- Java 17 or higher
- Maven 3.6+
- PostgreSQL 14+ (or use H2 for development)

### Configuration

Create a `.env` file or set environment variables:

```bash
JWT_SECRET=your-secret-key-here
```

### Database

The application is configured to work with PostgreSQL in production and H2 in development.

**PostgreSQL (Production):**
- URL: `jdbc:postgresql://localhost:5432/flavorique`
- Username: `flavorique_user`
- Password: `flavorique_secret`

**H2 (Development):**
- Use profile: `dev`
- Console: `http://localhost:8080/api/h2-console`

### Run with Maven

```bash
# Development mode with H2
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev

# Production mode with PostgreSQL
./mvnw spring-boot:run
```

### Build

```bash
./mvnw clean package
```

### Run JAR

```bash
java -jar target/flavorique-1.0.0-SNAPSHOT.jar
```

## API Documentation

Once running, access Swagger UI at:
- http://localhost:8080/api/swagger-ui.html

API Docs JSON:
- http://localhost:8080/api/api-docs

## Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login

### Recipes
- `GET /api/recipes` - Get all public recipes
- `GET /api/recipes/{id}` - Get recipe by ID
- `POST /api/recipes` - Create recipe (authenticated)
- `PUT /api/recipes/{id}` - Update recipe (authenticated)
- `DELETE /api/recipes/{id}` - Delete recipe (authenticated)
- `GET /api/recipes/search?q={query}` - Search recipes

### Users
- `GET /api/users/{id}` - Get user profile
- `PUT /api/users/{id}` - Update user profile

### Categories
- `GET /api/categories` - Get all categories

### Favorites
- `POST /api/favorites/recipes/{recipeId}` - Toggle favorite
- `GET /api/favorites/recipes/{recipeId}` - Check if favorite

## Testing

```bash
./mvnw test
```

## Project Structure

```
src/main/java/dev/arubik/flavorique/
├── config/          # Configuration classes
├── controller/      # REST controllers
├── dto/             # Data Transfer Objects
├── entity/          # JPA entities
├── exception/       # Exception handling
├── mapper/          # DTO mappers
├── repository/      # JPA repositories
├── security/        # Security & JWT
└── service/         # Business logic
```

## License

MIT
