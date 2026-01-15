-- ================================================================
-- FLAVORIQUE - RECETAS DTM COMPLETAS
-- Base de datos completa de recetas para Disfunción Temporomandibular
-- Todas las recetas incluyen ingredientes y pasos detallados
-- Basado en dtm.md - Documento técnico de nutrición DTM
-- ================================================================

-- ================================================================
-- CONFIGURACIÓN INICIAL
-- ================================================================

-- Crear tags DTM específicos
INSERT INTO tags (name, slug) VALUES
('Dieta Blanda', 'dieta-blanda'),
('DTM Friendly', 'dtm-friendly'),
('Antiinflamatorio', 'antiinflamatorio'),
('Textura Suave', 'textura-suave'),
('Alto en Magnesio', 'alto-magnesio'),
('Rico en Omega-3', 'rico-omega3')
ON CONFLICT (slug) DO NOTHING;

-- Crear categoría DTM
INSERT INTO categories (name, slug, description, icon) VALUES
('DTM Terapéutico', 'dtm-terapeutico', 'Recetas adaptadas para disfunción temporomandibular', '🦷')
ON CONFLICT (slug) DO NOTHING;

-- ================================================================
-- SECCIÓN 1: DESAYUNOS Y BEBIDAS NUTRITIVAS
-- ================================================================

-- RECETA 1: Avena Cremosa con Puré de Plátano
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Avena Cremosa con Puré de Plátano') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Avena Cremosa con Puré de Plátano',
            'Desayuno ideal para DTM: avena cocida en leche hasta deshacerse completamente, endulzada con miel y canela. Textura sedosa que no requiere esfuerzo oclusal.',
            5, 10, 2, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('desayunos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'dtm-friendly', 'facil', 'rapido');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Avena en hojuelas', 1, 'taza', NULL, 1),
        (recipe_id, 'Leche entera o bebida vegetal', 2.5, 'tazas', 'Para cocción cremosa', 2),
        (recipe_id, 'Plátano maduro', 1, 'unidad', 'Grande, muy maduro', 3),
        (recipe_id, 'Miel de abeja', 2, 'cucharadas', 'Al gusto', 4),
        (recipe_id, 'Canela en polvo', 0.5, 'cucharadita', NULL, 5),
        (recipe_id, 'Pizca de sal', NULL, 'al gusto', 'Opcional', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'En una olla, combinar la avena con la leche y una pizca de sal. Llevar a fuego medio-bajo.', 2),
        (recipe_id, 2, 'Cocinar removiendo constantemente hasta que la avena esté completamente deshecha y la mezcla tenga consistencia de crema espesa (no debe quedar al dente). Esto toma aproximadamente 8-10 minutos.', 10),
        (recipe_id, 3, 'Mientras tanto, aplastar el plátano con un tenedor hasta formar un puré completamente liso sin grumos.', 2),
        (recipe_id, 4, 'Cuando la avena esté lista, incorporar el puré de plátano y mezclar bien.', 1),
        (recipe_id, 5, 'Agregar la miel y la canela, mezclar. Servir tibio, asegurándose de que la textura sea totalmente suave.', 1);
        
        RAISE NOTICE '✅ Receta 1/73: Avena Cremosa con Puré de Plátano';
    END IF;
END $$;

-- RECETA 2: Quinua Caliente "Al Paso"
-- ================================================================
DO $$
DECLARE
   admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Quinua Caliente Al Paso') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Quinua Caliente Al Paso',
            'Bebida tradicional peruana de quinua cocida con frutas. Rica en magnesio para relajación muscular mandibular.',
            10, 25, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('bebidas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-magnesio', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Quinua', 0.5, 'taza', 'Lavada y escurrida', 1),
        (recipe_id, 'Agua', 4, 'tazas', NULL, 2),
        (recipe_id, 'Manzana roja', 1, 'unidad', 'Pelada y picada', 3),
        (recipe_id, 'Piña', 1, 'taza', 'En trozos pequeños', 4),
        (recipe_id, 'Canela en rama', 2, 'unidades', NULL, 5),
        (recipe_id, 'Clavo de olor', 3, 'unidades', NULL, 6),
        (recipe_id, 'Azúcar o miel', NULL, 'al gusto', NULL, 7);
        
        INSERT INTO steps (recipe_id,step_number, description, duration) VALUES
        (recipe_id, 1, 'Enjuagar bien la quinua bajo agua fría hasta que el agua salga clara para eliminar las saponinas.', 3),
        (recipe_id, 2, 'En una olla, colocar la quinua con el agua, las frutas picadas, la canela y el clavo.', 2),
        (recipe_id, 3, 'Llevar a ebullición y luego reducir el fuego. Cocinar durante 20-25 minutos hasta que la quinua esté muy suave y las frutas desintegradas.', 25),
        (recipe_id, 4, 'Endulzar al gusto con azúcar o miel.', 1),
        (recipe_id, 5, 'Servir caliente como bebida espesa. La textura debe permitir tomarse con cuchara.', 1);
        
        RAISE NOTICE '✅ Receta 2/73: Quinua Caliente Al Paso';
    END IF;
END $$;

-- RECETA 3: Huevos Revueltos con Queso Ricotta
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Huevos Revueltos con Queso Ricotta') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Huevos Revueltos con Queso Ricotta',
            'Huevos preparados a fuego muy lento con queso ricotta o fresco para máxima jugosidad y textura suave. No requieren esfuerzo oclusal.',
            5, 8, 2, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('desayunos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-proteina', 'facil', 'rapido');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Huevos', 3, 'unidades', NULL, 1),
        (recipe_id, 'Queso ricotta o queso fresco', 3, 'cucharadas', NULL,2),
        (recipe_id, 'Mantequilla', 1, 'cucharada', NULL, 3),
        (recipe_id, 'Leche', 2, 'cucharadas', 'Para mayor cremosidad', 4),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Batir los huevos con la leche, sal y pimienta hasta integrar bien.', 2),
        (recipe_id, 2, 'Calentar una sartén antiadherente a fuego BAJO y derretir la mantequilla.', 1),
        (recipe_id, 3, 'Verter los huevos batidos y cocinar a fuego muy lento, removiendo constantemente con movimientos suaves.', 5),
        (recipe_id, 4, 'Cuando los huevos estén casi cuajados pero aún cremosos, agregar el queso ricotta y mezclar delicadamente.', 2),
        (recipe_id, 5, 'Retirar del fuego cuando aún estén jugosos (no dejar secar). La textura debe ser muy suave y cremosa.', 1);
        
        RAISE NOTICE '✅ Receta 3/73: Huevos Revueltos con Queso Ricotta';
    END IF;
END $$;


-- RECETA 4: Smoothie de Papaya, Plátano y Avena
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Smoothie de Papaya Plátano y Avena') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Smoothie de Papaya Plátano y Avena',
            'Licuado a alta velocidad que elimina fibras. Aporta enzimas digestivas (papaína) y energía rápida. Perfecto para DTM.',
            5, 0, 2, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('bebidas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'rapido', 'sin-masticacion');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Papaya madura', 1.5, 'tazas', 'En cubos', 1),
        (recipe_id, 'Plátano maduro', 1, 'unidad', NULL, 2),
        (recipe_id, 'Avena en hojuelas', 0.25, 'taza', NULL, 3),
        (recipe_id, 'Leche o bebida vegetal', 1, 'taza', NULL, 4),
        (recipe_id, 'Miel', 1, 'cucharada', 'Opcional', 5),
        (recipe_id, 'Hielo', 0.5, 'taza', 'Opcional', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Colocar todos los ingredientes en una licuadora de alta potencia.', 1),
        (recipe_id, 2, 'Licuar a máxima velocidad durante 2-3 minutos hasta obtener una textura completamente lisa sin grumos ni fibras visibles.', 3),
        (recipe_id, 3, 'Si está muy espeso, añadir más leche gradualmente hasta alcanzar consistencia bebible.', 1),
        (recipe_id, 4, 'Servir inmediatamente. La textura debe ser sedosa y fácil de tragar sin masticar.', 1);
        
        RAISE NOTICE '✅ Receta 4/73: Smoothie de Papaya Plátano y Avena';
    END IF;
END $$;

-- RECETA 5: Yogur Griego con Puré de Aguaymanto
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Yogur Griego con Puré de Aguaymanto') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Yogur Griego con Puré de Aguaymanto',
            'Yogur con probióticos y aguaymanto triturado sin semillas. Rica en vitamina C, ideal para desayuno DTM.',
            5, 0, 1, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('desayunos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'rapido', 'saludable');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Yogur griego natural', 1, 'taza', NULL, 1),
        (recipe_id, 'Aguaymanto', 0.5, 'taza', 'Fresco o congelado', 2),
        (recipe_id, 'Miel', 1, 'cucharada', 'Al gusto', 3),
        (recipe_id, 'Vainilla', 0.25, 'cucharadita', 'Opcional', 4);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Triturar el aguaymanto con un tenedor o licuar hasta obtener un puré completamente liso. Colar para eliminar semillas.', 3),
        (recipe_id, 2, 'Mezclar el puré de aguaymanto con la miel.', 1),
        (recipe_id, 3, 'Servir el yogur griego en un tazón y cubrir con el puré de aguaymanto.', 1),
        (recipe_id, 4, 'Mezclar suavemente antes de consumir. La textura debe ser completamente cremosa.', 1);
        
        RAISE NOTICE '✅ Receta 5/73: Yogur Griego con Puré de Aguaymanto';
    END IF;
END $$;

-- RECETA 6: Ponche de Habas
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Ponche de Habas') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Ponche de Habas',
            'Bebida espesa nutritiva rica en calcio y proteínas vegetales. Se consume con cuchara.',
            10, 30, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('bebidas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-proteina', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Hababas secas peladas', 1, 'taza', 'Remojadas 8 horas', 1),
        (recipe_id, 'Leche', 4, 'tazas', NULL, 2),
        (recipe_id, 'Azúcar', 0.5, 'taza', 'Al gusto', 3),
        (recipe_id, 'Canela en rama', 1, 'unidad', NULL, 4),
        (recipe_id, 'Clavo de olor', 2, 'unidades', NULL, 5),
        (recipe_id, 'Vainilla', 1, 'cucharadita', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar las habas remojadas y peladas en agua hasta que estén muy suaves (aproximadamente 20 minutos).', 20),
        (recipe_id, 2, 'Escurrir y licuar las habas con un poco de la leche hasta obtener una pasta completamente lisa.', 3),
        (recipe_id, 3, 'En una olla, calentar el resto de la leche con la canela, clavo y azúcar.', 5),
        (recipe_id, 4, 'Agregar la pasta de habas licuada y cocinar a fuego medio, removiendo constantemente hasta espesar.', 8),
        (recipe_id, 5, 'Añadir la vainilla, retirar las especias enteras y servir caliente con textura de ponche espeso.', 2);
        
        RAISE NOTICE '✅ Receta 6/73: Ponche de Habas';
    END IF;
END $$;

-- ================================================================
-- SECCIÓN 2: SOPAS Y CREMAS TERAPÉUTICAS
-- ================================================================

-- RECETA 7: Crema de Zapallo Macre y Loche
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Crema de Zapallo Macre y Loche') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Crema de Zapallo Macre y Loche',
            'Textura aterciopelada rica en betacarotenos. El zapallo loche aporta sabor gourmet único de la costa norte peruana.',
            15, 35, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'vegetariano', 'antiinflamatorio');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Zapallo macre o loche', 600,  'g', 'Pelado y en cubos', 1),
        (recipe_id, 'Papa amarilla', 2, 'unidades', 'Medianas, peladas', 2),
        (recipe_id, 'Cebolla blanca', 0.5, 'unidad', 'Picada fino', 3),
        (recipe_id, 'Ajo', 2, 'dientes', 'Picados', 4),
        (recipe_id, 'Caldo de verduras', 4, 'tazas', NULL, 5),
        (recipe_id, 'Leche evaporada', 0.5, 'taza', NULL, 6),
        (recipe_id, 'Aceite de oliva', 2, 'cucharadas', NULL, 7),
        (recipe_id, 'Queso fresco', 50, 'g', 'Para enriquecer', 8),
        (recipe_id, 'Sal y pimienta blanca', NULL, 'al gusto', NULL, 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'En una olla grande, calentar el aceite de oliva y sofre ír la cebolla y ajo a fuego medio hasta que estén transparentes (no dorar).', 5),
        (recipe_id, 2, 'Agregar los cubos de zapallo y papa. Cocinar por 2 minutos removiendo.', 2),
        (recipe_id, 3, 'Verter el caldo de verduras, llevar a ebullición y luego reducir el fuego. Cocinar hasta que el zapallo y la papa estén completamente suaves (se deben deshacer al presionar con una cuchara).', 25),
        (recipe_id, 4, 'Licuar la mezcla con batidora de inmersión o en licuadora hasta obtener una textura absolutamente lisa y aterciopelada.', 3),
        (recipe_id, 5, 'Regresar a la olla, añadir la leche evaporada y el queso fresco. Calentar sin hervir, removiendo hasta que el queso se funda.', 3),
        (recipe_id, 6, 'Ajustar la sazón con sal y pimienta blanca. Servir tibio con textura de seda líquida.', 2);
        
        RAISE NOTICE '✅ Receta 7/73: Crema de Zapallo Macre y Loche';
    END IF;
END $$;

-- RECETA 8: Caldo Verde Cajamarquino Adaptado
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Caldo Verde Cajamarquino Adaptado') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Caldo Verde Cajamarquino Adaptado',
            'Sopa de papas amarillas deshechas con huevo y hierbas aromáticas licuadas. Se evita el queso duro para DTM.',
            15, 35, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'alto-proteina');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Papas amarillas', 4, 'unidades', 'Grandes', 1),
        (recipe_id, 'Caldo de verduras o pollo', 6, 'tazas', NULL, 2),
        (recipe_id, 'Huevos', 2, 'unidades', NULL, 3),
        (recipe_id, 'Paico fresco', 0.25, 'taza', 'Hojas', 4),
        (recipe_id, 'Perejil', 0.25, 'taza', NULL, 5),
        (recipe_id, 'Culantro', 0.25, 'taza', NULL, 6),
        (recipe_id, 'Cebolla china', 2, 'tallos', 'Solo parte verde', 7),
        (recipe_id, 'Ajo', 2, 'dientes', NULL, 8),
        (recipe_id, 'Leche', 0.5, 'taza', NULL, 9),
        (recipe_id, 'Aceite', 2, 'cucharadas', NULL, 10),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 11);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Pelar y cortar las papas en cubos. Cocinarlas en el caldo hasta que estén muy suaves y se deshagan (30 minutos aprox).', 30),
        (recipe_id, 2, 'Mientras tanto, licuar las hierbas (paico, perejil, culantro, cebolla china) con el ajo, medio vaso de caldo y la leche hasta obtener una pasta verde completamente lisa.', 3),
        (recipe_id, 3, 'Cuando las papas estén muy suaves, aplastarlas parcialmente con un tenedor para espesar el caldo.', 2),
        (recipe_id, 4, 'Agregar la pasta verde licuada al caldo con papas. Cocinar 5 minutos más.', 5),
        (recipe_id, 5, 'Batir los huevos y verterlos lentamente en la sopa mientras se remueve, para que formen hilos suaves.', 2),
        (recipe_id, 6, 'Ajustar sazón y servir caliente. La textura debe ser cremosa con las papas prácticamente deshechas.', 2);
        
        RAISE NOTICE '✅ Receta 8/73: Caldo Verde Cajamarquino Adaptado';
    END IF;
END $$;

-- RECETA 9: Crema de Pallares Pelados
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Crema de Pallares Pelados') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Crema de Pallares Pelados',
            'Los pallares se remojan 24h y se pelan uno a uno para eliminar cáscara fibrosa. Resulta en una crema proteica de sabor sofisticado.',
            1470, 90, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-proteina', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Pallares secos', 2, 'tazas', 'Remojados 24 horas y pelados', 1),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada fino', 2),
        (recipe_id, 'Ajo', 3, 'dientes', 'Picados', 3),
        (recipe_id, 'Caldo de verduras', 6, 'tazas', NULL, 4),
        (recipe_id, 'Leche evaporada', 1, 'taza', NULL, 5),
        (recipe_id, 'Mantequilla', 2, 'cucharadas', NULL, 6),
        (recipe_id, 'Aceite', 2, 'cucharadas', NULL, 7),
        (recipe_id, 'Sal, pimienta y comino', NULL, 'al gusto', NULL, 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Después de remojar los pallares por 24 horas, pelar uno por uno eliminando la cáscara gruesa externa. Este paso es crítico para la textura final.', 30),
        (recipe_id, 2, 'Cocinar los pallares pelados en agua con sal hasta que estén completamente suaves (60-90 minutos). Escurrir.', 90),
        (recipe_id, 3, 'Preparar un aderezo: sofreír cebolla y ajo en aceite y mantequilla hasta que estén transparentes y aromáticos.', 8),
        (recipe_id, 4, 'Licuar los pallares cocidos con el aderezo, el caldo y la leche evaporada hasta obtener una crema completamente lisa (puede requerir varias tandas en licuadora).', 10),
        (recipe_id, 5, 'Pasar la crema por un colador fino para asegurar textura sedosa.', 5),
        (recipe_id, 6, 'Calentar la crema, ajustar consistencia con más caldo si está muy espesa. Sazonar con sal, pimienta y un toque de comino.', 5),
        (recipe_id, 7, 'Servir caliente. La textura debe ser como un terciopelo líquido, sin grumos.', 2);
        
        RAISE NOTICE '✅ Receta 9/73: Crema de Pallares Pelados';
    END IF;
END $$;

-- RECETA 10: Sopa de Lentejas Licuada con Cúrcuma
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Sopa de Lentejas Licuada con Cúrcuma') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Sopa de Lentejas Licuada con Cúrcuma',
            'Lentejas aportan hierro y la cúrcuma actúa como antiinflamatorio natural para la articulación ATM. Totalmente licuada.',
            10, 45, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'antiinflamatorio', 'alto-proteina', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Lentejas', 1.5, 'tazas', NULL, 1),
        (recipe_id, 'Zanahoria', 2, 'unidades', 'Peladas y picadas', 2),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada', 3),
        (recipe_id, 'Apio', 2, 'tallos', 'Picados', 4),
        (recipe_id, 'Ajo', 3, 'dientes', 'Picados', 5),
        (recipe_id, 'Cúrcuma en polvo', 1, 'cucharadita', 'Antiinflamatoria', 6),
        (recipe_id, 'Comino', 0.5, 'cucharadita', NULL, 7),
        (recipe_id, 'Caldo de verduras', 6, 'tazas', NULL, 8),
        (recipe_id, 'Aceite de oliva', 3, 'cucharadas', NULL, 9),
        (recipe_id, 'Jugo de limón', 1, 'cucharada', 'Al servir', 10),
        (recipe_id, 'Sal y pimienta negra', NULL, 'al gusto', 'La pimienta activa la cúrcuma', 11);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Enjuagar las lentejas. En una olla, calentar aceite de oliva y sofreír cebolla, ajo, zanahoria y apio hasta suavizar.', 8),
        (recipe_id, 2, 'Agregar la cúrcuma, comino y pimienta negra. Cocinar 1 minuto para liberar aromas. La pimienta negra ayuda a la absorción de la curcumina.', 1),
        (recipe_id, 3, 'Añadir las lentejas y el caldo. Llevar a ebullición, reducir fuego y cocinar hasta que las lentejas estén muy suaves (35-40 minutos).', 40),
        (recipe_id, 4, 'Licuar completamente la sopa hasta obtener una textura absolutamente lisa y cremosa. Puede hacerse en tandas.', 5),
        (recipe_id, 5, 'Regresar a la olla, ajustar consistencia con más caldo si es necesario. Sazonar con sal.', 2),
        (recipe_id, 6, 'Servir caliente con un chorrito de jugo de limón fresco y un hilo de aceite de oliva. La acidez del limón potencia el sabor.', 2);
        
        RAISE NOTICE '✅ Receta 10/73: Sopa de Lentejas Licuada con Cúrcuma';
    END IF;
END $$;


-- RECETA 11: Crema de Arracacha
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Crema de Arracacha') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Crema de Arracacha',
            'Tubérculo andino de fácil digestión y sabor sofisticado. Al cocerse se deshace en la boca.',
            10, 25, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'vegetariano', 'facil');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Arracacha', 500, 'g', 'Pelada y en cubos', 1),
        (recipe_id, 'Papa blanca', 1, 'unidad', 'Mediana', 2),
        (recipe_id, 'Cebolla', 0.5, 'unidad', 'Picada', 3),
        (recipe_id, 'Ajo', 2, 'dientes', NULL, 4),
        (recipe_id, 'Caldo de verduras', 4, 'tazas', NULL, 5),
        (recipe_id, 'Crema de leche', 0.5, 'taza', NULL, 6),
        (recipe_id, 'Mantequilla', 1, 'cucharada', NULL, 7),
        (recipe_id, 'Nuez moscada', 1, 'pizca', NULL, 8),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Derretir la mantequilla y sofreír cebolla y ajo hasta transparentar.', 5),
        (recipe_id, 2, 'Agregar la arracacha y papa en cubos, cocinar 2 minutos.', 2),
        (recipe_id, 3, 'Verter el caldo, cocinar hasta que los tubérculos estén completamente suaves (20 minutos).', 20),
        (recipe_id, 4, 'Licuar hasta textura sedosa. Regresar a la olla.', 3),
        (recipe_id, 5, 'Añadir crema de leche y nuez moscada. Calentar sin hervir. Ajustar sazón.', 3),
        (recipe_id, 6, 'Servir tibio. Textura debe ser como terciopelo líquido.', 1);
        
        RAISE NOTICE '✅ Receta 11/73: Crema de Arracacha';
    END IF;
