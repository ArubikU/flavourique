# 🎨 Flavorique - Guía de Estilo Frontend

> Guía de diseño visual para el frontend de Flavorique. Inspirado en Tasty con un enfoque moderno y minimalista.

---

## 📋 Índice

1. [Filosofía de Diseño](#-filosofía-de-diseño)
2. [Paleta de Colores](#-paleta-de-colores)
3. [Tipografía](#-tipografía)
4. [Espaciado](#-espaciado)
5. [Layout y Grid](#-layout-y-grid)
6. [Componentes](#-componentes)
7. [Iconografía](#-iconografía)
8. [Animaciones](#-animaciones)
9. [Logo y Branding](#-logo-y-branding)

---

## 🎯 Filosofía de Diseño

| Principio | Descripción |
|-----------|-------------|
| **Minimalista** | Menos es más. Espacios en blanco generosos, UI limpia |
| **Apetitoso** | Los colores y fotos deben hacer que la comida se vea irresistible |
| **Accesible** | Contraste adecuado, tamaños legibles, mobile-first |
| **Consistente** | Reutilizar componentes de Angular Material + Tailwind |
| **Flat** | Sin sombras pesadas, bordes limpios, diseño plano |

---

## 🎨 Paleta de Colores

### Colores Principales

Paleta pastel cálida con acentos naranjas y azules.

#### Tema Claro (Default)

```css
:root {
  /* === PRIMARIOS === */
  --color-primary-50: #FFF7ED;    /* Naranja muy claro - backgrounds */
  --color-primary-100: #FFEDD5;   /* Naranja claro */
  --color-primary-200: #FED7AA;   /* Naranja pastel suave */
  --color-primary-300: #FDBA74;   /* Naranja pastel */
  --color-primary-400: #FB923C;   /* Naranja medio */
  --color-primary-500: #F97316;   /* Naranja principal ⭐ */
  --color-primary-600: #EA580C;   /* Naranja hover */
  --color-primary-700: #C2410C;   /* Naranja oscuro */

  /* === SECUNDARIOS (Azul) === */
  --color-secondary-50: #F0F9FF;  /* Azul muy claro */
  --color-secondary-100: #E0F2FE; /* Azul claro */
  --color-secondary-200: #BAE6FD; /* Azul pastel suave */
  --color-secondary-300: #7DD3FC; /* Azul pastel */
  --color-secondary-400: #38BDF8; /* Azul medio */
  --color-secondary-500: #0EA5E9; /* Azul principal ⭐ */
  --color-secondary-600: #0284C7; /* Azul hover */
  --color-secondary-700: #0369A1; /* Azul oscuro */

  /* === NEUTROS === */
  --color-neutral-0: #FFFFFF;     /* Blanco puro */
  --color-neutral-50: #FAFAFA;    /* Gris muy claro - page bg */
  --color-neutral-100: #F5F5F5;   /* Gris claro - card bg */
  --color-neutral-200: #E5E5E5;   /* Bordes */
  --color-neutral-300: #D4D4D4;   /* Bordes hover */
  --color-neutral-400: #A3A3A3;   /* Texto deshabilitado */
  --color-neutral-500: #737373;   /* Texto secundario */
  --color-neutral-600: #525252;   /* Texto medio */
  --color-neutral-700: #404040;   /* Texto principal */
  --color-neutral-800: #262626;   /* Texto oscuro */
  --color-neutral-900: #171717;   /* Texto muy oscuro */

  /* === SEMÁNTICOS === */
  --color-success: #22C55E;       /* Verde éxito */
  --color-success-light: #DCFCE7;
  --color-warning: #EAB308;       /* Amarillo advertencia */
  --color-warning-light: #FEF9C3;
  --color-error: #EF4444;         /* Rojo error */
  --color-error-light: #FEE2E2;
  --color-info: #0EA5E9;          /* Azul info */
  --color-info-light: #E0F2FE;

  /* === SUPERFICIES === */
  --surface-page: var(--color-neutral-50);
  --surface-card: var(--color-neutral-0);
  --surface-elevated: var(--color-neutral-0);
  --surface-overlay: rgba(0, 0, 0, 0.5);

  /* === TEXTO === */
  --text-primary: var(--color-neutral-800);
  --text-secondary: var(--color-neutral-500);
  --text-disabled: var(--color-neutral-400);
  --text-inverse: var(--color-neutral-0);
  --text-link: var(--color-primary-500);
  --text-link-hover: var(--color-primary-600);

  /* === BORDES === */
  --border-default: var(--color-neutral-200);
  --border-hover: var(--color-neutral-300);
  --border-focus: var(--color-primary-500);
  --border-radius-sm: 4px;
  --border-radius-md: 8px;
  --border-radius-lg: 12px;
  --border-radius-full: 9999px;
}
```

#### Tema Oscuro (Futuro)

```css
[data-theme="dark"] {
  /* === SUPERFICIES === */
  --surface-page: #0A0A0A;
  --surface-card: #171717;
  --surface-elevated: #262626;
  --surface-overlay: rgba(0, 0, 0, 0.7);

  /* === TEXTO === */
  --text-primary: #FAFAFA;
  --text-secondary: #A3A3A3;
  --text-disabled: #525252;
  --text-inverse: #171717;

  /* === BORDES === */
  --border-default: #404040;
  --border-hover: #525252;

  /* Los colores primarios y secundarios se mantienen */
}
```

### Configuración Tailwind

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#FFF7ED',
          100: '#FFEDD5',
          200: '#FED7AA',
          300: '#FDBA74',
          400: '#FB923C',
          500: '#F97316',
          600: '#EA580C',
          700: '#C2410C',
        },
        secondary: {
          50: '#F0F9FF',
          100: '#E0F2FE',
          200: '#BAE6FD',
          300: '#7DD3FC',
          400: '#38BDF8',
          500: '#0EA5E9',
          600: '#0284C7',
          700: '#0369A1',
        },
      },
    },
  },
}
```

---

## 🔤 Tipografía

### Fuente Principal: Inter

```css
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

:root {
  --font-family-base: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  --font-family-display: 'Inter', sans-serif;
  
  /* === PESOS === */
  --font-weight-regular: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;
}
```

### Escala Tipográfica

| Nombre | Tamaño | Peso | Line Height | Uso |
|--------|--------|------|-------------|-----|
| `display-xl` | 48px | 700 | 1.1 | Hero títulos |
| `display-lg` | 36px | 700 | 1.2 | Títulos de página |
| `display-md` | 30px | 700 | 1.2 | Títulos de sección |
| `heading-lg` | 24px | 600 | 1.3 | Subtítulos grandes |
| `heading-md` | 20px | 600 | 1.4 | Subtítulos |
| `heading-sm` | 18px | 600 | 1.4 | Títulos de tarjeta |
| `body-lg` | 18px | 400 | 1.6 | Texto grande |
| `body-md` | 16px | 400 | 1.6 | Texto principal |
| `body-sm` | 14px | 400 | 1.5 | Texto secundario |
| `caption` | 12px | 500 | 1.4 | Labels, captions |
| `overline` | 11px | 600 | 1.4 | Overlines, tags |

```css
/* Clases de utilidad */
.text-display-xl { font-size: 48px; font-weight: 700; line-height: 1.1; }
.text-display-lg { font-size: 36px; font-weight: 700; line-height: 1.2; }
.text-display-md { font-size: 30px; font-weight: 700; line-height: 1.2; }
.text-heading-lg { font-size: 24px; font-weight: 600; line-height: 1.3; }
.text-heading-md { font-size: 20px; font-weight: 600; line-height: 1.4; }
.text-heading-sm { font-size: 18px; font-weight: 600; line-height: 1.4; }
.text-body-lg    { font-size: 18px; font-weight: 400; line-height: 1.6; }
.text-body-md    { font-size: 16px; font-weight: 400; line-height: 1.6; }
.text-body-sm    { font-size: 14px; font-weight: 400; line-height: 1.5; }
.text-caption    { font-size: 12px; font-weight: 500; line-height: 1.4; }
.text-overline   { font-size: 11px; font-weight: 600; line-height: 1.4; text-transform: uppercase; letter-spacing: 0.5px; }
```

---

## 📐 Espaciado

### Sistema de 4px

Todos los espaciados son múltiplos de 4px.

```css
:root {
  --space-0: 0;
  --space-1: 4px;    /* 0.25rem */
  --space-2: 8px;    /* 0.5rem */
  --space-3: 12px;   /* 0.75rem */
  --space-4: 16px;   /* 1rem */
  --space-5: 20px;   /* 1.25rem */
  --space-6: 24px;   /* 1.5rem */
  --space-8: 32px;   /* 2rem */
  --space-10: 40px;  /* 2.5rem */
  --space-12: 48px;  /* 3rem */
  --space-16: 64px;  /* 4rem */
  --space-20: 80px;  /* 5rem */
  --space-24: 96px;  /* 6rem */
}
```

### Uso Recomendado

| Espacio | Uso |
|---------|-----|
| `space-1` (4px) | Gaps mínimos, padding de iconos |
| `space-2` (8px) | Entre elementos inline, padding de chips/tags |
| `space-3` (12px) | Padding interno de inputs |
| `space-4` (16px) | Padding de tarjetas, gap de grid |
| `space-6` (24px) | Separación entre secciones pequeñas |
| `space-8` (32px) | Margen entre componentes |
| `space-12` (48px) | Separación entre secciones |
| `space-16+` (64px+) | Padding de página, hero sections |

---

## 📱 Layout y Grid

### Contenedor Full-Width

```css
.container {
  width: 100%;
  padding-left: var(--space-4);
  padding-right: var(--space-4);
}

@media (min-width: 640px) {
  .container {
    padding-left: var(--space-6);
    padding-right: var(--space-6);
  }
}

@media (min-width: 1024px) {
  .container {
    padding-left: var(--space-8);
    padding-right: var(--space-8);
  }
}

/* Opcionalmente limitar ancho máximo para legibilidad */
.container-readable {
  max-width: 1400px;
  margin: 0 auto;
}
```

### Grid de Recetas (3 columnas)

```css
.recipe-grid {
  display: grid;
  gap: var(--space-4);
  grid-template-columns: 1fr;
}

@media (min-width: 640px) {
  .recipe-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1024px) {
  .recipe-grid {
    grid-template-columns: repeat(3, 1fr);
    gap: var(--space-6);
  }
}
```

```html
<!-- Tailwind -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 lg:gap-6">
  <!-- Recipe cards -->
</div>
```

### Breakpoints

| Nombre | Ancho | Uso |
|--------|-------|-----|
| `sm` | 640px | Tablets pequeñas |
| `md` | 768px | Tablets |
| `lg` | 1024px | Desktop |
| `xl` | 1280px | Desktop grande |
| `2xl` | 1536px | Pantallas muy grandes |

---

## 🧩 Componentes

### Tarjetas de Receta (Cuadradas)

```html
<div class="recipe-card">
  <div class="recipe-card__image">
    <img src="..." alt="Nombre de receta" />
    <button class="recipe-card__favorite">
      <mat-icon>favorite_border</mat-icon>
    </button>
  </div>
  <div class="recipe-card__content">
    <span class="recipe-card__category">Postres</span>
    <h3 class="recipe-card__title">Tarta de Manzana</h3>
    <div class="recipe-card__meta">
      <span><mat-icon>schedule</mat-icon> 45 min</span>
      <span><mat-icon>restaurant</mat-icon> Fácil</span>
    </div>
  </div>
</div>
```

```css
.recipe-card {
  background: var(--surface-card);
  border: 1px solid var(--border-default);
  border-radius: var(--border-radius-md);
  overflow: hidden;
  transition: border-color 0.2s ease;
}

.recipe-card:hover {
  border-color: var(--border-hover);
}

.recipe-card__image {
  position: relative;
  aspect-ratio: 1 / 1; /* Cuadrada */
  overflow: hidden;
}

.recipe-card__image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.recipe-card:hover .recipe-card__image img {
  transform: scale(1.05);
}

.recipe-card__favorite {
  position: absolute;
  top: var(--space-2);
  right: var(--space-2);
  background: var(--surface-card);
  border: none;
  border-radius: var(--border-radius-full);
  padding: var(--space-2);
  cursor: pointer;
  transition: background 0.2s ease;
}

.recipe-card__favorite:hover {
  background: var(--color-primary-100);
}

.recipe-card__content {
  padding: var(--space-4);
}

.recipe-card__category {
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  color: var(--color-primary-500);
}

.recipe-card__title {
  font-size: 18px;
  font-weight: 600;
  color: var(--text-primary);
  margin: var(--space-1) 0 var(--space-2);
  
  /* Truncar a 2 líneas */
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.recipe-card__meta {
  display: flex;
  gap: var(--space-4);
  color: var(--text-secondary);
  font-size: 14px;
}

.recipe-card__meta mat-icon {
  font-size: 16px;
  width: 16px;
  height: 16px;
  vertical-align: middle;
  margin-right: var(--space-1);
}
```

### Botones (Cuadrados)

```css
/* === BOTÓN BASE === */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-2);
  padding: var(--space-3) var(--space-4);
  font-family: var(--font-family-base);
  font-size: 14px;
  font-weight: 500;
  border: 1px solid transparent;
  border-radius: var(--border-radius-sm); /* 4px - Cuadrado */
  cursor: pointer;
  transition: all 0.2s ease;
}

/* === VARIANTES === */

/* Primario */
.btn-primary {
  background: var(--color-primary-500);
  color: var(--text-inverse);
}

.btn-primary:hover {
  background: var(--color-primary-600);
}

/* Secundario */
.btn-secondary {
  background: var(--color-secondary-500);
  color: var(--text-inverse);
}

.btn-secondary:hover {
  background: var(--color-secondary-600);
}

/* Outline */
.btn-outline {
  background: transparent;
  border-color: var(--border-default);
  color: var(--text-primary);
}

.btn-outline:hover {
  border-color: var(--color-primary-500);
  color: var(--color-primary-500);
}

/* Ghost */
.btn-ghost {
  background: transparent;
  color: var(--text-primary);
}

.btn-ghost:hover {
  background: var(--color-neutral-100);
}

/* === TAMAÑOS === */
.btn-sm {
  padding: var(--space-2) var(--space-3);
  font-size: 12px;
}

.btn-lg {
  padding: var(--space-4) var(--space-6);
  font-size: 16px;
}

/* === ESTADOS === */
.btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn:focus-visible {
  outline: 2px solid var(--color-primary-500);
  outline-offset: 2px;
}
```

### Inputs

```css
.input {
  width: 100%;
  padding: var(--space-3);
  font-family: var(--font-family-base);
  font-size: 16px;
  color: var(--text-primary);
  background: var(--surface-card);
  border: 1px solid var(--border-default);
  border-radius: var(--border-radius-sm);
  transition: border-color 0.2s ease;
}

.input:hover {
  border-color: var(--border-hover);
}

.input:focus {
  outline: none;
  border-color: var(--color-primary-500);
}

.input::placeholder {
  color: var(--text-disabled);
}

.input-error {
  border-color: var(--color-error);
}

/* Label */
.input-label {
  display: block;
  font-size: 14px;
  font-weight: 500;
  color: var(--text-primary);
  margin-bottom: var(--space-1);
}

/* Helper text */
.input-helper {
  font-size: 12px;
  color: var(--text-secondary);
  margin-top: var(--space-1);
}

.input-helper-error {
  color: var(--color-error);
}
```

### Chips / Tags

```css
.chip {
  display: inline-flex;
  align-items: center;
  gap: var(--space-1);
  padding: var(--space-1) var(--space-2);
  font-size: 12px;
  font-weight: 500;
  border-radius: var(--border-radius-sm);
  background: var(--color-neutral-100);
  color: var(--text-secondary);
}

.chip-primary {
  background: var(--color-primary-100);
  color: var(--color-primary-700);
}

.chip-secondary {
  background: var(--color-secondary-100);
  color: var(--color-secondary-700);
}
```

### Badge de Dificultad

```css
.difficulty-badge {
  display: inline-flex;
  align-items: center;
  gap: var(--space-1);
  padding: var(--space-1) var(--space-2);
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  border-radius: var(--border-radius-sm);
}

.difficulty-easy {
  background: var(--color-success-light);
  color: #166534;
}

.difficulty-medium {
  background: var(--color-warning-light);
  color: #854D0E;
}

.difficulty-hard {
  background: var(--color-error-light);
  color: #991B1B;
}
```

---

## 🎯 Iconografía

### Material Icons

```html
<!-- Agregar en index.html -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
```

### Iconos Comunes en Flavorique

| Icono | Nombre Material | Uso |
|-------|-----------------|-----|
| ❤️ | `favorite` / `favorite_border` | Favoritos |
| ⏱️ | `schedule` | Tiempo de preparación |
| 🍽️ | `restaurant` | Dificultad / Porciones |
| 👤 | `person` | Usuario / Perfil |
| 🔍 | `search` | Búsqueda |
| ➕ | `add` | Agregar receta |
| ✏️ | `edit` | Editar |
| 🗑️ | `delete` | Eliminar |
| ⭐ | `star` / `star_border` | Rating |
| 🏷️ | `local_offer` | Tags |
| 📂 | `folder` | Categorías |
| 🔗 | `share` | Compartir |
| 💬 | `chat_bubble_outline` | Comentarios |
| 🔔 | `notifications` | Notificaciones |
| ⚙️ | `settings` | Configuración |
| 🌙 | `dark_mode` | Tema oscuro |
| ☀️ | `light_mode` | Tema claro |

### Tamaños de Iconos

```css
.icon-sm { font-size: 16px; width: 16px; height: 16px; }
.icon-md { font-size: 24px; width: 24px; height: 24px; } /* Default */
.icon-lg { font-size: 32px; width: 32px; height: 32px; }
.icon-xl { font-size: 48px; width: 48px; height: 48px; }
```

---

## ✨ Animaciones

### Principios

- **Sutiles**: Máximo 300ms para transiciones UI
- **Propósito**: Toda animación debe tener un propósito (feedback, guiar atención)
- **Consistentes**: Usar las mismas curvas y duraciones

### Variables de Animación

```css
:root {
  /* === DURACIONES === */
  --duration-instant: 100ms;
  --duration-fast: 150ms;
  --duration-normal: 200ms;
  --duration-slow: 300ms;
  --duration-slower: 500ms;

  /* === EASINGS === */
  --ease-default: cubic-bezier(0.4, 0, 0.2, 1);
  --ease-in: cubic-bezier(0.4, 0, 1, 1);
  --ease-out: cubic-bezier(0, 0, 0.2, 1);
  --ease-bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55);
}
```

### Microinteracciones

```css
/* Hover en tarjetas - Imagen zoom */
.recipe-card__image img {
  transition: transform var(--duration-slow) var(--ease-default);
}
.recipe-card:hover .recipe-card__image img {
  transform: scale(1.05);
}

/* Botón de favorito - Escala al click */
.favorite-btn {
  transition: transform var(--duration-fast) var(--ease-bounce);
}
.favorite-btn:active {
  transform: scale(0.9);
}
.favorite-btn.active {
  animation: heartPop var(--duration-normal) var(--ease-bounce);
}

@keyframes heartPop {
  0% { transform: scale(1); }
  50% { transform: scale(1.3); }
  100% { transform: scale(1); }
}

/* Hover en botones */
.btn {
  transition: 
    background var(--duration-fast) var(--ease-default),
    border-color var(--duration-fast) var(--ease-default),
    transform var(--duration-fast) var(--ease-default);
}
.btn:hover {
  transform: translateY(-1px);
}
.btn:active {
  transform: translateY(0);
}

/* Focus visible */
.btn:focus-visible,
.input:focus-visible {
  transition: outline-offset var(--duration-fast) var(--ease-default);
  outline-offset: 2px;
}

/* Aparición de elementos (fade in up) */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(8px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in-up {
  animation: fadeInUp var(--duration-normal) var(--ease-out);
}

/* Skeleton loading pulse */
@keyframes skeletonPulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.skeleton {
  background: var(--color-neutral-200);
  animation: skeletonPulse 1.5s var(--ease-default) infinite;
}
```

### Transiciones de Página (Angular Router)

```css
/* En styles.scss */
.page-enter {
  opacity: 0;
  transform: translateY(8px);
}

.page-enter-active {
  opacity: 1;
  transform: translateY(0);
  transition: 
    opacity var(--duration-normal) var(--ease-out),
    transform var(--duration-normal) var(--ease-out);
}
```

---

## 🏷️ Logo y Branding

### Concepto del Logo

El logo de **Flavorique** debe transmitir:
- 🍊 **Calidez**: Colores naranjas pastel
- ✨ **Elegancia minimalista**: Líneas limpias, sin exceso de detalle
- 🍳 **Conexión con cocina**: Elemento visual que evoque comida/cocina
- 📱 **Versatilidad**: Funcionar en tamaños pequeños (favicon) y grandes

### Prompt para Generador de Logo AI

```
Design a minimalist logo for "Flavorique", a modern recipe sharing platform.

Style:
- Flat design, no gradients or shadows
- Clean geometric shapes
- Modern and sophisticated
- Similar vibe to Tasty logo (bold, friendly, appetizing)

Elements to consider:
- Combine a stylized chef's hat or cooking pot with the letter "F"
- OR a fork/spoon forming the letter "F"
- OR a flame/steam element integrated with typography

Colors:
- Primary: Soft orange/peach (#F97316 or pastel #FDBA74)
- Secondary: Soft sky blue (#0EA5E9 or pastel #7DD3FC)
- Can be single color (orange) for simplicity

Typography:
- If including wordmark, use a clean sans-serif like Inter or Poppins
- Bold weight for the word "Flavorique"
- Consider making "Flavor" in orange and "ique" in blue

Versions needed:
1. Full logo with icon + wordmark (horizontal)
2. Icon only (for favicon, app icon)
3. Monochrome version (white, black)

Output: Vector format (SVG), clean paths, scalable
```

### Variaciones del Logo

```
┌─────────────────────────────────────────────┐
│                                             │
│   🍳  FLAVORIQUE     ← Full horizontal      │
│                                             │
│   🍳                 ← Icon only            │
│                                             │
│   🍳                                        │
│   FLAVORIQUE         ← Stacked              │
│                                             │
└─────────────────────────────────────────────┘
```

### Uso del Logo

| Contexto | Versión | Tamaño mínimo |
|----------|---------|---------------|
| Header web | Full horizontal | 120px ancho |
| Favicon | Icon only | 32x32px |
| App icon | Icon only | 512x512px |
| Footer | Full horizontal (pequeño) | 80px ancho |
| Redes sociales | Icon only o stacked | Varía |

### Archivos del Logo

 - `isotipo.png` - Icono solo en 1024x1024px PNG
 - `logotipo.png` - Logo horizontal en 1200x400px PNG

### Espacio de Respeto

```
         ┌───────────────────┐
         │                   │
    █────│   🍳 FLAVORIQUE   │────█
    █    │                   │    █
         └───────────────────┘
         
█ = Espacio mínimo = altura del icono
```

---

## 📦 Implementación Angular Material + Tailwind

### Configuración Recomendada

```typescript
// angular.json - Asegurar Tailwind está configurado
{
  "styles": [
    "src/styles.scss"
  ]
}
```

```scss
// styles.scss
@use '@angular/material' as mat;

// Importar fuente
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

// Tailwind
@tailwind base;
@tailwind components;
@tailwind utilities;

// Variables CSS globales
:root {
  // ... (todas las variables definidas arriba)
}

// Tema Angular Material personalizado
$flavorique-primary: mat.define-palette((
  50: #FFF7ED,
  100: #FFEDD5,
  200: #FED7AA,
  300: #FDBA74,
  400: #FB923C,
  500: #F97316,
  600: #EA580C,
  700: #C2410C,
  800: #9A3412,
  900: #7C2D12,
  contrast: (
    50: #000,
    100: #000,
    200: #000,
    300: #000,
    400: #000,
    500: #fff,
    600: #fff,
    700: #fff,
    800: #fff,
    900: #fff,
  )
));

$flavorique-theme: mat.define-light-theme((
  color: (
    primary: $flavorique-primary,
    accent: mat.define-palette(mat.$blue-palette),
  ),
  typography: mat.define-typography-config(
    $font-family: 'Inter, sans-serif',
  ),
));

@include mat.all-component-themes($flavorique-theme);
```

---

## ✅ Checklist de Implementación

- [ ] Configurar Tailwind con colores personalizados
- [ ] Configurar tema Angular Material
- [ ] Importar fuente Inter
- [ ] Crear componente de tarjeta de receta
- [ ] Crear estilos de botones
- [ ] Crear estilos de inputs
- [ ] Configurar animaciones globales
- [ ] Diseñar/generar logo
- [ ] Implementar tema oscuro (futuro)

---

> **Última actualización:** Diciembre 2024  
> **Versión:** 1.0.0
