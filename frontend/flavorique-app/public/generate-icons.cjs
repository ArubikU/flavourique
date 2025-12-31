/**
 * Script para generar iconos PWA desde isotipo.png
 * 
 * Requisitos:
 *   npm install sharp
 * 
 * Uso:
 *   node generate-icons.js
 */

const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

const PUBLIC_DIR = __dirname;
const ICONS_DIR = path.join(__dirname, 'icons');
const ISOTIPO = path.join(PUBLIC_DIR, 'isotipo.png');
const LOGOTIPO = path.join(PUBLIC_DIR, 'logotipo.png');

// Tamaños de iconos estándar
const STANDARD_SIZES = [16, 32, 48, 70, 72, 96, 128, 144, 150, 152, 192, 310, 384, 512];

// Tamaños de Apple Touch Icons
const APPLE_SIZES = [57, 60, 72, 76, 114, 120, 144, 152, 180];

// Tamaños maskable
const MASKABLE_SIZES = [192, 512];

async function generateIcons() {
  console.log('🎨 Generando iconos PWA para Flavorique...\n');

  // Crear directorio si no existe
  if (!fs.existsSync(ICONS_DIR)) {
    fs.mkdirSync(ICONS_DIR, { recursive: true });
  }

  // Verificar que existe isotipo.png
  if (!fs.existsSync(ISOTIPO)) {
    console.error('❌ No se encontró isotipo.png en public/');
    process.exit(1);
  }

  console.log(`📁 Usando: ${ISOTIPO}\n`);

  // Generar iconos estándar
  console.log('📦 Generando iconos estándar...');
  for (const size of STANDARD_SIZES) {
    const outputPath = path.join(ICONS_DIR, `icon-${size}x${size}.png`);
    await sharp(ISOTIPO)
      .resize(size, size, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 0 } })
      .png()
      .toFile(outputPath);
    console.log(`  ✓ icon-${size}x${size}.png`);
  }

  // Generar wide icon para Windows (usando logotipo si existe)
  console.log('\n📦 Generando icono wide para Windows...');
  const wideSource = fs.existsSync(LOGOTIPO) ? LOGOTIPO : ISOTIPO;
  await sharp(wideSource)
    .resize(310, 150, { fit: 'contain', background: { r: 249, g: 115, b: 22, alpha: 1 } })
    .png()
    .toFile(path.join(ICONS_DIR, 'icon-310x150.png'));
  console.log('  ✓ icon-310x150.png');

  // Generar Apple Touch Icons
  console.log('\n🍎 Generando Apple Touch Icons...');
  for (const size of APPLE_SIZES) {
    const outputPath = path.join(ICONS_DIR, `apple-touch-icon-${size}x${size}.png`);
    await sharp(ISOTIPO)
      .resize(size, size, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 0 } })
      .png()
      .toFile(outputPath);
    console.log(`  ✓ apple-touch-icon-${size}x${size}.png`);
  }

  // Apple Touch Icon default (180x180)
  await sharp(ISOTIPO)
    .resize(180, 180, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 0 } })
    .png()
    .toFile(path.join(ICONS_DIR, 'apple-touch-icon.png'));
  console.log('  ✓ apple-touch-icon.png (default)');

  // Generar iconos maskable (con fondo naranja y padding)
  console.log('\n🎭 Generando iconos maskable...');
  for (const size of MASKABLE_SIZES) {
    const outputPath = path.join(ICONS_DIR, `icon-maskable-${size}x${size}.png`);
    // Maskable icons need 10% safe zone padding
    const iconSize = Math.floor(size * 0.7);
    const padding = Math.floor((size - iconSize) / 2);
    
    // Crear fondo naranja
    const background = await sharp({
      create: {
        width: size,
        height: size,
        channels: 4,
        background: { r: 249, g: 115, b: 22, alpha: 1 }
      }
    }).png().toBuffer();
    
    // Redimensionar isotipo
    const icon = await sharp(ISOTIPO)
      .resize(iconSize, iconSize, { fit: 'contain', background: { r: 249, g: 115, b: 22, alpha: 1 } })
      .png()
      .toBuffer();
    
    // Componer
    await sharp(background)
      .composite([{ input: icon, left: padding, top: padding }])
      .png()
      .toFile(outputPath);
    
    console.log(`  ✓ icon-maskable-${size}x${size}.png`);
  }

  // Generar favicon.ico (32x32)
  console.log('\n🔖 Generando favicon...');
  await sharp(ISOTIPO)
    .resize(32, 32, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 0 } })
    .png()
    .toFile(path.join(PUBLIC_DIR, 'favicon.ico'));
  console.log('  ✓ favicon.ico (32x32)');

  // Generar OG Image (1200x630) usando logotipo
  console.log('\n📸 Generando Open Graph image...');
  if (fs.existsSync(LOGOTIPO)) {
    // Crear fondo con gradiente simulado (naranja claro)
    const ogBackground = await sharp({
      create: {
        width: 1200,
        height: 630,
        channels: 4,
        background: { r: 255, g: 247, b: 237, alpha: 1 } // #FFF7ED
      }
    }).png().toBuffer();
    
    // Redimensionar logotipo
    const logo = await sharp(LOGOTIPO)
      .resize(600, 200, { fit: 'contain', background: { r: 255, g: 247, b: 237, alpha: 0 } })
      .png()
      .toBuffer();
    
    // Componer centrado
    await sharp(ogBackground)
      .composite([{ input: logo, left: 300, top: 215 }])
      .png()
      .toFile(path.join(PUBLIC_DIR, 'og-image.png'));
    console.log('  ✓ og-image.png (1200x630)');
  } else {
    console.log('  ⚠ logotipo.png no encontrado, saltando og-image');
  }

  // Generar shortcut icons
  console.log('\n⚡ Generando shortcut icons...');
  const shortcuts = ['shortcut-search', 'shortcut-add', 'shortcut-categories'];
  for (const shortcut of shortcuts) {
    await sharp(ISOTIPO)
      .resize(96, 96, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 0 } })
      .png()
      .toFile(path.join(ICONS_DIR, `${shortcut}.png`));
    console.log(`  ✓ ${shortcut}.png`);
  }

  console.log('\n✅ ¡Todos los iconos generados correctamente!');
  console.log(`\n📁 Ubicación: ${ICONS_DIR}`);
  console.log('\nIconos generados:');
  const files = fs.readdirSync(ICONS_DIR).filter(f => f.endsWith('.png'));
  console.log(`  Total: ${files.length} archivos PNG`);
}

// Ejecutar
generateIcons().catch(err => {
  console.error('❌ Error generando iconos:', err);
  process.exit(1);
});