END $$;

-- RECETA 12: Gazpacho de Tomate y Sandía
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Gazpacho de Tomate y Sandía') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Gazpacho de Tomate y Sandía',
            'Sopa fría muy hidratante ideal para reducir temperatura si hay inflamación aguda en ATM. Completamente licuada.',
            15, 0, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'antiinflamatorio', 'vegetariano', 'frio');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Tomates maduros', 4, 'unidades', 'Grandes, pelados y sin semillas', 1),
        (recipe_id, 'Sandía', 2, 'tazas', 'En cubos, sin semillas', 2),
        (recipe_id, 'Pepino', 1, 'unidad', 'Pelado y sin semillas', 3),
        (recipe_id, 'Pimiento rojo', 0.5, 'unidad', 'Sin semillas', 4),
        (recipe_id, 'Ajo', 1, 'diente', 'Pequeño', 5),
        (recipe_id, 'Aceite de oliva extra virgen', 3, 'cucharadas', NULL, 6),
        (recipe_id, 'Vinagre de vino blanco', 1, 'cucharada', NULL, 7),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 8),
        (recipe_id, 'Albahaca fresca', 5, 'hojas', 'Opcional', 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Colocar todos los ingredientes en licuadora (tomates, sandía, pepino, pimiento, ajo).', 2),
        (recipe_id, 2, 'Licuar a máxima potencia hasta obtener líquido completamente liso (aproximadamente 3 minutos).', 3),
        (recipe_id, 3, 'Colar la mezcla presionando con cuchara para asegurar textura absolutamente suave sin fibras.', 5),
        (recipe_id, 4, 'Añadir aceite de oliva, vinagre y sal. Mezclar bien.', 1),
        (recipe_id, 5, 'Refrigerar al menos 2 horas antes de servir.', 120),
        (recipe_id, 6, 'Servir muy frío. Puede decorar con una hoja de albahaca finamente picada.', 1);
        
        RAISE NOTICE '✅ Receta 12/73: Gazpacho de Tomate y Sandía';
    END IF;
END $$;

-- RECETA 13: Sopa a la Minuta
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Sopa a la Minuta') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Sopa a la Minuta',
            'Sopa peruana de carne molida con fideos cabello de ángel y leche. La carne molida no requiere corte dental y el fideo es delgado.',
            10, 20, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'alto-proteina');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Carne molida de res', 300, 'g', 'Molida dos veces para mayor suavidad', 1),
        (recipe_id, 'Fideos cabello de ángel', 100, 'g', NULL, 2),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada fino', 3),
        (recipe_id, 'Ajo', 2, 'dientes', 'Picados', 4),
        (recipe_id, 'Tomate', 1, 'unidad', 'Picado sin piel', 5),
        (recipe_id, 'Ají panca molido', 1, 'cucharada', NULL, 6),
        (recipe_id, 'Caldo de res', 6, 'tazas', NULL, 7),
        (recipe_id, 'Leche evaporada', 0.5, 'taza', NULL, 8),
        (recipe_id, 'Huevo', 1, 'unidad', 'Para escalfar', 9),
        (recipe_id, 'Aceite', 2, 'cucharadas', NULL, 10),
        (recipe_id, 'Orégano en polvo', 0.5, 'cucharadita', NULL, 11),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 12);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Calentar aceite y preparar aderezo: sofreír cebolla, ajo, tomate y ají panca hasta que esté suave.', 6),
        (recipe_id, 2, 'Agregar la carne molida, cocinar removiendo hasta que cambie de color. Sazonar con sal, pimienta y orégano.', 5),
        (recipe_id, 3, 'Verter el caldo de res, llevar a ebullición.', 3),
        (recipe_id, 4, 'Cuando hierva, añadir los fideos cabello de ángel. Cocinar hasta que estén muy suaves (no al dente).', 6),
        (recipe_id, 5, 'Agregar la leche evaporada, mezclar bien.', 1),
        (recipe_id, 6, 'Escalfar el huevo directamente en la sopa hirviendo. El huevo formará una masa suave.', 3),
        (recipe_id, 7, 'Servir caliente. Los fideos deben estar muy cocidos y la carne molida debe deshacerse fácilmente.', 1);
        
        RAISE NOTICE '✅ Receta 13/73: Sopa a la Minuta';
    END IF;
END $$;

-- RECETA 14: Sopa Criolla
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Sopa Criolla') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Sopa Criolla',
            'Similar a la minuta pero con pan hidratado en lugar de tostado. El pan se deshace completamente en el caldo espesándolo.',
            10, 25, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'comfort-food');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Carne molida de res', 300, 'g', 'Molida fino', 1),
        (recipe_id, 'Fideos gruesos', 150, 'g', 'Cortados pequeños', 2),
        (recipe_id, 'Pan de molde', 2, 'rebanadas', 'Sin corteza', 3),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada', 4),
        (recipe_id, 'Ajo', 2, 'dientes', NULL, 5),
        (recipe_id, 'Tomate', 2, 'unidades', 'Picados', 6),
        (recipe_id, 'Ají amarillo molido', 1, 'cucharada', NULL, 7),
        (recipe_id, 'Caldo de res', 7, 'tazas', NULL, 8),
        (recipe_id, 'Leche', 0.5, 'taza', NULL, 9),
        (recipe_id, 'Huevos', 2, 'unidades', 'Para escalfar', 10),
        (recipe_id, 'Aceite', 3, 'cucharadas', NULL, 11),
        (recipe_id, 'Sal, pimienta, comino', NULL, 'al gusto', NULL, 12);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hacer aderezo: sofreír cebolla, ajo, tomate y ají hasta formar pasta.', 8),
        (recipe_id, 2, 'Agregar carne molida, cocinar hasta dorar. Sazonar con sal, pimiento y comino.', 5),
        (recipe_id, 3, 'Añadir el caldo y llevar a ebullición.', 3),
        (recipe_id, 4, 'Incorporar fideos, cocinar hasta que estén MUY suaves.', 10),
        (recipe_id, 5, 'Agregar el pan de molde cortado en trozos. Dejar que se hidrate y deshaga en el caldo (3-5 minutos), espesando la sopa.', 5),
        (recipe_id, 6, 'Añadir leche y mezclar.', 1),
        (recipe_id, 7, 'Escalfar los huevos en la sopa. Servir caliente con el pan completamente desintegrado.', 3);
        
        RAISE NOTICE '✅ Receta 14/73: Sopa Criolla';
    END IF;
END $$;

-- RECETA 15: Caldo de Bolas
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Caldo de Bolas Tumbesino') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Caldo de Bolas Tumbesino',
            'Obra maestra norteña: esfera de plátano verde majado rellena de carne picada, flotando en caldo. La masa cede fácilmente ante presión lingual.',
            45, 60, 4, 'HARD', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'alto-proteina');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Plátanos verdes', 4, 'unidades', 'Para majar', 1),
        (recipe_id, 'Carne molida de res', 300, 'g', 'Para el relleno', 2),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada fino', 3),
        (recipe_id, 'Pimiento', 0.5, 'unidad', 'Picado', 4),
        (recipe_id, 'Pasas', 0.25, 'taza', NULL, 5),
        (recipe_id, 'Aceitunas', 8, 'unidades', 'Picadas', 6),
        (recipe_id, 'Huevo duro', 2, 'unidades', 'Picados', 7),
        (recipe_id, 'Yuca', 300, 'g', 'En trozos para el caldo', 8),
        (recipe_id, 'Zanahoria', 2, 'unidades', 'En rodajas', 9),
        (recipe_id, 'Caldo de res', 10, 'tazas', NULL, 10),
        (recipe_id, 'Culantro', 0.25, 'taza', 'Picado', 11),
        (recipe_id, 'Achiote', 1, 'cucharadita', NULL, 12),
        (recipe_id, 'Sal y comino', NULL, 'al gusto', NULL, 13);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar los plátanos verdes con cáscara en agua hirviendo hasta que estén suaves (30 min). Pelar y majar hasta formar masa elástica.', 35),
        (recipe_id, 2, 'Preparar relleno: sofreír cebolla y pimiento, agregar carne molida. Cocinar hasta dorar. Añadir pasas, aceitunas y huevo duro picado. Sazonar y enfriar.', 15),
        (recipe_id, 3, 'Formar bolas: tomar porción de masa de plátano, hacer hueco, rellenar con mezcla de carne, cerrar formando esfera sellada.', 15),
        (recipe_id, 4, 'En otra olla, preparar caldo con yuca, zanahoria y achiote. Cocinar hasta que yuca esté semiblanda.', 20),
        (recipe_id, 5, 'Añadir cuidadosamente las bolas de plátano al caldo hirviendo. Cocinar 25-30 minutos a fuego medio.', 30),
        (recipe_id, 6, 'Agregar culantro 5 minutos antes de servir.', 5),
        (recipe_id, 7, 'Servir caliente. La bola debe cortarse fácilmente con cuchara, revelando el relleno húmedo. El caldo lubrica todo.', 2);
        
        RAISE NOTICE '✅ Receta 15/73: Caldo de Bolas Tumbesino';
    END IF;
