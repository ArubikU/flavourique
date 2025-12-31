# Flavorique 🍳

> **Un recetario virtual full-stack con sistema de cuentas, favoritos y comunidad**

Flavorique es una aplicación web completa para gestionar recetas personales y descubrir creaciones de otros usuarios. Construida con **Spring Boot** en el backend y **Angular** en el frontend, demuestra arquitectura empresarial moderna y mejores prácticas de desarrollo full-stack.

---

## 🎯 Objetivo del Proyecto

Este proyecto fue creado para:
- Demostrar dominio de **Java con Spring Boot** (REST APIs, Spring Security, JPA/Hibernate)
- Implementar frontend moderno con **Angular** (componentes reactivos, servicios, routing)
- Practicar arquitectura **full-stack** con autenticación JWT y roles de usuario
- Crear un producto funcional que pueda ser usado por usuarios reales

---

## ✨ Características

### 👤 Sistema de Usuarios
- Registro e inicio de sesión con validación
- Autenticación JWT con refresh tokens
- Perfiles de usuario personalizables
- Roles (Usuario, Chef Verificado, Admin)

### 📖 Gestión de Recetas
- CRUD completo de recetas personales
- Editor rico con ingredientes, pasos e imágenes
- Categorías y etiquetas personalizables
- Tiempo de preparación y dificultad
- Información nutricional básica

### ❤️ Interacción Social
- Sistema de favoritos/guardados
- Calificaciones y reseñas
- Comentarios en recetas
- Seguir a otros usuarios
- Feed de actividad reciente

### 🔍 Búsqueda y Filtros
- Búsqueda por nombre, ingredientes o chef
- Filtros por categoría, tiempo, dificultad
- Ordenar por popularidad, fecha, calificación
- Sugerencias basadas en preferencias

### 📱 UI/UX
- Diseño responsivo (mobile-first)
- Tema claro/oscuro
- Lazy loading de imágenes
- Skeleton loaders

---

## 🛠️ Stack Tecnológico

### Backend (Java)
```
├── Spring Boot 3.2+
├── Spring Security (JWT)
├── Spring Data JPA
├── Hibernate
├── PostgreSQL
├── Maven/Gradle
├── Lombok
├── MapStruct
└── OpenAPI/Swagger
```

### Frontend (Angular)
```
├── Angular 17+
├── TypeScript
├── Angular Material / TailwindCSS
├── RxJS
├── NgRx (State Management)
├── Angular Router
└── Angular Forms (Reactive)
```

### DevOps
```
├── Docker & Docker Compose
├── GitHub Actions (CI/CD)
├── PostgreSQL (Producción)
├── H2 (Desarrollo/Testing)
└── Nginx (Reverse Proxy)
```

---

## 📁 Estructura del Proyecto

```
flavorique/
├── backend/
│   ├── src/main/java/dev/arubik/flavorique/
│   │   ├── config/           # Configuración Spring
│   │   ├── controller/       # REST Controllers
│   │   ├── dto/              # Data Transfer Objects
│   │   ├── entity/           # Entidades JPA
│   │   ├── exception/        # Manejo de excepciones
│   │   ├── mapper/           # MapStruct mappers
│   │   ├── repository/       # Repositorios JPA
│   │   ├── security/         # JWT, filtros, config
│   │   └── service/          # Lógica de negocio
│   ├── src/main/resources/
│   │   ├── application.yml
│   │   └── db/migration/     # Flyway migrations
│   └── pom.xml
│
├── frontend/
│   ├── src/app/
│   │   ├── core/             # Guards, interceptors, services
│   │   ├── features/         # Módulos de funcionalidad
│   │   │   ├── auth/
│   │   │   ├── recipes/
│   │   │   ├── profile/
│   │   │   └── explore/
│   │   ├── shared/           # Componentes compartidos
│   │   └── app.routes.ts
│   ├── angular.json
│   └── package.json
│
├── docker-compose.yml
└── README.md
```

---

## 🚀 Instalación

### Prerrequisitos
- Java 17+
- Node.js 18+
- PostgreSQL 14+ (o Docker)
- Maven o Gradle

