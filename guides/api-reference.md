# API Reference 📚

## Base URL

```
Development: http://localhost:8080/api
Production:  https://api.flavorique.app/api
```

---

## Autenticación

Todos los endpoints protegidos requieren el header:
```
Authorization: Bearer <jwt_token>
```

---

## Endpoints

### 🔐 Auth

#### POST `/auth/register`
Registrar nuevo usuario.

**Request Body:**
```json
{
  "email": "usuario@ejemplo.com",
  "username": "chef_ejemplo",
  "password": "Password123!",
  "confirmPassword": "Password123!"
}
```

**Response:** `201 Created`
```json
{
  "id": 1,
  "email": "usuario@ejemplo.com",
  "username": "chef_ejemplo",
  "role": "USER",
  "createdAt": "2025-12-30T10:00:00Z"
}
```

---

#### POST `/auth/login`
Iniciar sesión.

**Request Body:**
```json
{
  "email": "usuario@ejemplo.com",
  "password": "Password123!"
}
```

**Response:** `200 OK`
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
  "tokenType": "Bearer",
  "expiresIn": 86400
}
```

---

#### POST `/auth/refresh`
Refrescar token de acceso.

**Request Body:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIs..."
}
```

---

### 📖 Recipes

#### GET `/recipes`
Listar recetas con paginación.

**Query Parameters:**
| Param | Type | Default | Description |
|-------|------|---------|-------------|
| page | int | 0 | Número de página |
| size | int | 10 | Elementos por página |
| sort | string | createdAt,desc | Campo y dirección de orden |

**Response:** `200 OK`
```json
{
  "content": [
    {
      "id": 1,
      "title": "Paella Valenciana",
      "description": "Receta tradicional española...",
      "prepTime": 45,
      "difficulty": "MEDIUM",
      "author": {
        "id": 1,
        "username": "chef_ejemplo"
      },
      "imageUrl": "/images/paella.jpg",
      "rating": 4.5,
      "favoritesCount": 128
    }
  ],
  "totalElements": 150,
  "totalPages": 15,
  "number": 0,
  "size": 10
}
```

---

#### GET `/recipes/{id}`
Obtener receta por ID.

**Response:** `200 OK`
```json
{
  "id": 1,
  "title": "Paella Valenciana",
  "description": "Receta tradicional española...",
  "prepTime": 45,
  "cookTime": 30,
  "servings": 4,
  "difficulty": "MEDIUM",
  "ingredients": [
    {
      "name": "Arroz bomba",
      "quantity": 400,
      "unit": "g"
    }
  ],
  "instructions": [
    {
      "step": 1,
      "description": "Calentar el aceite en la paellera..."
    }
  ],
  "categories": ["Española", "Mariscos"],
  "tags": ["sin-gluten", "tradicional"],
  "author": {...},
  "createdAt": "2025-12-30T10:00:00Z",
  "updatedAt": "2025-12-30T10:00:00Z"
}
```

---

#### POST `/recipes`
Crear nueva receta. **Requiere autenticación.**

**Request Body:**
```json
{
  "title": "Mi Receta",
  "description": "Descripción...",
  "prepTime": 30,
  "cookTime": 45,
  "servings": 4,
  "difficulty": "EASY",
  "ingredients": [...],
  "instructions": [...],
  "categories": ["Postres"],
  "tags": ["vegano"]
}
```

---

#### PUT `/recipes/{id}`
Actualizar receta. **Requiere ser el autor o admin.**

---

#### DELETE `/recipes/{id}`
Eliminar receta. **Requiere ser el autor o admin.**

---

#### GET `/recipes/search`
Buscar recetas.

**Query Parameters:**
| Param | Type | Description |
|-------|------|-------------|
| q | string | Texto de búsqueda |
| category | string | Filtrar por categoría |
| difficulty | string | EASY, MEDIUM, HARD |
| maxPrepTime | int | Tiempo máximo en minutos |
| ingredients | string[] | Ingredientes a incluir |

---

#### POST `/recipes/{id}/favorite`
Agregar/quitar de favoritos. **Requiere autenticación.**

---

### 👤 Users

#### GET `/users/{id}`
Obtener perfil público de usuario.

#### PUT `/users/{id}`
Actualizar perfil. **Requiere ser el usuario.**

#### GET `/users/{id}/recipes`
Listar recetas del usuario.

#### GET `/users/{id}/favorites`
Listar favoritos del usuario.

---

## Códigos de Error

| Código | Descripción |
|--------|-------------|
| 400 | Bad Request - Datos inválidos |
| 401 | Unauthorized - Token inválido/expirado |
| 403 | Forbidden - Sin permisos |
| 404 | Not Found - Recurso no existe |
| 409 | Conflict - Email/username ya existe |
| 422 | Unprocessable Entity - Validación fallida |
| 500 | Internal Server Error |

---

## Formato de Errores

```json
{
  "timestamp": "2025-12-30T10:00:00Z",
  "status": 400,
  "error": "Bad Request",
  "message": "Validation failed",
  "errors": [
    {
      "field": "email",
      "message": "Email format is invalid"
    }
  ],
  "path": "/api/auth/register"
}
```
