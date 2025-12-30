# Guía de Despliegue 🚀

## Opciones de Despliegue

| Plataforma | Backend | Frontend | Base de Datos |
|------------|---------|----------|---------------|
| **Railway** | ✅ Spring Boot | ✅ Static | ✅ PostgreSQL |
| **Render** | ✅ Docker | ✅ Static | ✅ PostgreSQL |
| **Vercel** | ❌ | ✅ Angular | ❌ |
| **Netlify** | ❌ | ✅ Angular | ❌ |
| **AWS** | ✅ ECS/EB | ✅ S3+CloudFront | ✅ RDS |
| **Azure** | ✅ App Service | ✅ Static Web Apps | ✅ Azure SQL |
| **GCP** | ✅ Cloud Run | ✅ Firebase Hosting | ✅ Cloud SQL |

---

## Docker Compose (Desarrollo)

```yaml
# docker-compose.yml
version: '3.8'

services:
  db:
    image: postgres:15
    environment:
      POSTGRES_DB: flavorique
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  backend:
    build: ./backend
    ports:
      - "8080:8080"
    environment:
      - SPRING_DATASOURCE_URL=jdbc:postgresql://db:5432/flavorique
      - SPRING_DATASOURCE_USERNAME=postgres
      - SPRING_DATASOURCE_PASSWORD=postgres
      - JWT_SECRET=${JWT_SECRET}
    depends_on:
      - db

  frontend:
    build: ./frontend
    ports:
      - "4200:80"
    depends_on:
      - backend

volumes:
  postgres_data:
```

---

## Dockerfile Backend

```dockerfile
# backend/Dockerfile
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app
COPY mvnw pom.xml ./
COPY .mvn .mvn
RUN ./mvnw dependency:go-offline
COPY src src
RUN ./mvnw package -DskipTests

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

---

## Dockerfile Frontend

```dockerfile
# frontend/Dockerfile
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build -- --configuration production

FROM nginx:alpine
COPY --from=build /app/dist/flavorique/browser /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

---

## Nginx Config (Frontend)

```nginx
# frontend/nginx.conf
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    # Angular routing
    location / {
        try_files $uri $uri/ /index.html;
    }

    # API proxy
    location /api/ {
        proxy_pass http://backend:8080/api/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

---

## GitHub Actions (CI/CD)

```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test-backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
      - name: Run tests
        run: |
          cd backend
          ./mvnw test

  test-frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - name: Install and test
        run: |
          cd frontend
          npm ci
          npm run test -- --watch=false --browsers=ChromeHeadless

  build-and-push:
    needs: [test-backend, test-frontend]
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Build and push Docker images
        run: |
          docker build -t ghcr.io/${{ github.repository }}/backend ./backend
          docker build -t ghcr.io/${{ github.repository }}/frontend ./frontend
          # Push to registry...
```

---

## Variables de Entorno (Producción)

### Backend
```env
# Database
SPRING_DATASOURCE_URL=jdbc:postgresql://host:5432/flavorique_prod
SPRING_DATASOURCE_USERNAME=<user>
SPRING_DATASOURCE_PASSWORD=<password>

# JWT
JWT_SECRET=<strong-256-bit-secret>
JWT_EXPIRATION=86400000

# Spring
SPRING_PROFILES_ACTIVE=prod
SERVER_PORT=8080

# CORS
CORS_ALLOWED_ORIGINS=https://flavorique.app
```

### Frontend
```typescript
// environment.prod.ts
export const environment = {
  production: true,
  apiUrl: 'https://api.flavorique.app/api'
};
```

---

## Checklist Pre-Despliegue

- [ ] Tests pasan (backend y frontend)
- [ ] Variables de entorno configuradas
- [ ] Secretos no están en código
- [ ] CORS configurado correctamente
- [ ] SSL/HTTPS habilitado
- [ ] Base de datos con backups
- [ ] Logs configurados
- [ ] Monitoreo/alertas configurado
- [ ] Rate limiting habilitado
- [ ] Headers de seguridad (HSTS, CSP, etc.)

---

## Monitoreo Recomendado

- **Logs**: ELK Stack, CloudWatch, o LogDNA
- **APM**: New Relic, DataDog, o Elastic APM
- **Uptime**: UptimeRobot, Pingdom
- **Error tracking**: Sentry

---

## Rollback

```bash
# Con Docker
docker pull ghcr.io/arubiku/flavorique/backend:previous-tag
docker-compose up -d

# Con Kubernetes
kubectl rollout undo deployment/flavorique-backend
```
