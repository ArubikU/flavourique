# Generador de Iconos PWA para Flavorique

Este directorio contiene los iconos necesarios para la PWA de Flavorique.

## Archivos SVG Base

- `icon.svg` - Icono principal con gradiente (para generar PNGs)
- `icon-maskable.svg` - Icono con safe zone para Android adaptive icons
- `safari-pinned-tab.svg` - Icono monocromático para Safari

## Iconos PNG Requeridos

Genera los siguientes PNGs desde los SVGs usando herramientas como:
- [Real Favicon Generator](https://realfavicongenerator.net/)
- [PWA Asset Generator](https://github.com/nickreese/pwa-asset-generator)
- ImageMagick o Sharp (Node.js)

### Iconos Estándar (desde icon.svg)
```
icon-16x16.png
icon-32x32.png
icon-48x48.png
icon-70x70.png
icon-72x72.png
icon-96x96.png
icon-128x128.png
icon-144x144.png
icon-150x150.png
icon-152x152.png
icon-192x192.png
icon-310x150.png (wide)
icon-310x310.png
icon-384x384.png
icon-512x512.png
```

### Iconos Maskable (desde icon-maskable.svg)
```
icon-maskable-192x192.png
icon-maskable-512x512.png
```

### Apple Touch Icons (desde icon.svg)
```
apple-touch-icon.png (180x180)
apple-touch-icon-57x57.png
apple-touch-icon-60x60.png
apple-touch-icon-72x72.png
apple-touch-icon-76x76.png
apple-touch-icon-114x114.png
apple-touch-icon-120x120.png
apple-touch-icon-144x144.png
apple-touch-icon-152x152.png
apple-touch-icon-180x180.png
```

### Shortcut Icons
```
shortcut-search.png (96x96) - Icono de lupa
shortcut-add.png (96x96) - Icono de +
shortcut-categories.png (96x96) - Icono de carpeta
```

### Screenshots
```
screenshots/screenshot-wide.png (1280x720)
screenshots/screenshot-mobile.png (390x844)
```

### Open Graph Image
```
og-image.png (1200x630) - Preview para redes sociales
```

## Comando rápido con ImageMagick

```bash
# Generar todos los tamaños desde SVG
for size in 16 32 48 70 72 96 128 144 150 152 192 310 384 512; do
  magick icon.svg -resize ${size}x${size} icon-${size}x${size}.png
done

# Apple touch icons
for size in 57 60 72 76 114 120 144 152 180; do
  magick icon.svg -resize ${size}x${size} apple-touch-icon-${size}x${size}.png
done

# Favicon ICO (multi-resolution)
magick icon.svg -define icon:auto-resize=256,128,64,48,32,16 ../favicon.ico
```

## Usando pwa-asset-generator (Node.js)

```bash
npx pwa-asset-generator icon.svg ./generated --background "#F97316" --splash-only false --icon-only
```
