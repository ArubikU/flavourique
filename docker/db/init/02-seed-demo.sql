-- ============================================
-- Flavorique - Datos de demostración
-- ============================================
-- Este script crea usuarios y recetas de ejemplo
-- Contraseña para todos los usuarios: "Password123!"
-- Hash generado con BCrypt (strength 10)

-- ============================================
-- USUARIOS DE DEMO
-- ============================================
INSERT INTO users (email, username, password_hash, display_name, bio, role, is_verified) VALUES
(
    'admin@flavorique.app',
    'admin',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZRGdjGj/n3.ow9aqQ.ghvF5Vj3H6m',
    'Administrador',
    'Administrador del sistema Flavorique',
    'ADMIN',
    TRUE
),
(
    'chef.maria@example.com',
    'chef_maria',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZRGdjGj/n3.ow9aqQ.ghvF5Vj3H6m',
    'María García',
    'Chef profesional con 10 años de experiencia en cocina mediterránea. Me encanta compartir mis recetas favoritas.',
    'CHEF',
    TRUE
),
(
    'carlos.cocina@example.com',
    'carlos_cocina',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZRGdjGj/n3.ow9aqQ.ghvF5Vj3H6m',
    'Carlos Rodríguez',
    'Amante de la cocina casera y los sabores tradicionales.',
    'USER',
    FALSE
),
(
    'ana.postres@example.com',
    'dulce_ana',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZRGdjGj/n3.ow9aqQ.ghvF5Vj3H6m',
    'Ana Martínez',
    'Especialista en repostería y postres creativos 🍰',
    'CHEF',
    TRUE
);

-- ============================================
-- RECETAS DE DEMO
-- ============================================

-- Receta 1: Paella Valenciana (por chef_maria)
INSERT INTO recipes (author_id, title, description, instructions, prep_time, cook_time, servings, difficulty, is_public)
VALUES (
    2,
    'Paella Valenciana Tradicional',
    'La auténtica paella valenciana con pollo, conejo y judías verdes. Una receta que ha pasado de generación en generación.',
    'Instrucciones detalladas de la paella...',
    30,
    45,
    6,
    'MEDIUM',
    TRUE
);

-- Ingredientes para Paella
INSERT INTO ingredients (recipe_id, name, quantity, unit, sort_order) VALUES
(1, 'Arroz bomba', 400, 'g', 1),
(1, 'Pollo troceado', 500, 'g', 2),
(1, 'Conejo troceado', 300, 'g', 3),
(1, 'Judías verdes', 200, 'g', 4),
(1, 'Garrofón', 100, 'g', 5),
(1, 'Tomate rallado', 150, 'g', 6),
(1, 'Aceite de oliva', 100, 'ml', 7),
(1, 'Azafrán', 1, 'g', 8),
(1, 'Sal', NULL, 'al gusto', 9),
(1, 'Agua o caldo', 1, 'litro', 10);

-- Pasos para Paella
INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
(1, 1, 'Calentar el aceite en la paellera a fuego medio-alto.', 2),
(1, 2, 'Dorar el pollo y el conejo hasta que estén bien sellados. Reservar.', 10),
(1, 3, 'En el mismo aceite, sofreír las judías verdes durante 5 minutos.', 5),
(1, 4, 'Añadir el tomate rallado y cocinar hasta que oscurezca.', 5),
(1, 5, 'Incorporar el pimentón, remover rápidamente y añadir el agua.', 1),
(1, 6, 'Devolver la carne a la paellera y cocinar 20 minutos.', 20),
(1, 7, 'Añadir el azafrán y rectificar de sal.', 1),
(1, 8, 'Subir el fuego, añadir el arroz distribuyéndolo bien.', 1),
(1, 9, 'Cocinar a fuego fuerte 10 minutos, luego medio 8 minutos.', 18),
(1, 10, 'Dejar reposar 5 minutos antes de servir.', 5);

-- Receta 2: Tortilla Española (por carlos_cocina)
INSERT INTO recipes (author_id, title, description, instructions, prep_time, cook_time, servings, difficulty, is_public)
VALUES (
    3,
    'Tortilla Española de la Abuela',
    'La clásica tortilla de patatas jugosa por dentro y doradita por fuera. El secreto está en la paciencia.',
    'Instrucciones de la tortilla...',
    20,
    25,
    4,
    'EASY',
    TRUE
);

-- Ingredientes para Tortilla
INSERT INTO ingredients (recipe_id, name, quantity, unit, sort_order) VALUES
(2, 'Patatas', 600, 'g', 1),
(2, 'Huevos', 6, 'unidades', 2),
(2, 'Cebolla', 1, 'grande', 3),
(2, 'Aceite de oliva', 200, 'ml', 4),
(2, 'Sal', NULL, 'al gusto', 5);

