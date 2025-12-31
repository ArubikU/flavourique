-- ============================================
-- Flavorique - Script de poblado de datos
-- Equivalente al DataLoader.java
-- ============================================

-- ============================================
-- CATEGORÍAS
-- ============================================
INSERT INTO categories (name, slug, description, icon) VALUES
('Desayunos', 'desayunos', 'Recetas para comenzar el día con energía', '🍳'),
('Almuerzos', 'almuerzos', 'Platos principales para el mediodía', '🍽️'),
('Cenas', 'cenas', 'Recetas ligeras y deliciosas para la noche', '🌙'),
('Postres', 'postres', 'Dulces tentaciones para cualquier momento', '🍰'),
('Sopas y Cremas', 'sopas-cremas', 'Reconfortantes y nutritivas', '🍲'),
('Ensaladas', 'ensaladas', 'Frescas y saludables', '🥗'),
('Carnes', 'carnes', 'Recetas con carne de res, cerdo y más', '🥩'),
('Aves', 'aves', 'Pollo, pavo y otras aves', '🍗'),
('Pescados y Mariscos', 'pescados-mariscos', 'Del mar a tu mesa', '🐟'),
('Vegetariano', 'vegetariano', 'Sin carne, lleno de sabor', '🥬'),
('Vegano', 'vegano', '100% basado en plantas', '🌱'),
('Pastas', 'pastas', 'Italianas y más', '🍝'),
('Arroces', 'arroces', 'Paellas, risottos y más', '🍚'),
('Panes y Masas', 'panes-masas', 'Horneados caseros', '🍞'),
('Bebidas', 'bebidas', 'Refrescantes y deliciosas', '🍹'),
('Snacks', 'snacks', 'Bocadillos rápidos', '🍿'),
('Salsas', 'salsas', 'Complementos perfectos', '🫙'),
('Internacional', 'internacional', 'Sabores del mundo', '🌍')
ON CONFLICT (slug) DO NOTHING;

-- ============================================
-- TAGS
-- ============================================
INSERT INTO tags (name, slug) VALUES
('Rápido', 'rapido'),
('Fácil', 'facil'),
('Económico', 'economico'),
('Sin Gluten', 'sin-gluten'),
('Sin Lactosa', 'sin-lactosa'),
('Bajo en Calorías', 'bajo-calorias'),
('Alto en Proteína', 'alto-proteina'),
('Keto', 'keto'),
('Comfort Food', 'comfort-food'),
('Para Niños', 'para-ninos'),
('Gourmet', 'gourmet'),
('Tradicional', 'tradicional'),
('Fusión', 'fusion'),
('Picante', 'picante'),
('Dulce', 'dulce'),
('Salado', 'salado'),
('Frío', 'frio'),
('Caliente', 'caliente'),
('Batch Cooking', 'batch-cooking'),
('Meal Prep', 'meal-prep')
ON CONFLICT (slug) DO NOTHING;

-- ============================================
-- USUARIO ADMIN
-- Password: Admin123!
-- Hash generado con BCrypt (strength 10)
-- ============================================
INSERT INTO users (email, username, password_hash, display_name, role, is_verified, bio)
VALUES (
    'arubik4u@gmail.com',
    'Arubik',
    '$2a$10$rDkPvvAFV8kqwvKJzwlRv.FDXyX0JvQyZ1sY5Y9K5IJ5Z5Z5Z5Z5e',
    'Arubik',
    'ADMIN',
    TRUE,
    'Chef y administrador de Flavorique. Apasionado por la cocina italiana y las técnicas culinarias avanzadas.'
)
ON CONFLICT (email) DO NOTHING;

-- ============================================
-- RECETA DE DEMOSTRACIÓN: Ragù alla Bolognese
-- ============================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
    cat_carnes_id BIGINT;
    cat_pastas_id BIGINT;
    cat_internacional_id BIGINT;
    tag_gourmet_id BIGINT;
    tag_tradicional_id BIGINT;