END $$;

-- RECETA 16: Sopa de Morón
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Sopa de Morón') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Sopa de Morón',
            'Cebada perlada que al cocerse libera almidón creando textura mucilaginosa (babosa) extremadamente calmante para gargantas irritadas.',
            10, 50, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'textura-suave', 'reconfortante');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Cebada perlada (morón)', 1, 'taza', 'Enjuagada', 1),
        (recipe_id, 'Carne de res', 200, 'g', 'Molida o en trozos muy pequeños', 2),
        (recipe_id, 'Zapallo', 200, 'g', 'En cubos', 3),
        (recipe_id, 'Zanahoria', 2, 'unidades', 'Picadas', 4),
        (recipe_id, 'Apio', 2, 'tallos', 'Picados', 5),
        (recipe_id, 'Poro', 1, 'unidad', 'Solo parte blanca', 6),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada', 7),
        (recipe_id, 'Ajo', 3, 'dientes', NULL, 8),
        (recipe_id, 'Caldo', 8, 'tazas', NULL, 9),
        (recipe_id, 'Aceite', 2, 'cucharadas', NULL, 10),
        (recipe_id, 'Yerba buena', 3, 'ramitas', 'Opcional', 11),
        (recipe_id, 'Sal, pimienta, comino', NULL, 'al gusto', NULL, 12);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Sofreír cebolla, ajo, apio y poro hasta suavizar.', 6),
        (recipe_id, 2, 'Si usa carne en trozo, agregar ahora y dorar. Si es molida, agregar en paso 4.', 5),
        (recipe_id, 3, 'Añadir la cebada perlada, remover 1 minuto.', 1),
        (recipe_id, 4, 'Verter el caldo, agregar zapallo y zanahoria. Si usa carne molida, agregar ahora.', 2),
        (recipe_id, 5, 'Cocinar a fuego medio-bajo por 40-45 minutos removiendo ocasionalmente. La cebada liberará almidón y la sopa se volverá espesa y mucilaginosa.', 45),
        (recipe_id, 6, 'Las verduras deben estar completamente deshacidas, integradas en la textura viscosa. Sazonar.', 2),
        (recipe_id, 7, 'Agregar yerba buena al final. Servir caliente. La textura debe ser como un caldo espeso que recubre la cuchara.', 2);
        
        RAISE NOTICE '✅ Receta 16/73: Sopa de Morón';
    END IF;
END $$;


-- RECETA 17: Chupe de Habas
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Chupe de Habas') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Chupe de Habas',
            'Habas peladas (sin cáscara gruesa) con leche, huevo y queso fresco. El cotiledón se convierte en puré harinoso suave.',
            30, 45, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-proteina', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Habas frescas o secas', 2, 'tazas', 'Peladas (sin cáscara)', 1),
        (recipe_id, 'Papas', 3, 'unidades', 'En cubos', 2),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada', 3),
        (recipe_id, 'Ajo', 2, 'dientes', NULL, 4),
        (recipe_id, 'Caldo de verduras', 5, 'tazas', NULL, 5),
        (recipe_id, 'Leche', 1, 'taza', NULL, 6),
        (recipe_id, 'Queso fresco', 150, 'g', 'En cubos', 7),
        (recipe_id, 'Huevos', 2, 'unidades', 'Batidos', 8),
        (recipe_id, 'Aceite', 2, 'cucharadas', NULL, 9),
        (recipe_id, 'Hierbabuena', 3, 'ramitas', NULL, 10),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 11);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Si usa habas secas, remojar por 8 horas y pelar eliminando la cáscara externa gruesa (crítico para textura).', 10),
        (recipe_id, 2, 'Sofreír cebolla y ajo hasta transparentar.', 5),
        (recipe_id, 3, 'Agregar habas peladas y papas, cocinar 2 minutos.', 2),
        (recipe_id, 4, 'Añadir caldo, cocinar hasta que habas y papas estén muy suaves (30-35 min). Las habas deben deshacerse.', 35),
        (recipe_id, 5, 'Agregar leche y queso fresco. Cocinar hasta que queso se ablande (no se derrite completamente, solo se suaviza).', 5),
        (recipe_id, 6, 'Batir huevos y verter lentamente mientras se remueve para formar hilos suaves en la sopa.', 2),
        (recipe_id, 7, 'Agregar hierbabuena picada, ajustar sazón. Servir caliente. Textura debe ser cremosa con habas deshechas.', 2);
        
        RAISE NOTICE '✅ Receta 17/73: Chupe de Habas';
    END IF;
END $$;

-- RECETA 18: Sopa Chairo
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Sopa Chairo') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Sopa Chairo',
            'Sopa andina con chuño negro o blanco (papa deshidratada) machacado. Textura esponjosa húmeda que absorbe caldo.',
            20, 60, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'reconfortante');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Chuño negro o tunta', 1, 'taza', 'Remojado y machacado', 1),
        (recipe_id, 'Carne de res o cordero', 300, 'g', 'Molida o en trozos muy pequeños', 2),
        (recipe_id, 'Papas', 2, 'unidades', 'Picadas', 3),
        (recipe_id, 'Habas verdes', 0.5, 'taza', 'Peladas', 4),
        (recipe_id, 'Zanahoria', 1, 'unidad', 'Picada', 5),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada', 6),
        (recipe_id, 'Ajo', 2, 'dientes', NULL, 7),
        (recipe_id, 'Caldo', 7, 'tazas', NULL, 8),
        (recipe_id, 'Orégano', 1, 'cucharadita', NULL, 9),
        (recipe_id, 'Aceite', 2, 'cucharadas', NULL, 10),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 11);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Remojar el chuño en agua durante 2 horas. Escurrir y machacar hasta desmenuzar.', 5),
        (recipe_id, 2, 'Sofreír cebolla y ajo, agregar la carne. Cocinar hasta dorar.', 8),
        (recipe_id, 3, 'Añadir caldo, papas, zanahoria, habas y chuño machacado.', 3),
        (recipe_id, 4, 'Cocinar a fuego medio durante 40-45 minutos hasta que todo esté muy suave. El chuño absorberá líquido y se volverá esponjoso.', 45),
        (recipe_id, 5, 'Agregar orégano, ajustar sazón. Machacar parcialmente algunas papas para espesar.', 2),
        (recipe_id, 6, 'Servir caliente. El chuño debe tener textura elástica y suave, no harinosa.', 2);
        
        RAISE NOTICE '✅ Receta 18/73: Sopa Chairo';
    END IF;
END $$;

-- RECETA 19: Sopa de Olluco
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Sopa de Olluco') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Sopa de Olluco',
            'Olluco en juliana fina con alto contenido de mucílago que lo hace resbaladizo y fácil de tragar.',
            15, 30, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'textura-suave', 'facil');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Olluco', 400, 'g', 'En juliana fina', 1),
        (recipe_id, 'Papa', 2, 'unidades', 'Picadas', 2),
        (recipe_id, 'Carne molida', 200, 'g', 'Opcional', 3),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada', 4),
        (recipe_id, 'Ajo', 2, 'dientes', NULL, 5),
        (recipe_id, 'Tomate', 1, 'unidad', 'Picado', 6),
        (recipe_id, 'Caldo', 6, 'tazas', NULL, 7),
        (recipe_id, 'Hierbabuena', 2, 'ramitas', NULL, 8),
        (recipe_id, 'Aceite', 2, 'cucharadas', NULL, 9),
        (recipe_id, 'Sal y comino', NULL, 'al gusto', NULL, 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Sofreír cebolla, ajo y tomate hasta formar pasta.', 6),
        (recipe_id, 2, 'Si usa carne molida, agregar y cocinar hasta dorar.', 5),
        (recipe_id, 3, 'Añadir papas y caldo, cocinar 10 minutos.', 10),
        (recipe_id, 4, 'Incorporar las tiras de olluco. Cocinar 12-15 minutos más hasta que olluco esté tierno pero mantenga forma. Se volverá resbaladizo.', 15),
        (recipe_id, 5, 'El mucílago del olluco espesará naturalmente la sopa. Agregar hierbabuena.', 2),
        (recipe_id, 6, 'Servir caliente. Las tiras de olluco deben deslizarse fácilmente.', 1);
        
        RAISE NOTICE '✅ Receta 19/73: Sopa de Olluco';
    END IF;
END $$;

-- ================================================================
-- SECCIÓN 3: PLATOS DE FONDO - PRINCIPALES
-- ================================================================

-- RECETA 20: Causa Limeña de Atún y Palta
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Causa Limeña de Atún y Palta') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Causa Limeña de Atún y Palta',
            'Plato emblemático peruano: puré de papa amarilla prensada con atún de fibras cortas y palta cremosa. La papa no requiere masticación.',
            25, 20, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('almuerzos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'sin-masticacion');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Papa amarilla', 1, 'kg', 'Cocida y pelada', 1),
        (recipe_id, 'Limón', 3, 'unidades', 'Jugo', 2),
        (recipe_id, 'Ají amarillo molido', 2, 'cucharadas', 'Sin picante excesivo', 3),
        (recipe_id, 'Aceite vegetal', 0.33, 'taza', NULL, 4),
        (recipe_id, 'Atún en lata', 2, 'latas', '340g total, desmenuzado', 5),
        (recipe_id, 'Palta', 2, 'unidades', 'Madura', 6),
        (recipe_id, 'Mayonesa', 4, 'cucharadas', NULL, 7),
        (recipe_id, 'Huevo duro', 2, 'unidades', 'Picado muy fino', 8),
        (recipe_id, 'Cebolla morada', 0.25, 'unidad', 'Picada fino y desagrada (opcional)', 9),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Prensar las papas amarillas calientes hasta formar un puré muy fino sin grumos.', 5),
        (recipe_id, 2, 'Mezclar el puré con ají amarillo, jugo de limón, aceite y sal. Amasar hasta obtener una masa suave, aromática y moldeable.', 8),
        (recipe_id, 3, 'Preparar relleno de atún: desmenuzar el atún, mezclar con mayonesa, huevo picado finísimo y cebolla (si usa).', 5),
        (recipe_id, 4, 'Aplastar la palta hasta obtener cremosidad total, sin grumos.', 3),
        (recipe_id, 5, 'En un molde rectangular, hacer capas: base de puré amarillo (mitad), atún con mayonesa, palta aplastada, y cubrir con resto del puré.', 8),
        (recipe_id, 6, 'Compactar bien cada capa. Refrigerar mínimo 1 hora.', 60),
        (recipe_id, 7, 'Desmoldar, cortar en porciones con cuchillo afilado. Servir frío. Decorar con aceitunas o huevo si desea.', 3);
        
        RAISE NOTICE '✅ Receta 20/73: Causa Limeña de Atún y Palta';
    END IF;
END $$;

-- RECETA 21: Ají de Huevos
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Ají de Huevos') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Ají de Huevos',
            'Versión del tradicional ají de gallina usando huevo duro picado en salsa cremosa de ají amarillo y pan remojado. Muy suave.',
            20, 30, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('almuerzos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'alto-proteina');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Huevos duros', 6, 'unidades', 'Picados fino', 1),
        (recipe_id, 'Pan de molde', 4, 'rebanadas', 'Sin corteza', 2),
        (recipe_id, 'Leche evaporada', 1, 'lata', '410ml', 3),
        (recipe_id, 'Ají amarillo molido', 3, 'cucharadas', NULL, 4),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada fino', 5),
        (recipe_id, 'Ajo', 3, 'dientes', NULL, 6),
        (recipe_id, 'Caldo de verduras', 1, 'taza', NULL, 7),
        (recipe_id, 'Queso parmesano', 0.5, 'taza', 'Rallado', 8),
        (recipe_id, 'Nueces', 0.25, 'taza', 'Molidas (no enteras)', 9),
        (recipe_id, 'Aceite', 3, 'cucharadas', NULL, 10),
        (recipe_id, 'Arroz blanco', NULL, 'c/n', 'Para acompañar, muy cocido', 11),
        (recipe_id, 'Papa sancochada', 4, 'unidades', 'Para acompañar', 12),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 13);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Remojar el pan en 1 taza de leche evaporada hasta que se deshaga completamente.', 10),
        (recipe_id, 2, 'Sofreír cebolla y ajo hasta transparentar. Agregar ají amarillo, cocinar 2 minutos.', 6),
        (recipe_id, 3, 'Licuar el pan remojado con el sofrito, el resto de leche evaporada y el caldo hasta obtener salsa completamente lisa.', 4),
        (recipe_id, 4, 'Regresar la salsa a la olla, añadir nueces molidas y queso parmesano. Cocinar a fuego medio removiendo hasta espesar (textura cremosa).', 10),
        (recipe_id, 5, 'Picar los huevos duros muy fino (o machacarlos con tenedor) e incorporar a la salsa. Mezclar bien.', 5),
        (recipe_id, 6, 'Cocinar 5 minutos más. Ajustar consistencia con más leche o caldo si está muy espeso. Sazonar.', 5),
        (recipe_id, 7, 'Servir sobre arroz muy cocido y con papas sancochadas. La salsa debe cubrir todo para facilitar deglución.', 2);
        
        RAISE NOTICE '✅ Receta 21/73: Ají de Huevos';
    END IF;
END $$;

-- RECETA 22: Locro de Zapallo con Queso Fresco
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Locro de Zapallo con Queso Fresco') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Locro de Zapallo con Queso Fresco',
            'Guiso de zapallo y papas cocidos hasta formar puré rústico. Se omite choclo entero o se usa licuado.',
            15, 35, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('almuerzos', 'vegetariano', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'vegetariano', 'comfort-food');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Zapallo macre', 600, 'g', 'En cubos', 1),
        (recipe_id, 'Papas', 4, 'unidades', 'Medianas, en cubos', 2),
        (recipe_id, 'Choclo', 1, 'unidad', 'Desgranado y licuado (opcional)', 3),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada', 4),
        (recipe_id, 'Ajo', 2, 'dientes', NULL, 5),
        (recipe_id, 'Queso fresco', 200, 'g', 'En cubos', 6),
        (recipe_id, 'Leche', 1, 'taza', NULL, 7),
        (recipe_id, 'Aceite', 3, 'cucharadas', NULL, 8),
        (recipe_id, 'Huacatay o hierbabuena', 2, 'cucharadas', 'Picado', 9),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Sofreír cebolla y ajo hasta suavizar.', 5),
        (recipe_id, 2, 'Agregar zapallo y papas, cocinar 3 minutos removiendo.', 3),
        (recipe_id, 3, 'Si usa choclo, licuarlo con un poco de agua y agregar ahora. Si no usa, saltear este paso.', 3),
        (recipe_id, 4, 'Añadir suficiente agua para cubrir (aprox 2 tazas). Cocinar a fuego medio hasta que zapallo y papas se deshagan (25 minutos).', 25),
        (recipe_id, 5, 'Machacar parcialmente con cuchara de madera para formar un puré rústico con algunos trozos suaves.', 3),
        (recipe_id, 6, 'Incorporar leche y queso fresco. El queso fresco se ablandará pero conservará algo de textura (masticable nivel 2).', 5),
        (recipe_id, 7, 'Agregar huacatay o hierbabuena. Sazonar. Servir caliente con textura cremosa tipo puré espeso.', 2);
        
        RAISE NOTICE '✅ Receta 22/73: Locro de Zapallo con Queso Fresco';
    END IF;
