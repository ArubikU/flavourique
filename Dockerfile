# ===========================================
# Flavorique - All-in-One Dockerfile
# ===========================================

# Stage 1: Build Backend
FROM maven:3.9-eclipse-temurin-17-alpine AS backend-build
WORKDIR /app/backend

COPY backend/pom.xml .
RUN mvn dependency:go-offline -B

COPY backend/src ./src
RUN mvn package -DskipTests -B

# Stage 2: Build Frontend
FROM node:20-alpine AS frontend-build
WORKDIR /app/frontend

COPY frontend/flavorique-app/package.json frontend/flavorique-app/bun.lock* ./
RUN npm install

COPY frontend/flavorique-app/ .
RUN npm run build -- --configuration=production

# Stage 3: Final Runtime Image
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Install nginx and supervisor
RUN apk add --no-cache nginx supervisor curl

# Create non-root user
RUN addgroup -S flavorique && adduser -S flavorique -G flavorique

# Copy backend jar
COPY --from=backend-build /app/backend/target/*.jar app.jar

# Copy frontend build to nginx
COPY --from=frontend-build /app/frontend/dist/flavorique-app/browser /usr/share/nginx/html

# Copy nginx config
COPY docker/nginx.conf /etc/nginx/http.d/default.conf

# Copy supervisor config
COPY docker/supervisord.conf /etc/supervisord.conf

# Create necessary directories
RUN mkdir -p /var/log/supervisor /run/nginx && \
    chown -R flavorique:flavorique /app /var/log/supervisor /run/nginx /var/lib/nginx /var/log/nginx

# Expose ports
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost/api/actuator/health || exit 1

# Start supervisor (manages both nginx and java)
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
