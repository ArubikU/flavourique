# Esquema de Base de Datos 🗄️

## Diagrama ER

```
┌─────────────────────────────────────────────────────────────────────┐
│                              USERS                                   │
├─────────────────────────────────────────────────────────────────────┤
│ PK │ id            │ BIGSERIAL                                      │
│    │ email         │ VARCHAR(255) UNIQUE NOT NULL                   │
│    │ username      │ VARCHAR(50) UNIQUE NOT NULL                    │
│    │ password_hash │ VARCHAR(255) NOT NULL                          │
│    │ display_name  │ VARCHAR(100)                                   │
│    │ bio           │ TEXT                                           │
│    │ avatar_url    │ VARCHAR(500)                                   │
│    │ role          │ VARCHAR(20) DEFAULT 'USER'                     │
│    │ is_verified   │ BOOLEAN DEFAULT FALSE                          │
│    │ created_at    │ TIMESTAMP DEFAULT CURRENT_TIMESTAMP            │
│    │ updated_at    │ TIMESTAMP DEFAULT CURRENT_TIMESTAMP            │
└─────────────────────────────────────────────────────────────────────┘
                                    │
                                    │ 1:N
                                    ▼
┌─────────────────────────────────────────────────────────────────────┐
│                             RECIPES                                  │
├─────────────────────────────────────────────────────────────────────┤
│ PK │ id            │ BIGSERIAL                                      │
│ FK │ author_id     │ BIGINT REFERENCES users(id)                    │
│    │ title         │ VARCHAR(200) NOT NULL                          │
│    │ description   │ TEXT                                           │
│    │ instructions  │ TEXT NOT NULL                                  │
│    │ prep_time     │ INTEGER (minutos)                              │
│    │ cook_time     │ INTEGER (minutos)                              │
│    │ servings      │ INTEGER                                        │
│    │ difficulty    │ VARCHAR(20) -- EASY, MEDIUM, HARD              │
│    │ image_url     │ VARCHAR(500)                                   │
│    │ is_public     │ BOOLEAN DEFAULT TRUE                           │
│    │ created_at    │ TIMESTAMP DEFAULT CURRENT_TIMESTAMP            │
│    │ updated_at    │ TIMESTAMP DEFAULT CURRENT_TIMESTAMP            │
└─────────────────────────────────────────────────────────────────────┘
                                    │
          ┌─────────────────────────┼─────────────────────────┐
          │                         │                         │
          ▼ 1:N                     ▼ 1:N                     ▼ 1:N
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│   INGREDIENTS    │    │      STEPS       │    │  RECIPE_IMAGES   │
├──────────────────┤    ├──────────────────┤    ├──────────────────┤
│ PK │ id          │    │ PK │ id          │    │ PK │ id          │
│ FK │ recipe_id   │    │ FK │ recipe_id   │    │ FK │ recipe_id   │
│    │ name        │    │    │ step_number │    │    │ image_url   │
│    │ quantity    │    │    │ description │    │    │ is_primary  │
│    │ unit        │    │    │ image_url   │    │    │ sort_order  │
│    │ notes       │    │    │ duration    │    └──────────────────┘
│    │ sort_order  │    └──────────────────┘
└──────────────────┘
```

---

## Tablas de Relación

```
┌─────────────────────────────────────────────────────────────────────┐
│                            FAVORITES                                 │
├─────────────────────────────────────────────────────────────────────┤
│ PK │ id            │ BIGSERIAL                                      │
│ FK │ user_id       │ BIGINT REFERENCES users(id)                    │
│ FK │ recipe_id     │ BIGINT REFERENCES recipes(id)                  │
│    │ created_at    │ TIMESTAMP DEFAULT CURRENT_TIMESTAMP            │
│    │               │ UNIQUE(user_id, recipe_id)                     │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│                             REVIEWS                                  │
├─────────────────────────────────────────────────────────────────────┤
│ PK │ id            │ BIGSERIAL                                      │
│ FK │ user_id       │ BIGINT REFERENCES users(id)                    │
│ FK │ recipe_id     │ BIGINT REFERENCES recipes(id)                  │
│    │ rating        │ INTEGER CHECK (rating >= 1 AND rating <= 5)    │
│    │ comment       │ TEXT                                           │
│    │ created_at    │ TIMESTAMP DEFAULT CURRENT_TIMESTAMP            │
│    │ updated_at    │ TIMESTAMP DEFAULT CURRENT_TIMESTAMP            │
│    │               │ UNIQUE(user_id, recipe_id)                     │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│                            FOLLOWERS                                 │
├─────────────────────────────────────────────────────────────────────┤
│ PK │ id            │ BIGSERIAL                                      │
│ FK │ follower_id   │ BIGINT REFERENCES users(id)                    │
│ FK │ following_id  │ BIGINT REFERENCES users(id)                    │
│    │ created_at    │ TIMESTAMP DEFAULT CURRENT_TIMESTAMP            │
│    │               │ UNIQUE(follower_id, following_id)              │
│    │               │ CHECK(follower_id != following_id)             │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Categorías y Tags

```
┌──────────────────┐         ┌──────────────────────┐
│   CATEGORIES     │         │  RECIPE_CATEGORIES   │
├──────────────────┤         ├──────────────────────┤
│ PK │ id          │◄────────│ FK │ category_id     │
│    │ name        │         │ FK │ recipe_id       │
│    │ slug        │         │    │ UNIQUE(c_id,r_id)│
│    │ description │         └──────────────────────┘
│    │ icon        │
└──────────────────┘

┌──────────────────┐         ┌──────────────────────┐
│      TAGS        │         │     RECIPE_TAGS      │
├──────────────────┤         ├──────────────────────┤
│ PK │ id          │◄────────│ FK │ tag_id          │
│    │ name        │         │ FK │ recipe_id       │
│    │ slug        │         │    │ UNIQUE(t_id,r_id)│
└──────────────────┘         └──────────────────────┘
```

---

## Índices Recomendados

```sql
-- Users
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);

-- Recipes
CREATE INDEX idx_recipes_author ON recipes(author_id);
CREATE INDEX idx_recipes_created ON recipes(created_at DESC);
CREATE INDEX idx_recipes_title ON recipes USING GIN(to_tsvector('spanish', title));

-- Favorites
CREATE INDEX idx_favorites_user ON favorites(user_id);
CREATE INDEX idx_favorites_recipe ON favorites(recipe_id);

-- Reviews
CREATE INDEX idx_reviews_recipe ON reviews(recipe_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);

-- Full-text search
CREATE INDEX idx_recipes_search ON recipes 
  USING GIN(to_tsvector('spanish', title || ' ' || COALESCE(description, '')));
```

---

## Migraciones SQL (Flyway)

### V1__create_users_table.sql
```sql
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    display_name VARCHAR(100),
    bio TEXT,
    avatar_url VARCHAR(500),
    role VARCHAR(20) DEFAULT 'USER',
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### V2__create_recipes_table.sql
```sql
CREATE TABLE recipes (
    id BIGSERIAL PRIMARY KEY,
    author_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    instructions TEXT NOT NULL,
    prep_time INTEGER,
    cook_time INTEGER,
    servings INTEGER,
    difficulty VARCHAR(20),
    image_url VARCHAR(500),
    is_public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## Notas

- Usar `BIGSERIAL` para IDs permite escalar a millones de registros
- Timestamps con zona horaria: considerar usar `TIMESTAMPTZ`
- Soft delete: agregar columna `deleted_at` si se necesita
- Auditoría: considerar tablas de historial para cambios críticos