END $$;


-- RECETA 23: Solterito de Quinua
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Solterito de Quinua') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Solterito de Quinua',
            'Ensalada de quinua bien cocida con cubos mínimos de queso fresco, palta y tomate pelado sin pepas ni piel.',
            20, 20, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('ensaladas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'vegetariano', 'alto-proteina');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Quinua', 1, 'taza', 'Bien lavada', 1),
        (recipe_id, 'Agua', 2, 'tazas', 'Para cocción', 2),
        (recipe_id, 'Queso fresco', 150, 'g', 'En cubos muy pequeños', 3),
        (recipe_id, 'Palta', 1, 'unidad', 'Madura, en cubos', 4),
        (recipe_id, 'Tomate', 2, 'unidades', 'Pelados, sin semillas, en cubos', 5),
        (recipe_id, 'Cebolla morada', 0.25, 'unidad', 'Picada muy fino, desamargada', 6),
        (recipe_id, 'Aceite de oliva', 3, 'cucharadas', NULL, 7),
        (recipe_id, 'Limón', 2, 'unidades', 'Jugo', 8),
        (recipe_id, 'Culantro', 3, 'cucharadas', 'Picado fino', 9),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Lavar la quinua bajo agua fría hasta que salga clara. Escurrir bien.', 3),
        (recipe_id, 2, 'Cocinar quinua en agua con pizca de sal hasta que esté MUY suave y los granos hayan abierto completamente (15-18 min). Escurrir cualquier exceso de líquido.', 18),
        (recipe_id, 3, 'Enfriar la quinua completamente, puede refrigerar o extender en bandeja.', 10),
        (recipe_id, 4, 'Pelar tomates (sumergir en agua hirviendo 30 seg, luego agua fría). Cortar, eliminar semillas, picar en cubos muy pequeños.', 5),
        (recipe_id, 5, 'Picar cebolla fino, lavar bajo agua fría para desamargar. Escurrir bien.', 3),
        (recipe_id, 6, 'En un bowl, mezclar quinua fría con queso, palta, tomate, cebolla y culantro.', 3),
        (recipe_id, 7, 'Aliñar con aceite de oliva, jugo de limón, sal y pimienta. Mezclar suavemente para no aplastar palta.', 2),
        (recipe_id, 8, 'Servir fresco. Todos los ingredientes deben estar en trozos muy pequeños para facilitar deglución.', 1);
        
        RAISE NOTICE '✅ Receta 23/73: Solterito de Quinua';
    END IF;
END $$;

-- RECETA 24: Pescado Blanco al Vapor
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Pescado Blanco al Vapor') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Pescado Blanco al Vapor',
            'Lenguado o merluza preparado con hierbas finas. La carne se desmorona al contacto con la lengua. Rico en omega-3.',
            10, 15, 2, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('pescados-mariscos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'rico-omega3', 'alto-proteina', 'facil');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Filete de lenguado o merluza', 400, 'g', 'Sin espinas', 1),
        (recipe_id, 'Limón', 1, 'unidad', 'Jugo', 2),
        (recipe_id, 'Perejil fresco', 2, 'cucharadas', 'Picado', 3),
        (recipe_id, 'Albahaca fresca', 1, 'cucharada', 'Picada', 4),
        (recipe_id, 'Aceite de oliva', 2, 'cucharadas', NULL, 5),
        (recipe_id, 'Ajo', 1, 'diente', 'Laminado fino', 6),
        (recipe_id, 'Sal y pimienta blanca', NULL, 'al gusto', NULL, 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Sazonar los filetes con sal, pimienta blanca y jugo de limón. Dejar reposar 5 minutos.', 5),
        (recipe_id, 2, 'Preparar vaporera: hervir agua en olla con rejilla o canasta de bambú encima.', 3),
        (recipe_id, 3, 'Colocar filetes en la vaporera, esparcir hierbas frescas y ajo laminado encima. Rociar con aceite de oliva.', 2),
        (recipe_id, 4, 'Tapar y cocinar al vapor durante 12-15 minutos dependiendo del grosor del filete. El pescado debe quedar opaco y desmenuzarse fácilmente con tenedor.', 15),
        (recipe_id, 5, 'Retirar con cuidado. El pescado debe estar tan suave que se separe en láminas al menor contacto.', 1),
        (recipe_id, 6, 'Servir tibio con el líquido que soltó (rico en sabor). Acompañar con puré de papa o arroz muy cocido.', 2);
        
        RAISE NOTICE '✅ Receta 24/73: Pescado Blanco al Vapor';
    END IF;
END $$;

-- RECETA 25: Albóndigas de Res en Salsa de Tomate
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Albóndigas de Res en Salsa de Tomate') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Albóndigas de Res en Salsa de Tomate',
            'Carne molida DOS VECES para máxima suavidad, cocida en salsa húmeda que facilita el bolo alimenticio.',
            25, 40, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-proteina', 'comfort-food');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Carne molida de res', 500, 'g', 'Molida DOS veces (importante)', 1),
        (recipe_id, 'Pan de molde', 2, 'rebanadas', 'Sin corteza, remojado en leche', 2),
        (recipe_id, 'Leche', 0.5, 'taza', 'Para remojar pan', 3),
        (recipe_id, 'Huevo', 1, 'unidad', NULL, 4),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada muy fino', 5),
        (recipe_id, 'Ajo', 3, 'dientes', 'Picados', 6),
        (recipe_id, 'Tomates', 4, 'unidades', 'Grandes, pelados y triturados', 7),
        (recipe_id, 'Pasta de tomate', 2, 'cucharadas', NULL, 8),
        (recipe_id, 'Caldo de res', 1.5, 'tazas', NULL, 9),
        (recipe_id, 'Albahaca fresca', 5, 'hojas', NULL, 10),
        (recipe_id, 'Orégano', 1, 'cucharadita', NULL, 11),
        (recipe_id, 'Aceite', 3, 'cucharadas', NULL, 12),
        (recipe_id, 'Sal, pimienta, comino', NULL, 'al gusto', NULL, 13);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Exprimir el pan remojado para quitar exceso de leche. Desmenuzar bien.', 2),
        (recipe_id, 2, 'En un bowl, mezclar carne molida (doble molida), pan exprimido, huevo, mitad de la cebolla, mitad del ajo, sal, pimienta y comino. Amasar hasta mezcla homogénea.', 5),
        (recipe_id, 3, 'Formar albóndigas pequeñas (3-4cm diámetro) para que sean fáciles de comer. Deben quedar compactas.', 10),
        (recipe_id, 4, 'En una olla, calentar aceite. Sofreír resto de cebolla y ajo hasta transparentar.', 5),
        (recipe_id, 5, 'Agregar tomates triturados, pasta de tomate, orégano y albahaca. Cocinar 10 minutos formando salsa.', 10),
        (recipe_id, 6, 'Añadir caldo, sazonar. Cuando hierva, incorporar cuidadosamente las albóndigas.', 3),
        (recipe_id, 7, 'Cocinar a fuego medio-bajo tapado por 25-30 minutos. Las albóndigas deben quedar muy suaves. La salsa debe estar espesa y abundante.', 30),
        (recipe_id, 8, 'Servir con bastante salsa sobre arroz muy cocido o puré de papa. La salsa lubrica las albóndigas.', 2);
        
        RAISE NOTICE '✅ Receta 25/73: Albóndigas de Res en Salsa de Tomate';
    END IF;
END $$;

-- RECETA 26: Carapulcra de Champiñones
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Carapulcra de Champiñones') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Carapulcra de Champiñones',
            'Guiso de papa seca hidratada donde los champiñones aportan sabor umami con textura blanda.',
            30, 50, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('vegetariano', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Papa seca', 300, 'g', 'Remojada 12 horas', 1),
        (recipe_id, 'Champiñones', 400, 'g', 'Laminados', 2),
        (recipe_id, 'Cebolla', 2, 'unidades', 'Picadas', 3),
        (recipe_id, 'Ajo', 4, 'dientes', NULL, 4),
        (recipe_id, 'Ají panca molido', 2, 'cucharadas', NULL, 5),
        (recipe_id, 'Maní tostado', 0.25, 'taza', 'Molido', 6),
        (recipe_id, 'Caldo de verduras', 3, 'tazas', NULL, 7),
        (recipe_id, 'Vino tinto', 0.5, 'taza', NULL, 8),
        (recipe_id, 'Aceite', 4, 'cucharadas', NULL, 9),
        (recipe_id, 'Comino, pimienta, clavo', NULL, 'al gusto', NULL, 10),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 11);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Después de remojar 12h, cocinar papa seca en agua hasta suave (30-40 min). Escurrir. Debe quedar esponjosa.', 40),
        (recipe_id, 2, 'En una olla grande, calentar aceite. Sofreír cebolla y ajo hasta dorar ligeramente.', 8),
        (recipe_id, 3, 'Agregar ají panca, comino, pimienta y clavo. Cocinar 2 minutos hasta aromático.', 2),
        (recipe_id, 4, 'Añadir champiñones, cocinar hasta que suelten líquido y se reduzca (8 minutos).', 8),
        (recipe_id, 5, 'Incorporar papa seca cocida, mezclar bien con el sofrito.', 2),
        (recipe_id, 6, 'Agregar vino, dejar evaporar. Luego añadir caldo y maní molido. El maní espesará la salsa.', 5),
        (recipe_id, 7, 'Cocinar a fuego medio por 20-25 minutos, removiendo ocasionalmente. La papa seca absorberá sabores y se volverá aún más suave.', 25),
        (recipe_id, 8, 'Ajustar sazón. Servir caliente con arroz. La textura debe ser de guiso espeso con papa seca muy tierna.', 2);
        
        RAISE NOTICE '✅ Receta 26/73: Carapulcra de Champiñones';
    END IF;
END $$;

-- RECETA 27: Pepián de Choclo
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Pepián de Choclo') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Pepián de Choclo',
            'Puré de maíz tierno licuado y cocido con aderezo suave. Servido con arroz muy cocido.',
            15, 30, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('almuerzos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Choclo tierno', 4, 'unidades', 'Desgranado', 1),
        (recipe_id, 'Leche', 1, 'taza', NULL, 2),
        (recipe_id, 'Queso fresco', 150, 'g', 'Desmenuzado', 3),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada', 4),
        (recipe_id, 'Ajo', 2, 'dientes', NULL, 5),
        (recipe_id, 'Ají amarillo', 1, 'cucharada', 'Molido', 6),
        (recipe_id, 'Huevos', 2, 'unidades', NULL, 7),
        (recipe_id, 'Aceite', 3, 'cucharadas', NULL, 8),
        (recipe_id, 'Albahaca', 5, 'hojas', NULL, 9),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Licuar el choclo desgranado con la leche hasta obtener puré completamente liso. Colar si quedan fibras.', 5),
        (recipe_id, 2, 'Sofreír cebolla, ajo y ají amarillo hasta suavizar.', 6),
        (recipe_id, 3, 'Agregar el puré de choclo colado al sofrito. Cocinar a fuego medio removiendo constantemente.', 15),
        (recipe_id, 4, 'Cuando espese (textura de puré), añadir queso fresco desmenuzado. Mezclar hasta incorporar.', 3),
        (recipe_id, 5, 'Batir huevos e integrarlos al pepián removiendo rápido para que se cocinen en hilos suaves.', 3),
        (recipe_id, 6, 'Agregar albahaca picada, ajustar sazón.', 1),
        (recipe_id, 7, 'Servir caliente sobre arroz muy cocido. La textura debe ser cremosa como puré espeso.', 2);
        
        RAISE NOTICE '✅ Receta 27/73: Pepián de Choclo';
    END IF;
END $$;

-- RECETA 28: Tallarines Verdes con Queso Batido
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Tallarines Verdes con Queso Batido') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Tallarines Verdes con Queso Batido',
            'Pasta cocida más allá de al dente con salsa de espinaca y albahaca completamente licuada.',
            15, 20, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('pastas', 'vegetariano', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'vegetariano', 'facil');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Tallarines o spaghetti', 400, 'g', NULL, 1),
        (recipe_id, 'Espinaca', 2, 'tazas', 'Hojas frescas', 2),
        (recipe_id, 'Albahaca', 1, 'taza', 'Hojas frescas', 3),
        (recipe_id, 'Queso fresco', 150, 'g', NULL, 4),
        (recipe_id, 'Leche evaporada', 1, 'taza', NULL, 5),
        (recipe_id, 'Ajo', 3, 'dientes', NULL, 6),
        (recipe_id, 'Nueces', 0.25, 'taza', 'Molidas', 7),
        (recipe_id, 'Queso parmesano', 0.5, 'taza', 'Rallado', 8),
        (recipe_id, 'Aceite de oliva', 3, 'cucharadas', NULL, 9),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Blanquear espinaca en agua hirviendo por 2 minutos. Escurrir bien exprimiendo toda el agua.', 3),
        (recipe_id, 2, 'Licuar espinaca escurrida, albahaca, queso fresco, ajo, nueces, leche evaporada y aceite de oliva hasta obtener salsa completamente lisa y verde brillante.', 4),
        (recipe_id, 3, 'Cocinar pasta en abundante agua con sal. Cocinarla 2-3 minutos MÁS del tiempo indicado para que quede muy suave (no al dente).', 12),
        (recipe_id, 4, 'Calentar la salsa verde en una sartén grande a fuego bajo. No debe hervir.', 2),
        (recipe_id, 5, 'Escurrir pasta y agregarla directamente a la salsa verde. Mezclar bien para que se cubra completamente.', 2),
        (recipe_id, 6, 'Añadir queso parmesano, mezclar. La salsa debe ser cremosa y cubrir cada fideo.', 1),
        (recipe_id, 7, 'Servir inmediatamente. La pasta debe estar muy suave y la salsa completamente lisa sin grumos de verdura.', 1);
        
        RAISE NOTICE '✅ Receta 28/73: Tallarines Verdes con Queso Batido';
    END IF;
END $$;


