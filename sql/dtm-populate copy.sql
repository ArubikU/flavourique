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
        (recipe_id, 'Avena en hojuelas', 1, 'taza', 'Avena tradicional, no instantánea', 1),
        (recipe_id, 'Leche entera o bebida vegetal', 2.5, 'tazas', 'Leche entera para mejor cremosidad, o leche de almendras/avena', 2),
        (recipe_id, 'Plátano maduro', 1, 'unidad', 'Grande, muy maduro con manchas marrones (más dulce y suave)', 3),
        (recipe_id, 'Miel de abeja pura', 2, 'cucharadas', 'Puede ajustarse según dulzor del plátano', 4),
        (recipe_id, 'Canela en polvo', 0.5, 'cucharadita', 'Preferiblemente canela de Ceylon', 5),
        (recipe_id, 'Sal marina', 1, 'pizca', 'Realza el sabor dulce', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'En una olla mediana, combinar la avena con la leche fría y la pizca de sal. Mezclar bien antes de encender el fuego para evitar grumos. Llevar a fuego medio-bajo.', 2),
        (recipe_id, 2, 'Cocinar removiendo constantemente con cuchara de madera en movimientos circulares para evitar que se pegue al fond o. La avena irá absorbiendo el líquido gradualmente. Cuando empiece a espesar (aproximadamente a los 5 minutos), reducir el fuego a bajo. Continuar cocinando hasta que la avena esté completamente deshecha y la mezcla tenga una consistencia cremosa como crema espesa - NO debe quedar al dente ni con textura granular. El tiempo total es de 8-10 minutos.', 10),
        (recipe_id, 3, 'Mientras la avena cocina, preparar el plátano: pelar y colocar en un bowl. Aplastar vigorosamente con un tenedor hasta formar un puré completamente liso y homogéneo, sin ningún trozo visible ni grumos. Si el plátano está muy maduro, se convertirá casi en líquido, lo cual es ideal.', 2),
        (recipe_id, 4, 'Cuando la avena alcance la textura deseada (cremosa y sin granos visibles), retirar del fuego. Incorporar inmediatamente el puré de plátano y mezclar enérgicamente hasta integrar completamente. El calor de la avena ayudará a suavizar aún más el plátano.', 1),
        (recipe_id, 5, 'Agregar la miel y la canela en polvo. Mezclar hasta distribuir uniformemente. Probar y ajustar dulzor si es necesario. Servir tibio en bowls, asegurándose de que la textura sea sedosa, cremosa y totalmente suave - debe poder comerse sin masticar, deslizándose fácilmente por la garganta.', 1);
        
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
        (recipe_id, 'Quinua', 0.5, 'taza', 'Blanca, roja o tricolor - debe lavarse muy bien', 1),
        (recipe_id, 'Agua filtrada', 4, 'tazas', 'Más 1 taza adicional si se reduce mucho', 2),
        (recipe_id, 'Manzana roja', 1, 'unidad', 'Mediana, pelada y picada en cubos de 1cm', 3),
        (recipe_id, 'Piña madura', 1, 'taza', 'Fresca, en trozos pequeños de 1cm', 4),
        (recipe_id, 'Canela en rama', 2, 'unidades', 'De aproximadamente 5cm cada una', 5),
        (recipe_id, 'Clavo de olor entero', 3, 'unidades', 'Para infusión aromática', 6),
        (recipe_id, 'Azúcar blanca o miel de abeja', NULL, 'al gusto', 'Empezar con 3-4 cucharadas y ajustar', 7);
        
        INSERT INTO steps (recipe_id,step_number, description, duration) VALUES
        (recipe_id, 1, 'Colocar la quinua en un colador de malla fina. Enjuagar vigorosamente bajo el chorro de agua fría durante 2-3 minutos, frotando los granos con las manos. Continuar lavando hasta que el agua salga completamente clara y sin espuma - esto elimina las saponinas naturales que dan sabor amargo. Escurrir muy bien.', 3),
        (recipe_id, 2, 'En una olla grande (preferiblemente de fondo grueso), colocar la quinua lavada junto con las 4 tazas de agua filtrada. Agregar los cubos de manzana y piña, las ramas de canela y los clavos de olor enteros. Remover para distribuir los ingredientes uniformemente.', 2),
        (recipe_id, 3, 'Llevar la mezcla a ebullición a fuego alto sin tapar, removiendo ocasionalmente. Una vez que hierva, reducir inmediatamente el fuego a medio-bajo. Cocinar durante 20-25 minutos, removiendo cada 5 minutos. La quinua debe abrirse completamente (verás un pequeño espiral blanco), volverse muy suave  y casi transparente. Las frutas deben desintegrarse completamente, mezclándose con el líquido. Si el agua se reduce demasiado, agregar media taza más de agua caliente.', 25),
        (recipe_id, 4, 'Probar y endulzar al gusto con azúcar o miel. Empezar con 3 cucharadas, mezclar bien, probar y agregar más si se desea. La bebida debe tener un dulzor agradable que equilibre el sabor de las frutas.', 1),
        (recipe_id, 5, 'Servir caliente en tazones o tazas grandes. La textura debe ser la de una bebida espesa y reconfortante - lo suficientemente densa para comerse con cuchara como una sopa dulce, pero también puede beberse. Los granos de quinua deben estar tan suaves que se deshagan al menor contacto con la lengua.', 1);
        
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
        (recipe_id, 'Huevos grandes', 3, 'unidades', 'Frescos, a temperatura ambiente', 1),
        (recipe_id, 'Queso ricotta o queso fresco', 3, 'cucharadas', 'El ricotta da más cremosidad; queso fresco es más accesible', 2),
        (recipe_id, 'Mantequilla sin sal', 1, 'cucharada', 'Preferiblemente europea (mayor contenido graso)', 3),
        (recipe_id, 'Leche entera', 2, 'cucharadas', 'Para mayor cremosidad y textura sedosa', 4),
        (recipe_id, 'Sal fina', 1, 'pizca', 'Al gusto, sal de mar o del Himalaya', 5),
        (recipe_id, 'Pimienta blanca molida', 1, 'pizca', 'Opcional, más suave que la negra', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'En un bowl mediano, batir los huevos junto con la leche, una pequeña pizca de sal y pimienta blanca (si se usa) usando un tenedor o batidor de alambre. Batir vigorosamente durante 30-40 segundos hasta que la mezcla esté completamente homogénea, espumosa y de color amarillo uniforme - no deben verse hebras de clara o yema separadas.', 2),
        (recipe_id, 2, 'Calentar una sartén antiadherente de tamaño mediano a fuego MUY BAJO (2 de 10 en escala de calor). Agregar la mantequilla y dejarla derretir lentamente hasta que esté completamente líquida y cubra el fondo de la sartén, pero SIN que burbujee ni se dore. Esto es crucial para huevos cremosos.', 1),
        (recipe_id, 3, 'Verter los huevos batidos en la sartén. NO remover inmediatamente. Esperar 15-20 segundos hasta que los bordes comiencen a cuajar ligeramente. Luego, usando una espátula de silicona, comenzar a remover muy suavemente con movimientos lentos y amplios desde el exterior hacia el centro, levantando y doblando - NO revolver agitadamente. Continuar cocinando a fuego muy lento, removiendo cada 10-15 segundos. El proceso completo toma 5-6 minutos.', 5),
        (recipe_id, 4, 'Cuando los huevos estén semicuajados pero aún muy húmedos y brillantes (aproximadamente 70% cocidos), agregar el queso ricotta en pequeñas cucharadas repartidas por toda la sartén. Mezclar muy delicadamente con movimientos envolventes para distribuir el queso sin romper demasiado la cuajada de huevo. El ricotta se suavizará con el calor residual.', 2),
        (recipe_id, 5, 'Retirar la sartén del fuego cuando los huevos aún luzcan ligeramente húmedos y brillantes (se terminarán de cocinar con el calor residual). La textura final debe ser la de cuajada cremosa y suave, con trozos irregulares de huevo muy tiernos mezclados con el queso fundido. NUNCA deben quedar secos, gomosos o con líquido separado. Servir inmediatamente en platos tibios - los huevos se enfrían rápido y pierden textura.', 1);
        
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
        (recipe_id, 'Papaya madura', 1.5, 'tazas', 'Muy madura, de pulpa naranja intenso, en cubos sin semillas negras', 1),
        (recipe_id, 'Plátano maduro', 1, 'unidad', 'Grande, con manchas marrones, congelado opcional para textura más cremosa', 2),
        (recipe_id, 'Avena en hojuelas', 0.25, 'taza', 'Avena tradicional - aporta fibra soluble y energía', 3),
        (recipe_id, 'Leche entera o bebida vegetal', 1, 'taza', 'Leche de almendras, avena o coco funcionan bien', 4),
        (recipe_id, 'Miel de abeja pura', 1, 'cucharada', 'Opcional - depende del dulzor natural de las frutas', 5),
        (recipe_id, 'Hielo triturado', 0.5, 'taza', 'Opcional, para servir frío y con textura más espesa', 6),
        (recipe_id, 'Semillas de chía', 1, 'cucharadita', 'Opcional, para omega-3 adicional - dejar hidratar 5 min', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Preparar los ingredientes: cortar la papaya madura en cubos de aproximadamente 2-3cm, desechando todas las semillas negras. Pelar el plátano. Si se desea textura más fría y cremosa tipo helado, puede usarse plátano previamente congelado en rodajas. Medir la avena y la leche.', 1),
        (recipe_id, 2, 'Colocar todos los ingredientes en una licuadora de alta potencia en este orden: primero la leche (líquidos primero facilitan el licuado), luego la papaya y el plátano, después la avena, finalmente la miel y el hielo si se usa. Este orden ayuda a que las cuchillas trabajen mejor.', 1),
        (recipe_id, 3, 'Licuar a velocidad BAJA durante 30 segundos para romper los trozos grandes. Luego aumentar a velocidad MÁXIMA y licuar continuamente durante 2-3 minutos completos sin parar. La mezcla debe transformarse en un líquido completamente liso, sedoso y uniforme, sin ningún punto de fibra visible, grumos de avena o trozos de fruta. Detener ocasionalmente para verificar la textura - si se detectan partículas, continuar licuando 1-2 minutos más.', 3),
        (recipe_id, 4, 'Verificar la consistencia: debe ser bebible pero con cuerpo - no demasiado líquido ni demasiado espeso. Si está muy espeso (difícil de verter), agregar leche en incrementos de 2 cucharadas, licuando 20 segundos más después de cada adición. Si está muy líquido, agregar más plátano o un par de cubos de hielo.', 1),
        (recipe_id, 5, 'OPCIONAL para DTM severo: Para eliminar completamente cualquier fibra residual, colar el smoothie a través de un colador de malla fina, presionando con una cuchara para extraer todo el líquido. Esto dará una textura aún más sedosa.', 1),
        (recipe_id, 6, 'Servir inmediatamente en vasos altos. La textura final debe ser sedosa, aterciopelada y muy fácil de tragar sin ninguna sensación de fibras o grumos en la garganta. Debe deslizarse suavemente sin necesidad de masticar. Consumir de inmediato ya que la avena puede seguir absorbiendo líquido y espesar el smoothie con el tiempo.', 1);
        
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
        (recipe_id, 'Yogur griego natural', 1, 'taza', 'Sin azúcar añadido, alto en proteínas y textura espesa', 1),
        (recipe_id, 'Aguaymanto fresco', 0.5, 'taza', 'Lavado y sin cáliz (hoja protectora)', 2),
        (recipe_id, 'Miel de abeja', 1, 'cucharada', 'Para equilibrar la acidez del aguaymanto', 3),
        (recipe_id, 'Extracto de vainilla', 0.25, 'cucharadita', 'Opcional, para aroma', 4),
        (recipe_id, 'Hoja de menta', 1, 'unidad', 'Solo para infundir sabor (retirar al comer)', 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Preparación del aguaymanto: Lavar bien los frutos. Colocarlos en una licuadora pequeña o procesador de alimentos. Triturar hasta obtener un puré rústico.', 2),
        (recipe_id, 2, 'Colado (Paso Crítico DTM): Pasar el puré de aguaymanto por un colador de malla fina para retirar TODAS las semillas pequeñas. Presionar con una cuchara para extraer todo el jugo y la pulpa suave. Desechar las semillas. La textura debe quedar como una salsa espesa y limpia.', 3),
        (recipe_id, 3, 'Mezclar la pulpa colada de aguaymanto con la miel y la vainilla hasta integrar bien.', 1),
        (recipe_id, 4, 'En un bowl o vaso, servir el yogur griego frío. Crear un hueco en el centro o colocar el puré de aguaymanto por encima.', 1),
        (recipe_id, 5, 'Mezclar suavemente con la cuchara antes de consumir para integrar sabores. La textura final es cremosa y suave, sin semillas que puedan molestar al masticar.', 1);
        
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
        (recipe_id, 'Habas secas', 1, 'taza', 'Deben remojarse toda la noche (mínimo 8 horas)', 1),
        (recipe_id, 'Leche evaporada', 1, 'taza', 'Para dar cuerpo y cremosidad final', 2),
        (recipe_id, 'Agua', 4, 'tazas', 'Para la cocción de las habas', 3),
        (recipe_id, 'Azúcar rubia o blanca', 0.5, 'taza', 'Ajustar al gusto', 4),
        (recipe_id, 'Canela', 1, 'rama', 'Entera para aromatizar', 5),
        (recipe_id, 'Clavo de olor', 2, 'unidades', 'Enteros, retirar al final', 6),
        (recipe_id, 'Esencia de vainilla', 1, 'cucharadita', 'Añadir al final', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Pelado inicial: Un día antes, remojar las habas secas en abundante agua (8-12 horas). Al día siguiente, retirar la cáscara gruesa de cada haba una por una. Este paso es fundamental para obtener una textura fina y evitar fibras duras.', 15),
        (recipe_id, 2, 'Cocción: En una olla, colocar las habas ya peladas (sin cáscara) con las 4 tazas de agua, la rama de canela y los clavos de olor. Llevar a ebullición y cocinar a fuego medio hasta que las habas estén tan suaves que se deshagan al tacto (aprox 20-25 minutos).', 25),
        (recipe_id, 3, 'Licuado: Retirar la canela y los clavos. Dejar entibiar un poco. Licuar las habas con su propia agua de cocción hasta obtener una crema muy lisa y homogénea. No debe quedar ningún trozo entero.', 3),
        (recipe_id, 4, 'Cocción final: Regresar la crema licuada a la olla. Añadir el azúcar y cocinar a fuego bajo, moviendo constantemente para que no se pegue, hasta que tome punto de ponche (ligeramente espeso).', 8),
        (recipe_id, 5, 'Acabado: Incorporar la leche evaporada y la esencia de vainilla. Mezclar bien y apagar el fuego (no dejar hervir vigorosamente después de echar la leche).', 2),
        (recipe_id, 6, 'Servir caliente en tazas. La textura debe ser sedosa, densa y nutritiva, similar a un atole fino.', 1);
        
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
        (recipe_id, 'Zapallo macre', 400,  'g', 'Pelado, sin semillas y en cubos medianos', 1),
        (recipe_id, 'Zapallo loche', 200, 'g', 'Con cáscara lavada (aporta sabor) o pelado para textura más lisa', 2),
        (recipe_id, 'Papa amarilla', 2, 'unidades', 'Medianas, peladas y en cuartos (para espesar)', 3),
        (recipe_id, 'Cebolla blanca', 0.5, 'unidad', 'Picada en trozos (se va a licuar)', 4),
        (recipe_id, 'Ajo', 2, 'dientes', 'Chancados o picados', 5),
        (recipe_id, 'Caldo de verduras o pollo', 4, 'tazas', 'Casero o bajo en sodio preferiblemente', 6),
        (recipe_id, 'Leche evaporada', 0.5, 'taza', 'Para dar cremosidad final', 7),
        (recipe_id, 'Aceite de oliva', 1, 'cucharada', 'Para el aderezo base', 8),
        (recipe_id, 'Queso fresco', 50, 'g', 'Opcional, para decorar en cubitos diminutos o rallado', 9),
        (recipe_id, 'Sal y pimienta blanca', NULL, 'al gusto', 'Pimienta blanca es más sutil y estética en cremas claras', 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Aderezo base: En una olla grande, calentar el aceite a fuego medio. Agregar la cebolla y el ajo. Sofreír por 4-5 minutos hasta que la cebolla esté transparente y fragante, sin dejar que se dore demasiado.', 5),
        (recipe_id, 2, 'Cocción de vegetales: Incorporar los cubos de zapallo macre, zapallo loche y papa amarilla. Mezclar con el aderezo para impregnar sabores por 2 minutos.', 2),
        (recipe_id, 3, 'Hervido: Verter el caldo de verduras hasta cubrir los vegetales. Llevar a ebullición, tapar y reducir el fuego a medio-bajo. Cocinar durante 20-25 minutos o hasta que el zapallo y la papa estén extremadamente suaves y se deshagan al presionarlos.', 25),
        (recipe_id, 4, 'Licuado para textura seda: Retirar del fuego y dejar reposar unos minutos. Licuar todo el contenido (vegetales y caldo) a velocidad alta hasta obtener una crema perfectamente lisa, brillante y aterciopelada. Si usaste loche con cáscara, colar la preparación es obligatorio para evitar texturas fibrosas.', 5),
        (recipe_id, 5, 'Toque final: Regresar la crema a la olla a fuego bajo. Agregar la leche evaporada e integrar bien. Probar y ajustar la sal. Si está muy espesa, agregar un chorrito más de caldo o agua caliente.', 3),
        (recipe_id, 6, 'Servir tibio. La textura debe ser de "terciopelo líquido", densa pero fluida, sin necesidad de masticar. Puede decorar con queso fresco rallado muy fino que se fundirá con el calor.', 2);
        
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
        (recipe_id, 'Papas amarillas', 4, 'unidades', 'Grandes, peladas y lavadas (variedad que se deshace)', 1),
        (recipe_id, 'Caldo de verduras o pollo', 6, 'tazas', 'Desgrasado y colado', 2),
        (recipe_id, 'Huevos', 2, 'unidades', 'Frescos, para batir en la sopa', 3),
        (recipe_id, 'Paico fresco', 0.25, 'taza', 'Hojas lavadas (da el sabor característico)', 4),
        (recipe_id, 'Perejil fresco', 0.25, 'taza', 'Hojas lavadas', 5),
        (recipe_id, 'Culantro (cilantro)', 0.25, 'taza', 'Hojas lavadas', 6),
        (recipe_id, 'Cebolla china', 2, 'tallos', 'Solo parte verde pica, lavada', 7),
        (recipe_id, 'Ajo', 2, 'dientes', 'Pelados', 8),
        (recipe_id, 'Leche evaporada', 0.5, 'taza', 'Para dar cremosidad final', 9),
        (recipe_id, 'Aceite vegetal', 1, 'cucharada', 'Mínima cantidad', 10),
        (recipe_id, 'Sal', NULL, 'al gusto', 'Poca cantidad', 11);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocción de las papas: En una olla con el caldo hirviendo, colocar las papas amarillas cortadas en láminas finas (para acelerar el proceso). Cocinar a fuego medio-alto hasta que las papas se deshagan por completo (aprox 20-30 min). Ayudar presionando con un cucharón contra las paredes de la olla para espesar el caldo.', 30),
        (recipe_id, 2, 'Preparación del "Verde": Mientras las papas cocinan, colocar en la licuadora el paico, perejil, culantro, cebolla china (parte verde) y el ajo. Agregar un cucharón del caldo caliente (con cuidado) y la leche. Licuar a potencia MÁXIMA por 2 minutos hasta obtener una crema verde brillante totalmente líquida y sin fibras visibles.', 5),
        (recipe_id, 3, 'Integración: Cuando las papas estén completamente deshechas (formando un caldo espeso natural), bajar el fuego al mínimo. Verter la mezcla verde licuada a la olla. Remover suavemente. Cocinar por 3-4 minutos para que se cocinen las hierbas sin perder su color verde vivo.', 4),
        (recipe_id, 4, 'Hilo de huevo: En un tazón aparte, batir ligeramente los huevos claras y yemas. Con la sopa a fuego muy bajo (sin burbujeo fuerte), verter los huevos en forma de hilo fino constante mientras se remueve circularmente la sopa con un tenedor. Esto creará hilos de huevo muy finos y suaves que no requieren masticación.', 3),
        (recipe_id, 5, 'Servir caliente inmediatamente. La textura debe ser cremosa por la papa deshecha, aromática y con el huevo en hebras imperceptibles al tacto.', 1);
        
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
        (recipe_id, 'Pallares secos grandes', 2, 'tazas', 'Remojados 24h previas (esencial para ablandar)', 1),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Mediana, picada en trozos grandes', 2),
        (recipe_id, 'Ajo', 3, 'dientes', 'Enteros o chancados', 3),
        (recipe_id, 'Caldo de verduras o pollo', 6, 'tazas', 'Sin grasa', 4),
        (recipe_id, 'Leche evaporada', 1, 'taza', 'Entera, para cremosidad', 5),
        (recipe_id, 'Mantequilla con sal', 1, 'cucharada', 'Para suavizar sabor final', 6),
        (recipe_id, 'Aceite vegetal', 2, 'cucharadas', 'Para aderezo', 7),
        (recipe_id, 'Orégano seco', 0.5, 'cucharadita', 'Frotado', 8),
        (recipe_id, 'Sal', NULL, 'al gusto', 'Refinada', 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Preparación crítica (Pelado): Tras el remojo de 24 horas (cambiando el agua 2 veces), se debe retirar MANUALMENTE la cáscara gruesa de cada pallar. Presionar suavemente el grano entre los dedos y la cáscara se deslizará. Descartar todas las cáscaras. Quedarán los cotiledones blancos.', 30),
        (recipe_id, 2, 'Cocción base: Poner los pallares pelados en una olla con agua nueva (que los cubra 3 dedos por encima). Llevar a ebullición y cocinar por 45-60 minutos hasta que estén deshaciéndose de suaves. Si seca, añadir agua caliente.', 60),
        (recipe_id, 3, 'Aderezo: En una sartén aparte, sofreír la cebolla picada y los ajos en el aceite hasta que estén dorados y caramelizados (esto da el sabor de fondo, ya que luego se licuará).', 10),
        (recipe_id, 4, 'Licuado total: Colocar los pallares cocidos (con 1 taza de su líquido), el aderezo de cebolla/ajo, y la leche evaporada en la licuadora. Procesar a velocidad alta por 3 minutos. La mezcla debe ser una crema blanca densa y absolutamente lisa.', 5),
        (recipe_id, 5, 'Colado y acabado: Pasar toda la crema por un colador fino para asegurar textura de seda (opcional si la licuadora es potente). Llevar nuevamente a la olla a fuego bajo. Agregar la mantequilla, el orégano frotado (polvo) y sal al gusto. Cocinar 5 minutos moviendo para que tome cuerpo.', 5),
        (recipe_id, 6, 'Servir solo la crema en plato hondo. Puede acompañarse de arroz muy graneado si el paciente tolera granos suaves, o sola como cena nutritiva.', 2);
        
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
        (recipe_id, 'Lentejas marrones o verdes', 1.5, 'tazas', 'Lavadas y escogidas (sin piedras)', 1),
        (recipe_id, 'Zanahoria', 2, 'unidades', 'Medianas, peladas en trozos', 2),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Grande, en trozos', 3),
        (recipe_id, 'Rama de apio', 2, 'tallos', 'Sin hilos, lavados', 4),
        (recipe_id, 'Ajo', 3, 'dientes', 'Pelados', 5),
        (recipe_id, 'Cúrcuma en polvo', 1.5, 'cucharadita', 'Antiinflamatorio clave (usar buena calidad)', 6),
        (recipe_id, 'Comino molido', 0.5, 'cucharadita', 'Para digestión', 7),
        (recipe_id, 'Caldo de verduras', 6, 'tazas', 'O agua filtrada', 8),
        (recipe_id, 'Aceite de oliva extra virgen', 3, 'cucharadas', 'Añadir al final crudo', 9),
        (recipe_id, 'Jugo de limón', 1, 'cucharada', 'Fresco, potencia absorción de hierro', 10),
        (recipe_id, 'Pimienta negra molida', 1, 'pizca', 'Indispensable para activar la cúrcuma', 11),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 12);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Sofrito aromático: En la olla de presión o normal, calentar 1 cda de aceite. Sofreír cebolla, ajo, zanahoria y apio picados grueso por 5 minutos hasta dorar levemente.', 5),
        (recipe_id, 2, 'Activación de especias: Añadir la CÚRCUMA, comino y pimienta negra al sofrito. Mover por 1 minuto para "despertar" los aceites esenciales de las especias (olor intenso), cuidando que no se queme.', 1),
        (recipe_id, 3, 'Cocción: Agregar las lentejas lavadas y el caldo/agua. Tapar. Si es olla a presión, cocinar 15-20 min. Si es olla normal, 45 min o hasta que las lentejas se deshagan totalmente.', 45),
        (recipe_id, 4, 'Licuado homogéneo: Esperar que baje la temperatura un poco. Licuar TODO el contenido de la olla a alta velocidad hasta obtener un puré amarillo-ocre sedoso. No debe quedar ni una sola cáscara de lenteja entera.', 5),
        (recipe_id, 5, 'Ajuste de textura: Regresar a la olla. Si está muy espeso (tipo puré de papa), agregar agua caliente hasta lograr consistencia de crema fluida. Rectificar sal.', 3),
        (recipe_id, 6, 'Servido terapéutico: Servir en tazón. Justo antes de comer, añadir el jugo de limón y el chorrito de aceite de oliva crudo por encima (mejora el perfil antiinflamatorio). Tomar caliente.', 2);
        
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
        (recipe_id, 'Arracacha fresca', 500, 'g', 'Pelada, lavada y cortada en cubos pequeños', 1),
        (recipe_id, 'Papa blanca', 1, 'unidad', 'Mediana, para dar liga, pelada', 2),
        (recipe_id, 'Cebolla blanca', 0.5, 'unidad', 'Picada en trozos (para licuar)', 3),
        (recipe_id, 'Ajo', 2, 'dientes', 'Enteros o chancados', 4),
        (recipe_id, 'Caldo de verduras o pollo', 4, 'tazas', 'Casero y bajo en grasa', 5),
        (recipe_id, 'Crema de leche light', 0.5, 'taza', 'O leche evaporada para menor grasa', 6),
        (recipe_id, 'Mantequilla', 1, 'cucharada', 'Para el aderezo inicial', 7),
        (recipe_id, 'Nuez moscada', 1, 'pizca', 'Recién rallada es mejor', 8),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Suavizado inicial: En la olla, derretir la mantequilla a fuego medio. Agregar la cebolla y el ajo y sofreír hasta que estén brillantes y tiernos (5 min), sin quemar.', 5),
        (recipe_id, 2, 'Incorporación de raíz: Añadir los cubos de arracacha y papa blanca. Rehogar con el aderezo por 3 minutos para sellar sabor.', 3),
        (recipe_id, 3, 'Cocción profunda: Verter el caldo caliente. Llevar a hervor suave. Tapar y cocinar hasta que la arracacha se esté desmoronando sola (aprox 20-25 minutos). Es vital que esté muy pasada de cocción.', 25),
        (recipe_id, 4, 'Transformación a crema: Dejar enfriar un poco. Licuar todo hasta obtener un puré fino y elástico (característica de la arracacha). Debe quedar completamente liso.', 3),
        (recipe_id, 5, 'Acabado aromático: Regresar a la olla a fuego mínimo. Incorporar la crema de leche y la pizca de nuez moscada. Remover bien hasta calentar (sin hervir fuerte para no cortar la crema).', 3),
        (recipe_id, 6, 'Servir tibio. La textura es chiclosa-suave (agradable) y muy digerible. Ideal para cenas ligeras.', 2);
        
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
        (recipe_id, 'Tomates maduros', 4, 'unidades', 'Muy rojos y blandos, pelados y sin semillas', 1),
        (recipe_id, 'Sandía', 2, 'tazas', 'Dulce, sin semillas negras ni blancas', 2),
        (recipe_id, 'Pepino inglés', 1, 'unidad', 'Sin cáscara y SIN semillas', 3),
        (recipe_id, 'Pimiento rojo', 0.5, 'unidad', 'Asado o crudo, sin piel ni semillas', 4),
        (recipe_id, 'Ajo', 0.5, 'diente', 'Sin el germen central (para que no repita)', 5),
        (recipe_id, 'Aceite de oliva virgen extra', 3, 'cucharadas', 'De buena calidad', 6),
        (recipe_id, 'Vinagre de manzana', 1, 'cucharada', 'Más suave que el de vino', 7),
        (recipe_id, 'Sal marina', NULL, 'al gusto', NULL, 8),
        (recipe_id, 'Miga de pan blanco', 1, 'rebanada', 'Sin corteza, remojada (opcional para espesar)', 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Preparación meticulosa: Pelar tomates y quitar semillas. Pelar pepino y quitar semillas centrales con cuchara. Cortar sandía y asegurarse que no tenga semillas.', 10),
        (recipe_id, 2, 'Maceración rápida: Colocar tomates, sandía, pepino, pimiento y ajo en el vaso de la licuadora. Añadir la sal y el vinagre. Dejar reposar 10 minutos para que suelten sus jugos.', 10),
        (recipe_id, 3, 'Licuado potente: Procesar a velocidad máxima por 3 minutos hasta que esté totalmente líquido. Si se quiere más espesor, añadir la miga de pan remojada y licuar más.', 3),
        (recipe_id, 4, 'Emulsión: Con la licuadora en marcha lenta, agregar el aceite de oliva en un hilo fino para que emulsione y cambie el color a un rojo anaranjado cremoso.', 1),
        (recipe_id, 5, 'Tamizado (Obligatorio DTM): Pasar la mezcla por un colador fino ("chino") presionando para eliminar cualquier resto de piel de pimiento o tomate que haya quedado. Debe quedar una sopa fría líquida y sedosa.', 5),
        (recipe_id, 6, 'Refrigeración y servicio: Enfriar en nevera al menos 1 hora. Servir muy frío en vaso o tazón. Es excelente para aliviar dolor inflamatorio facial por el frío.', 60);
        
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
        (recipe_id, 'Carne de res molida', 300, 'g', 'Molida finamente (pedir doble molienda) y sin grasa', 1),
        (recipe_id, 'Fideos cabello de ángel', 100, 'g', 'Los más finos que existen', 2),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada en cuadraditos muy pequeños (brunoise)', 3),
        (recipe_id, 'Ajo', 2, 'dientes', 'Chancados o pasta', 4),
        (recipe_id, 'Tomate rallado', 1, 'unidad', 'Sin piel, rallado para hacer pasta', 5),
        (recipe_id, 'Ají panca en pasta', 1, 'cucharada', 'Sin picante', 6),
        (recipe_id, 'Caldo de carne sustancioso', 6, 'tazas', 'Bajo en grasa', 7),
        (recipe_id, 'Leche evaporada', 0.5, 'taza', 'Para suavizar', 8),
        (recipe_id, 'Huevos', 2, 'unidades', 'Para escalfar', 9),
        (recipe_id, 'Orégano tostado', 0.5, 'cucharadita', 'Molido entre los dedos', 10),
        (recipe_id, 'Aceite vegetal', 2, 'cucharadas', NULL, 11),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 12);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Aderezo base: Sofreír la cebolla picada finita y el ajo en aceite por 8 minutos hasta que la cebolla "desaparezca" visualmente. Agregar el tomate rallado y el ají panca. Cocinar 5 min más hasta formar una pasta rojiza oscura.', 13),
        (recipe_id, 2, 'Cocción de carne: Incorporar la carne molida. Usando un tenedor, aplastarla mientras se cocina para evitar que se formen "pelotas" grandes. Debe quedar como arena fina cocida. Sazonar con sal y orégano.', 5),
        (recipe_id, 3, 'Sopa: Verter el caldo de carne y llevar a ebullición. Dejar hervir 5 minutos para integrar sabores.', 5),
        (recipe_id, 4, 'Fideos pasados: Partir los fideos cabello de ángel con la mano en trozos de 2-3 cm (no echar enteros). Agregarlos a la sopa hirviendo. Cocinar 5-6 minutos (el doble de lo usual) hasta que estén hinchados y extremadamente suaves.', 6),
        (recipe_id, 5, 'Toque lácteo y huevos: Bajar el fuego. Agregar la leche. Romper los huevos cuidadosamente y echarlos enteros a la sopa suave (burbujeo mínimo). Dejar pochar (escalfar) por 3-4 minutos hasta que la clara esté blanca y sólida pero suave.', 4),
        (recipe_id, 6, 'Servir inmediatamente. La carne molida fina y los fideos sobrecocidos hacen que esta sopa casi no requiera masticación.', 1);
        
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
        (recipe_id, 'Carne molida de res', 300, 'g', 'Molienda fina, sin grasa visible', 1),
        (recipe_id, 'Fideos cabello de ángel', 150, 'g', 'Sustituyendo al fideo grueso para facilitar ingesta', 2),
        (recipe_id, 'Pan de molde blanco', 3, 'rebanadas', 'Sin corteza, trozado a mano', 3),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada en brunoise fina', 4),
        (recipe_id, 'Ajo', 2, 'dientes', 'Pasta o picado fino', 5),
        (recipe_id, 'Tomate', 2, 'unidades', 'Pelados y sin semillas, picados', 6),
        (recipe_id, 'Ají panca en pasta', 2, 'cucharadas', 'Base de sabor, sin picante', 7),
        (recipe_id, 'Caldo de res', 7, 'tazas', 'Bien colado', 8),
        (recipe_id, 'Leche evaporada', 0.5, 'taza', 'Para dar color y sabor final', 9),
        (recipe_id, 'Huevos', 2, 'unidades', 'Para escalfar', 10),
        (recipe_id, 'Aceite vegetal', 2, 'cucharadas', NULL, 11),
        (recipe_id, 'Sal y orégano', NULL, 'al gusto', NULL, 12);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Sofrito base: Calentar aceite. Sofreír cebolla, ajo, tomate y ají panca a fuego medio-bajo por 10 minutos. Debe quedar como una pasta roja suave y brillante.', 10),
        (recipe_id, 2, 'Carne: Añadir la carne molida. Cocinar separándola constantemente con la cuchara para que quede suelta y fina, no en grumos. Dorar por 5 minutos.', 5),
        (recipe_id, 3, 'Caldo: Incorporar el caldo de res. Llevar a hervor. Espumar si es necesario para retirar impurezas.', 5),
        (recipe_id, 4, 'Fideos: Agregar los fideos cabello de ángel partidos en 3 partes. Cocinar 4 minutos.', 4),
        (recipe_id, 5, 'El secreto del pan: Agregar el pan de molde trozado DIRECTAMENTE al caldo caliente. Dejar hervir 3-4 minutos más. El pan se hidratará y comenzará a deshacerse, espesando el caldo y dándole una textura aterciopelada única.', 4),
        (recipe_id, 6, 'Finalización: Verter la leche y el orégano estrujado. Romper los huevos y dejarlos caer suavemente en la sopa (sin que hierva fuerte). Cocinar 3 minutos hasta que la clara cuaje suavemente.', 3),
        (recipe_id, 7, 'Servir: Servir caliente. El pan habrá desaparecido casi por completo, dejando una sopa cremosa y espesa fácil de tomar.', 1);
        
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
        (recipe_id, 'Plátanos verdes (bellaco)', 4, 'unidades', 'Bien verdes y duros (para la masa)', 1),
        (recipe_id, 'Carne de res molida', 250, 'g', 'Para el relleno (condumio)', 2),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada muy fina', 3),
        (recipe_id, 'Pimiento rojo', 0.5, 'unidad', 'Picado minúsculo, sin piel', 4),
        (recipe_id, 'Pasas negras', 2, 'cucharadas', 'Picadas', 5),
        (recipe_id, 'Aceitunas negras', 6, 'unidades', 'Sin pepa, picadas', 6),
        (recipe_id, 'Huevo duro', 2, 'unidades', 'Picados', 7),
        (recipe_id, 'Yuca amarilla', 300, 'g', 'Pelada, sin fibra central, trozos medianos', 8),
        (recipe_id, 'Zanahoria', 1, 'unidad', 'Rodajas finas o rallada', 9),
        (recipe_id, 'Caldo de res concentrado', 10, 'tazas', NULL, 10),
        (recipe_id, 'Culantro picado', 2, 'cucharadas', 'Fino', 11),
        (recipe_id, 'Aceite con achiote', 2, 'cucharadas', 'Para color', 12),
        (recipe_id, 'Maní tostado molido', 2, 'cucharadas', 'Para espesar la masa (opcional)', 13);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Masa 1: Cocinar los plátanos con cáscara lavados en agua hirviendo por 30-35 min. Deben estar suaves al hincar. Pelar CALIENTES.', 35),
        (recipe_id, 2, 'Masa 2: Majar (aplastar) los plátanos calientes en batán o procesador hasta obtener una masa chiclosa y lisa. Agregar sal y un poco de aceite con achiote para que sea maleable. Amasar bien con las manos mojadas. Si está muy dura, añadir un poquito de caldo tibio.', 15),
        (recipe_id, 3, 'Relleno (Condumio): Sofreír cebolla, pimiento y carne molida. Cuando esté cocido y jugoso, apagar fuego. Mezclar con pasas, aceitunas y huevo duro picado. Todo el relleno debe estar picado muy pequeño.', 15),
        (recipe_id, 4, 'Armado: Tomar una porción de masa de plátano (tamaño de un limón grande), hacer un hueco con el dedo, rellenar con una cucharadita del condumio, y cerrar rodando suavemente entre las manos para formar una esfera perfecta sin grietas.', 15),
        (recipe_id, 5, 'Caldo: En una olla grande llevar el caldo de res a hervor con la yuca y zanahoria. Cuando la yuca esté semicocida (15 min), bajar el fuego a medio.', 20),
        (recipe_id, 6, 'Cocción final: Introducir las bolas de plátano con cuidado. Cocinar 20-25 minutos. Las bolas flotarán y se hincharán ligeramente. El caldo espesará un poco por el almidón.', 25),
        (recipe_id, 7, 'Servicio: Servir 1-2 bolas por plato con abundante caldo y un trozo de yuca (que debe estar muy blanda). Al comer, la bola debe ceder suavemente a la cuchara, mezclando la masa untuosa con el relleno húmedo.', 2);
        
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
        (recipe_id, 'Morón partido (cebada)', 1, 'taza', 'Remojado 4 horas y lavado', 1),
        (recipe_id, 'Carne de res (ossobuco o pecho)', 500, 'g', 'Corte con hueso para sabor, carne muy suave', 2),
        (recipe_id, 'Zapallo macre', 1, 'slice', 'Pelado en cubos (se deshará)', 3),
        (recipe_id, 'Apio', 2, 'tallos', 'Picados', 4),
        (recipe_id, 'Zanahoria', 1, 'unidad', 'Picada en cubitos o rallada', 5),
        (recipe_id, 'Papa blanca', 2, 'unidades', 'Peladas y picadas', 6),
        (recipe_id, 'Orégano seco', 1, 'cucharadita', NULL, 7),
        (recipe_id, 'Hierbabuena', 2, 'ramas', 'Enteras para saborizar', 8),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Caldo gelatinoso: En olla a presión, cocinar la carne de res con agua, sal, apio y zanahoria por 45 minutos. La carne debe deshacerse sola. El colágeno del hueso es vital.', 45),
        (recipe_id, 2, 'Cocción del morón: Colar el caldo (reservar carne deshilachada y vegetales si se desea). Volver el caldo a la olla, agregar el morón lavado. Cocinar a fuego medio-bajo por 30-40 minutos.', 40),
        (recipe_id, 3, 'Espesado: Cuando el morón esté abriendo, agregar las papas y el zapallo. Cocinar 15 minutos más. El zapallo debe desaparecer y espesar el caldo, dándole color amarillo.', 15),
        (recipe_id, 4, 'Aromatizar: Agregar el orégano y las ramas de hierbabuena. Cocinar 5 minutos finales. La sopa debe tener una textura "babosa" (mucílago de cebada) que es excelente para recubrir la garganta y estómago.', 5),
        (recipe_id, 5, 'Servir: Retirar ramas de hierbabuena. Servir la sopa espesa. La carne se incorpora deshilachada muy fina o se omite según severidad del DTM.', 2);
        
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
        (recipe_id, 'Habas verdes frescas', 500, 'g', 'DOBLE PELADO (sin vaina y sin cáscara individual)', 1),
        (recipe_id, 'Papa amarilla', 4, 'unidades', 'Peladas y cortadas (se deshacen)', 2),
        (recipe_id, 'Queso fresco', 150, 'g', 'Cortado en cubitos de 0.5cm', 3),
        (recipe_id, 'Leche evaporada', 1, 'taza', NULL, 4),
        (recipe_id, 'Huevos', 2, 'unidades', 'Batidos o para escalfar', 5),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada brunoise', 6),
        (recipe_id, 'Ajo', 2, 'dientes', 'Picados', 7),
        (recipe_id, 'Ají panca', 1, 'cucharada', 'Pasta suave', 8),
        (recipe_id, 'Huacatay', 1, 'rama', 'Entera para retirar o licuada si se tolera líquido', 9),
        (recipe_id, 'Caldo de vegetales', 6, 'tazas', NULL, 10),
        (recipe_id, 'Aceite', 2, 'cucharadas', NULL, 11),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 12);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'El secreto del doble pelado: Retirar las habas de sus vainas. Luego, con paciencia, retirar la cáscara verde claro de CADA haba individual, dejando expuesto el interior verde brillante y tierno. Esto elimina la fibra dura que es difícil de masticar.', 20),
        (recipe_id, 2, 'Aderezo: Sofreír cebolla, ajo y ají panca hasta que el aceite se separe. Agregar las papas amarillas y revolver.', 10),
        (recipe_id, 3, 'Cocción: Añadir el caldo y la rama de huacatay. Hervir. Cuando rompa el hervor, añadir las habas peladas. Cocinan muy rápido (5-7 min) y se ponen mantequillosas.', 15),
        (recipe_id, 4, 'Espesado natural: Dejar cocinar unos minutos más hasta que las papas amarillas comiencen a deshacerse, espesando el caldo.', 5),
        (recipe_id, 5, 'Enriquecimiento: Agregar la leche y el queso fresco picadito. Remover hasta que el queso se ablande (pero que no se funda totalmente, que queden trocitos suaves).', 3),
        (recipe_id, 6, 'Huevos: Agregar los huevos batidos en hilo o enteros escalfados según preferencia, para aportar proteína blanda.', 3),
        (recipe_id, 7, 'Servir: Retirar el huacatay. Servir caliente. Todo debe poder aplastarse fácilmente con la lengua contra el paladar.', 1);
        
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
        (recipe_id, 'Chuño o Tunta (papa deshidratada)', 1, 'taza', 'Remojado toda la noche, lavado varias veces', 1),
        (recipe_id, 'Carne de cordero o res', 250, 'g', 'Pulpa muy suave picada fino o molida', 2),
        (recipe_id, 'Zapallo macre', 200, 'g', 'En cubos (para espesar)', 3),
        (recipe_id, 'Zanahoria', 1, 'unidad', 'Rallada finamente', 4),
        (recipe_id, 'Habas verdes', 0.5, 'taza', 'Peladas (sin la cáscara de cada haba)', 5),
        (recipe_id, 'Papa blanca', 2, 'unidades', 'Peladas y cortadas', 6),
        (recipe_id, 'Hierbabuena', 2, 'ramas', 'Para saborizar', 7),
        (recipe_id, 'Caldo de res', 7, 'tazas', 'Sustancioso', 8),
        (recipe_id, 'Sal y orégano', NULL, 'al gusto', NULL, 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Chuño: El chuño remojado debe pelarse (si tiene cáscara) y luego chancarse (machacarse) en un mortero o con piedra hasta que quede destrozado en trocitos minúsculos. Esto es vital para que no sea gomoso-duro sino suave.', 15),
        (recipe_id, 2, 'Base: Hervir el caldo con la carne picada y el chuño machacado. El chuño tarda en cocinar, así que va primero. Cocinar 20 minutos.', 20),
        (recipe_id, 3, 'Verduras: Agregar la zanahoria rallada, el zapallo y las papas. Cocinar hasta que todo esté deshecho. El zapallo se integrará al caldo.', 20),
        (recipe_id, 4, 'Habas: Agregar las habas peladas al final (solo necesitan 5 min).', 5),
        (recipe_id, 5, 'Aromatizar: Agregar la hierbabuena y orégano. Rectificar sal.', 2),
        (recipe_id, 6, 'Reposo: Dejar reposar 5 minutos tapado. El chuño absorberá sabor. Servir.', 5);
        
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
        (recipe_id, 'Olluco picado', 400, 'g', 'Picado en juliana muy fina (se cocina más rápido)', 1),
        (recipe_id, 'Papa amarilla', 2, 'unidades', 'Peladas y picadas en cubos (para espesar)', 2),
        (recipe_id, 'Carne de res molida', 200, 'g', 'Molida fina (opcional, para sabor)', 3),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada brunoise', 4),
        (recipe_id, 'Ajo', 2, 'dientes', 'Molido', 5),
        (recipe_id, 'Tomate', 1, 'unidad', 'Pelado y picado fino', 6),
        (recipe_id, 'Caldo de res o agua', 6, 'tazas', NULL, 7),
        (recipe_id, 'Hierbabuena', 2, 'ramitas', 'Para dar el sabor característico', 8),
        (recipe_id, 'Aceite con achiote', 2, 'cucharadas', 'Para color', 9),
        (recipe_id, 'Sal y comino', NULL, 'al gusto', NULL, 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Aderezo: Calentar el aceite con achiote. Sofreír cebolla, ajo y tomate hasta que estén deshechos (pasta).', 8),
        (recipe_id, 2, 'Carne: Agregar la carne molida y cocinarla separándola bien para que no queden bolas grandes. (Si el paciente no tolera carne, usarla solo para dar sabor al caldo y colar después).', 5),
        (recipe_id, 3, 'Ollucos: Incorporar el olluco picado fino. Rehogar unos minutos. El olluco es duro, requiere buena cocción.', 5),
        (recipe_id, 4, 'Hervor: Añadir las papas amarillas y el caldo. Cocinar a fuego medio-bajo por 25-30 minutos. El olluco debe estar muy tierno y "baboso" (suelta mucílago espesante). La papa amarilla debe haberse deshecho.', 30),
        (recipe_id, 5, 'Final: Agregar la hierbabuena y retirar del fuego. Dejar reposar. Servir caliente. La textura resbaladiza del olluco facilita la deglución.', 2);
        
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
        (recipe_id, 'Papa amarilla', 1, 'kg', 'Sancochada, pelada y prensada CALIENTE (x2)', 1),
        (recipe_id, 'Limón sutil', 3, 'unidades', 'Jugo recién exprimido, colado', 2),
        (recipe_id, 'Ají amarillo en pasta', 3, 'cucharadas', 'Sin picante, tamizado', 3),
        (recipe_id, 'Aceite vegetal neutro', 0.25, 'taza', 'Para dar elasticidad y brillo', 4),
        (recipe_id, 'Atún en conserva', 2, 'latas', 'Sólido o filete, en aceite (más suave)', 5),
        (recipe_id, 'Palta fuerte', 2, 'unidades', 'Muy madura ("mantequilla")', 6),
        (recipe_id, 'Mayonesa', 0.5, 'taza', 'Casera o de buena calidad', 7),
        (recipe_id, 'Huevo duro', 2, 'unidades', 'Para decoración o relleno (picado polvo)', 8),
        (recipe_id, 'Sal', NULL, 'al gusto', 'Disuelta en el limón', 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Masa de Papa (Base): Prensar las papas amarillas dos veces mientras están calientes para asegurar que no haya ningún grumo. Dejar enfriar un poco. Añadir la pasta de ají, el aceite, sal y el jugo de limón. Amasar con la mano hasta obtener una masa muy suave, sedosa y maleable que no se pegue.', 15),
        (recipe_id, 2, 'Relleno proteico: Escurrir el atún y desmenuzarlo completamente con un tenedor hasta que parezca fibras sueltas. Mezclar con abundante mayonesa para formar una pasta untuosa ("mousse de atún").', 5),
        (recipe_id, 3, 'Palta: Cortar la palta en láminas muy finas o aplastarla ligeramente si se prefiere tipo puré.', 3),
        (recipe_id, 4, 'Montaje: En un pírex o con molde, colocar una capa base de la masa de papa. Alisar. Colocar una capa de la pasta de atún. Colocar la palta. Cubrir con otra capa de masa de papa.', 10),
        (recipe_id, 5, 'Reposo: Refrigerar por 30 minutos. El frío compacta la causa y mejora la textura.', 30),
        (recipe_id, 6, 'Servir: Cortar con espátula. Es un plato frío ideal porque deshace en la boca. Si el paciente no puede abrir mucho la boca, se pueden hacer bolitas tamaño bocado (causitas).', 2);
        
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
        (recipe_id, 'Huevos duros', 6, 'unidades', 'Hervidos 10 min, pelados y picados muy menudito', 1),
        (recipe_id, 'Pan de molde blanco', 4, 'rebanadas', 'Sin corteza, trozado para licuar', 2),
        (recipe_id, 'Leche evaporada', 1.5, 'tazas', 'Cantidad necesaria para la salsa', 3),
        (recipe_id, 'Ají amarillo en pasta', 4, 'cucharadas', 'Hervido previamente para quitar picante', 4),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Mediana, picada gruesa (se licuará)', 5),
        (recipe_id, 'Ajo', 3, 'dientes', 'Enteros', 6),
        (recipe_id, 'Caldo de pollo o verduras', 1, 'taza', 'Para soltar la salsa', 7),
        (recipe_id, 'Queso parmesano', 3, 'cucharadas', 'Rallado fino (opcional)', 8),
        (recipe_id, 'Pecanas o nueces', 2, 'unidades', 'Ralladas (opcional, cuidado con trozos)', 9),
        (recipe_id, 'Aceite vegetal', 3, 'cucharadas', NULL, 10),
        (recipe_id, 'Papas sancochadas', 4, 'unidades', 'Rodajas, para servir', 11),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 12);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Remojo: Remojar el pan trozado en la leche evaporada por 5-10 minutos.', 10),
        (recipe_id, 2, 'Base de sabor: Sofreír la cebolla y los ajos en el aceite hasta que doren suavemente. Agregar la pasta de ají amarillo y cocinar 2 minutos más.', 8),
        (recipe_id, 3, 'Salsa cremosa (Licuado): Licuar el remojo de pan con leche, junto con el sofrito de cebolla/ají. Agregar el caldo poco a poco. Licuar hasta obtener una crema amarilla intensa, espesa y sin ningún grumo. Debe ser napadora (cubrir cuchara).', 5),
        (recipe_id, 4, 'Cocción de salsa: Verter la crema en la olla. Cocinar a fuego lento moviendo constantemente con cuchara de palo (salpica mucho, cuidado). Cocinar 10 minutos hasta que tome punto y brille. Agregar queso parmesano y pecanas ralladas (polvo).', 10),
        (recipe_id, 5, 'Integración: Agregar los huevos duros picados MUY chiquito (casi arena) a la salsa caliente. Mezclar suavemente. El huevo aporta textura sin necesidad de masticar grandes trozos.', 3),
        (recipe_id, 6, 'Servir: Colocar papas sancochadas en rodajas en el plato. Cubrir generosamente con la salsa de huevo ("Ají de Huevos"). Puede acompañar con arroz muy graneado si se permite.', 2);
        
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
        (recipe_id, 'Zapallo macre', 800, 'g', 'Pelado y en trozos medianos (compra el de cáscara verde oscura)', 1),
        (recipe_id, 'Papa amarilla', 3, 'unidades', 'Peladas y cortadas en 4', 2),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada menuda', 3),
        (recipe_id, 'Ajo', 2, 'dientes', 'Molido', 4),
        (recipe_id, 'Ají amarillo pasta', 1, 'cucharada', 'Opcional (baja en picante)', 5),
        (recipe_id, 'Queso fresco', 200, 'g', 'Cortado en cubos de 1cm', 6),
        (recipe_id, 'Leche evaporada', 0.75, 'taza', 'Para cremosidad final', 7),
        (recipe_id, 'Aceite vegetal', 2, 'cucharadas', NULL, 8),
        (recipe_id, 'Huacatay', 1, 'rama', 'Entera para dar aroma y retirar', 9),
        (recipe_id, 'Habas peladas', 0.5, 'taza', 'Sin cáscara, opcional si son muy tiernas', 10),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 11);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Aderezo: En una olla grande, sofreír cebolla, ajo y ají amarillo en el aceite hasta que la cebolla esté transparente y suave.', 8),
        (recipe_id, 2, 'Base de guiso: Agregar el zapallo trozado y las papas amarillas. Mezclar con el aderezo. Agregar agua o caldo vegetal solo hasta cubrir la mitad del volumen (el zapallo suelta mucha agua).', 5),
        (recipe_id, 3, 'Cocción lenta: Tapar y cocinar a fuego bajo por 25-30 minutos. Remover ocasionalmente. El objetivo es que el zapallo se deshaga por completo y forme una crema espesa natural. La papa amarilla también debe deshacerse.', 30),
        (recipe_id, 4, 'Textura: Usar una cuchara de madera o machacador para aplastar cualquier trozo grande de zapallo o papa que quede. Debe quedar como un puré rústico anaranjado.', 3),
        (recipe_id, 5, 'Finalización: Agregar las habas peladas (si usa, cocinan en 5 min). Luego agregar la leche y el queso fresco en cubos y la rama de huacatay. Cocinar 5 minutos más hasta que todo esté integrado y caliente, y el queso suave.', 5),
        (recipe_id, 6, 'Servir: Retirar la rama de huacatay. Servir solo o con arroz blanco. La textura es húmeda, dulce y suave, muy fácil de pasar.', 2);
        
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
        (recipe_id, 'Quinua perlada', 1, 'taza', 'Bien lavada (sin saponina)', 1),
        (recipe_id, 'Agua filtrada', 2.5, 'tazas', 'Para cocción (un poco más para que abra bien)', 2),
        (recipe_id, 'Queso fresco light', 150, 'g', 'Picado en cubitos de 3mm (minúsculos)', 3),
        (recipe_id, 'Palta fuerte', 1, 'unidad', 'Madura pero firme, cubos de 5mm', 4),
        (recipe_id, 'Tomate', 2, 'unidades', 'Pelados, sin semillas, cubos de 3mm', 5),
        (recipe_id, 'Cebolla roja', 0.25, 'unidad', 'Brunoise super fina, lavada 3 veces', 6),
        (recipe_id, 'Aceite de oliva virgen', 3, 'cucharadas', 'Generoso para lubricar', 7),
        (recipe_id, 'Limón', 2, 'unidades', 'Jugo colado', 8),
        (recipe_id, 'Culantro picado', 2, 'cucharadas', 'Casi polvo', 9),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocción de quinua (Plus): Lavar bien la quinua. Cocinarla en agua hirviendo por 20 minutos (más de lo normal) hasta que el grano explote ("saque colita") y esté muy tierno. Colar y dejar enfriar.', 20),
        (recipe_id, 2, 'Picado microscópico: La clave del DTM aquí es el tamaño. Picar el queso, tomate y cebolla en cubitos del tamaño de un grano de arroz o menor. Restregar la cebolla con sal y lavar para quitar crocancia y picor.', 10),
        (recipe_id, 3, 'Mezcla: En un bowl, unir la quinua fría, el queso, cebolla y tomate. Mezclar bien.', 2),
        (recipe_id, 4, 'Adición de palta: Agregar la palta picada al final, moviendo con cuidado para que no se haga puré (o si se prefiere puré para unir todo, mezclar vigorosamente).', 2),
        (recipe_id, 5, 'Aliño: Emulsionar el aceite de oliva con el limón y sal. Verter sobre la mezcla. El aceite es vital para que resbale al tragar.', 1),
        (recipe_id, 6, 'Servir fría. Es una ensalada completa de masticación mínima si el picado es correcto.', 1);
        
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
        (recipe_id, 'Filete de pescado blanco', 400, 'g', 'Lenguado, Tilapia o Corvina (sin espinas)', 1),
        (recipe_id, 'Limón', 2, 'unidades', 'Jugo y rodajas', 2),
        (recipe_id, 'Kion (jengibre)', 1, 'trozo', 'En láminas o rallado jugoso', 3),
        (recipe_id, 'Ajo', 2, 'dientes', 'Laminado fino', 4),
        (recipe_id, 'Sillao (salsa de soja)', 1, 'cucharadita', 'Bajo en sodio', 5),
        (recipe_id, 'Aceite de ajonjolí', 1, 'cucharadita', 'Para aroma', 6),
        (recipe_id, 'Cebolla china', 2, 'tallos', 'Parte verde picada fina', 7),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Preparación: Secar los filetes. Colocarlos en un plato resistente al calor (que quepa en la vaporera). Rociar con el jugo de limón y el sillao.', 5),
        (recipe_id, 2, 'Aromatización: Colocar las láminas de kion y ajo sobre y debajo del pescado. Esto infundirá sabor sin necesidad de comer los trozos duros.', 2),
        (recipe_id, 3, 'Vapor: Llevar el plato a la vaporera con agua hirviendo abajo. Tapar bien. Cocinar por 10-12 minutos exactos. El pescado blanco se cocina muy rápido. Al hincarlo debe separarse en lascas suaves.', 12),
        (recipe_id, 4, 'Finalizado: Retirar el plato con cuidado (estará caliente y con jugo). Retirar los trozos grandes de kion. Rociar el aceite de ajonjolí y espolvorear la cebolla china.', 2),
        (recipe_id, 5, 'Servir: Servir inmediatamente con su propio jugo. La textura es húmeda y se deshace sola, ideal para días de mucho dolor. Acompañar con arroz meloso.', 1);
        
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
        (recipe_id, 'Carne de res molida', 500, 'g', 'DOBLE o TRIPLE molienda (pedir en carnicería)', 1),
        (recipe_id, 'Pan de molde', 3, 'rebanadas', 'Sin corteza, remojado en leche', 2),
        (recipe_id, 'Leche', 0.5, 'taza', 'Para suavizar la carne', 3),
        (recipe_id, 'Huevo', 1, 'unidad', 'Para ligar', 4),
        (recipe_id, 'Cebolla blanca', 1, 'unidad', 'Rallada (no picada) para que no se sienta', 5),
        (recipe_id, 'Ajo en polvo', 1, 'cucharadita', 'Mejor que fresco para evitar trozos', 6),
        (recipe_id, 'Tomates maduros', 6, 'unidades', 'Licuados y colados', 7),
        (recipe_id, 'Pasta de tomate', 2, 'cucharadas', 'Para color', 8),
        (recipe_id, 'Caldo de res', 1, 'taza', NULL, 9),
        (recipe_id, 'Azúcar', 1, 'cucharadita', 'Para acidez del tomate', 10),
        (recipe_id, 'Sal y orégano', NULL, 'al gusto', NULL, 11);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Masa suave: Mezclar la carne molida fina con el pan remojado (hecho puré), el huevo, la cebolla rallada, sal y ajo en polvo. Amasar con la mano por 5 minutos hasta que se sienta como una pasta untable casi.', 10),
        (recipe_id, 2, 'Boleado: Con las manos húmedas, formar bolitas pequeñas (tamaño nuez). No hacerlas grandes para que no requieran partirse mucho.', 10),
        (recipe_id, 3, 'Salsa roja: En la olla, poner el tomate licuado, pasta de tomate, caldo y azúcar. Hervir 10 minutos hasta que tome cuerpo.', 10),
        (recipe_id, 4, 'Cocción poché: Bajar el fuego de la salsa a mínimo. Introducir las albóndigas crudas suavemente en la salsa. No freírlas antes (esto crea costra dura).', 2),
        (recipe_id, 5, 'Guisado: Tapar y cocinar a fuego bajo por 25 minutos. Las albóndigas se cocinarán en el líquido, quedando tiernas y jugosas, absorbiendo la salsa.', 25),
        (recipe_id, 6, 'Servir: Servir bañadas en abundante salsa. Deben poder aplastarse con la lengua.', 2);
        
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
        (recipe_id, 'Papa seca', 300, 'g', 'Remojada 24 horas y lavada múltiples veces', 1),
        (recipe_id, 'Champiñones frescos', 400, 'g', 'Cortados en láminas o picados fino (textura suave)', 2),
        (recipe_id, 'Cebolla roja', 2, 'unidades', 'Picadas brunoise muy fina', 3),
        (recipe_id, 'Ajo', 4, 'dientes', 'Pasta suave', 4),
        (recipe_id, 'Ají panca en pasta', 2, 'cucharadas', 'Base de sabor', 5),
        (recipe_id, 'Maní tostado', 0.25, 'taza', 'Molido tipo harina o mantequilla (sin trozos)', 6),
        (recipe_id, 'Caldo de vegetales', 4, 'tazas', 'Caliente', 7),
        (recipe_id, 'Vino tinto dulce', 0.25, 'taza', 'Opcional (aporta acidez)', 8),
        (recipe_id, 'Aceite de maní o vegetal', 4, 'cucharadas', NULL, 9),
        (recipe_id, 'Canela y clavo (polvo)', 1, 'pizca', 'Toque sutil', 10),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 11);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hidratación profunda: Cocinar primero la papa seca (ya remojada 24h) en agua hirviendo sola por 40 min hasta que doble su volumen y esté totalmente blanda al centro. Escurrir.', 40),
        (recipe_id, 2, 'Aderezo: Sofreír cebolla y ajo en abundante aceite hasta caramelizar. Agregar ají panca y las especias. Cocinar hasta que el aceite se separe.', 10),
        (recipe_id, 3, 'Integración: Añadir los champiñones láminados, dejar que suelten su agua. Luego agregar la papa seca cocida.', 5),
        (recipe_id, 4, 'Guisado: Verter el caldo y el vino. Agregar el maní molido FINO (que actuará como espesante). Cocinar a fuego lento moviendo constantemente para que no se pegue. La papa seca debe comenzar a deshacerse ligeramente, formando una masa unida y húmeda.', 20),
        (recipe_id, 5, 'Servir: Servir muy caliente con yuca sancochada (muy suave) o arroz. La textura es grumosa pero blanda, tipo risotto espeso.', 2);
        
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
        (recipe_id, 'Choclo desgranado', 4, 'tazas', 'Tierno (lechosos), crudo', 1),
        (recipe_id, 'Leche evaporada', 1, 'taza', 'Para licuar', 2),
        (recipe_id, 'Caldo de pollo', 1, 'taza', 'Para soltar', 3),
        (recipe_id, 'Queso fresco', 150, 'g', 'Picado minúsculo', 4),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada muy fina', 5),
        (recipe_id, 'Ajo', 3, 'dientes', 'Molido', 6),
        (recipe_id, 'Ají amarillo pasta', 2, 'cucharadas', 'Hervido (sin picante)', 7),
        (recipe_id, 'Huevos', 2, 'unidades', 'Batidos', 8),
        (recipe_id, 'Aceite vegetal', 3, 'cucharadas', NULL, 9),
        (recipe_id, 'Culantro', 2, 'cucharadas', 'Licuado con el choclo para color verde (estilo norteño)', 10),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 11);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Licuado fino: Licuar el choclo con la leche y el culantro hasta obtener una pasta fina. IMPORTANTE: Pasar por colador para retirar todo el "hollejo" (cáscara del grano) que es molesto para pacientes DTM. Quedarse solo con la crema de almidón.', 10),
        (recipe_id, 2, 'Aderezo: Sofreír cebolla, ajo y ají amarillo muy bien (10 min).', 10),
        (recipe_id, 3, 'Cocción de almidón: Verter la crema de choclo colada sobre el aderezo. Cocinar a fuego medio, moviendo SIN PARAR en forma de 8 con cuchara de palo. Espesará rápido.', 15),
        (recipe_id, 4, 'Punto: Si está muy espeso (bloque), agregar caldo caliente poco a poco hasta lograr consistencia de puré suave. Cocinar 10 min más hasta que se vea el fondo de la olla.', 10),
        (recipe_id, 5, 'Enriquecer: Agregar el queso fresco picado y los huevos batidos (en hilo, moviendo rápido). Esto da suavidad extra.', 3),
        (recipe_id, 6, 'Servir: Servir solo o con arroz. Es una crema densa y muy nutritiva, libre de cáscaras.', 2);
        
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
        (recipe_id, 'Spaghetti o Tallarín grueso', 400, 'g', 'Cocido 3 minutos extra (muy suave)', 1),
        (recipe_id, 'Espinaca', 3, 'tazas', 'Hojas blanqueadas', 2),
        (recipe_id, 'Albahaca', 1, 'taza', 'Hojas frescas', 3),
        (recipe_id, 'Queso fresco', 200, 'g', 'Para la salsa', 4),
        (recipe_id, 'Leche evaporada', 1, 'taza', 'Para licuar', 5),
        (recipe_id, 'Ajo', 1, 'diente', 'Sin corazón', 6),
        (recipe_id, 'Pecanas tostadas', 2, 'cucharadas', 'Molidas en polvo previamente', 7),
        (recipe_id, 'Queso parmesano', 0.5, 'taza', 'Rallado polvo', 8),
        (recipe_id, 'Aceite vegetal', 0.25, 'taza', 'Para emulsionar', 9),
        (recipe_id, 'Sal', NULL, 'al gusto', NULL, 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Base verde: Blanquear espinaca y albahaca (pasar por agua hirviendo 1 min y luego hielo). Esto fija el color y suaviza fibra.', 5),
        (recipe_id, 2, 'Salsa lisa: Licuar las hojas con el queso fresco, leche, pecanas (ya molidas), ajo y aceite. Procesar por 2-3 minutos hasta que sea una crema verde uniforme, sedosa, sin puntitos de hoja visibles.', 3),
        (recipe_id, 3, 'Pasta sobrecocida: Cocinar los fideos en agua con sal. Dejar pasar el punto "al dente". Deben estar muy blandos e hinchados, que se corten solos con el tenedor.', 15),
        (recipe_id, 4, 'Unión: Calentar la salsa suavemente (sin hervir o se corta el queso). Mezclar con la pasta caliente escurrida.', 2),
        (recipe_id, 5, 'Servir: Servir inmediatamente. La salsa debe ser abundante para lubricar la pasta en la boca. Espolvorear queso parmesano fino.', 1);
        
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
        (recipe_id, 'Choclo desgranado', 6, 'unidades', 'Tierno (lechoso)', 1),
        (recipe_id, 'Queso mantecoso', 250, 'g', 'Corta en láminas gruesas (se funde bien)', 2),
        (recipe_id, 'Mantequilla sin sal', 4, 'cucharadas', 'Derretida', 3),
        (recipe_id, 'Azúcar blanca', 3, 'cucharadas', 'Al gusto', 4),
        (recipe_id, 'Sal', 1, 'cucharadita', NULL, 5),
        (recipe_id, 'Leche evaporada', 0.5, 'taza', 'Solo si falta líquido al licuar', 6),
        (recipe_id, 'Anís en grano', 0.5, 'cucharadita', 'Tostado y molido (para no encontrar granos)', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Procesado fino: Licuar el choclo con la mantequilla y un chorrito de leche. Debe quedar una crema espesa. Pasar POR TAMIZ o colador fino para eliminar todo el hollejo (piel del grano). Quedará una masa sedosa.', 15),
        (recipe_id, 2, 'Sazonado: Mezclar la masa colada con el azúcar, sal y anís molido. Probar (debe ser ligeramente dulce).', 5),
        (recipe_id, 3, 'Armado tipo Pastel: No envolver individualmente. Engrasar un molde o pirex. Colocar la mitad de la masa en el fondo. Poner una capa generosa de queso mantecoso. Cubrir con el resto de la masa.', 10),
        (recipe_id, 4, 'Cocción Vapor (Baño María): Cubrir el molde con papel aluminio herméticamente. Colocar el molde dentro de una asadera con agua caliente en el horno (180°C) o en olla grande con agua (fuego medio).', 5),
        (recipe_id, 5, 'Tiempo: Cocinar por 45-50 minutos. La masa cuajará como un flan firme pero muy suave ("baba de choclo"). El queso estará derretido.', 50),
        (recipe_id, 6, 'Servir tibio. Comer con cuchara. Se deshace en la boca sin residuos fibrosos.', 2);
        
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
        (recipe_id, 'Papa blanca o rosada', 1.5, 'kg', 'Harinosa, para buen puré', 1),
        (recipe_id, 'Leche evaporada', 1.5, 'tazas', 'Bien caliente', 2),
        (recipe_id, 'Mantequilla', 100, 'g', 'Para cremosidad', 3),
        (recipe_id, 'Queso Edam o Mozzarella', 250, 'g', 'Rallado o láminas (que funda bien)', 4),
        (recipe_id, 'Queso Parmesano', 50, 'g', 'Rallado fino (no trozos)', 5),
        (recipe_id, 'Huevos', 2, 'unidades', 'Separados claras y yemas', 6),
        (recipe_id, 'Nuez moscada', 0.5, 'cucharadita', 'Rallada', 7),
        (recipe_id, 'Sal y pimienta', NULL, 'al gusto', NULL, 8),
        (recipe_id, 'Anís', 0.5, 'cucharadita', 'Granos (opcional)', 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Puré base: Sancochar papas peladas hasta que se deshagan. Prensar caliente DOS VECES. Mezclar con la mantequilla y la leche caliente. Batir fuerte con cuchara de palo para airear y eliminar grumos.', 20),
        (recipe_id, 2, 'Sazonado: Agregar sal, pimienta y nuez moscada. Incorporar las yemas de huevo una a una, batiendo rápido para que no se cocinen.', 5),
        (recipe_id, 3, 'Aireado: Batir las claras a punto nieve e incorporar al puré con movimientos envolventes. Esto hará el pastel tipo soufflé (muy aireado y suave).', 5),
        (recipe_id, 4, 'Montaje: En molde engrasado, poner capa de puré (mitad). Cubrir con todo el queso Edam/Mozzarella. Tapar con el resto del puré. Alisar.', 5),
        (recipe_id, 5, 'Gratinado suave: Espolvorear parmesano. Llevar al horno 180°C por 30-40 min hasta que infle y dore LIGERAMENTE. No dejar quemar para evitar costra dura.', 35),
        (recipe_id, 6, 'Servir: Servir cuchareado. Es una nube de papa con queso fundido, cero resistencia al diente.', 2);
        
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
        (recipe_id, 'Mondongo nacional', 600, 'g', 'Limpio, sin grasa, picado en cubitos de 0.5cm (milimétrico)', 1),
        (recipe_id, 'Papa blanca', 4, 'unidades', 'Picada en cubitos de 1cm (para que espese)', 2),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada brunoise fina', 3),
        (recipe_id, 'Ajo', 3, 'dientes', 'Molido', 4),
        (recipe_id, 'Ají amarillo pasta', 3, 'cucharadas', 'Sin picante', 5),
        (recipe_id, 'Palillo (cúrcuma)', 1.5, 'cucharaditas', 'Polvo', 6),
        (recipe_id, 'Hierbabuena', 4, 'amas', 'Hojas enteras para retirar después', 7),
        (recipe_id, 'Caldo de res o pollo', 4, 'tazas', NULL, 8),
        (recipe_id, 'Arvejas', 0.5, 'taza', 'Opcional (si son muy tiernas, si no, omitir)', 9),
        (recipe_id, 'Sal y comino', NULL, 'al gusto', NULL, 10);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Pre-cocción extrema: Hervir el mondongo (cortado entero grandes trozos) en olla a presión con hierbabuena y leche (para blanquear) por 45-60 min hasta que esté SUAVE como gelatina. Dejar enfriar.', 60),
        (recipe_id, 2, 'Picado DTM: Retirar el mondongo cocido y picarlo en cubitos minúsculos (0.5cm). Si quedó duro, procesarlo ligeramente.', 15),
        (recipe_id, 3, 'Aderezo: Sofreír cebolla, ajo, ají amarillo y palillo por 10 min. Separación de aceite indica punto.', 10),
        (recipe_id, 4, 'Guisado: Agregar el mondongo picadito y el caldo. Hervir 15 min. Agregar las papas picadas. Cocinar hasta que las papas se deshagan y espesen el guiso naturalmente.', 20),
        (recipe_id, 5, 'Aroma: Agregar ramas de hierbabuena fresca al final para aromatizar y retirar antes de servir.', 2),
        (recipe_id, 6, 'Servir: Acompañar con arroz bien cocido. El mondongo no debe oponer resistencia, debe ser una textura gelatinosa suave en una salsa espesa de papa.', 2);
        
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
        (recipe_id, 'Choclo desgranado', 8, 'unidades', 'Bien tierno', 1),
        (recipe_id, 'Culantro fresco', 1.5, 'tazas', 'Hojas lavadas', 2),
        (recipe_id, 'Cebolla china parte verde', 1, 'taza', 'Picada', 3),
        (recipe_id, 'Manteca o Aceite vegetal', 0.75, 'taza', 'Para suavidad', 4),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada', 5),
        (recipe_id, 'Ajo', 2, 'dientes', 'Molido', 6),
        (recipe_id, 'Sal', 1, 'cucharada', NULL, 7),
        (recipe_id, 'Pancas de choclo', 10, 'unidades', 'Para envolver (opcional, se puede hacer en molde)', 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Licuado Verde: Licuar el choclo con el culantro y la cebolla china y un poco de agua o aceite. Debe ser una pasta verde muy lisa. TAMIZAR para quitar hollejos (esencial para DTM).', 10),
        (recipe_id, 2, 'Aderezo: Sofreír la cebolla roja y ajo en la manteca hasta que esté transparente y deshecha.', 8),
        (recipe_id, 3, 'Cocción de masa: Verter el licuado verde sobre el aderezo. Cocinar a fuego medio moviendo constantemente hasta que tome cuerpo, cambie a un verde más oscuro y brillante, y se desprenda de la olla (15-20 min).', 20),
        (recipe_id, 4, 'En molde (Más fácil para comer): En lugar de envolver, colocar la masa cocida en un molde refractario. Nivelar.', 5),
        (recipe_id, 5, 'Golpe de horno/vapor: Llevar al horno a baño maría por 20 minutos para terminar la cocción o simplemente servir la masa cocida de la olla (estilo "pepián verde").', 20),
        (recipe_id, 6, 'Servir: Acompañar con salsa criolla SOLO el jugo (sin cebolla) o con palta. La textura es de puré firme y suave.', 2);
        
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
        (recipe_id, 'Maíz morado', 500, 'g', 'Desgranado y corontaa', 1),
        (recipe_id, 'Piña Golden', 0.5, 'unidad', 'Pelada sin ojos, picada brunoise (3mm)', 2),
        (recipe_id, 'Manzana Delicia', 2, 'unidades', 'Pelada, picada brunoise (3mm)', 3),
        (recipe_id, 'Membrillo', 1, 'unidad', 'Pelado, picado brunoise (3mm)', 4),
        (recipe_id, 'Guindones', 10, 'unidades', 'Sin pepa, picados muy fino', 5),
        (recipe_id, 'Canela y clavo', NULL, 'cantidad necesaria', 'Para infusión', 6),
        (recipe_id, 'Azúcar', 1, 'taza', 'O edulcorante al gusto', 7),
        (recipe_id, 'Harina de camote o Chuño', 150, 'g', 'Disuelto en agua fría', 8),
        (recipe_id, 'Limón', 2, 'unidades', 'Jugo', 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Concentrado: Hervir el maíz morado, cáscara de piña, memblillo y especias en 3 litros de agua por 45 min hasta que el agua sea casi negra y concentrada. Colar.', 45),
        (recipe_id, 2, 'Cocción de fruta (Clave DTM): En el líquido colado hirviendo, agregar la piña, membrana y manzana picadas en BRUNOISE (cubitos de 3mm). Cocinar 15-20 minutos hasta que la fruta se deshaga en la boca. Agregar guindones picados.', 20),
        (recipe_id, 3, 'Dulzura: Agregar el azúcar y disolver bien.', 2),
        (recipe_id, 4, 'Espesado: Agregar el chuño/harina disuelto en un hilo, moviendo constantemente. Debe quedar espesa (punto gacha). Cocinar 5 min para quitar sabor a crudo.', 5),
        (recipe_id, 5, 'Final: Apagar fuego, añadir jugo de limón. Mezclar.', 1),
        (recipe_id, 6, 'Servir tibio. La fruta picada tan pequeña y cocida no requiere masticación, se traga junto con la mazamorra.', 2);
        
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
        (recipe_id, 'Yemas de huevo', 5, 'unidades', 'Coladas (sin la membrana)', 3),
        (recipe_id, 'Vainilla', 1, 'cucharadita', 'Esencia', 4),
        (recipe_id, 'Claras de huevo', 3, 'unidades', 'A temperatura ambiente', 5),
        (recipe_id, 'Azúcar blanca', 1, 'taza', 'Para el almíbar del merengue', 6),
        (recipe_id, 'Vino Oporto', 0.5, 'taza', 'Para el almíbar (generoso)', 7),
        (recipe_id, 'Canela en polvo', NULL, 'al gusto', 'Para espolvorear', 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Manjar de Yemas: En una olla de fondo grueso, mezclar leche condensada y evaporada. Cocinar a fuego lento moviendo con espátula de goma hasta que tome punto (aprox 25 min).', 25),
        (recipe_id, 2, 'Temperado: Retirar del fuego. Agregar las yemas coladas en hilo mientras se bate enérgicamente para que no se cocinen como huevo revuelto. Regresar al fuego 2 minutos sin dejar de mover hasta que espese más.', 5),
        (recipe_id, 3, 'Aromatizar: Agregar vainilla, colar la mezcla (opcional, para lisura extrema) y servir en copas. Dejar enfriar.', 10),
        (recipe_id, 4, 'Merengue al Oporto: Hacer un almíbar con el azúcar y el Oporto hasta punto "hilo fuerte" (burbujas lentas).', 10),
        (recipe_id, 5, 'Batido: Batir las claras a punto nieve. Agregar el almíbar de Oporto hirviendo en hilo fino sin dejar de batir (merengue italiano). Batir hasta que el bowl enfríe y el merengue sea brilloso y firme.', 10),
        (recipe_id, 6, 'Decorar: Coronar las copas con el merengue (usar manga si desea). Espolvorear canela. Textura: Nube dulce sobre crema densa.', 5);
        
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
        (recipe_id, 'Pulpa de lúcuma', 2, 'tazas', 'Madura, procesada sin cáscara ni pepa', 1),
        (recipe_id, 'Leche condensada', 1, 'lata', 'Ajustar s/dulzor de lúcuma', 2),
        (recipe_id, 'Crema de leche (nata)', 2, 'tazas', 'Bien fría para batir', 3),
        (recipe_id, 'Colapez (gelatina sin sabor)', 1, 'hoja', 'O 1 cdta polvo hidratado (opcional para consistencia)', 4),
        (recipe_id, 'Leche fresca', 0.25, 'taza', 'Para disolver pulpa o colapez', 5),
        (recipe_id, 'Chocolate rallado', 2, 'cucharadas', 'Para decorar (polvo)', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Procesar: Licuar la pulpa de lúcuma con la leche condensada y el chorrito de leche fresca hasta obtener una crema densa muy lisa. Si la lúcuma es harinosa, colar para quitar grumos.', 5),
        (recipe_id, 2, 'Hidratar: Si usa colapez, hidratar y disolver en caliente. Mezclar con la crema de lúcuma (temperar para que no cuaje rápido).', 5),
        (recipe_id, 3, 'Airear: Batir la crema de leche a punto chantilly (picos medios).', 5),
        (recipe_id, 4, 'Envolver: Mezclar una parte de chantilly con la lúcuma para aligerar. Luego verter toda la mezcla de lúcuma sobre el resto de chantilly y mezclar con espátula en movimientos envolventes.', 5),
        (recipe_id, 5, 'Refrigerar: Servir en copas y refrigerar 3 horas. La textura será de mousse aireado.', 180),
        (recipe_id, 6, 'Decorar con chocolate rallado fino. Se disuelve en la lengua.', 2);
        
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
        (recipe_id, 'Plátanos de seda maduros', 4, 'unidades', 'Con pintitas negras (muy dulces y suaves)', 1),
        (recipe_id, 'Leche evaporada', 1, 'lata', 'Sin diluir', 2),
        (recipe_id, 'Leche condensada', 1, 'lata', 'Para dulzor y textura', 3),
        (recipe_id, 'Huevos', 5, 'unidades', 'Enteros', 4),
        (recipe_id, 'Vainilla', 1, 'cucharadita', NULL, 5),
        (recipe_id, 'Azúcar', 0.5, 'taza', 'Para caramelo', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Caramelo: Hacer un caramelo líquido con el azúcar en el molde. Cubrir fondo y paredes. Enfriar.', 10),
        (recipe_id, 2, 'Licuado total: Poner en la licuadora los plátanos trozados, la leche evaporada, leche condensada, huevos y vainilla. Licuar por 3 minutos hasta que sea una mezcla espumosa y totalmente homogénea.', 5),
        (recipe_id, 3, 'Colado (Opcional): Si se desea extra fino, colar la mezcla al verter en el molde caramelizado.', 2),
        (recipe_id, 4, 'Baño María: Hornear a 160°C (horno medio-bajo) dentro de una asadera con agua caliente por 60-70 minutos.', 70),
        (recipe_id, 5, 'Verificación: Insertar un palillo, debe salir limpio. No sobrecocinar para que no salgan huequitos (burbujas).', 2),
        (recipe_id, 6, 'Enfriar y refrigerar toda la noche para que compacte.', 480),
        (recipe_id, 7, 'Desmoldar. El plátano le da una cremosidad densa especial.', 5);
        
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
        (recipe_id, 'Semillas de chía', 0.25, 'taza', 'No sustituir, es la base', 1),
        (recipe_id, 'Leche de coco', 1.5, 'tazas', 'O leche de almendras (más líquido es mejor)', 2),
        (recipe_id, 'Miel, agave o maple', 2, 'cucharadas', 'Líquido para disolver fácil', 3),
        (recipe_id, 'Vainilla', 1, 'cucharadita', 'Extracto', 4),
        (recipe_id, 'Mango', 0.5, 'taza', 'Licuado tipo salsa (coulis)', 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Mezcla inicial: En un frasco o bowl, combinar las semillas de chía, la leche de coco, el endulzante y vainilla.', 2),
        (recipe_id, 2, 'Batido vigoroso: Batir con tenedor o batidor de alambre por 1 minuto completo para asegurar que las semillas no se peguen en grumos.', 1),
        (recipe_id, 3, 'Reposo estratégico: Esperar 5 minutos y batir de nuevo. Esto es crucial para la suspensión.', 5),
        (recipe_id, 4, 'Hidratación larga: Refrigerar toda la noche (mínimo 6 horas). La chía soltará mucílago creando un gel espeso ("pudín").', 360),
        (recipe_id, 5, 'Servir: Servir cubierto con el mango licuado. Las semillas estarán envueltas en gel y pasarán por la garganta sin raspar ni masticar (como perlas de tapioca finas).', 2);
        
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
        (recipe_id, 'Harina de maíz amarillo', 1.5, 'tazas', 'Fina (tipo polenta fina o harina)', 1),
        (recipe_id, 'Chancaca (panela)', 250, 'g', 'Troceada o rallada', 2),
        (recipe_id, 'Manteca vegetal o mantequilla', 100, 'g', 'Para suavidad', 3),
        (recipe_id, 'Agua', 4, 'tazas', 'Cantidad necesaria para hidratar', 4),
        (recipe_id, 'Clavo, canela y anís', NULL, 'al gusto', 'Para el agua', 5),
        (recipe_id, 'Pasas', 2, 'cucharadas', 'Picadas muy fino (opcional)', 6),
        (recipe_id, 'Grageas de colores', 1, 'cucharadita', 'Decoración (se disuelven, no morder)', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Miel especiada: Hervir la chancaca en el agua con clavo, canela y anís. Colar. Debe quedar un líquido dulce oscuro.', 15),
        (recipe_id, 2, 'Tostado (Sabor): Tostar ligeramente la harina de maíz en una olla seca con cuidado de no quemar (solo calentar para activar aroma).', 5),
        (recipe_id, 3, 'Mezcla grasa: Agregar la manteca a la harina caliente y mezclar hasta que se absorba (arenado húmedo).', 3),
        (recipe_id, 4, 'Cocción lenta: Ir agregando la miel de chancaca caliente poco a poco, moviendo enérgicamente con cuchara de palo. Se formará una masa pegajosa.', 10),
        (recipe_id, 5, 'Punto Sanguito: Cocinar a fuego lento moviendo hasta que la masa brille, se desprenda de la olla y tenga textura elástica suave (como plastilina muy blanda).', 15),
        (recipe_id, 6, 'Servir tibio. Decorar con pasas picaditas. La textura es densa pero se deshace con la saliva, muy energética.', 2);
        
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
        (recipe_id, 'Harina de trigo', 1, 'taza', 'Disuelta en líquido frío', 1),
        (recipe_id, 'Chancaca', 400, 'g', 'Troceada', 2),
        (recipe_id, 'Leche evaporada', 1, 'lata', '410g', 3),
        (recipe_id, 'Agua', 3, 'tazas', 'Para la miel', 4),
        (recipe_id, 'Clavo de olor y canela', NULL, 'cantidad necesaria', NULL, 5),
        (recipe_id, 'Anís en grano', 1, 'cucharadita', NULL, 6),
        (recipe_id, 'Mantequilla', 1, 'cucharada', 'Para brillo final', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Infusión: Hervir el agua con la chancaca, clavo, canela y anís hasta que la chancaca se disuelva y tenga sabor intenso. COLAR.', 20),
        (recipe_id, 2, 'Base láctea: Agregar la leche evaporada al líquido de chancaca. Bajar el fuego.', 2),
        (recipe_id, 3, 'Espesante: Disolver la harina de trigo en un poco de agua fría (sin grumos).', 5),
        (recipe_id, 4, 'Cocción (Gacha): Verter la harina disuelta en la olla caliente en forma de hilo, moviendo constantemente con batidor de globo (esencial para evitar bolas).', 5),
        (recipe_id, 5, 'Punto: Cocinar a fuego bajo por 15 minutos sin dejar de mover. Espesará como una crema pastelera oscura. Si queda muy espesa, aligerar con agua hervida.', 15),
        (recipe_id, 6, 'Final: Agregar la mantequilla cocida. Servir caliente. Es muy suave, dulce y reconfortante para la garganta.', 2);
        
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
        (recipe_id, 'Pan francés o de molde', 6, 'unidades', 'Tostado y trozado (se va a remojar)', 1),
        (recipe_id, 'Chancaca', 400, 'g', 'Gran bloque', 2),
        (recipe_id, 'Queso fresco', 200, 'g', 'Cortado en cubos', 3),
        (recipe_id, 'Nueces/Pecanas', 0.25, 'taza', 'Picadas casi polvo', 4),
        (recipe_id, 'Coco rallado', 2, 'cucharadas', 'Fino', 5),
        (recipe_id, 'Clavo y canela', NULL, 'al gusto', NULL, 6),
        (recipe_id, 'Vino Oporto', 2, 'cucharadas', 'Opcional', 7),
        (recipe_id, 'Mantequilla', 1, 'cucharada', NULL, 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Jarabe: Hacer una miel con la chancaca, agua (que cubra), clavo, canela y cáscara de naranja si tiene. Hervir hasta punto de miel ligera. Colar.', 20),
        (recipe_id, 2, 'Impregnación: En la misma olla con la miel caliente, echar los trozos de pan tostado. Dejar que se empapen y ablanden. El pan debe perder su forma crujiente y volverse esponja húmeda.', 5),
        (recipe_id, 3, 'Adiciones: Agregar el queso fresco, el coco y las pecanas molidas. Mezclar suavemente. El queso se ablandará con el calor.', 3),
        (recipe_id, 4, 'Aroma: Echar la mantequilla y el Oporto. Cocinar 2 minutos más para integrar sabores.', 2),
        (recipe_id, 5, 'Servir: Servir tibio. Es una mezcla dulce, salada, suave y húmeda. No debe haber bordes de pan duros (si hay, empujar al fondo para remojar más).', 2);
        
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
        (recipe_id, 'Frejol negro o canario', 500, 'g', 'Remojado día anterior', 1),
        (recipe_id, 'Azúcar morena o chancaca', 400, 'g', 'Para dulzor profundo', 2),
        (recipe_id, 'Leche evaporada', 1, 'lata', '410g', 3),
        (recipe_id, 'Clavo de olor', 4, 'unidades', 'Molido o entero para retirar', 4),
        (recipe_id, 'Canela', 1, 'cucharadita', 'Polvo', 5),
        (recipe_id, 'Ajonjolí', 2, 'cucharadas', 'Tostado y molido (decoración)', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocción extrema: Hervir los frejoles (sin sal) hasta que la piel se desprenda sola y estén muy cremosos (aprox 1.5 horas).', 90),
        (recipe_id, 2, 'Licuado y Colado (Vital): Licuar los frejoles con su agua y la leche evaporada. PASAR POR COLADOR FINO (tamiz) obligatoriamente. Descartar todas las cáscaras (hollejos). Quedará una crema grisácea lisa.', 15),
        (recipe_id, 3, 'Punto Dulce: Poner la crema colada en la olla, agregar azúcar/chancaca y especias. Cocinar a fuego medio moviendo constantemente.', 10),
        (recipe_id, 4, 'Reducción: Cocinar moviendo (salpica mucho, cuidado) hasta que tome color oscuro y espese mucho (punto manjar). Al pasar la cuchara se ve el fondo.', 30),
        (recipe_id, 5, 'Servir: Servir frío en dulceras. Espolvorear ajonjolí molido (asegurar que sea polvo, no semilla entera dura). Es una pasta energética y suave, excelente fuente de hierro.', 5);
        
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
        (recipe_id, 'Arroz grano corto', 1, 'taza', 'Tiene más almidón (más cremoso)', 1),
        (recipe_id, 'Agua', 4, 'tazas', 'Para cocción inicial del arroz', 2),
        (recipe_id, 'Leche evaporada', 1, 'lata', '410g', 3),
        (recipe_id, 'Chancaca', 250, 'g', 'Rallada o trozada', 4),
        (recipe_id, 'Coco rallado', 0.5, 'taza', 'Fino (opcional)', 5),
        (recipe_id, 'Pasas negras', 0.5, 'taza', 'Picadas', 6),
        (recipe_id, 'Canela, clavo, cáscara naranja', NULL, 'al gusto', 'Para infusionar', 7),
        (recipe_id, 'Nueces/Pecanas', 2, 'cucharadas', 'Molidas en polvo (decoración)', 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Infusión: Hervir el agua con canela, clavo y cáscara de naranja por 10 min. Retirar especias.', 10),
        (recipe_id, 2, 'Reventado del Arroz: Agregar el arroz al agua aromatizada hirviendo. Cocinar hasta que el arroz se abra ("reviente") y el agua se consuma casi toda. El grano debe estar muy blando.', 20),
        (recipe_id, 3, 'Melado: Agregar la chancaca, el coco y las pasas picadas. Cocinar hasta que la chancaca se disuelva.', 5),
        (recipe_id, 4, 'Cremosidad: Agregar la leche. Cocinar a fuego bajo moviendo constantemente hasta que tome punto cremoso. El arroz debe estar casi deshecho.', 15),
        (recipe_id, 5, 'Servir: Tibio o frío. Espolvorear polvo de pecanas. Textura melosa y suave, sin necesidad de masticar el grano.', 5);
        
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
        (recipe_id, 'Leche fresca entera', 1, 'litro', 'Mejor sabor que evaporada', 1),
        (recipe_id, 'Huevos', 6, 'unidades', 'Temperatura ambiente', 2),
        (recipe_id, 'Azúcar blanca', 1, 'taza', 'Para la mezcla', 3),
        (recipe_id, 'Vainilla', 1, 'cucharada', 'Esencia', 4),
        (recipe_id, 'No lleva caramelo', 0, 'unidad', 'Diferencia con crema volteada', 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Mezcla tibia: Tibiar la leche con el azúcar hasta que se disuelva (no hervir). Agregar vainilla.', 5),
        (recipe_id, 2, 'Batido suave: Batir los huevos ligeramente (sin hacer espuma). Integrar con la leche tibia poco a poco.', 5),
        (recipe_id, 3, 'Colado Importante: Pasar la mezcla por un colador fino 2 o 3 veces para eliminar chalazas del huevo y burbujas. Esto asegura textura lisa.', 5),
        (recipe_id, 4, 'Horneado: Verter en pirex o moldes individuales. Llevar al horno a Baño María a 160°C. El agua del baño maría debe estar caliente.', 5),
        (recipe_id, 5, 'Tiempo y Dorado: Hornear 45-60 min. La superficie dorará naturalmente. Insertar cuchillo, debe salir limpio.', 60),
        (recipe_id, 6, 'Enfriar: Dejar enfriar completamente. La textura interior es cuajada suave ("flan"), la costra superior es delgada y suave.', 120);
        
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
        (recipe_id, 'Leche condensada', 1, 'lata', '395g', 1),
        (recipe_id, 'Leche evaporada', 1, 'lata', '410g', 2),
        (recipe_id, 'Huevos', 6, 'unidades', 'Enteros', 3),
        (recipe_id, 'Vainilla', 1, 'cucharadita', NULL, 4),
        (recipe_id, 'Azúcar', 1, 'taza', 'Para el caramelo', 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Caramelo: Fundir el azúcar en el molde directamente (con cuidado) o en sartén hasta color ámbar (no quemar o amarga). Cubrir fondo y paredes. ENFRIAR.', 10),
        (recipe_id, 2, 'Mezcla lisa: Licuar las leches y los huevos por poco tiempo (solo para integrar).', 2),
        (recipe_id, 3, 'Colado (Vital): Colar la mezcla sobre el molde caramelizado para quitar cualquier espuma o residuo de huevo. Si tiene espuma, dejar reposar o quitar con cuchara. Queremos "Cero Huequitos".', 5),
        (recipe_id, 4, 'Baño María: Hornear a 150°C (bajo) por 60-75 minutos. La temperatura baja evita que hierva y salgan agujeros.', 75),
        (recipe_id, 5, 'Enfriar: Dejar enfriar a temperatura ambiente y luego refrigerar TODA la noche (necesario para desmoldar bien).', 480),
        (recipe_id, 6, 'Desmoldar: Pasar cuchillo fino por borde, voltear rápido. Textura de espejo, lisa y cremosa.', 5);
        
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
        (recipe_id, 'Maíz Mote', 500, 'g', 'Pelado y cocido (muy suave)', 1),
        (recipe_id, 'Guanábana', 1, 'kg', 'Pulpa madura, sin pepas', 2),
        (recipe_id, 'Piña', 0.5, 'unidad', 'Picada brunoise fino', 3),
        (recipe_id, 'Membrillo', 1, 'unidad', 'Picado brunoise fino', 4),
        (recipe_id, 'Chancaca y Azúcar', 250, 'g', 'Mitad y mitad', 5),
        (recipe_id, 'Harina de maíz', 0.5, 'taza', 'Para espesar', 6),
        (recipe_id, 'Canela, clavo, hojas de naranjo', NULL, 'al gusto', 'Para agua aromática', 7),
        (recipe_id, 'Limón', 1, 'unidad', 'Jugo', 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Agua de Mota: Hervir el mote en abundante agua con cáscara de piña y especias hasta que reviente y esté sumamente blando (tipo puré). Descartar cáscaras/especias.', 60),
        (recipe_id, 2, 'Frutas: Agregar piña y membrillo picados finitos (3mm). Cocinar 15 min.', 15),
        (recipe_id, 3, 'Dulzor y Sabor: Agregar la chancaca y azúcar. Disolver.', 2),
        (recipe_id, 4, 'Espesado: Disolver la harina de maíz en agua fría y agregar al champús. Cocinar moviendo hasta espesor deseado.', 10),
        (recipe_id, 5, 'Guanábana: Al final, fuera del fuego o últimos 2 min, agregar la pulpa de guanábana deshuesada. No hervir mucho para no amargar y mantener su frescura.', 2),
        (recipe_id, 6, 'Servir caliente. El mote debe estar tan cocido que no requiere fuerza para masticar.', 2);
        
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
        (recipe_id, 'Camote Lacinato o amarillo', 1, 'kg', 'Pelado y cortado en rodajas gruesas', 1),
        (recipe_id, 'Chancaca', 250, 'g', 'Trozada', 2),
        (recipe_id, 'Azúcar', 0.5, 'taza', 'Rubia', 3),
        (recipe_id, 'Jugo de naranja', 1, 'taza', 'Natural', 4),
        (recipe_id, 'Canela', 2, 'ramas', NULL, 5),
        (recipe_id, 'Clavo de olor', 3, 'unidades', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Base líquida: En una olla ancha, colocar la chancaca, azúcar, jugo de naranja, agua (1 taza), canela y clavo. Hervir hasta disolver.', 10),
        (recipe_id, 2, 'Cocción Camote: Acomodar las rodajas de camote en una sola capa (idealmente) o máximo dos. Tapar y cocinar a fuego bajo.', 20),
        (recipe_id, 3, 'Confitado: Cuando el camote esté cocido, destapar y dejar reducir el líquido hasta que se forme un almíbar brillante que glasee los camotes. Bañar los camotes con cuchara.', 15),
        (recipe_id, 4, 'Servir: Servir tibio con el almíbar. El camote es naturalmente suave, pero con esta cocción se vuelve mantequilla.', 2);
        
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
        (recipe_id, 'Membrillos maduros', 1, 'kg', 'Pelados y sin corazón', 1),
        (recipe_id, 'Azúcar blanca', 750, 'g', 'Ajustar si gusta menos dulce', 2),
        (recipe_id, 'Agua', 1, 'taza', 'Solo para iniciar cocción', 3),
        (recipe_id, 'Jugo de limón', 1, 'cucharada', 'Evita oxidación', 4),
        (recipe_id, 'Canela', 1, 'rama', 'Opcional', 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocción inicial: Cortar membrillos en cubos. Cocinar con el agua y canela tapado a fuego bajo hasta que estén muy suaves (como puré).', 30),
        (recipe_id, 2, 'Procesado: Retirar canela. Licuar o procesar el membrillo cocido hasta obtener un puré FINA. Si hay grumos, colar.', 5),
        (recipe_id, 3, 'Punto Dulce: Poner el puré en olla de fondo grueso. Agregar azúcar y limón. Cocinar a fuego medio-bajo moviendo constantemente con cuchara de palo.', 45),
        (recipe_id, 4, 'Reducción: Cocinar hasta que la mezcla se desprenda de las paredes de la olla y al pasar la cuchara deje un surco limpio (aprox 45-60 min). Tomará color rojizo.', 15),
        (recipe_id, 5, 'Moldeado: Verter caliente en molde rectangular forrado con papel film o engrasado.', 5),
        (recipe_id, 6, 'Enfriar: Dejar enfriar completamente 24h para que corte. Para DTM, servir láminas delgadas o cubitos que se disuelven en boca.', 2);
        
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
        (recipe_id, 'Garbanzos cocidos', 2, 'tazas', 'Sin piel (pelados uno por uno o frotados)', 1),
        (recipe_id, 'Tahini (pasta sésamo)', 3, 'cucharadas', NULL, 2),
        (recipe_id, 'Limón', 1, 'unidad', 'Jugo', 3),
        (recipe_id, 'Ajo', 1, 'diente', 'Sin corazón, hervido previamente (menos fuerte)', 4),
        (recipe_id, 'Aceite de oliva', 4, 'cucharadas', 'Extra virgen', 5),
        (recipe_id, 'Comino', 0.25, 'cucharadita', NULL, 6),
        (recipe_id, 'Agua helada', 3, 'cucharadas', 'Para emulsionar', 7),
        (recipe_id, 'Pan Pita', 4, 'unidades', 'Blanco (sin semillas), muy fresco', 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Preparación Garbanzo: Si usa garbanzos de lata o caseros, quitarles la piel transparente. Esto cambia la textura de grumosa a sedosa. Hervir 10 min más hasta que se deshagan.', 10),
        (recipe_id, 2, 'Licuado: Procesar garbanzos calientes con tahini, limón, ajo, aceite y comino. Licuar por 3 minutos.', 3),
        (recipe_id, 3, 'Emulsión: Agregar agua helada poco a poco mientras se licúa. El hummus se volverá pálido y esponjoso (tipo mousse).', 2),
        (recipe_id, 4, 'Pan: Calentar el pan pita al vapor o microondas (en bolsa) para que esté húmedo y gomoso, no tostado.', 2),
        (recipe_id, 5, 'Servir: Un plato de hummus con aceite de oliva encima. Comer cuchareando con el pan blando.', 1);
        
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
        (recipe_id, 'Sangrecita de pollo', 500, 'g', 'Ya sancochada, textura migas', 1),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada brunoise (fina)', 2),
        (recipe_id, 'Cebolla china', 0.5, 'taza', 'Parte verde picada fina', 3),
        (recipe_id, 'Ají amarillo', 2, 'cucharadas', 'Pasta sin picante', 4),
        (recipe_id, 'Ajo', 2, 'dientes', 'Molido', 5),
        (recipe_id, 'Hierbabuena', 2, 'ramas', 'Hojas picadas fino', 6),
        (recipe_id, 'Papas fritas', 0, 'unidad', 'OMITIR papas fritas o reemplazar por papa sancochada en cubos', 7),
        (recipe_id, 'Aceite', 3, 'cucharadas', NULL, 8),
        (recipe_id, 'Caldo de pollo', 0.5, 'taza', 'Para dar humedad', 9);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Preparar Sangre: Lavar la sangrecita cocida y desmigajarla con las manos o tenedor hasta que quede como arena gruesa suave.', 5),
        (recipe_id, 2, 'Aderezo: Sofreír cebolla roja y ajo en aceite hasta transparentar (8 min). Agregar ají amarillo.', 8),
        (recipe_id, 3, 'Guisado: Agregar la sangrecita y mezclar. IMPORTANTE: Añadir el caldo de pollo para que no quede seca ("atoradora"). Cocinar 10 min para que absorba sabor.', 10),
        (recipe_id, 4, 'Toque final: Agregar hierbabuena y cebolla china picadas. Mezclar y apagar (no recocinar verduras).', 2),
        (recipe_id, 5, 'Servir: Acompañar con yuca sancochada muy suave o papa al vapor. La sangrecita debe estar jugosa.', 1);
        
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
        (recipe_id, 'Patas de res', 1, 'kg', 'Limpias y trozadas', 1),
        (recipe_id, 'Maní tostado', 150, 'g', 'Molido pasta (tipo mantequilla)', 2),
        (recipe_id, 'Papa blanca', 4, 'unidades', 'Picada en cubos 1cm', 3),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada brunoise', 4),
        (recipe_id, 'Ajo', 3, 'dientes', 'Molido', 5),
        (recipe_id, 'Ají panca', 3, 'cucharadas', 'Pasta', 6),
        (recipe_id, 'Hierbabuena', 1, 'rama', 'Entera', 7),
        (recipe_id, 'Orégano', 1, 'cucharadita', 'Seco', 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Gelatinización: Cocinar las patas con sal y hierbabuena en olla a presión por 60 minutos (o 3 horas olla normal) hasta que los huesos se salgan solos.', 60),
        (recipe_id, 2, 'Picado: Retirar huesos. Picar la piel y tendones en cubitos de 1cm. Reservar el caldo (colágeno puro).', 15),
        (recipe_id, 3, 'Aderezo: Sofreír cebolla, ajo y ají panca 15 min.', 15),
        (recipe_id, 4, 'Guisado: Agregar la pata picada, las papas en cubos y cubrir con el caldo reservado. Cocinar hasta que la papa se deshaga un poco.', 20),
        (recipe_id, 5, 'Espesado: Disolver el maní molido en un poco de caldo y agregar. Cocinar 5 min hasta que espese.', 5),
        (recipe_id, 6, 'Servir: Plato muy pegajoso y suave. La pata se desliza, no se mastica. Acompañar con arroz.', 2);
        
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
        (recipe_id, 'Ollucos', 500, 'g', 'Picados en juliana MUY fina', 1),
        (recipe_id, 'Carne de res', 250, 'g', 'Molida (doble pasada) o picada microscópica', 2),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada fina', 3),
        (recipe_id, 'Ajo', 2, 'dientes', 'Molido', 4),
        (recipe_id, 'Ají panca', 1, 'cucharada', 'Color', 5),
        (recipe_id, 'Ají amarillo', 1, 'cucharada', 'Sabor', 6),
        (recipe_id, 'Perejil', 1, 'cucharada', 'Picado polvo', 7),
        (recipe_id, 'Aceite', 3, 'cucharadas', NULL, 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Aderezo base: Sofreír cebolla, ajo y los ajíes hasta que se separe el aceite.', 10),
        (recipe_id, 2, 'Carne: Agregar la carne MOLIDA (no trozos). Cocinar bien separando grumos.', 8),
        (recipe_id, 3, 'Olluco: Agregar el olluco picado finamente. Tapar y bajar el fuego al mínimo. El olluco soltará su propia agua.', 5),
        (recipe_id, 4, 'Cocción Lenta: Cocinar por 25-30 minutos en su jugo. El olluco debe estar muy tierno y el jugo debe volverse "baboso" (espesado natural).', 30),
        (recipe_id, 5, 'Final: Agregar perejil picadito. Mezclar.', 1),
        (recipe_id, 6, 'Servir: Con arroz blanco. El plato es resbaloso y fácil de tragar, ideal para DTM.', 2);
        
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
        (recipe_id, 'Caiguas', 8, 'unidades', 'Elegir las más tiernas y verdes claras', 1),
        (recipe_id, 'Carne molida', 400, 'g', 'Doble molienda (muy fina)', 2),
        (recipe_id, 'Pan de molde', 3, 'rebanadas', 'Sin corteza, remojado en leche', 3),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada finísima', 4),
        (recipe_id, 'Huevo', 2, 'unidades', '1 crudo para ligar, 1 duro picado', 5),
        (recipe_id, 'Pasas', 2, 'cucharadas', 'Picadas (para suavidad y dulce)', 6),
        (recipe_id, 'Caldo de carne', 2, 'tazas', 'Para la cocción', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Pre-cocción Caigua: Cortar punta, limpiar semillas. Hervir en agua con sal 15 min hasta que estén blandas. Esto es crucial para que la piel no sea fibrosa.', 15),
        (recipe_id, 2, 'Relleno Suave: Mezclar la carne molida fina con el pan remojado (hecho puré), cebolla, huevo crudo y pasas picadas. Debe ser una masa húmeda tipo albóndiga.', 10),
        (recipe_id, 3, 'Rellenado: Rellenar las caiguas con la masa sin apretar demasiado (la carne expande).', 10),
        (recipe_id, 4, 'Estofado: Colocar las caiguas en una olla con el caldo (no freír). Tapar y cocinar a fuego bajo por 40 min. El relleno se cocinará al vapor dentro y la caigua se pondrá mantequilla.', 40),
        (recipe_id, 5, 'Servir: Bañar con su propio jugo espesado. Se corta solo con el tenedor.', 2);
        
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
        (recipe_id, 'Asado de tira o carne para guiso', 1, 'kg', 'Sin hueso, en trozos grandes', 1),
        (recipe_id, 'Culantro licuado', 2, 'tazas', 'Pasta verde intensa', 2),
        (recipe_id, 'Chicha de jora o Cerveza negra', 1, 'taza', 'Para ablandar', 3),
        (recipe_id, 'Zapallo Loche', 150, 'g', 'Rallado (espesante natural)', 4),
        (recipe_id, 'Arvejas', 1, 'taza', 'Pre-cocidas muy suaves', 5),
        (recipe_id, 'Cebolla roja', 2, 'unidades', 'Picada fina', 6),
        (recipe_id, 'Aceite', 3, 'cucharadas', NULL, 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Maceración (Enzimática): Macerar la carne con la chicha/cerveza y culantro por 2 horas. El alcohol y ácidos ablandan fibras.', 120),
        (recipe_id, 2, 'Aderezo y Sellado: En olla a presión (preferible), sofreír cebolla y ajo. Agregar la carne y dorar levemente.', 10),
        (recipe_id, 3, 'Cocción Presión: Agregar el líquido de maceración y el zapallo loche rallado. Tapar olla presión y cocinar 45-60 min. (O 2.5 horas olla normal).', 60),
        (recipe_id, 4, 'Verificación: Abrir olla. La carne debe deshilacharse sola al tocarla. Si no, cocinar más.', 10),
        (recipe_id, 5, 'Toque final: Agregar las arvejas ya cocidas solo para calentar en la salsa espesa.', 5),
        (recipe_id, 6, 'Servir con arroz muy graneado pero suave (o puré). Bañar con mucha salsa verde. Carne tipo "mechada".', 2);
        
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
        (recipe_id, 'Pollo (Pierna con encuentro)', 4, 'piezas', 'Sin piel (carne oscura es más jugosa)', 1),
        (recipe_id, 'Tomate', 4, 'unidades', 'Pelados y licuados (pasta)', 2),
        (recipe_id, 'Zanahoria', 2, 'unidades', 'En rodajas finas (muy cocidas)', 3),
        (recipe_id, 'Hongo y Laurel', NULL, 'unidad', 'Para sabor', 4),
        (recipe_id, 'Pasas', 2, 'cucharadas', 'Hidratadas', 5),
        (recipe_id, 'Papa amarilla', 4, 'unidades', 'Peladas (se deshacen y espesan)', 6),
        (recipe_id, 'Vino dulce', 0.5, 'taza', NULL, 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Sellado ligero: Dorar las presas de pollo salpimentadas muy ligeramente (no formar costra dura). Retirar.', 8),
        (recipe_id, 2, 'Salsa Madre: Sofreír cebolla + ajo + tomate licuado + hongo/laurel. Cocinar 15 min hasta que esté rojo oscuro.', 15),
        (recipe_id, 3, 'Estofado: Regresar el pollo. Añadir vino, zanahoria y las papas amarillas enteras. Tapar.', 2),
        (recipe_id, 4, 'Cocción Vapor: Cocinar a fuego mínimo por 45 min. El pollo debe soltar su jugo. La papa amarilla se abrirá espesando la salsa.', 45),
        (recipe_id, 5, 'Servir: La carne del pollo se debe salir del hueso con cuchara. La salsa es espesa y dulce (por las pasas/zanahoria).', 2);
        
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
        (recipe_id, 'Spaghetti', 500, 'g', 'Cocido extra suave', 1),
        (recipe_id, 'Carne molida especial', 400, 'g', 'Doble pasada (fina)', 2),
        (recipe_id, 'Tomates italianos', 6, 'unidades', 'Maduros, licuados sin piel', 3),
        (recipe_id, 'Zanahoria', 1, 'unidad', 'Rallada finísima (desaparece)', 4),
        (recipe_id, 'Hongo y Laurel', NULL, 'al gusto', NULL, 5),
        (recipe_id, 'Queso parmesano', NULL, 'al gusto', 'Rallado polvo', 6),
        (recipe_id, 'Aceite de oliva', 2, 'cucharadas', NULL, 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Tuco (Salsa): Sofreír cebolla y ajo. Agregar carne molida y cocinar bien deshaciendo grumos con tenedor. Agregar zanahoria rallada.', 15),
        (recipe_id, 2, 'Tomate: Agregar el tomate licuado, hongo y laurel. Tapar y cocinar a fuego lento por 40 MINUTOS. La larga cocción deshace fibras de carne y verduras.', 40),
        (recipe_id, 3, 'Pasta Suave: Cocinar fideos 3-4 minutos MÁS de lo indicado. Deben estar hinchados y muy blandos.', 15),
        (recipe_id, 4, 'Mezcla: Echar los fideos DENTRO de la salsa y mezclar un minuto. La pasta absorbe salsa y se lubrica.', 2),
        (recipe_id, 5, 'Servir: Con queso parmesano polvo. Plato muy húmedo, no requiere fuerza al comer.', 2);
        
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
        (recipe_id, 'Hígado de res', 600, 'g', 'Limpio, sin membrana, laminado fino', 1),
        (recipe_id, 'Cebolla roja', 2, 'unidades', 'Corte pluma grueso (sudado)', 2),
        (recipe_id, 'Tomate', 2, 'unidades', 'Gajos pelados', 3),
        (recipe_id, 'Vinagre tinto', 0.25, 'taza', 'Para macerar', 4),
        (recipe_id, 'Ají amarillo', 1, 'cucharada', 'Pasta', 5),
        (recipe_id, 'Perejil', 1, 'cucharada', 'Picado', 6),
        (recipe_id, 'Caldo', 0.5, 'taza', 'Para jugo', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Limpieza y Corte: Retirar TODA la membrana externa del hígado (es lo duro). Cortar en tiras tamaño bocado.', 10),
        (recipe_id, 2, 'Maceración: Macerar hígado con vinagre, sal pimienta y ají por 30 min. El ácido ablanda. ', 30),
        (recipe_id, 3, 'Cocción Flash (Opción 1 - Tierno): Saltear el hígado a fuego muy alto por 2 minutos. Sacar. Si se pasa se pone duro.', 5),
        (recipe_id, 4, 'Salsa: En la misma sartén, poner cebolla, tomate y caldo. Cocinar tapado hasta que la cebolla esté muy blanda (no crocante).', 10),
        (recipe_id, 5, 'Retorno: Regresar el hígado a la sartén con el jugo caliente, solo 1 minuto para calentar. Apagar.', 2),
        (recipe_id, 6, 'Servir: Inmediatamente. El hígado estará rosado y suave. La cebolla babosa.', 1);
        
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
        (recipe_id, 'Cerdo (Bondiola o pierna)', 1, 'kg', 'Sin hueso, trozos medianos', 1),
        (recipe_id, 'Chicha de jora', 3, 'tazas', 'Sin endulzar (ácida)', 2),
        (recipe_id, 'Ají panca', 0.5, 'taza', 'Pasta', 3),
        (recipe_id, 'Comino', 1, 'cucharada', 'Recién molido', 4),
        (recipe_id, 'Cebolla roja', 2, 'unidades', 'Corte grueso (se deshace)', 5),
        (recipe_id, 'Rocoto', 1, 'unidad', 'Entero para sabor (SIN picar)', 6),
        (recipe_id, 'Orégano', 1, 'cucharada', 'Seco', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Maceración (Esencial): Macerar el cerdo con chicha, ají panca, sal, pimienta, comino y orégano por 12 horas (en refri). La acidez pre-digiere las fibras.', 720),
        (recipe_id, 2, 'Cocción Lenta: Poner todo (con líquido) en olla de barro u olla gruesa. Agregar las cebollas y el rocoto entero. Tapar.', 10),
        (recipe_id, 3, 'Fuego Bajo: Cocinar a fuego muy lento por 2-3 horas. No dejar secar (agregar agua si falta). La carne debe poder cortarse con cuchara.', 150),
        (recipe_id, 4, 'Servir: Retirar rocoto. Servir en plato hondo con mucho jugo y pan de tres puntas. Remojar el pan en el jugo.', 2);
        
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
        (recipe_id, 'Carne de res molida', 500, 'g', 'Molida especial (sin grasa dura)', 1),
        (recipe_id, 'Papa blanca', 4, 'unidades', 'Sancochada y prensada grueso', 2),
        (recipe_id, 'Maní tostado', 0.5, 'taza', 'Molido pasta fina', 3),
        (recipe_id, 'Ají panca', 3, 'cucharadas', 'Pasta', 4),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada finísima', 5),
        (recipe_id, 'Ajo', 2, 'dientes', 'Molido', 6),
        (recipe_id, 'Caldo de res', 2, 'tazas', 'Para soltar', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Aderezo: Sofreír cebolla y ajo. Agregar ají panca y dorar bien.', 10),
        (recipe_id, 2, 'Carne: Agregar la carne molida y cocinar separando grumos. Añadir sal y pimienta.', 8),
        (recipe_id, 3, 'Cuerpo: Agregar la papa prensada (no puré liso, con textura de puré rústico) y el maní licuado con el caldo.', 5),
        (recipe_id, 4, 'Unificación: Cocinar moviendo 10 min. Debe quedar como una mazamorra de carne y papa, muy humectada.', 10),
        (recipe_id, 5, 'Servir: Con arroz blanco. Es fácil de comer porque todo está triturado y húmedo.', 2);
        
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
        (recipe_id, 'Bofe (pulmón de res)', 1, 'kg', 'Limpio de conductos', 1),
        (recipe_id, 'Hierbabuena', 1, 'atado', 'Para hervir (quita olor)', 2),
        (recipe_id, 'Papa blanca', 4, 'unidades', 'Cubos pequeños 1cm', 3),
        (recipe_id, 'Mote pelado', 1, 'taza', 'Cocido muy blando (opcional)', 4),
        (recipe_id, 'Ají panca', 0.5, 'taza', 'Pasta', 5),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Picada fina', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Pre-cocción Bofe: Hervir el bofe entero con hierbabuena y sal por 45 min. Escurrir y enfriar.', 45),
        (recipe_id, 2, 'Picado Fino: Picar el bofe cocido en cubitos de 0.5cm (brunoise). Al ser esponjoso, debe ser pequeño para no atorar. Retirar cualquier tubo duro.', 15),
        (recipe_id, 3, 'Aderezo: Sofreír cebolla, ajo y ají panca.', 10),
        (recipe_id, 4, 'Guisado: Agregar bofe picado, papas en cubos y caldo que cubra. Cocinar hasta que la papa se deshaga un poco para espesar.', 25),
        (recipe_id, 5, 'Servir: Con mote muy cocido (si tolera) o solo. La textura es esponjosa y suave.', 2);
        
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
        (recipe_id, 'Filete pescado blanco', 600, 'g', 'Corvina, Cabrilla (sin espinas)', 1),
        (recipe_id, 'Tomate', 4, 'unidades', 'Pelados y picados grueso', 2),
        (recipe_id, 'Cebolla roja', 2, 'unidades', 'Corte pluma grueso', 3),
        (recipe_id, 'Ají amarillo', 1, 'unidad', 'En tiras (sin venas)', 4),
        (recipe_id, 'Chicha de jora', 0.5, 'taza', 'Ácida', 5),
        (recipe_id, 'Culantro', 2, 'ramas', 'Picado', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cama vegetal: En una sartén amplia u olla chata, poner mitad de cebolla y tomate.', 2),
        (recipe_id, 2, 'Pescado: Salpimentar filetes y colocar sobre la cama. Cubrir con el resto de cebolla, tomate y ají.', 5),
        (recipe_id, 3, 'Líquido: Echar la chicha de jora. Tapar bien.', 1),
        (recipe_id, 4, 'Vapor: Cocinar a fuego medio-alto por 10-12 minutos. El pescado se cocina en su jugo y vapor. No sobrecocinar para que no se seque.', 12),
        (recipe_id, 5, 'Servir: En plato hondo con su jugo (que es un caldo concentrado). Acompañar con yuca sancochada suave. El pescado se come con cuchara.', 2);
        
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
        (recipe_id, 'Filete de pescado', 600, 'g', 'Firme (Bonito o Perico)', 1),
        (recipe_id, 'Cebolla roja', 3, 'unidades', 'Corte pluma grueso', 2),
        (recipe_id, 'Vinagre tinto', 0.5, 'taza', 'O vinagre blanco', 3),
        (recipe_id, 'Ají amarillo', 2, 'cucharadas', 'Pasta', 4),
        (recipe_id, 'Ají panca', 1, 'cucharada', 'Pasta', 5),
        (recipe_id, 'Camote y Huevo duro', 2, 'unidades', 'Guarnición', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Pescado Hervido: En lugar de freír (que crea costra), hervir los filetes en agua con sal y vinagre por 8 min (Pochado). Retirar con cuidado.', 10),
        (recipe_id, 2, 'Escabeche (Salsa): Sofreír ají panca y amarillo. Agregar las cebollas y el vinagre. Cocinar hasta que la cebolla pierda crocancia y esté transparente (para DTM no debe ser crocante).', 15),
        (recipe_id, 3, 'Maceración tibia: Colocar el pescado en una fuente y cubrir con la salsa caliente. Dejar reposar 1 hora.', 60),
        (recipe_id, 4, 'Servir: Frío o tibio. El vinagre habrá ablandado más el pescado. Acompañar de huevo duro picado.', 5);
        
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
        (recipe_id, 'Filete de pescado blanco', 600, 'g', 'Lenguado, Tilapia (firme pero suave)', 1),
        (recipe_id, 'Tomate', 4, 'unidades', 'Pelados y sin semillas, tiras', 2),
        (recipe_id, 'Cebolla roja', 2, 'unidades', 'Corte pluma grueso', 3),
        (recipe_id, 'Ají amarillo', 2, 'cucharadas', 'Pasta (sin piel)', 4),
        (recipe_id, 'Vino blanco', 0.5, 'taza', 'O caldo de pescado', 5),
        (recipe_id, 'Caldo de pescado', 0.5, 'taza', 'Para la salsa', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Pochado suave: En una sartén ancha, ponga agua con sal y vino a hervir. Baje el fuego al mínimo (sin burbujas fuertes). Coloque el pescado por 6-8 minutos. Retirar suavemente.', 10),
        (recipe_id, 2, 'Chorrillana: En otra sartén, sofreír la cebolla, tomate y ají. Cocinar hasta que la cebolla esté TRANSLÚCIDA y suave (no crocante).', 10),
        (recipe_id, 3, 'Unión: Agregar el caldo a la salsa y dejar reducir un poco. Regresar el pescado solo para calentar 1 minuto.', 5),
        (recipe_id, 4, 'Servir: Colocar el pescado y cubrir con la salsa jugosa. El pescado debe estar húmedo, no seco.', 2);
        
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
        (recipe_id, 'Tramboyo o Raya', 600, 'g', 'Limpio (es carne muy gelatinosa)', 1),
        (recipe_id, 'Tomate', 3, 'unidades', 'Licuado o rallado', 2),
        (recipe_id, 'Cebolla roja', 1, 'unidad', 'Picada muy fina', 3),
        (recipe_id, 'Chicha de jora', 0.5, 'taza', NULL, 4),
        (recipe_id, 'Culantro', 1, 'cucharada', 'Picado', 5),
        (recipe_id, 'Yuca', 500, 'g', 'Sancochada muy suave (puré rústico)', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Base: Sofreír cebolla y tomate hasta formar pasta. Agregar chicha.', 10),
        (recipe_id, 2, 'Cocción Gelatina: Colocar el tramboyo/raya. Tapar y cocinar 15 min. Esta carne tiene mucho colágeno y se vuelve gelatina natural al cocinarse.', 15),
        (recipe_id, 3, 'Espesado: El propio colágeno espesará el caldo. Si no, aplastar un trozo de yuca en el caldo.', 5),
        (recipe_id, 4, 'Servir: Plato muy resbaladizo y suave, ideal para máxima facilidad de deglución.', 2);
        
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
        (recipe_id, 'Quinua lavada', 1, 'taza', 'Blanca (más suave que roja/negra)', 1),
        (recipe_id, 'Filete de pescado', 300, 'g', 'Picado en cubos pequeños', 2),
        (recipe_id, 'Leche evaporada', 0.5, 'taza', 'O crema de leche', 3),
        (recipe_id, 'Queso fresco', 100, 'g', 'Rallado', 4),
        (recipe_id, 'Caldo de pescado', 3, 'tazas', NULL, 5),
        (recipe_id, 'Cebolla', 1, 'unidad', 'Brunoise fina', 6),
        (recipe_id, 'Ají amarillo', 2, 'cucharadas', 'Pasta', 7);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Quinotto: Sofreír cebolla y ají. Agregar quinua y nacarar. Ir agregando caldo caliente poco a poco como risotto, moviendo siempre.', 20),
        (recipe_id, 2, 'Cremosidad: Cuando quinua reviente y esté cremosa (15-18 min), agregar los cubitos de pescado (se cocinan en 3 min).', 18),
        (recipe_id, 3, 'Mantecado: Apagar fuego. Agregar leche y queso. Mezclar vigorosamente para emulsionar.', 2),
        (recipe_id, 4, 'Servir inmediato. Textura de risotto muy suave, granos de quinua no requieren masticación fuerte.', 2);
        
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
        (recipe_id, 'Quinua', 1, 'taza', 'Lavada varias veces', 1),
        (recipe_id, 'Agua o Caldo', 5, 'tazas', 'El doble de lo normal para sobrecocer', 2),
        (recipe_id, 'Queso fresco', 150, 'g', 'Desmenuzado', 3),
        (recipe_id, 'Leche evaporada', 0.5, 'taza', NULL, 4),
        (recipe_id, 'Mantequilla', 1, 'cucharada', NULL, 5),
        (recipe_id, 'Ají amarillo', 1, 'cucharada', 'Pasta (opcional sabor)', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Sobrecocción: Hervir quinua en abundante agua/caldo. No dejar secar. Cocinar hasta que se deshaga y forme una pasta grumosa suave (atomalada).', 30),
        (recipe_id, 2, 'Sabor: Agregar el aderezo de ají aparte (sofrito) o directo mantequilla y queso.', 5),
        (recipe_id, 3, 'Final: Agregar leche para soltar punto. Debe correr en la cuchara como avena espesa.', 2),
        (recipe_id, 4, 'Servir: Como plato de fondo o guarnición. Muy reconfortante y suave.', 1);
        
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
        (recipe_id, 'Acelga', 1, 'atado', 'Solo hojas, sin tallos duros', 1),
        (recipe_id, 'Huevos', 4, 'unidades', 'Batidos', 2),
        (recipe_id, 'Queso parmesano', 0.5, 'taza', 'Rallado fino', 3),
        (recipe_id, 'Crema de leche o Leche', 1, 'taza', NULL, 4),
        (recipe_id, 'Pan rallado', 2, 'cucharadas', 'Para aglutinar suave', 5),
        (recipe_id, 'Nuez moscada', 1, 'pizca', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Preparar hoja: Lavar acelga, quitar tallos blancos (muy fibrosos). Blanquear hojas en agua hirviendo 1 min. Escurrir BIEN y picar FINÍSIMO.', 15),
        (recipe_id, 2, 'Ligante: Batir huevos con crema, queso, sal, pimienta y nuez moscada.', 5),
        (recipe_id, 3, 'Mezcla: Unir acelga picada con la mezcla. Agregar pan rallado solo si está muy líquido.', 2),
        (recipe_id, 4, 'Horno: Verter en molde engrasado (sin masa base para evitar costras duras, tipo frittata). Hornear 180°C por 25-30 min hasta cuajar.', 30),
        (recipe_id, 5, 'Servir: Tibio. Textura de flan de verduras.', 2);
        
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
        (recipe_id, 'Coliflor', 1, 'unidad', 'Grande, solo flores', 1),
        (recipe_id, 'Salsa Blanca (Bechamel)', 2, 'tazas', 'Espesa y suave', 2),
        (recipe_id, 'Queso Edam/Mozzarella', 150, 'g', 'Rallado', 3),
        (recipe_id, 'Huevo', 2, 'unidades', 'Batidos', 4),
        (recipe_id, 'Pan rallado', 1, 'cucharada', 'Fino', 5),
        (recipe_id, 'Nuez moscada', 1, 'pizca', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Cocción Coliflor: Cortar coliflor en flores pequeñas. Hervir hasta que esté MUY tierna (que se aplaste sola). Escurrir bien.', 15),
        (recipe_id, 2, 'Base: Mezclar la coliflor con los huevos batidos y la mitad del queso. Aplastar un poco con tenedor (no puré total, pero trozos suaves).', 5),
        (recipe_id, 3, 'Montaje: Poner en pirex engrasado. Cubrir con la salsa blanca y el resto del queso.', 5),
        (recipe_id, 4, 'Horneado: Hornear 180°C por 30-35 min hasta gratinar y burbujear. La coliflor debe estar unificada con la crema.', 35),
        (recipe_id, 5, 'Servir: Plato único o guarnición. Textura cremosa.', 2);
        
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
        (recipe_id, 'Espinaca', 500, 'g', 'Solo hojas limpias', 1),
        (recipe_id, 'Papa amarilla', 2, 'unidades', 'Para espesar suave', 2),
        (recipe_id, 'Leche evaporada', 0.5, 'taza', 'Opcional, para cremosidad', 3),
        (recipe_id, 'Mantequilla', 1, 'cucharada', NULL, 4),
        (recipe_id, 'Caldo de verduras', 0.5, 'taza', NULL, 5),
        (recipe_id, 'Nuez moscada', 1, 'pizca', NULL, 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Blanqueado: Pasar hojas de espinaca 1 min por agua hirviendo. Escurrir (exprimir bien el agua).', 5),
        (recipe_id, 2, 'Licuado Fino: Licuar la espinaca con la leche y el caldo hasta obtener una crema verde intensa SIN fibras.', 2),
        (recipe_id, 3, 'Cuerpo: Cocinar la papa amarilla aparte y prensarla caliente (puré).', 15),
        (recipe_id, 4, 'Unión: En una olla, derretir mantequilla, agregar el licuado de espinaca y el puré de papa. Cocinar moviendo hasta homogeneizar. Sazonar con nuez moscada.', 5),
        (recipe_id, 5, 'Servir: Como guarnición. Textura de mousse densa.', 1);
        
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
        (recipe_id, 'Papa blanca', 4, 'unidades', 'Sancochada y pelada', 1),
        (recipe_id, 'Tomate', 2, 'unidades', 'Sin piel ni semillas, picado brunoise', 2),
        (recipe_id, 'Rocoto', 0.25, 'unidad', 'Sin venas ni pepas, picado polvo (opcional)', 3),
        (recipe_id, 'Vinagre', 2, 'cucharadas', NULL, 4),
        (recipe_id, 'Aceite de oliva', 2, 'cucharadas', NULL, 5),
        (recipe_id, 'Perejil', 1, 'cucharada', 'Picado fino', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Machacado: Aplastar las papas cocidas calientes con tenedor de forma rústica (no puré liso, pero sin trozos duros).', 10),
        (recipe_id, 2, 'Mezcla: Agregar tomate picadito (es importante que no tenga piel), rocoto (si usa), vinagre, aceite y perejil.', 5),
        (recipe_id, 3, 'Sazón: Rectificar sal. La papa absorberá el vinagre y aceite volviéndose muy suave.', 2),
        (recipe_id, 4, 'Servir: Tibio (tradicional) o frío. Es una entrada de fácil masticación y digestión.', 2);
        
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
        (recipe_id, 'Papa amarilla', 1, 'kg', 'Sancochada y prensada caliente (2 veces)', 1),
        (recipe_id, 'Beterraga', 2, 'unidades', 'Cocidas muy suaves y licuadas puré', 2),
        (recipe_id, 'Limón', 3, 'unidades', 'Jugo', 3),
        (recipe_id, 'Aceite', 0.25, 'taza', 'Vegetal neutro', 4),
        (recipe_id, 'Palta', 2, 'unidades', 'Madura para relleno', 5),
        (recipe_id, 'Mayonesa', 0.5, 'taza', 'Casera o light', 6);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Masa Rosa: Mezclar el puré de papa prensado fino con el puré de beterraga, aceite, limón y sal. Amasar hasta tener una pasta rosada lisa y suave (sin grumos).', 20),
        (recipe_id, 2, 'Relleno: Chancar la palta con tenedor o cortar láminas muy finas.', 5),
        (recipe_id, 3, 'Armado: En un molde o aro, poner base de masa, capa de palta/mayonesa, y cubrir con masa. Alisar.', 10),
        (recipe_id, 4, 'Servir: Frío. Es un pastel de papa suave y dulce por la beterraga, textura de plastilina blanda.', 2);
        
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
        (recipe_id, 'Harina de 7 semillas', 0.5, 'taza', 'Mezcla comercial lista (Linaza, trigo, cebada, cañihua, kiwicha, maíz, arveja)', 1),
        (recipe_id, 'Agua', 3, 'tazas', 'Para diluir', 2),
        (recipe_id, 'Leche (opcional)', 1, 'taza', 'Para enriquecer', 3),
        (recipe_id, 'Canela y Clavo', NULL, 'al gusto', 'Para hervir', 4),
        (recipe_id, 'Miel o Algarrobina', 2, 'cucharadas', 'Endulzante', 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Disolución: Disolver la harina de 7 semillas en una taza de agua fría (evita grumos).', 2),
        (recipe_id, 2, 'Cocción: Hervir el resto del agua con canela y clavo. Agregar la harina disuelta moviendo constantemente.', 10),
        (recipe_id, 3, 'Punto: Cocinar a fuego bajo por 10-15 min hasta que espese como una avena bebible.', 15),
        (recipe_id, 4, 'Final: Agregar leche y endulzar. Colar si desea textura ultra fina, pero usualmente no es necesario.', 2),
        (recipe_id, 5, 'Servir: Tibio en taza. Espesor modificable al gusto.', 1);
        
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
        (recipe_id, 'Maca en polvo gelatinizada', 2, 'cucharadas', 'Ya cocida/procesada', 1),
        (recipe_id, 'Leche fresca o vegetal', 2, 'tazas', 'Base', 2),
        (recipe_id, 'Miel de abeja', 2, 'cucharadas', 'Al final', 3),
        (recipe_id, 'Canela', 0.5, 'cucharadita', 'Polvo', 4),
        (recipe_id, 'Esencia de vainilla', 1, 'gotas', NULL, 5);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Disolver: Poner la maca y un poco de leche en una olla. Disolver bien con batidor de globo para quitar bolas.', 2),
        (recipe_id, 2, 'Calentar: Agregar el resto de la leche y canela. Calentar a fuego medio sin dejar de mover (la maca espesa).', 5),
        (recipe_id, 3, 'Ebullición suave: Dejar hervir suavemente 2 minutos.', 2),
        (recipe_id, 4, 'Servir: Servir en taza, endulzar con miel. Textura de chocolate caliente espeso.', 1);
        
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
        (recipe_id, 'Cebada tostada', 0.5, 'taza', 'Granos', 1),
        (recipe_id, 'Cola de caballo', 1, 'atado', 'Seca o fresca', 2),
        (recipe_id, 'Linaza', 0.5, 'taza', 'Semillas enteras (vital para mucílago)', 3),
        (recipe_id, 'Boldo', 5, 'hojas', NULL, 4),
        (recipe_id, 'Uña de gato', 2, 'cortezas', 'Opcional', 5),
        (recipe_id, 'Agua', 3, 'litros', NULL, 6),
        (recipe_id, 'Limón', 4, 'unidades', 'Jugo fresco', 7),
        (recipe_id, 'Miel/Azúcar', NULL, 'al gusto', NULL, 8);
        
        INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
        (recipe_id, 1, 'Hervido Largo: Poner todas las hierbas, cebada y linaza en el agua fría. Llevar a ebullición. Bajar fuego y cocinar tapado 45 min.', 45),
        (recipe_id, 2, 'Goma de Linaza: La linaza soltará su "baba" (fibra soluble) haciendo el agua espesa y viscosa. Esto es lo terapéutico.', 0),
        (recipe_id, 3, 'Colado: Colar caliente. Descartar hierbas.', 2),
        (recipe_id, 4, 'Preparado: Servir caliente mezclando con jugo de limón y miel.', 1),
        (recipe_id, 5, 'Consumo: Beber tibio. La textura es ligeramente densa y suave para la garganta.', 0);
        
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