-- Pasos para Tortilla
INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
(2, 1, 'Pelar y cortar las patatas en láminas finas.', 10),
(2, 2, 'Picar la cebolla en juliana fina.', 5),
(2, 3, 'Freír las patatas y cebolla a fuego medio-bajo hasta que estén tiernas.', 20),
(2, 4, 'Batir los huevos con sal en un bol grande.', 2),
(2, 5, 'Escurrir las patatas y mezclar con el huevo batido.', 3),
(2, 6, 'Cuajar la tortilla en sartén antiadherente, darle la vuelta con un plato.', 8),
(2, 7, 'Servir templada o a temperatura ambiente.', 0);

-- Receta 3: Tarta de Chocolate (por dulce_ana)
INSERT INTO recipes (author_id, title, description, instructions, prep_time, cook_time, servings, difficulty, is_public)
VALUES (
    4,
    'Tarta de Chocolate Fundente',
    'Una tarta de chocolate intenso con el centro fundente. Para verdaderos amantes del chocolate.',
    'Instrucciones de la tarta...',
    15,
    25,
    8,
    'MEDIUM',
    TRUE
);

-- Ingredientes para Tarta
INSERT INTO ingredients (recipe_id, name, quantity, unit, sort_order) VALUES
(3, 'Chocolate negro 70%', 200, 'g', 1),
(3, 'Mantequilla', 150, 'g', 2),
(3, 'Azúcar', 150, 'g', 3),
(3, 'Huevos', 4, 'unidades', 4),
(3, 'Harina', 50, 'g', 5),
(3, 'Sal', 1, 'pizca', 6);

-- Pasos para Tarta
INSERT INTO steps (recipe_id, step_number, description, duration) VALUES
(3, 1, 'Precalentar el horno a 180°C.', 0),
(3, 2, 'Derretir el chocolate con la mantequilla al baño maría.', 5),
(3, 3, 'Batir los huevos con el azúcar hasta que blanqueen.', 5),
(3, 4, 'Incorporar el chocolate derretido a la mezcla de huevos.', 2),
(3, 5, 'Añadir la harina tamizada y la sal, mezclar suavemente.', 2),
(3, 6, 'Verter en molde engrasado y hornear 20-25 minutos.', 25),
(3, 7, 'El centro debe quedar ligeramente tembloroso. Dejar enfriar.', 0);

-- ============================================
-- ASIGNAR CATEGORÍAS A RECETAS
-- ============================================
INSERT INTO recipe_categories (recipe_id, category_id) VALUES
(1, 2),  -- Paella -> Almuerzos
(1, 11), -- Paella -> Mariscos
(2, 1),  -- Tortilla -> Desayunos
(2, 2),  -- Tortilla -> Almuerzos
(3, 4);  -- Tarta -> Postres

-- ============================================
-- ASIGNAR TAGS A RECETAS
-- ============================================
INSERT INTO recipe_tags (recipe_id, tag_id) VALUES
(1, 7),  -- Paella -> tradicional
(1, 2),  -- Paella -> sin-gluten (el arroz es sin gluten)
(2, 7),  -- Tortilla -> tradicional
(2, 9),  -- Tortilla -> fácil
(2, 12), -- Tortilla -> vegetariano
(3, 8),  -- Tarta -> gourmet
(3, 12); -- Tarta -> vegetariano

-- ============================================
-- FAVORITOS DE DEMO
-- ============================================
INSERT INTO favorites (user_id, recipe_id) VALUES
(3, 1),  -- Carlos guarda Paella
(3, 3),  -- Carlos guarda Tarta
(4, 2);  -- Ana guarda Tortilla

-- ============================================
-- REVIEWS DE DEMO
-- ============================================
INSERT INTO reviews (user_id, recipe_id, rating, comment) VALUES
(3, 1, 5, '¡Espectacular! La mejor paella que he hecho en casa. Los pasos están muy bien explicados.'),
(4, 2, 4, 'Muy buena receta, aunque yo le añado un poco más de cebolla. Queda jugosita.');

-- ============================================
-- SEGUIDORES DE DEMO
-- ============================================
INSERT INTO followers (follower_id, following_id) VALUES
(3, 2),  -- Carlos sigue a María
(3, 4),  -- Carlos sigue a Ana
(4, 2);  -- Ana sigue a María

RAISE NOTICE 'Datos de demostración insertados correctamente ✅';