-- RECETA 29: Humita en Olla de Sal
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Humita en Olla de Sal') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Humita en Olla de Sal',
            'Masa de maíz tierno cocida lentamente evitando panca exterior, con queso derretido en el centro. Muy suave.',
            30, 40, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('almuerzos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Choclo tierno', 6, 'unidades', 'Desgranado', 1),
        (recipe_id, 'Queso fresco', 200, 'g', 'En cubos', 2),
        (recipe_id, 'Mantequilla', 3, 'cucharadas', NULL, 3),
        (recipe_id, 'Azúcar', 2, 'cucharadas', NULL, 4),
        (recipe_id, 'Sal', 1, 'cucharadita', NULL, 5),
        (recipe_id, 'Anís', 1, 'cucharadita', 'Opcional', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Licuar el choclo desgranado con la mantequilla derretida hasta formar masa homogénea.', 5),
        (recipe_id, 2, 'Pasar por colador para eliminar fibras y obtener masa completamente lisa.', 5),
        (recipe_id, 3, 'Mezclar la masa colada con azúcar, sal y anís.', 2),
        (recipe_id, 4, 'En una olla grande, colocar una cama de hojas de choclo o papel vegetal. Verter la mitad de la masa.', 3),
        (recipe_id, 5, 'Distribuir cubos de queso sobre la masa. Cubrir con el resto de la masa.', 2),
        (recipe_id, 6, 'Tapar y cocinar a fuego muy bajo por 35-40 minutos. El vapor cocina la masa y derrite el queso.', 40),
        (recipe_id, 7, 'Dejar enfriar 10 minutos antes de servir. La textura debe ser suave como pudín con queso fundido.', 10);
        
        RAISE NOTICE '✅ Receta 29/73: Humita en Olla de Sal';
    END IF;
END $$;

-- RECETA 30: Pastel de Papa Versión Puré
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Pastel de Papa Versión Puré') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Pastel de Papa Versión Puré',
            'Capas de puré de papa rellenas de queso fundido. Horneado hasta suave, NO crocante.',
            20, 35, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('almuerzos', 'vegetariano', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'comfort-food', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Papas', 1, 'kg', 'Para puré', 1),
        (recipe_id, 'Leche', 1, 'taza', NULL, 2),
        (recipe_id, 'Mantequilla', 4, 'cucharadas', NULL, 3),
        (recipe_id, 'Queso mozzarella', 200, 'g', 'Rallado', 4),
        (recipe_id, 'Queso parmesano', 0.5, 'taza', 'Rallado', 5),
        (recipe_id, 'Huevo', 1, 'unidad', 'Batido', 6),
        (recipe_id, 'Sal, pimienta, nuez moscada', NULL, 'al gusto', NULL, 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar papas hasta muy suaves. Hacer puré agregando leche, mantequilla, sal, pimienta y nuez moscada hasta cremoso.', 10),
        (recipe_id, 2, 'Dejar enfriar levemente, mezclar con el huevo batido.', 5),
        (recipe_id, 3, 'En molde engrasado, colocar mitad del puré formando capa uniforme.', 2),
        (recipe_id, 4, 'Cubrir con queso mozzarella rallado generosamente.', 1),
        (recipe_id, 5, 'Agregar resto del puré como segunda capa. Alisar superficie.', 2),
        (recipe_id, 6, 'Espolvorear parmesano encima. NO debe formar costra dura, solo gratinar ligeramente.', 1),
        (recipe_id, 7, 'Hornear a 180°C por 25-30 minutos. Debe quedar suave, no crujiente. El queso interno debe estar fundido.', 30),
        (recipe_id, 8, 'Dejar reposar 5 minutos. Servir tibio en porciones suaves.', 5);
        
        RAISE NOTICE '✅ Receta 30/73: Pastel de Papa Versión Puré';
    END IF;
END $$;

-- RECETA 31: Cau Cau de Mondongo
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Cau Cau de Mondongo') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Cau Cau de Mondongo',
            'Mondongo picado MUY pequeño y cocido hasta extrema ternura en salsa de palillo y hierbabuena. Requiere cocción prolongada.',
            30, 180, 4, 'HARD', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'alto-proteina');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Mondongo', 500, 'g', 'Precocido y picado en cubos de 0.5cm', 1),
        (recipe_id, 'Papas', 3, 'unidades', 'En cubos pequeños', 2),
        (recipe_id, 'Cebolla', 2, 'unidades', 'Picada', 3),
        (recipe_id, 'Ajo', 4, 'dientes', NULL, 4),
        (recipe_id, 'Ají amarillo', 2, 'cucharadas', 'Molido', 5),
        (recipe_id, 'Palillo (cúrcuma)', 1, 'cucharadita', NULL, 6),
        (recipe_id, 'Hierbabuena', 0.25, 'taza', 'Picada', 7),
        (recipe_id, 'Caldo', 4, 'tazas', NULL, 8),
        (recipe_id, 'Aceite', 4, 'cucharadas', NULL, 9),
        (recipe_id, 'Sal, pimienta, comino', NULL, 'al gusto', NULL, 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'El mondongo debe estar precocido. Picarlo en cubos MINIMOS (0.5cm). Esto es crítico para textura DTM.', 15),
        (recipe_id, 2, 'Sofreír cebolla, ajo, ají amarillo y palillo hasta dorar.', 8),
        (recipe_id, 3, 'Agregar mondongo picado, cocinar 10 minutos removiendo.', 10),
        (recipe_id, 4, 'Añadir caldo y especias. Cocinar a fuego medio-bajo por 2.5-3 HORAS hasta que mondongo esté sumamente tierno. Debe casi deshacerse.', 180),
        (recipe_id, 5, 'En la última hora, agregar papas. Deben cocerse hasta estar muy suaves.', 60),
        (recipe_id, 6, 'Agregar hierbabuena picada 10 minutos antes de terminar.', 10),
        (recipe_id, 7, 'Servir caliente con arroz. El mondongo debe estar tan suave que no requiera masticación fuerte.', 2);
        
        RAISE NOTICE '✅ Receta 31/73: Cau Cau de Mondongo';
    END IF;
END $$;

-- RECETA 32: Tamalito Verde
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Tamalito Verde Piurano') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Tamalito Verde Piurano',
            'Maíz choclo tierno licuado con culantro. La masa es puré gelificado húmedo. Se omite salsa criolla para DTM.',
            40, 45, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('almuerzos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'sin-masticacion');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Choclo tierno crudo', 8, 'unidades', 'Desgranado', 1),
        (recipe_id, 'Culantro', 1, 'taza', 'Hojas', 2),
        (recipe_id, 'Cebolla china', 4, 'tallos', NULL, 3),
        (recipe_id, 'Ají verde', 1, 'unidad', 'Pequeño, sin semillas', 4),
        (recipe_id, 'Manteca de cerdo', 0.5, 'taza', 'O mantequilla', 5),
        (recipe_id, 'Sal', 1, 'cucharada', NULL, 6),
        (recipe_id, 'Pancas de choclo', 12, 'unidades', 'Para envolver', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Licuar choclo crudo desgranado con culantro, cebolla china, ají verde y manteca hasta obtener masa completamente lisa y verde.', 8),
        (recipe_id, 2, 'Agregar sal, licuar nuevamente. La consistencia debe ser como puré espeso.', 2),
        (recipe_id, 3, 'Lavar y secar pancas de choclo.', 5),
        (recipe_id, 4, 'Colocar 3-4 cucharadas de masa en el centro de cada panca. Envolver formando paquete.', 15),
        (recipe_id, 5, 'En olla grande con rejilla, hervir agua. Colocar tamales parados en la rejilla sin que toquen el agua.', 5),
        (recipe_id, 6, 'Cocinar al vapor tapado por 40-45 minutos. La masa se gelificará y cocinará completamente.', 45),
        (recipe_id, 7, 'Dejar enfriar 5 min. Desenvolver y servir SIN salsa criolla (la cebolla cruda no es DTM-friendly). La textura debe ser como puré gelificado suave.', 5);
        
        RAISE NOTICE '✅ Receta 32/73: Tamalito Verde Piurano';
    END IF;
END $$;

-- ================================================================
-- SECCIÓN 4: POSTRES Y DULCES
-- ================================================================

-- RECETA 33: Mazamorra Morada con Frutas Picaditas
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Mazamorra Morada con Frutas Picaditas') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Mazamorra Morada con Frutas Picaditas',
            'Postre emblemático peruano rico en antocianinas antioxidantes. Frutas picadas MUY pequeñas.',
            15, 45, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'antiinflamatorio');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Maíz morado', 500, 'g', 'Desgranado', 1),
        (recipe_id, 'Piña', 0.5, 'unidad', 'En cubos muy pequeños', 2),
        (recipe_id, 'Manzana', 2, 'unidades', 'Pelada y picada muy fino', 3),
        (recipe_id, 'Membrillo', 1, 'unidad', 'En cubos pequeños', 4),
        (recipe_id, 'Guindones (ciruelas secas)', 0.5, 'taza', 'Remojadas y picadas', 5),
        (recipe_id, 'Canela', 2, 'ramas', NULL, 6),
        (recipe_id, 'Clavo de olor', 5, 'unidades', NULL, 7),
        (recipe_id, 'Azúcar', 1.5, 'tazas', 'Al gusto', 8),
        (recipe_id, 'Fécula de maíz', 0.75, 'taza', 'Disuelta en agua fría', 9),
        (recipe_id, 'Limón', 1, 'unidad', 'Jugo', 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hervir maíz morado con canela y clavo en abundante agua (8 tazas) por 30-35 minutos. El agua se volverá morada oscura.', 35),
        (recipe_id, 2, 'Colar y descartar los sólidos. Regresar líquido morado a la olla.', 3),
        (recipe_id, 3, 'Agregar frutas picadas MUY pequeñas. Cocinar 10 minutos hasta que estén suaves.', 10),
        (recipe_id, 4, 'Añadir azúcar y mezclar.', 1),
        (recipe_id, 5, 'Incorporar fécula disuelta gradualmente mientras se remueve constante. Cocinar hasta espesar como gelatina líquida', 8),
        (recipe_id, 6, 'Agregar jugo de limón. Retirar del fuego.', 1),
        (recipe_id, 7, 'Enfriar completamente. Servir frío. Las frutas deben estar muy suaves y pequeñas, fáciles de tragar.', 2);
        
        RAISE NOTICE '✅ Receta 33/73: Mazamorra Morada con Frutas Picaditas';
    END IF;
END $$;

-- RECETA 34: Suspiro a la Limeña
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Suspiro a la Limeña') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Suspiro a la Limeña',
            'Postre de textura sedosa por excelencia. Manjar blanco cremoso con merengue al oporto. No requiere masticación, derrite en boca.',
            20, 40, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'sin-masticacion', 'dulce');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Leche condensada', 1, 'lata', '395g', 1),
        (recipe_id, 'Leche evaporada', 1, 'lata', '410g', 2),
        (recipe_id, 'Yemas de huevo', 6, 'unidades', NULL, 3),
        (recipe_id, 'Vainilla', 1, 'cucharadita', 'Esencia', 4),
        (recipe_id, 'Claras de huevo', 3, 'unidades', 'Para merengue', 5),
        (recipe_id, 'Azúcar', 0.75, 'taza', 'Para merengue', 6),
        (recipe_id, 'Vino oporto', 3, 'cucharadas', 'Para perfumar merengue', 7),
        (recipe_id, 'Canela en polvo', NULL, 'al gusto', 'Para decorar', 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'En una olla, mezclar leche condensada, evaporada y yemas batidas.', 3),
        (recipe_id, 2, 'Cocinar a fuego medio-bajo removiendo CONSTANTEMENTE en forma de 8 hasta que espese y desprenda del fondo (punto manjar).', 30),
        (recipe_id, 3, 'Añadir vainilla, mezclar. Retirar del fuego y enfriar completamente.', 2),
        (recipe_id, 4, 'Batir claras a punto de nieve. Añadir azúcar gradualmente mientras se sigue batiendo hasta merengue firme y brillante.', 8),
        (recipe_id, 5, 'Incorporar vino oporto al merengue con movimientos envolventes suaves.', 2),
        (recipe_id, 6, 'Servir manjar en copas individuales. Cubrir generosamente con merengue.', 3),
        (recipe_id, 7, 'Espolvorear canela encima. Servir frío o a temperatura ambiente. Textura debe ser sedosa, derretirse en boca.', 1);
        
        RAISE NOTICE '✅ Receta 34/73: Suspiro a la Limeña';
    END IF;
END $$;


-- RECETA 35: Mousse de Lúcuma
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Mousse de Lúcuma') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Mousse de Lúcuma',
            'Postre suave y aireado con pulpa de lúcuma peruana. Rica en betacarotenos y vitaminas. Sin masticación requerida.',
            15, 0, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'sin-masticacion', 'facil');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Pulpa de lúcuma', 1, 'taza', 'Fresca o congelada', 1),
        (recipe_id, 'Leche condensada', 0.5, 'taza', NULL, 2),
        (recipe_id, 'Crema para batir', 1, 'taza', 'Fría', 3),
        (recipe_id, 'Vainilla', 1, 'cucharadita', NULL, 4),
        (recipe_id, 'Azúcar glass', 2, 'cucharadas', 'Opcional', 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Licuar pulpa de lúcuma con leche condensada hasta completamente lisa.', 2),
        (recipe_id, 2, 'Batir crema para batir con vainilla y azúcar glass hasta formar picos suaves.', 5),
        (recipe_id, 3, 'Incorporar puré de lúcuma a la crema batida con movimientos envolventes suaves para no perder aire.', 3),
        (recipe_id, 4, 'Servir en copas individuales. Refrigerar mínimo 2 horas.', 120),
        (recipe_id, 5, 'Servir frío. La textura debe ser aireada y se derrite en la boca sin esfuerzo.', 1);
        
        RAISE NOTICE '✅ Receta 35/73: Mousse de Lúcuma';
    END IF;
END $$;

-- RECETA 36: Flan de Plátano o Camote
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Flan de Plátano') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Flan de Plátano',
            'Flan horneado con plátano maduro que aporta potasio y textura sedosa. Rico en fibra soluble digestible.',
            20, 60, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'sin-masticacion');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Plátanos maduros', 3, 'unidades', 'Grandes', 1),
        (recipe_id, 'Leche evaporada', 1, 'lata', '410g', 2),
        (recipe_id, 'Huevos', 4, 'unidades', NULL, 3),
        (recipe_id, 'Azúcar', 0.75, 'taza', NULL, 4),
        (recipe_id, 'Vainilla', 1, 'cucharadita', NULL, 5),
        (recipe_id, 'Azúcar para caramelo', 0.5, 'taza', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hacer caramelo: calentar azúcar para carameloen una olla hasta fundir y dorar. Verter en molde cubriendo fondo y lados. Dejar enfriar.', 8),
        (recipe_id, 2, 'Licuar plátanos, leche evaporada, huevos, azúcar y vainilla hasta mezcla completamente lisa.', 3),
        (recipe_id, 3, 'Verter mezcla en molde caramelizado.', 1),
        (recipe_id, 4, 'Hornear a baño maría a 170°C por 50-60 minutos. Debe quedar firme al centro.', 60),
        (recipe_id, 5, 'Enfriar completamente y refrigerar mínimo 4 horas antes de desmoldar.', 240),
        (recipe_id, 6, 'Desmoldar con cuidado. La textura debe ser sedosa y gelatinosa, fácil de cortar con cuchara.', 2);
        
        RAISE NOTICE '✅ Receta 36/73: Flan de Plátano';
    END IF;
END $$;

-- RECETA 37: Pudín de Chía y Coco
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Pudín de Chía y Coco') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Pudín de Chía y Coco',
            'Semillas de chía hidratadas en leche de coco creando gel nutritivo rico en Omega-3 antiinflamatorio. Sin cocción.',
            5, 0, 2, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'rico-omega3', 'antiinflamatorio', 'frio');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Semillas de chía', 0.25, 'taza', NULL, 1),
        (recipe_id, 'Leche de coco', 1, 'taza', NULL, 2),
        (recipe_id, 'Miel o jarabe de agave', 2, 'cucharadas', NULL, 3),
        (recipe_id, 'Vainilla', 0.5, 'cucharadita', NULL, 4),
        (recipe_id, 'Fruta licuada', 0.5, 'taza', 'Mango, fresa o plátano', 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Mezclar semillas de chía con leche de coco, miel y vainilla en un bowl.', 2),
        (recipe_id, 2, 'Batir bien para evitar grumos. Las semillas deben distribuirse uniformemente.', 1),
        (recipe_id, 3, 'Refrigerar mínimo 4 horas o toda la noche. Las semillas absorben líquido y forman gel.', 240),
        (recipe_id, 4, 'Antes de servir, remover bien. La textura debe ser como pudín espeso.', 1),
        (recipe_id, 5, 'Servir en capas alternando con fruta licuada. Las semillas hidratadas son suaves, resbaladizas y fáciles de tragar.', 2);
        
        RAISE NOTICE '✅ Receta 37/73: Pudín de Chía y Coco';
    END IF;
END $$;

-- RECETA 38: Sanguito
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Sanguito Cusqueño') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Sanguito Cusqueño',
            'Dulce tradicional andino de harina de maíz, chancaca y manteca. Textura densa tipo mazapán que se deshace lentamente.',
            10, 30, 8, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Harina de maíz', 2, 'tazas', 'Tostada suavemente', 1),
        (recipe_id, 'Chancaca', 1, 'panela', 'Aprox 250g, rallada', 2),
        (recipe_id, 'Manteca de cerdo', 0.5, 'taza', 'O mantequilla', 3),
        (recipe_id, 'Agua', 1, 'taza', NULL, 4),
        (recipe_id, 'Anís', 1, 'cucharadita', 'En grano', 5),
        (recipe_id, 'Canela', 1, 'rama', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hervir agua con chancaca rallada, anís y canela hasta formar miel espesa.', 15),
        (recipe_id, 2, 'Colar para eliminarespecias y obtener miel lisa.', 2),
        (recipe_id, 3, 'En una olla, mezclar harina de maíz tostada con la manteca derretida.', 3),
        (recipe_id, 4, 'Agregar la miel de chancaca caliente gradualmente mientras se remueve constantemente hasta formar pasta densa y homogénea.', 10),
        (recipe_id, 5, 'Cocinar a fuego bajo removiendo siempre hasta que se desprenda de la olla (punto de bola).', 8),
        (recipe_id, 6, 'Verter en molde engrasado, alisar superficie. Dejar enfriar completamente.', 60),
        (recipe_id, 7, 'Cortar en porciones. Textura debe ser densa pero suave, derretirse lentamente en boca como turrón suave.', 2);
        
        RAISE NOTICE '✅ Receta 38/73: Sanguito Cusqueño';
    END IF;
END $$;

-- RECETA 39: Mazamorra de Cochino
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Mazamorra de Cochino') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Mazamorra de Cochino',
            'Pudín cremoso de maíz, leche, chancaca y manteca. Se llama así por su color oscuro, no contiene cerdo.',
            15, 40, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Maíz morado molido', 1, 'taza', 'Harina de maíz morado', 1),
        (recipe_id, 'Leche', 4, 'tazas', NULL, 2),
        (recipe_id, 'Chancaca', 300, 'g', 'Rallada', 3),
        (recipe_id, 'Mantequilla', 4, 'cucharadas', NULL, 4),
        (recipe_id, 'Canela', 2, 'ramas', NULL, 5),
        (recipe_id, 'Clavo de olor', 4, 'unidades', NULL, 6),
        (recipe_id, 'Pasas', 0.25, 'taza', 'Opcional', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hervir leche con canela y clavo. Dejar infusionar 10 minutos, colar.', 15),
        (recipe_id, 2, 'Disolver harina de maíz morado en 1 taza de la leche especiada fría.', 2),
        (recipe_id, 3, 'Calentar el resto de leche, agregar chancaca rallada. Remover hasta disolver completamente.', 8),
        (recipe_id, 4, 'Incorporar la harina disuelta a la leche caliente removiendo constantemente para evitar grumos.', 3),
        (recipe_id, 5, 'Cocinar a fuego medio-bajo removiendo en forma de 8 hasta espesar como pudín (15-20 min).', 20),
        (recipe_id, 6, 'Agregar mantequilla y pasas (si usa). Mezclar hasta integrar.', 2),
        (recipe_id, 7, 'Servir tibio o frío en bowls. La textura debe ser cremosa tipo pudín espeso.', 1);
        
        RAISE NOTICE '✅ Receta 39/73: Mazamorra de Cochino';
    END IF;
END $$;

-- RECETA 40: Ranfañote
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Ranfañote') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Ranfañote',
            'Pan completamente saturado en miel de chancaca caliente con queso fresco derretido. Textura mojada tipo budín de pan.',
            20, 25, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Pan de molde', 8, 'rebanadas', 'Sin corteza', 1),
        (recipe_id, 'Chancaca', 400, 'g', 'Rallada', 2),
        (recipe_id, 'Agua', 2, 'tazas', NULL, 3),
        (recipe_id, 'Queso fresco', 200, 'g', 'En láminas', 4),
        (recipe_id, 'Canela', 1, 'rama', NULL, 5),
        (recipe_id, 'Clavo de olor', 3, 'unidades', NULL, 6),
        (recipe_id, 'Anís estrellado', 1, 'unidad', NULL, 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Preparar miel: hervir chancaca con agua, canela, clavo y anís hasta formar jarabe espeso (punto hilo). Colar.', 20),
        (recipe_id, 2, 'Cortar pan en trozos medianos (sin corteza).', 3),
        (recipe_id, 3, 'Disponer capa de pan en fuente honda. Cubrir con láminas de queso fresco.', 2),
        (recipe_id, 4, 'Bañar generosamente con miel de chancaca caliente. El pan debe absorber completamente el líquido.', 3),
        (recipe_id, 5, 'Repetir capas: pan, queso, miel.', 2),
        (recipe_id, 6, 'Dejar reposar 20-30 minutos para que pan absorba toda la miel y se ablande completamente.', 30),
        (recipe_id, 7, 'Servir tibio o frío. El pan debe estar totalmente empapado, casi desintegrado, con queso suavizado. Se come con cuchara como budín muy húmedo.', 1);
        
        RAISE NOTICE '✅ Receta 40/73: Ranfañote';
    END IF;
END $$;


-- RECETA 41: Frejol Colado  
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Frejol Colado') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Frejol Colado',
            'Dulce tradicional de frejoles negros licuados punto manjar. Alto en proteína, fibra y hierro. Textura cremosa.',
            30, 90, 8, 'HARD', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'alto-proteina');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Frejoles negros', 500, 'g', 'Remojados 12 horas', 1),
        (recipe_id, 'Chancaca', 400, 'g', 'Rallada', 2),
        (recipe_id, 'Leche condensada', 1, 'lata', '395g', 3),
        (recipe_id, 'Canela', 2, 'ramas', NULL, 4),
        (recipe_id, 'Clavo de olor', 4, 'unidades', NULL, 5),
        (recipe_id, 'Vainilla', 1, 'cucharada', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar frejoles remojados con canela y clavo en abundante agua hasta muy suaves (60-90 min). Deben deshacerse al presionar.', 90),
        (recipe_id, 2, 'Escurrir y retirar especias. Licuar frejoles con un poco del líquido de cocción hasta puré completamente liso.', 5),
        (recipe_id, 3, 'Colar el puré para eliminar cáscaras y obtener crema perfectamente lisa.', 10),
        (recipe_id, 4, 'Cocinar puré colado con chancaca y leche condensada a fuego medio-bajo, removiendo constantemente.', 40),
        (recipe_id, 5, 'Cocinar hasta punto manjar (se despega del fondo). Agregar vainilla.', 5),
        (recipe_id, 6, 'Servir frío. Textura debe ser cremosa como dulce de leche.', 1);
        
        RAISE NOTICE '✅ Receta 41/73: Frejol Colado';
    END IF;
END $$;

-- RECETA 42: Arroz Zambito
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Arroz Zambito') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Arroz Zambito',
            'Arroz con leche oscuro con chancaca, coco rallado y pasas. Variante tradicional del arroz con leche.',
            10, 40, 6, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'comfort-food');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Arroz', 1, 'taza', NULL, 1),
        (recipe_id, 'Leche', 4, 'tazas', NULL, 2),
        (recipe_id, 'Chancaca', 200, 'g', 'Rallada', 3),
        (recipe_id, 'Coco rallado', 0.5, 'taza', NULL, 4),
        (recipe_id, 'Pasas', 0.5, 'taza', 'Sin semillas', 5),
        (recipe_id, 'Canela', 2, 'ramas', NULL, 6),
        (recipe_id, 'Clavo', 3, 'unidades', NULL, 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hervir arroz en agua hasta semicocido. Escurrir.', 10),
        (recipe_id, 2, 'Cocinar leche con chancaca hasta disolver completamente.', 5),
        (recipe_id, 3, 'Agregar arroz, canela, clavo y coco. Cocinar a fuego bajo removiendo frecuentemente hasta que arroz esté MUY suave.', 25),
        (recipe_id, 4, 'Añadir pasas. Cocinar 5 minutos más.', 5),
        (recipe_id, 5, 'Servir tibio o frío. Arroz debe estar desfond, casi cremoso.', 1);
        
        RAISE NOTICE '✅ Receta 42/73: Arroz Zambito';
    END IF;
END $$;

-- RECETA 43: Leche Asada
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Leche Asada') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Leche Asada',
            'Postre horneado simple de leche y huevo. Superficie dorada, interior sedoso. DTM-friendly.',
            10, 45, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'facil');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Leche', 4, 'tazas', NULL, 1),
        (recipe_id, 'Huevos', 6, 'unidades', NULL, 2),
        (recipe_id, 'Azúcar', 1, 'taza', NULL, 3),
        (recipe_id, 'Vainilla', 1, 'cucharada', NULL, 4),
        (recipe_id, 'Azúcar para caramelo', 0.5, 'taza', NULL, 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Caramelizar molde con azúcar para caramelo.', 5),
        (recipe_id, 2, 'Batir huevos con azúcar hasta espumoso. Agregar leche y vainilla.', 5),
        (recipe_id, 3, 'Verter en molde caramelizado. Hornear a baño maría 170°C por 40-45 minutos.', 45),
        (recipe_id, 4, 'Enfriar y refrigerar. Desmoldar. Textura sedosa.', 1);
        
        RAISE NOTICE '✅ Receta 43/73: Leche Asada';
    END IF;
END $$;

-- RECETA 44: Crema Volteada
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Crema Volteada') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Crema Volteada',
            'Flan peruano con leche condensada. Denso, liso y sedoso. Ideal DTM.',
            15, 50, 8, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Leche condensada', 1, 'lata', NULL, 1),
        (recipe_id, 'Leche evaporada', 1, 'lata', NULL, 2),
        (recipe_id, 'Huevos', 5, 'unidades', NULL, 3),
        (recipe_id, 'Vainilla', 1, 'cucharadita', NULL, 4),
        (recipe_id, 'Azúcar para caramelo', 1, 'taza', NULL, 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Caramelizar molde.', 5),
        (recipe_id, 2, 'Licuar ambas leches, huevos y vainilla.', 2),
        (recipe_id, 3, 'Verter en molde. Hornear a baño maría 170°C por 45-50 min.', 50),
        (recipe_id, 4, 'Enfriar, refrigerar 4h, desmoldar.', 1);
        
        RAISE NOTICE '✅ Receta 44/73: Crema Volteada';
    END IF;
END $$;

-- RECETA 45: Champús de Guanábana
-- ================================================================ 
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Champús de Guanábana') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Champús de Guanábana',
            'Bebida caliente espesa norteña con frutas cocidas, mote tierno y especias. Textura suave.',
            20, 45, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('bebidas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, ' Guanábana', 2, 'tazas', 'Pulpa', 1),
        (recipe_id, 'Mote cocido', 1, 'taza', 'Muy suave', 2),
        (recipe_id, 'Piña', 1, 'taza', 'Picada', 3),
        (recipe_id, 'Chancaca', 200, 'g', NULL, 4),
        (recipe_id, 'Canela y clavo', NULL, 'al gusto', NULL, 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hervir agua con chancaca y especias.', 10),
        (recipe_id, 2, 'Agregar frutas picadas, cocinar hasta suaves.', 20),
        (recipe_id, 3, 'Añadir mote cocido, integrar.', 5),
        (recipe_id, 4, 'Servir caliente como bebida espesa.', 1);
        
        RAISE NOTICE '✅ Receta 45/73: Champús de Guanábana';
    END IF;
END $$;

-- RECETA 46: Dulce de Camote
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Dulce de Camote') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Dulce de Camote',
            'Camote cocido en almíbar de chancaca hasta traslúcido y confitado. Muy suave.',
            10, 35, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'facil');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Camote', 500, 'g', 'Amarillo', 1),
        (recipe_id, 'Chancaca', 250, 'g', NULL, 2),
        (recipe_id, 'Agua', 2, 'tazas', NULL, 3),
        (recipe_id, 'Canela y clavo', NULL, 'al gusto', NULL, 4);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar camote pelado hasta tierno.', 15),
        (recipe_id, 2, 'Hacer almíbar con chancaca, agua y especias.', 10),
        (recipe_id, 3, 'Agregar camote al almíbar, cocinar hasta confitar.', 20),
        (recipe_id, 4, 'Servir tibio o frío. Camote muy suave.', 1);
        
        RAISE NOTICE '✅ Receta 46/73: Dulce de Camote';
    END IF;
END $$;

-- RECETA 47: Machacado de Membrillo
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Machacado de Membrillo') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Machacado de Membrillo',
            'Dulce de corte de membrillo rico en pectina. Textura de jaleasuave.',
            15, 60, 8, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('postres', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Membrillos', 1, 'kg', NULL, 1),
        (recipe_id, 'Azúcar', 800, 'g', NULL, 2),
        (recipe_id, 'Agua', 2, 'tazas', NULL, 3);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar membrillos pelados hasta muy suaves.', 30),
        (recipe_id, 2, 'Machacar o licuar. Cocinar con azúcar.', 30),
        (recipe_id, 3, 'Cocinar hasta punto de corte. Verter en molde.', 20),
        (recipe_id, 4, 'Enfriar. Cortar en porciones. Textura de jalea.', 1);
        
        RAISE NOTICE '✅ Receta 47/73: Machacado de Membrillo';
    END IF;
END $$;

-- RECETA 48: Hummus con Pan Pita Blando
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Hummus con Pan Pita Blando') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Hummus con Pan Pita Blando',
            'Puré cremoso de garbanzos con tahini rico en magnesio. Pan tibio blando para acompañar.',
            10, 0, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('snacks', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-magnesio', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Garbanzos cocidos', 2, 'tazas', NULL, 1),
        (recipe_id, 'Tahini', 0.33, 'taza', NULL, 2),
        (recipe_id, 'Limón', 2, 'unidades', 'Jugo', 3),
        (recipe_id, 'Ajo', 2, 'dientes', NULL, 4),
        (recipe_id, 'Aceite de oliva', 0.25, 'taza', NULL, 5),
        (recipe_id, 'Comino', 0.5, 'cucharadita', NULL, 6),
        (recipe_id, 'Pan pita', 4, 'unidades', 'Tibio', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Licuar garbanzos, tahini, limón, ajo, aceite y comino hasta cremoso.', 5),
        (recipe_id, 2, 'Ajustar consistencia con agua si necesario.', 1),
        (recipe_id, 3, 'Calentar panes pita hasta tibios y suaves.', 2),
        (recipe_id, 4, 'Servir hummus con pan tibio para untar fácilmente.', 1);
        
        RAISE NOTICE '✅ Receta 48/73: Hummus con Pan Pita Blando';
    END IF;
END $$;



-- ================================================================
-- SECCIÓN 5: PROTEÍNAS ANIMALES
-- ================================================================

-- RECETA 49: Sangrecita Guisada
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Sangrecita Guisada') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Sangrecita Guisada',
            'Sangre de pollo coagulada friable que se desmorona fácilmente. Rica en hierro, textura suave.',
            10, 15, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-proteina', 'rapido');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Sangrecita de pollo', 500, 'g', 'Cocida y desmenuzada', 1),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada', 2),
        (recipe_id, 'Ajo', 2, 'dientes', NULL, 3),
        (recipe_id, 'Ají panca', 1, 'cucharada', 'Molido', 4),
        (recipe_id, 'Comino', 0.5, 'cucharadita', NULL, 5),
        (recipe_id, 'Aceite', 2, 'cucharadas', NULL, 6),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar sangrecita en agua hirviendo hasta que coagule completamente. Escurrir y desmenuzar.', 8),
        (recipe_id, 2, 'Sofreír cebolla, ajo y ají panca hasta suavizar.', 5),
        (recipe_id, 3, 'Agregar sangrecita desmenuzada, comino, sal y pimienta. Cocinar 5 minutos removiendo.', 5),
        (recipe_id, 4, 'Servir con arroz muy cocido. La sangrecita se desmenuza fácilmente sin masticación fuerte.', 1);
        
        RAISE NOTICE '✅ Receta 49/73: Sangrecita Guisada';
    END IF;
END $$;

-- RECETA 50: Patita con Maní
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Patita con Maní') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Patita con Maní',
            'Patas de res con colágeno hidrolizado en salsa cremosa de maní. Cocción prolongada hasta textura gelatinosa.',
            20, 240, 6, 'HARD', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'alto-proteina');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Patas de res', 1, 'kg', 'Limpias', 1),
        (recipe_id, 'Maní tostado', 1, 'taza', 'Molido', 2),
        (recipe_id, 'Cebolla', 2, 'unidades', NULL, 3),
        (recipe_id, 'Ajo', 4, 'dientes', NULL, 4),
        (recipe_id, 'Ají panca', 2, 'cucharadas', NULL, 5),
        (recipe_id, 'Caldo', 6, 'tazas', NULL, 6),
        (recipe_id, 'Papas', 4, 'unidades', NULL, 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar patas de res en olla a presión por 150 minutos hasta que la piel y tendones estén muy suaves.', 150),
        (recipe_id, 2, 'Retirar carne de los huesos. Debe desprenderse fácilmente. Picar en trozos pequeños.', 15),
        (recipe_id, 3, 'Sofreír cebolla, ajo y ají panca. Agregar maní molido y caldo.', 10),
        (recipe_id, 4, 'Añadir carne de patita y papas. Cocinar hasta que papas estén suaves y salsa espese.', 40),
        (recipe_id, 5, 'Servir caliente. La carne debe estar gelatinosa y muy tierna.', 1);
        
        RAISE NOTICE '✅ Receta 50/73: Patita con Maní';
    END IF;
END $$;

-- RECETA 51: Olluquito con Carne
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Olluquito con Carne') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Olluquito con Carne',
            'Tubérculo resbaladizo con mucílago natural y carne molida. Muy fácil de tragar.',
            20, 35, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional', 'textura-suave');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Olluco', 500, 'g', 'En juliana fina', 1),
        (recipe_id, 'Carne molida', 300, 'g', NULL, 2),
        (recipe_id, 'Cebolla', 1, 'unidad', NULL, 3),
        (recipe_id, 'Ajo', 2, 'dientes', NULL, 4),
        (recipe_id, 'Ají amarillo', 1, 'cucharada', NULL, 5),
        (recipe_id, 'Caldo', 1, 'taza', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Sofreír cebolla, ajo y ají amarillo.', 5),
        (recipe_id, 2, 'Agregar carne molida, cocinar hasta dorar.', 8),
        (recipe_id, 3, 'Añadir olluco en juliana y caldo. Cocinar hasta tierno (15-20 min).', 20),
        (recipe_id, 4, 'El olluco liberará mucílago y se volverá resbaladizo. Servir con arroz.', 1);
        
        RAISE NOTICE '✅ Receta 51/73: Olluquito con Carne';
    END IF;
END $$;

-- RECETA 52: Caigua Rellena
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Caigua Rellena') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Caigua Rellena',
            'Cucurbitácea tierna rellena de carne molida con pan remojado. Se cocina hasta muy suave.',
            30, 45, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'vegetales');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Caiguas', 8, 'unidades', NULL, 1),
        (recipe_id, 'Carne molida', 400, 'g', NULL, 2),
        (recipe_id, 'Pan remojado', 2, 'rebanadas', NULL, 3),
        (recipe_id, 'Cebolla', 1, 'unidad', NULL, 4),
        (recipe_id, 'Huevo', 1, 'unidad', NULL, 5),
        (recipe_id, 'Tomate', 2, 'unidades', 'Para salsa', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Limpiar caiguas, retirar semillas. Blanquear 5 minutos.', 8),
        (recipe_id, 2, 'Mezclar carne, pan exprimido, cebolla picada y huevo. Sazonar.', 10),
        (recipe_id, 3, 'Rellenar caiguas con la mezcla. Cerrar con palillos si necesario.', 12),
        (recipe_id, 4, 'Preparar salsa de tomate. Colocar caiguas, cocinar tapado 30-35 min hasta muy tiernas.', 35),
        (recipe_id, 5, 'Servir con salsa abundante. Caigua debe estar suave como para cortar con cuchara.', 1);
        
        RAISE NOTICE '✅ Receta 52/73: Caigua Rellena';
    END IF;
END $$;

-- RECETA 53: Seco de Res o Cabrito
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Seco de Res') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Seco de Res',
            'Guiso verde de culantro licuado con salsa abundante. Carne cocida hasta deshebrar.',
            25, 120, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Carne de res', 1, 'kg', 'En trozos', 1),
        (recipe_id, 'Culantro', 2, 'tazas', 'Licuado', 2),
        (recipe_id, 'Cerveza oscura', 1, 'botella', NULL, 3),
        (recipe_id, 'Cebolla', 2, 'unidades', NULL, 4),
        (recipe_id, 'Ají amarillo', 2, 'cucharadas', NULL, 5),
        (recipe_id, 'Arvejas', 1, 'taza', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Marinar carne con culantro licuado, cerveza y especias por 1 hora.', 60),
        (recipe_id, 2, 'Sofreír cebolla y ají. Agregar carne con marinada.', 10),
        (recipe_id, 3, 'Cocinar a fuego bajo tapado por 90-120 min hasta que carne esté muy tierna.', 120),
        (recipe_id, 4, 'Agregar arvejas, cocinar 10 min más. Servir con arroz y frejoles.', 10);
        
        RAISE NOTICE '✅ Receta 53/73: Seco de Res';
    END IF;
END $$;

-- RECETA 54: Estofado de Pollo o Res
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Estofado de Pollo') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Estofado de Pollo',
            'Piezas oscuras de pollo en salsa de tomate y zanahoria. Cocción lenta hasta caer del hueso.',
            20, 90, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'comfort-food');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Pollo', 1, 'kg', 'Piezas oscuras (muslos, piernas)', 1),
        (recipe_id, 'Zanahoria', 3, 'unidades', NULL, 2),
        (recipe_id, 'Tomate', 4, 'unidades', NULL, 3),
        (recipe_id, 'Cebolla', 2, 'unidades', NULL, 4),
        (recipe_id, 'Vino tinto', 1, 'taza', NULL, 5),
        (recipe_id, 'Caldo', 2, 'tazas', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Dorar piezas de pollo. Reservar.', 10),
        (recipe_id, 2, 'Sofreír cebolla, zanahoria y tomate hasta suavizar.', 10),
        (recipe_id, 3, 'Regresar pollo, agregar vino y caldo. Cocinar tapado 80-90 min.', 90),
        (recipe_id, 4, 'La carne debe desprenderse del hueso fácilmente. Servir con bastante salsa.', 1);
        
        RAISE NOTICE '✅ Receta 54/73: Estofado de Pollo';
    END IF;
END $$;

-- RECETA 55: Tallarines Rojos con Carne Molida
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Tallarines Rojos con Carne Molida') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Tallarines Rojos con Carne Molida',
            'Pasta bien cocida con salsa boloñesa peruana. Carne molida dos veces para máxima suavidad.',
            15, 35, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('pastas', 'carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'facil');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Tallarines', 400, 'g', NULL, 1),
        (recipe_id, 'Carne molida', 400, 'g', 'Molida dos veces', 2),
        (recipe_id, 'Tomate', 4, 'unidades', NULL, 3),
        (recipe_id, 'Cebolla', 1, 'unidad', NULL, 4),
        (recipe_id, 'Zanahoria', 1, 'unidad', NULL, 5),
        (recipe_id, 'Albahaca', 10, 'hojas', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Sofreír cebolla, zanahoria rallada. Agregar carne molida.', 10),
        (recipe_id, 2, 'Añadir tomates licuados, albahaca. Cocinar 20-25 min.', 25),
        (recipe_id, 3, 'Cocinar pasta 2-3 min extra para que esté muy suave.', 12),
        (recipe_id, 4, 'Mezclar pasta con salsa abundante. Servir caliente.', 1);
        
        RAISE NOTICE '✅ Receta 55/73: Tallarines Rojos con Carne Molida';
    END IF;
END $$;



-- RECETA 56: Hígado Encebollado
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Hígado Encebollado') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Hígado Encebollado',
            'Hígado de res cocido suave con cebolla caramelizada. Rico en hierro y muy tierno si no se sobrecocina.',
            10, 20, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-proteina', 'rapido');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Hígado de res', 500, 'g', 'En láminas delgadas', 1),
        (recipe_id, 'Cebolla', 3, 'unidades', 'En pluma', 2),
        (recipe_id, 'Ajo', 3, 'dientes', NULL, 3),
        (recipe_id, 'Vinagre', 2, 'cucharadas', NULL, 4),
        (recipe_id, 'Aceite', 3, 'cucharadas', NULL, 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Remojar hígado en leche o agua con vinagre 15 min para quitar sabor fuerte. Escurrir.', 15),
        (recipe_id, 2, 'Carame lizar cebollas a fuego medio hasta doradas y suaves.', 15),
        (recipe_id, 3, 'Subir fuego, agregar hígado. Cocinar SOLO 3-4 minutos por lado. NO sobrecocinar o queda duro.', 8),
        (recipe_id, 4, 'Servir inmediatamente con arroz. El hígado debe estar rosado al centro y muy tierno.', 1);
        
        RAISE NOTICE '✅ Receta 56/73: Hígado Encebollado';
    END IF;
END $$;

-- RECETA 57: Adobo Arequipeño
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Adobo Arequipeño') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Adobo Arequipeño',
            'Cerdo marinado en chicha y especias. Cocción lenta hasta caer de los huesos.',
            240, 120, 6, 'HARD', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Cerdo', 1, 'kg', 'Costilla o paleta', 1),
        (recipe_id, 'Chicha de jora', 2, 'tazas', NULL, 2),
        (recipe_id, 'Ají panca', 4, 'cucharadas', NULL, 3),
        (recipe_id, 'Comino', 1, 'cucharada', NULL, 4),
        (recipe_id, 'Cebolla', 2, 'unidades', NULL, 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Marinar cerdo con chicha, ají panca, comino y ajo machacado. Refrigerar 4 horas o toda la noche.', 240),
        (recipe_id, 2, 'Cocinar a fuego bajo con toda la marinada por 90-120 min hasta que carne esté muy tierna.', 120),
        (recipe_id, 3, 'Servir con pan marraqueta tibio. La carne debe deshacerse al contacto.', 1);
        
        RAISE NOTICE '✅ Receta 57/73: Adobo Arequipeño';
    END IF;
END $$;

-- RECETA 58: Picante de Carne
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Picante de Carne') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Picante de Carne',
            'Carne molida en base de papa licuada y maní. Salsa espesa y cremosa rojiza.',
            20, 45, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Carne molida', 500, 'g', NULL, 1),
        (recipe_id, 'Papas', 4, 'unidades', 'Cocidas y licuadas', 2),
        (recipe_id, 'Maní', 0.5, 'taza', 'Molido', 3),
        (recipe_id, 'Ají panca', 2, 'cucharadas', NULL, 4),
        (recipe_id, 'Cebolla', 2, 'unidades', NULL, 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar papas, licuar con un poco de caldo hasta puré líquido.', 20),
        (recipe_id, 2, 'Sofreír cebolla, ají panca. Agregar carne molida.', 10),
        (recipe_id, 3, 'Añadir puré de papa, maní molido. Cocinar hasta espesar.', 20),
        (recipe_id, 4, 'Servir con arroz. Textura cremosa tipo guiso espeso.', 1);
        
        RAISE NOTICE '✅ Receta 58/73: Picante de Carne';
    END IF;
END $$;

-- RECETA 59: Chanfainita de Bofe
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Chanfainita de Bofe') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Chanfainita de Bofe',
            'Pulmón de res cortado muy pequeño en guiso rojo. Textura esponjosa que absorbe salsa.',
            30, 90, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('carnes', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Bofe (pulmón)', 500, 'g', 'Cortado en cubos pequeños', 1),
        (recipe_id, 'Papas', 3, 'unidades', NULL, 2),
        (recipe_id, 'Cebolla', 2, 'unidades', NULL, 3),
        (recipe_id, 'Ají panca', 2, 'cucharadas', NULL, 4),
        (recipe_id, 'Caldo', 3, 'tazas', NULL, 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Precocinar bofe en agua hirviendo 30 min. Escurrir, cortar en cubos muy pequeños (0.5cm).', 35),
        (recipe_id, 2, 'Sofreír cebolla, ají panca. Agregar bofe picado.', 10),
        (recipe_id, 3, 'Añadir caldo y papas. Cocinar 40-45 min hasta espeso. El bofe absorbe líquido como esponja.', 45),
        (recipe_id, 4, 'Servir con arroz. Textura debe ser tierna y jugosa.', 1);
        
        RAISE NOTICE '✅ Receta 59/73: Chanfainita de Bofe';
    END IF;
END $$;

-- ================================================================
-- SECCIÓN 6: PESCADOS Y MARISCOS
-- ================================================================

-- RECETA 60: Sudado de Pescado
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Sudado de Pescado') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Sudado de Pescado',
            'Pescado blanco cocido al vapor en su propio jugo con tomate y cebolla. Carne desmenu zable.',
            15, 25, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('pescados-mariscos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'rico-omega3', 'facil');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Filete de corvina o lenguado', 600, 'g', NULL, 1),
        (recipe_id, 'Tomate', 3, 'unidades', 'Picados', 2),
        (recipe_id, 'Cebolla', 2, 'unidades', 'En pluma', 3),
        (recipe_id, 'Ají amarillo', 1, 'cucharada', NULL, 4),
        (recipe_id, 'Chicha de jora', 0.5, 'taza', NULL, 5),
        (recipe_id, 'Culantro', 0.25, 'taza', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'En olla, colocar capa de cebolla y tomate.', 2),
        (recipe_id, 2, 'Colocar filetes encima, cubrir con más tomate, cebolla y ají.', 3),
        (recipe_id, 3, 'Agregar chicha, tapar herméticamente. Cocinar a fuego medio 20-25 min sin destapar.', 25),
        (recipe_id, 4, 'Agregar culantro al final. El pescado debe desmenuzarse solo con la presión de tenedor.', 1);
        
        RAISE NOTICE '✅ Receta 60/73: Sudado de Pescado';
    END IF;
END $$;

-- RECETA 61: Escabeche de Pescado Hervido
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Escabeche de Pescado Hervido') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Escabeche de Pescado Hervido',
            'Pescado hervido suave con salsa de cebolla en vinagre. Se omiten piezas crocantes.',
            20, 30, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('pescados-mariscos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'rico-omega3');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Pescado blanco', 600, 'g', 'Filetes', 1),
        (recipe_id, 'Cebolla morada', 3, 'unidades', 'En pluma', 2),
        (recipe_id, 'Vinagre', 0.5, 'taza', NULL, 3),
        (recipe_id, 'Ají amarillo', 2, 'cucharadas', NULL, 4),
        (recipe_id, 'Camote', 2, 'unidades', 'Cocido', 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hervir pescado en agua con sal hasta cocido (8-10 min). NO freír. Reservar.', 10),
        (recipe_id, 2, 'Marchitar cebolla con sal 10 min. Lavar y escurrir.', 12),
        (recipe_id, 3, 'Saltear ají amarillo, agregar vinagre y cebolla. Cocinar 5 min.', 8),
        (recipe_id, 4, 'Servir pescado hervido con la salsa de cebolla encima y camote. Todo debe estar suave.', 1);
        
        RAISE NOTICE '✅ Receta 61/73: Escabeche de Pescado Hervido';
    END IF;
END $$;

-- RECETA 62: Pescado a la Chorrillana Pochado
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Pescado a la Chorrillana Pochado') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Pescado a la Chorrillana Pochado',
            'Pescado pochado con salsa criolla de tomate. Versión sin fritura para DTM.',
            15, 20, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('pescados-mariscos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'rico-omega3', 'facil');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Filete de lenguado', 600, 'g', NULL, 1),
        (recipe_id, 'Tomate', 4, 'unidades', NULL, 2),
        (recipe_id, 'Cebolla', 2, 'unidades', NULL, 3),
        (recipe_id, 'Ají amarillo', 1, 'cucharada', NULL, 4),
        (recipe_id, 'Vino blanco', 0.25, 'taza', NULL, 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Pochar filetes en agua con vino y limón 8-10 min. Reservar.', 10),
        (recipe_id, 2, 'Saltear tomate y cebolla hasta suavizar.', 8),
        (recipe_id, 3, 'Agregar ají amarillo. Cocinar hasta salsa espesa.', 5),
        (recipe_id, 4, 'Servir pescado pochado con salsa abundante encima. Arroz como acompañamiento.', 1);
        
        RAISE NOTICE '✅ Receta 62/73: Pescado a la Chorrillana Pochado';
    END IF;
END $$;



-- RECETA 63: Sudado de Tramboyo
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Sudado de Tramboyo') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Sudado de Tramboyo',
            'Raya desmenuz able muy suave en salsa de mariscos. Rico en colágeno y gelatina natural.',
            20, 30, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('pescados-mariscos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'rico-omega3');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Tramboyo (raya)', 600, 'g', NULL, 1),
        (recipe_id, 'Tomate', 3, 'unidades', NULL, 2),
        (recipe_id, 'Cebolla', 2, 'unidades', NULL, 3),
        (recipe_id, 'Chicha', 0.5, 'taza', NULL, 4);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Preparar como sudado de pescado. La raya se desmenuza fácilmente.', 30);
        
        RAISE NOTICE '✅ Receta 63/73: Sudado de Tramboyo';
    END IF;
END $$;

-- RECETA 64: Quinoto de Pescado
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Quinoto de Pescado') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Quinoto de Pescado',
            'Sopa espesa de pescado y quinua. Textura cremosa nutritiva.',
            15, 40, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('sopas-cremas', 'pescados-mariscos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'rico-omega3', 'alto-proteina');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Pescado blanco', 400, 'g', NULL, 1),
        (recipe_id, 'Quinua', 0.5, 'taza', NULL, 2),
        (recipe_id, 'Papas', 2, 'unidades', NULL, 3),
        (recipe_id, 'Caldo', 4, 'tazas', NULL, 4);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar quinua con caldo y papas hasta suave.', 20),
        (recipe_id, 2, 'Agregar pescado, cocinar 15 min. Desmenuzar pescado en la sopa.', 15);
        
        RAISE NOTICE '✅ Receta 64/73: Quinoto de Pescado';
    END IF;
END $$;

-- ================================================================
-- SECCIÓN 7: VEGETALES Y GUARNICIONES
-- ================================================================

-- RECETA 65: Quinua Atamalada
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Quinua Atamalada') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Quinua Atamalada',
            'Quinua cocida en exceso de agua hasta cremosa tipo atole. Rica en magnesio.',
            5, 25, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('acompañamientos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-magnesio', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Quinua', 1, 'taza', NULL, 1),
        (recipe_id, 'Agua', 4, 'tazas', 'Exceso intencional', 2),
        (recipe_id, 'Sal', 1, 'cucharadita', NULL, 3);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Lavar quinua. Cocinar con exceso de agua removiendo frecuentemente hasta cremosa (20-25 min).', 25);
        
        RAISE NOTICE '✅ Receta 65/73: Quinua Atamalada';
    END IF;
END $$;

-- RECETA 66: Pastel de Acelga
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Pastel de Acelga') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Pastel de Acelga',
            'Tipo quiche con acelga picada muy fina y queso. Horneado hasta suave.',
            20, 40, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('vegetariano', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Acelga', 500, 'g', 'Picada muy fino', 1),
        (recipe_id, 'Huevos', 4, 'unidades', NULL, 2),
        (recipe_id, 'Q ueso', 200, 'g', NULL, 3),
        (recipe_id, 'Leche', 1, 'taza', NULL, 4);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Blanquear acelga, picar muy fino.', 10),
        (recipe_id, 2, 'Mezclar con huevos, leche, queso. Hornear 180°C por 35-40 min.', 40);
        
        RAISE NOTICE '✅ Receta 66/73: Pastel de Acelga';
    END IF;
END $$;

-- RECETA 67: Pastel de Coliflor
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Pastel de Coliflor') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Pastel de Coliflor',
            'Coliflor bien cocida mezclada con salsa bechamel y queso gratinado.',
            20, 45, 6, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('vegetariano', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Coliflor', 1, 'unidad', 'Grande', 1),
        (recipe_id, 'Bechamel', 2, 'tazas', NULL, 2),
        (recipe_id, 'Queso', 150, 'g', NULL, 3);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar coliflor hasta muy suave. Colocar en molde.', 20),
        (recipe_id, 2, 'Cubrir con bechamel y queso. Hornear hasta gratinar (no crocante).', 25);
        
        RAISE NOTICE '✅ Receta 67/73: Pastel de Coliflor';
    END IF;
END $$;

-- RECETA 68: Puré de Espinaca
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Puré de Espinaca') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Puré de Espinaca',
            'Espinaca licuada con papa para dar cuerpo. Verde brillante rico en magnesio.',
            10, 20, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('acompañamientos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-magnesio', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Espinaca', 500, 'g', NULL, 1),
        (recipe_id, 'Papa', 2, 'unidades', NULL, 2),
        (recipe_id, 'Leche', 0.5, 'taza', NULL, 3);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocinar espinaca y papa. Licuar con leche hasta completamente liso.', 20);
        
        RAISE NOTICE '✅ Receta 68/73: Puré de Espinaca';
    END IF;
END $$;

-- RECETA 69: Escribano Arequipeño
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Escribano Arequipeño') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Escribano Arequipeño',
            'Ensalada tibia de papas con verduras muy picadas. Todo cocido.',
            15, 20, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('ensaladas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Papas', 4, 'unidades', 'Cocidas', 1),
        (recipe_id, 'Habas', 1, 'taza', 'Peladas y cocidas', 2),
        (recipe_id, 'Tomate', 2, 'unidades', 'Sin piel ni semillas', 3),
        (recipe_id, 'Queso fresco', 150, 'g', NULL, 4);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Picar todos los ingredientes MUY pequeños. Mezclar tibio con aceite y limón.', 15);
        
        RAISE NOTICE '✅ Receta 69/73: Escribano Arequipeño';
    END IF;
END $$;

-- RECETA 70: Causa Rellena de Beterrada
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Causa Rellena de Beterraga') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Causa Rellena de Beterraga',
            'Variante rosada de causa con beterraga licuada. Sabor dulce terroso.',
            25, 20, 4, 'MEDIUM', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('almuerzos', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'vegetariano');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Papa amarilla', 1, 'kg', NULL, 1),
        (recipe_id, 'Beterraga', 2, 'unidades', 'Cocidas y licuadas', 2),
        (recipe_id, 'Limón', 3, 'unidades', NULL, 3),
        (recipe_id, 'Queso', 200, 'g', 'Relleno', 4);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hacer puré de papa, mezclar con beterraga licuada y limón.', 20),
        (recipe_id, 2, 'Armar en capas como causa tradicional. Refrigerar.', 120);
        
        RAISE NOTICE '✅ Receta 70/73: Causa Rellena de Beterraga';
    END IF;
END $$;

-- ================================================================
-- SECCIÓN 8: BEBIDAS ADICIONALES
-- ================================================================

-- RECETA 71: Siete Semillas
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Siete Semillas') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Siete Semillas',
            'Bebida energética de semillas tostadas y molidas. Rico en minerales y omega.',
            10, 20, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('bebidas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'alto-magnesio', 'rico-omega3');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Linaza', 2, 'cucharadas', NULL, 1),
        (recipe_id, 'Ajonjolí', 2, 'cucharadas', NULL, 2),
        (recipe_id, 'Chia', 1, 'cucharada', NULL, 3),
        (recipe_id, 'Quinua', 2, 'cucharadas', NULL, 4),
        (recipe_id, 'Cebada', 2, 'cucharadas', NULL, 5),
        (recipe_id, 'Avena', 2, 'cucharadas', NULL, 6),
        (recipe_id, 'Trigo', 2, 'cucharadas', NULL, 7),
        (recipe_id, 'Agua', 4, 'tazas', NULL, 8),
        (recipe_id, 'Miel', 3, 'cucharadas', NULL, 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Tostar ligeramente todas las semillas por separado.', 10),
        (recipe_id, 2, 'Hervir en agua por 15-20 min. Colar y edulcorar con miel.', 20),
        (recipe_id, 3, 'Servir tibio o frío. Bebida nutritiva reconstituyente.', 1);
        
        RAISE NOTICE '✅ Receta 71/73: Siete Semillas';
    END IF;
END $$;

-- RECETA 72: Maca Cocida con Leche
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Maca Cocida con Leche') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Maca Cocida con Leche',
            'Raíz andina medicinal cocida en leche. Reconstituyente energético.',
            5, 25, 2, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('bebidas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Maca en polvo', 2, 'cucharadas', NULL, 1),
        (recipe_id, 'Leche', 2, 'tazas', NULL, 2),
        (recipe_id, 'Miel', 2, 'cucharadas', NULL, 3),
        (recipe_id, 'Canela', 1, 'rama', NULL, 4);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hervir leche con canela.', 5),
        (recipe_id, 2, 'Agregar maca en polvo, batir bien. Cocinar 5 min removiendo.', 10),
        (recipe_id, 3, 'Edulcorar con miel. Servir caliente como bebida nutritiva.', 1);
        
        RAISE NOTICE '✅ Receta 72/73: Maca Cocida con Leche';
    END IF;
END $$;

-- RECETA 73: Emoliente Fortificado
-- ================================================================
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = 'Emoliente Fortificado') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            'Emoliente Fortificado',
            'Infusión de hierbas medicinales con linaza y cebada. Bebida reconfortante digestiva.',
            10, 30, 4, 'EASY', TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id)
        SELECT recipe_id, id FROM categories WHERE slug IN ('bebidas', 'dtm-terapeutico');
        
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'antiinflamatorio', 'tradicional');
        
        INSERT INTO ingredients (recipe_id, name, quantity, unit, notes, sort_order) VALUES
        (recipe_id, 'Linaza', 3, 'cucharadas', NULL, 1),
        (recipe_id, 'Cebada tostada', 2, 'cucharadas', NULL, 2),
        (recipe_id, 'Cola de caballo', 1, 'cucharada', NULL, 3),
        (recipe_id, 'Boldo', 3, 'hojas', NULL, 4),
        (recipe_id, 'Agua', 6, 'tazas', NULL, 5),
        (recipe_id, 'Limón', 2, 'unidades', 'Jugo', 6),
        (recipe_id, 'Miel', 3, 'cucharadas', NULL, 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Tostar cebada si no está tostada.', 5),
        (recipe_id, 2, 'Hervir todos los ingredientes secos en agua por 25-30 min.', 30),
        (recipe_id, 3, 'Colar. Agregar limón y miel al gusto.', 2),
        (recipe_id, 4, 'Servir caliente. Bebida digestiva y antiinflamatoria perfecta para DTM.', 1);
        
        RAISE NOTICE '✅ Receta 73/73: Emoliente Fortificado - ¡TODAS LAS RECETAS DTM COMPLETAS!';
    END IF;
END $$;












-- ================================================================
-- VER IFICACIÓN FINAL
-- ================================================================
DO $$
BEGIN
    RAISE NOTICE '================================';
    RAISE NOTICE '📊 Recetas DTM cargadas: %', (SELECT COUNT(*) FROM recipes WHERE id IN (
        SELECT recipe_id FROM recipe_categories WHERE category_id = (
            SELECT id FROM categories WHERE slug = 'dtm-terapeutico'
        )
    ));
    RAISE NOTICE '================================';
END $$;
