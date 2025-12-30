# Arquitectura de Flavorique 🏗️

## Visión General

Flavorique sigue una arquitectura de **3 capas** con separación clara entre frontend y backend.

```
┌─────────────────────────────────────────────────────────────┐
│                        FRONTEND                              │
│                    Angular 17+ (SPA)                         │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐        │
│  │  Auth   │  │ Recipes │  │ Profile │  │ Explore │        │
│  │ Module  │  │ Module  │  │ Module  │  │ Module  │        │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘        │
│                         │                                    │
│              ┌──────────┴──────────┐                        │
│              │   HTTP Interceptor  │                        │
│              │   (JWT Handling)    │                        │
│              └──────────┬──────────┘                        │
└─────────────────────────┼───────────────────────────────────┘
                          │ REST API (JSON)
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                        BACKEND                               │
│                    Spring Boot 3.2+                          │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                   Controller Layer                    │   │
│  │         (REST Endpoints + Validación)                │   │
│  └─────────────────────────┬───────────────────────────┘   │
│                            │                                 │
│  ┌─────────────────────────▼───────────────────────────┐   │
│  │                   Service Layer                       │   │
│  │            (Lógica de Negocio + DTOs)                │   │
│  └─────────────────────────┬───────────────────────────┘   │
│                            │                                 │
│  ┌─────────────────────────▼───────────────────────────┐   │
│  │                  Repository Layer                     │   │
│  │              (Spring Data JPA + Hibernate)           │   │
│  └─────────────────────────┬───────────────────────────┘   │
└─────────────────────────────┼───────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                       DATABASE                               │
│                      PostgreSQL                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Componentes del Backend

### 1. Capa de Controladores (`controller/`)
- Maneja peticiones HTTP
- Validación de entrada
- Mapeo de DTOs
- Documentación OpenAPI

### 2. Capa de Servicios (`service/`)
- Lógica de negocio
- Transacciones
- Orquestación de operaciones

### 3. Capa de Repositorios (`repository/`)
- Acceso a datos
- Queries personalizadas
- Paginación

### 4. Seguridad (`security/`)
- Configuración JWT
- Filtros de autenticación
- Manejo de roles

---

## Componentes del Frontend

### 1. Core Module
- Guards de autenticación
- Interceptors HTTP
- Servicios singleton

### 2. Feature Modules
- **Auth**: Login, registro, recuperación
- **Recipes**: CRUD de recetas
- **Profile**: Gestión de perfil
- **Explore**: Descubrimiento y búsqueda

### 3. Shared Module
- Componentes reutilizables
- Pipes y directivas
- Modelos/interfaces

---

## Flujo de Autenticación

```
1. Usuario envía credenciales → POST /api/auth/login
2. Backend valida → Genera JWT (access + refresh token)
3. Frontend almacena tokens → localStorage/sessionStorage
4. Peticiones subsecuentes incluyen → Authorization: Bearer <token>
5. Interceptor añade token automáticamente
6. Si token expira → Refresh automático o redirect a login
```

---

## Base de Datos

### Entidades Principales

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│    User      │────<│   Recipe     │────<│  Ingredient  │
├──────────────┤     ├──────────────┤     ├──────────────┤
│ id           │     │ id           │     │ id           │
│ email        │     │ title        │     │ name         │
│ password     │     │ description  │     │ quantity     │
│ username     │     │ instructions │     │ unit         │
│ role         │     │ prepTime     │     │ recipe_id    │
│ avatar       │     │ difficulty   │     └──────────────┘
│ createdAt    │     │ author_id    │
└──────────────┘     │ createdAt    │
       │             └──────────────┘
       │                    │
       ▼                    ▼
┌──────────────┐     ┌──────────────┐
│  Favorite    │     │   Review     │
├──────────────┤     ├──────────────┤
│ user_id      │     │ id           │
│ recipe_id    │     │ rating       │
│ createdAt    │     │ comment      │
└──────────────┘     │ user_id      │
                     │ recipe_id    │
                     └──────────────┘
```

---

## Decisiones de Diseño

| Decisión | Justificación |
|----------|---------------|
| JWT sobre Sessions | Escalabilidad, stateless, ideal para SPAs |
| PostgreSQL | Relacional, robusto, soporte JSON |
| Angular Material | Componentes consistentes y accesibles |
| NgRx | Estado predecible en apps complejas |
| MapStruct | Mapeo eficiente DTO ↔ Entity |

---

## Próximos Pasos

- [ ] Documentar endpoints detalladamente
- [ ] Agregar diagramas de secuencia
- [ ] Definir estrategia de caché
- [ ] Planificar microservicios (futuro)
