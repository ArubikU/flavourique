# Guía de Desarrollo 🛠️

## Configuración del Entorno

### Requisitos
- Java 17+ (recomendado: OpenJDK 21)
- Node.js 18+ (recomendado: 20 LTS)
- PostgreSQL 14+
- Git
- IDE: IntelliJ IDEA / VS Code

### Extensiones Recomendadas para VS Code

```json
{
  "recommendations": [
    "vscjava.vscode-java-pack",
    "vmware.vscode-spring-boot",
    "Angular.ng-template",
    "esbenp.prettier-vscode",
    "ms-azuretools.vscode-docker"
  ]
}
```

---

## Primeros Pasos

### 1. Clonar y Configurar

```bash
git clone https://github.com/ArubikU/flavorique.git
cd flavorique
```

### 2. Base de Datos

```bash
# Con Docker (recomendado)
docker run -d \
  --name flavorique-db \
  -e POSTGRES_DB=flavorique \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -p 5432:5432 \
  postgres:15

# O instalar PostgreSQL localmente
```

### 3. Backend

```bash
cd backend
cp .env.example .env
# Editar .env con tus configuraciones

# Maven
./mvnw spring-boot:run

# Gradle
./gradlew bootRun
```

### 4. Frontend

```bash
cd frontend
npm install
ng serve
```

---

## Flujo de Trabajo Git

### Branches
- `main` - Producción estable
- `develop` - Desarrollo activo
- `feature/*` - Nuevas características
- `bugfix/*` - Correcciones
- `hotfix/*` - Fixes urgentes en producción

### Commits
Seguir [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: agregar sistema de calificaciones
fix: corregir validación de email
docs: actualizar README
style: formatear código
refactor: extraer lógica de autenticación
test: agregar tests para RecipeService
chore: actualizar dependencias
```

---

## Testing

### Backend

```bash
# Todos los tests
./mvnw test

# Tests específicos
./mvnw test -Dtest=RecipeServiceTest

# Con cobertura
./mvnw test jacoco:report
```

### Frontend

```bash
# Unit tests
ng test

# Con cobertura
ng test --code-coverage

# E2E
ng e2e
```

---

## Debugging

### Backend (IntelliJ/VS Code)

1. Configurar Remote Debug en puerto 5005
2. Ejecutar:
```bash
./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"
```

### Frontend

1. Usar Chrome DevTools
2. Instalar Angular DevTools extension
3. `ng serve` con source maps habilitados

---

## Base de Datos

### Migraciones (Flyway)

```
backend/src/main/resources/db/migration/
├── V1__create_users_table.sql
├── V2__create_recipes_table.sql
├── V3__create_favorites_table.sql
└── ...
```

### Resetear BD en desarrollo

```bash
# Eliminar y recrear
docker-compose down -v
docker-compose up -d db

# O con Flyway
./mvnw flyway:clean flyway:migrate
```

---

## Despliegue

### Build de Producción

```bash
# Backend
./mvnw clean package -DskipTests
# JAR en target/flavorique-0.0.1-SNAPSHOT.jar

# Frontend
ng build --configuration production
# Output en dist/flavorique/
```

### Docker

```bash
# Build images
docker-compose -f docker-compose.prod.yml build

# Push a registry
docker push your-registry/flavorique-backend:latest
docker push your-registry/flavorique-frontend:latest
```

---

## Troubleshooting

### Puerto en uso
```bash
# Windows
netstat -ano | findstr :8080
taskkill /PID <pid> /F

# Linux/Mac
lsof -i :8080
kill -9 <pid>
```

### Problemas de CORS
Verificar configuración en `WebConfig.java` o `SecurityConfig.java`

### Node modules corrompidos
```bash
rm -rf node_modules package-lock.json
npm install
```

---

## Recursos Útiles

- [Spring Boot Docs](https://docs.spring.io/spring-boot/docs/current/reference/html/)
- [Angular Docs](https://angular.dev/)
- [PostgreSQL Docs](https://www.postgresql.org/docs/)
- [JWT.io](https://jwt.io/) - Debugger de tokens