BEGIN
    -- Obtener ID del admin
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    -- Verificar si ya existe la receta
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Ragù alla Bolognese de Larga Cocción Técnica') THEN
        
        -- Insertar receta
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public, image_url)
        VALUES (
            admin_id,
            'Ragù alla Bolognese de Larga Cocción Técnica',
            'Elaboración de salsa boloñesa tradicional mediante técnica de cocción lenta (5 horas). El proceso prioriza la reacción de Maillard en la proteína, el desglasado con vino tinto de cuerpo y la suavización de fibras mediante la incorporación de lácteos, resultando en un ragù de textura compleja y acidez equilibrada.',
            45,
            300,
            3,
            'HARD',
            TRUE,
            'https://i.imgur.com/NZvqCMM.png'
        )
        RETURNING id INTO recipe_id;

        -- Obtener IDs de categorías
        SELECT id INTO cat_carnes_id FROM categories WHERE slug = 'carnes';
        SELECT id INTO cat_pastas_id FROM categories WHERE slug = 'pastas';
        SELECT id INTO cat_internacional_id FROM categories WHERE slug = 'internacional';

        -- Obtener IDs de tags
        SELECT id INTO tag_gourmet_id FROM tags WHERE slug = 'gourmet';
        SELECT id INTO tag_tradicional_id FROM tags WHERE slug = 'tradicional';

        -- Asociar categorías
        INSERT INTO recipe_categories (recipe_id, category_id) VALUES
        (recipe_id, cat_carnes_id),
        (recipe_id, cat_pastas_id),
        (recipe_id, cat_internacional_id);

        -- Asociar tags
        INSERT INTO recipe_tags (recipe_id, tag_id) VALUES
        (recipe_id, tag_gourmet_id),
        (recipe_id, tag_tradicional_id);

        -- Insertar ingredientes
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Entraña de res', 400, 'g', 'Picada manualmente a cuchillo', 1),
        (recipe_id, 'Panceta de cerdo curada', 100, 'g', 'Picada en brunoise fino', 2),
        (recipe_id, 'Cebolla blanca', 1, 'unidad', 'Picado fino (brunoise)', 3),
        (recipe_id, 'Zanahoria', 1, 'unidad', 'Picado fino (brunoise)', 4),
        (recipe_id, 'Apio', 1, 'tallo', 'Picado fino (brunoise)', 5),
        (recipe_id, 'Tomates San Marzano', 1, 'lata', 'Triturados manualmente', 6),
        (recipe_id, 'Tomates cherry', 150, 'g', 'Maduros, para guarnición técnica', 7),
        (recipe_id, 'Vino tinto (Malbec o Cabernet)', 2, 'tazas', 'Alta estructura tánica', 8),
        (recipe_id, 'Leche entera', 0.5, 'taza', 'Para control de acidez y texturizado', 9),
        (recipe_id, 'Caldo de res', 1, 'taza', 'Concentrado natural sin aditivos', 10),
        (recipe_id, 'Pasta larga (Pappardelle)', 400, 'g', 'De sémola de trigo duro', 11),
        (recipe_id, 'Aceite de oliva virgen extra', NULL, 'c/n', 'Para cocción inicial', 12),
        (recipe_id, 'Mantequilla sin sal', 30, 'g', 'Para emulsión de soffritto', 13),
        (recipe_id, 'Sal de mar, pimienta y laurel', NULL, 'al gusto', 'Especias base', 14);

        -- Insertar pasos
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Base de Soffritto: En una olla de fondo difusor, fundir la grasa de la panceta con el aceite de oliva y la mantequilla. Añadir la cebolla, zanahoria y apio. Sofreír a fuego bajo durante 20 minutos hasta lograr la caramelización de los azúcares naturales sin llegar a dorar excesivamente.', 20),
        (recipe_id, 2, 'Sellado de Proteína: Incrementar la temperatura y añadir la carne de res picada. Sellar uniformemente hasta obtener una costra de caramelización (reacción de Maillard).', 10),
        (recipe_id, 3, 'Desglasado y Reducción: Verter el vino tinto y desglasar el fondo de la olla para recuperar los compuestos de sabor. Reducir el líquido hasta que el alcohol se haya evaporado y el volumen disminuya al 50%.', 15),
        (recipe_id, 4, 'Tratamiento Lácteo: Añadir la leche y una pizca de nuez moscada. Cocinar hasta que el líquido se evapore; este paso permite proteger la textura de la carne frente a la acidez del tomate.', 10),
        (recipe_id, 5, 'Cocción Prolongada: Incorporar los tomates San Marzano y el laurel. Reducir el fuego al mínimo (simmering). Mantener la cocción tapada entre 4 y 5 horas, hidratando con caldo de res según sea necesario para mantener la humedad.', 270),
        (recipe_id, 6, 'Preparación de Tomates Cherry: 30 minutos antes de finalizar, saltear los tomates cherry en una sartén aparte con aceite de oliva y ajo hasta que la piel se rompa y caramelice. Incorporar a la salsa principal.', 30),
        (recipe_id, 7, 'Finalización: Cocer la pasta al dente y terminar su cocción directamente en la salsa para asegurar la emulsión y adherencia.', 12),
        (recipe_id, 8, 'Servicio: Emplatar y añadir queso Parmigiano Reggiano madurado para aportar salinidad y umami.', 5);

        RAISE NOTICE '✅ Receta "Ragù alla Bolognese" creada correctamente';
    ELSE
        RAISE NOTICE '⚠️ Receta "Ragù alla Bolognese" ya existe, omitiendo';
    END IF;
END $$;

-- ============================================
-- Verificación
-- ============================================
DO $$
BEGIN
    RAISE NOTICE '📊 Resumen de datos:';
    RAISE NOTICE '   - Categorías: %', (SELECT COUNT(*) FROM categories);
    RAISE NOTICE '   - Tags: %', (SELECT COUNT(*) FROM tags);
    RAISE NOTICE '   - Usuarios: %', (SELECT COUNT(*) FROM users);
    RAISE NOTICE '   - Recetas: %', (SELECT COUNT(*) FROM recipes);
    RAISE NOTICE '✅ Base de datos poblada correctamente';
END $$;