### Desarrollo Local

1. **Clonar el repositorio**
```bash
git clone https://github.com/ArubikU/flavorique.git
cd flavorique
```

2. **Backend**
```bash
cd backend
# Configurar variables de entorno
cp .env.example .env
# Ejecutar con Maven
./mvnw spring-boot:run
# O con Gradle
./gradlew bootRun
```

3. **Frontend**
```bash
cd frontend
npm install
ng serve
```

4. **Con Docker (Recomendado para producción)**
```bash
# Iniciar todos los servicios (database, backend, frontend)
docker-compose up -d

# Iniciar con herramientas de desarrollo (incluye Adminer)
docker-compose --profile dev up -d

# Ver logs
docker-compose logs -f

# Detener servicios
docker-compose down

# Reconstruir imágenes
docker-compose build --no-cache
docker-compose up -d
```

La aplicación estará disponible en:
- Frontend: `http://localhost:4200`
- Backend API: `http://localhost:8080/api`
- Swagger UI: `http://localhost:8080/api/swagger-ui.html`
- Adminer (solo con --profile dev): `http://localhost:8081`

### Servicios Docker

| Servicio | Puerto | Descripción |
|----------|--------|-------------|
| `db` | 5432 | PostgreSQL 15 |
| `backend` | 8080 | Spring Boot API |
| `frontend` | 4200 | Angular (Nginx) |
| `adminer` | 8081 | DB Admin (dev only) |

---

## 📋 API Endpoints

### Autenticación
| Método | Endpoint | Descripción |
|--------|----------|-------------|
| POST | `/api/auth/register` | Registro de usuario |
| POST | `/api/auth/login` | Inicio de sesión |
| POST | `/api/auth/refresh` | Refrescar token |
| POST | `/api/auth/logout` | Cerrar sesión |

### Recetas
| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/api/recipes` | Listar recetas (paginado) |
| GET | `/api/recipes/{id}` | Obtener receta por ID |
| POST | `/api/recipes` | Crear nueva receta |
| PUT | `/api/recipes/{id}` | Actualizar receta |
| DELETE | `/api/recipes/{id}` | Eliminar receta |
| GET | `/api/recipes/search` | Buscar recetas |
| POST | `/api/recipes/{id}/favorite` | Agregar a favoritos |

### Usuarios
| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/api/users/{id}` | Perfil de usuario |
| PUT | `/api/users/{id}` | Actualizar perfil |
| GET | `/api/users/{id}/recipes` | Recetas del usuario |
| GET | `/api/users/{id}/favorites` | Favoritos del usuario |

---

## 🧪 Testing

```bash
# Backend - Tests unitarios e integración
cd backend
./mvnw test

# Frontend - Tests unitarios
cd frontend
ng test

# E2E Tests
ng e2e
```

---

## 📝 Roadmap

- [x] Autenticación JWT
- [x] CRUD de recetas
- [x] Sistema de favoritos
- [ ] Subida de imágenes (AWS S3 o Cloudinary)
- [ ] Sistema de calificaciones
- [ ] Comentarios en recetas
- [ ] Notificaciones en tiempo real
- [ ] PWA Support
- [ ] Modo offline
- [ ] API de nutrición integrada

---

## 🤝 Contribuir

1. Fork el proyecto
2. Crea tu feature branch (`git checkout -b feature/NuevaCaracteristica`)
3. Commit tus cambios (`git commit -m 'Add: nueva característica'`)
4. Push a la branch (`git push origin feature/NuevaCaracteristica`)
5. Abre un Pull Request

---

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver [LICENSE](LICENSE) para más detalles.

---

## 👤 Autor

**Piero Alarcon (ArubikU)**
- Website: [arubik.dev](https://arubik.dev)
- GitHub: [@ArubikU](https://github.com/ArubikU)
- LinkedIn: [piero-alarcon-duenas](https://linkedin.com/in/piero-alarcon-duenas)

---

⭐ Si este proyecto te resulta útil, considera darle una estrella en GitHub.
