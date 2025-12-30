# Guía para Gemini AI 🤖

## Contexto del Proyecto

**Flavorique** es un recetario virtual full-stack con las siguientes características:

- **Backend**: Spring Boot 3.2+ con Java 17+
- **Frontend**: Angular 17+ con TypeScript
- **Base de Datos**: PostgreSQL
- **Autenticación**: JWT con refresh tokens

---

## Estructura del Proyecto

```
flavorique/
├── backend/          # API REST con Spring Boot
├── frontend/         # SPA con Angular
├── guides/           # Documentación del proyecto
└── docker-compose.yml
```

---

## Convenciones de Código

### Backend (Java)
- Usar **Lombok** para reducir boilerplate
- DTOs separados de Entities
- **MapStruct** para mapeos
- Validación con `@Valid` y anotaciones Jakarta
- Servicios con `@Transactional` cuando corresponda
- Excepciones personalizadas con `@ControllerAdvice`

### Frontend (Angular)
- Componentes **standalone** (Angular 17+)
- Signals para estado reactivo simple
- RxJS para streams complejos
- Formularios reactivos (`ReactiveFormsModule`)
- Lazy loading de rutas

---

## Patrones Utilizados

1. **Repository Pattern** - Acceso a datos
2. **DTO Pattern** - Transferencia de datos
3. **Service Layer** - Lógica de negocio
4. **Interceptor Pattern** - Manejo de JWT en Angular
5. **Guard Pattern** - Protección de rutas

---

## Tareas Comunes

### Crear un nuevo endpoint
1. Crear DTO en `dto/`
2. Crear/actualizar Entity en `entity/`
3. Crear método en Repository
4. Implementar lógica en Service
5. Exponer en Controller

### Crear un nuevo componente Angular
1. `ng generate component features/<module>/<component> --standalone`
2. Importar dependencias necesarias
3. Agregar a las rutas si es necesario
4. Crear servicio si requiere datos del backend

---

## Variables de Entorno

### Backend
```properties
DB_HOST=localhost
DB_PORT=5432
DB_NAME=flavorique
DB_USER=postgres
DB_PASSWORD=secret
JWT_SECRET=your-secret-key
JWT_EXPIRATION=86400000
```

### Frontend
```typescript
// environment.ts
export const environment = {
  production: false,
  apiUrl: 'http://localhost:8080/api'
};
```

---

## Comandos Útiles

```bash
# Backend
./mvnw spring-boot:run
./mvnw test
./mvnw clean package

# Frontend
ng serve
ng test
ng build --configuration production

# Docker
docker-compose up -d
docker-compose logs -f backend
```

---

## Notas para IA

- Preferir código limpio y legible sobre optimización prematura
- Incluir manejo de errores apropiado
- Documentar métodos públicos con JavaDoc/TSDoc
- Seguir principios SOLID
- Tests unitarios para lógica crítica
