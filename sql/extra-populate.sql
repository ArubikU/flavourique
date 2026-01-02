-- ============================================
-- Flavorique - Script de poblado adicional
-- Recetas extra para demostración
-- ============================================

-- ============================================
-- RECETA: Arroz Árabe Peruano
-- ============================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
    cat_arroces_id BIGINT;
    cat_internacional_id BIGINT;
    tag_tradicional_id BIGINT;
    tag_comfort_id BIGINT;
BEGIN
    -- Obtener ID del admin
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    -- Verificar si ya existe la receta
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Arroz Árabe Peruano') THEN
        
        -- Insertar receta
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public, image_url)
        VALUES (
            admin_id,
            'Arroz Árabe Peruano',
            'Una fusión perfecta de la cocina árabe y peruana. Este arroz aromático con Coca-Cola, fideos tostados, tocino ahumado y frutos secos es un clásico de las celebraciones peruanas. La cebolla roja picada finamente desaparece al cocinarse, dejando un fondo dulce y sabroso que hace que este plato sepa profesional. El toque final de aceite de ajonjolí eleva el aroma a nivel de restaurante.',
            20,
            35,
            6,
            'MEDIUM',
            TRUE,
            'https://i.imgur.com/JZDWRi6.png'
        )
        RETURNING id INTO recipe_id;

        -- Obtener IDs de categorías
        SELECT id INTO cat_arroces_id FROM categories WHERE slug = 'arroces';
        SELECT id INTO cat_internacional_id FROM categories WHERE slug = 'internacional';

        -- Obtener IDs de tags
        SELECT id INTO tag_tradicional_id FROM tags WHERE slug = 'tradicional';
        SELECT id INTO tag_comfort_id FROM tags WHERE slug = 'comfort-food';

        -- Asociar categorías
        INSERT INTO recipe_categories (recipe_id, category_id) VALUES
        (recipe_id, cat_arroces_id),
        (recipe_id, cat_internacional_id);

        -- Asociar tags
        INSERT INTO recipe_tags (recipe_id, tag_id) VALUES
        (recipe_id, tag_tradicional_id),
        (recipe_id, tag_comfort_id);

        -- ============================================
        -- INGREDIENTES
        -- ============================================
        
        -- La Base
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Arroz', 3, 'tazas', 'Lavado y escurrido', 1),
        (recipe_id, 'Fideo Cabello de Ángel', 150, 'g', 'Partido en trozos pequeños', 2),
        (recipe_id, 'Coca-Cola', 2.5, 'tazas', 'Regular, no dietética', 3),
        (recipe_id, 'Agua', 1, 'taza', NULL, 4),
        
        -- Proteínas
        (recipe_id, 'Tocino ahumado', 200, 'g', 'Picado en cuadrados', 5),
        (recipe_id, 'Cabanossi', 3, 'unidades', 'En rodajas finas', 6),
        
        -- El Aderezo
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Mediana, picada en brunoise extremadamente fino', 7),
        (recipe_id, 'Pasta de ajo', 1, 'cucharada', 'Colmada', 8),
        (recipe_id, 'Sillao (Salsa de Soja)', 1, 'cucharada', 'Da color dorado y sabor profundo', 9),
        
        -- Frutos Secos y Dulces
        (recipe_id, 'Pasas negras', 0.25, 'taza', NULL, 10),
        (recipe_id, 'Pasas rubias', 0.25, 'taza', NULL, 11),
        (recipe_id, 'Pecanas', 100, 'g', 'Picadas', 12),
        
        -- Aromas y Finalizado
        (recipe_id, 'Canela', 1, 'rama', 'Entera, para aromatizar', 13),
        (recipe_id, 'Mantequilla', 1, 'cucharada', NULL, 14),
        (recipe_id, 'Aceite de ajonjolí', 0.5, 'cucharadita', 'El secreto de restaurante', 15),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 16),
        (recipe_id, 'Aceite vegetal', NULL, 'c/n', 'Neutro, para freír', 17);

        -- ============================================
        -- PASOS
        -- ============================================
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Tostado del Fideo: En la olla, con un chorrito de aceite caliente, tuesta los fideos moviendo constantemente hasta que tengan un color marrón parejo. Retíralos inmediatamente a un plato para que el calor residual no los queme.', 5),
        
        (recipe_id, 2, 'El Aderezo Base: En la misma olla, fríe el tocino hasta dorar. Agrega el cabanossi, dale una vuelta rápida y retira la mitad de las carnes para decorar al final.', 5),
        
        (recipe_id, 3, 'Sofrito de Cebolla: En la grasa ahumada que quedó, echa la cebolla roja picadita. Sofríe a fuego medio-bajo por unos 5 minutos hasta que esté transparente y dulce. Luego agrega el ajo y cocina 2 minutos más. Esto crea la base de sabor que hace especial este arroz.', 7),
        
        (recipe_id, 4, 'Los Líquidos: Vierte la Coca-Cola, el agua y la cucharada de Sillao. Agrega la rama de canela, las pasas negras, las pasas rubias y sal al gusto (prueba el líquido, debe estar sabroso). Deja que rompa a hervir para que la canela suelte su aroma.', 5),
        
        (recipe_id, 5, 'Fusión y Cocción: Echa el arroz y los fideos tostados a la olla hirviendo. Mezcla bien. Deja cocinar destapado a fuego medio hasta que el líquido se evapore y se vean los huequitos en el arroz.', 8),
        
        (recipe_id, 6, 'El Secreto Final: Cuando el arroz haya secado, baja el fuego al mínimo. Agrega la cucharada de mantequilla y rocía la media cucharadita de aceite de ajonjolí encima del arroz. Tapa la olla y deja granear por 20 minutos exactos.', 20),
        
        (recipe_id, 7, 'Servir: Destapa, retira la rama de canela. Agrega las pecanas y el resto de tocino/cabanossi crujiente que reservaste. Mueve el arroz con un tenedor para mezclar todo. Notarás que la cebolla desapareció, pero el sabor está ahí, intenso y delicioso.', 3);

        RAISE NOTICE '✅ Receta "Arroz Árabe Peruano" creada correctamente';
    ELSE
        RAISE NOTICE '⚠️ Receta "Arroz Árabe Peruano" ya existe, omitiendo';
    END IF;
END $$;

-- ============================================
-- Verificación
-- ============================================
DO $$
BEGIN
    RAISE NOTICE '📊 Recetas actuales de Arubik:';
    RAISE NOTICE '   - Total: %', (SELECT COUNT(*) FROM recipes WHERE author_id = (SELECT id FROM users WHERE username = 'Arubik'));
    RAISE NOTICE '✅ Script extra-populate ejecutado correctamente';
END $$;
