#!/usr/bin/env python3
"""
Script para generar dtm-populate-complete.sql con TODAS las recetas de dtm.md
"""

# Lista completa de recetas extraídas de dtm.md
recipes = {
    "Desayunos y Bebidas": [
        {"title": "Avena Cremosa con Puré de Plátano", "desc": "Avena cocida en leche hasta textura sedosa, endulzada con miel y canela", "prep": 5, "cook": 10, "diff": "EASY"},
        {"title": "Quinua Caliente Al Paso", "desc": "Bebida tradicional de quinua cocida con manzana, piña y canela, rica en magnesio", "prep": 10, "cook": 20, "diff": "EASY"},
        {"title": "Huevos Revueltos con Queso Ricotta", "desc": "Preparados a fuego lento para textura jugosa sin esfuerzo oclusal", "prep": 5, "cook": 8, "diff": "EASY"},
        {"title": "Ponche de Habas o Kiwicha", "desc": "Bebida espesa nutritiva rica en calcio y proteínas vegetales", "prep": 10, "cook": 30, "diff": "MEDIUM"},
        {"title": "Smoothie de Papaya Plátano y Avena", "desc": "Licuado que aporta enzimas digestivas y energía rápida", "prep": 5, "cook": 0, "diff": "EASY"},
        {"title": "Yogur Griego con Puré de Aguaymanto", "desc": "Yogur con probióticos y aguaymanto triturado sin semillas", "prep": 5, "cook": 0, "diff": "EASY"},
        {"title": "Siete Semillas", "desc": "Bebida espesa de harinas tostadas de 7 granos con perfil de aminoácidos completo", "prep": 5, "cook": 15, "diff": "EASY"},
        {"title": "Maca Cocida con Leche", "desc": "Raíz adaptógena en suspensión, energizante con textura de papilla", "prep": 5, "cook": 20, "diff": "EASY"},
        {"title": "Emoliente Fortificado", "desc": "Infusión de hierbas con mucílago de linaza, antiinflamatorio", "prep": 10, "cook": 25, "diff": "EASY"},
    ],
    
    "Sopas y Cremas": [
        {"title": "Crema de Zapallo Macre y Loche", "desc": "Textura aterciopelada rica en betacarotenos, sabor gourmet norteño", "prep": 15, "cook": 30, "diff": "EASY"},
        {"title": "Caldo Verde Cajamarquino Adaptado", "desc": "Papas amarillas deshechas con huevo y hierbas licuadas", "prep": 15, "cook": 35, "diff": "MEDIUM"},
        {"title": "Crema de Pallares Pelados", "desc": "Pallares remojados y pelados licuados con leche, crema proteica", "prep": 30, "cook": 90, "diff": "MEDIUM"},
        {"title": "Sopa de Lentejas Licuada con Cúrcuma", "desc": "Lentejas con cúrcuma antiinflamatoria natural", "prep": 10, "cook": 40, "diff": "EASY"},
        {"title": "Crema de Arracacha", "desc": "Tubérculo andino de sabor sofisticado que se deshace en boca", "prep": 10, "cook": 25, "diff": "EASY"},
        {"title": "Gazpacho de Tomate y Sandía", "desc": "Sopa fría hidratante para reducir inflamación aguda", "prep": 15, "cook": 0, "diff": "EASY"},
        {"title": "Sopa a la Minuta", "desc": "Carne molida con fideos cabello de ángel y leche evaporada", "prep": 10, "cook": 20, "diff": "EASY"},
        {"title": "Sopa Criolla", "desc": "Fideos con carne molida y pan hidratado hasta desintegrarse", "prep": 10, "cook": 25, "diff": "EASY"},
        {"title": "Caldo de Bolas", "desc": "Esfera de plátano verde rellena flotando en caldo, de Tumbes", "prep": 45, "cook": 60, "diff": "HARD"},
        {"title": "Sopa de Morón", "desc": "Cebada perlada con textura mucilaginosa calmante", "prep": 10, "cook": 50, "diff": "MEDIUM"},
        {"title": "Chupe de Habas", "desc": "Habas peladas con leche, huevo y queso fresco", "prep": 30, "cook": 45, "diff": "MEDIUM"},
        {"title": "Sopa Chairo", "desc": "Chuño machacado con textura esponjosa y húmeda", "prep": 20, "cook": 60, "diff": "MEDIUM"},
        {"title": "Sopa de Olluco", "desc": "Olluco en juliana fina con alto contenido de mucílago", "prep": 15, "cook": 30, "diff": "EASY"},
    ],
    
    "Platos de Fondo - Principales": [
        {"title": "Causa Limeña de Atún y Palta", "desc": "Puré de papa amarilla prensada con atún de fibras cortas y palta", "prep": 25, "cook": 20, "diff": "MEDIUM"},
        {"title": "Ají de Huevos", "desc": "Versión del ají de gallina con huevo duro en salsa cremosa", "prep": 20, "cook": 30, "diff": "MEDIUM"},
        {"title": "Locro de Zapallo con Queso Fresco", "desc": "Guiso de zapallo y papas hasta puré rústico", "prep": 15, "cook": 35, "diff": "EASY"},
        {"title": "Solterito de Quinua", "desc": "Ensalada de quinua con queso fresco, palta y tomate pelado", "prep": 20, "cook": 20, "diff": "EASY"},
        {"title": "Pescado Blanco al Vapor", "desc": "Lenguado o merluza que se desmorona al contacto", "prep": 10, "cook": 15, "diff": "EASY"},
        {"title": "Albóndigas de Res en Salsa de Tomate", "desc": "Carne molida dos veces para máxima suavidad en salsa húmeda", "prep": 25, "cook": 40, "diff": "MEDIUM"},
        {"title": "Carapulcra de Champiñones", "desc": "Papa seca hidratada con champiñones de textura blanda", "prep": 30, "cook": 50, "diff": "MEDIUM"},
        {"title": "Pepián de Choclo", "desc": "Puré de maíz tierno licuado con aderezo suave", "prep": 15, "cook": 30, "diff": "MEDIUM"},
{"title": "Tallarines Verdes con Queso Batido", "desc": "Pasta suave con salsa de espinaca y albahaca licuada", "prep": 15, "cook": 20, "diff": "EASY"},
        {"title": "Humita en Olla de Sal", "desc": "Masa de maíz tierno con queso derretido, sin panca", "prep": 30, "cook": 40, "diff": "MEDIUM"},
        {"title": "Pastel de Papa Versión Puré", "desc": "Capas de puré rellenas de queso fundido, suave no crocante", "prep": 20, "cook": 35, "diff": "EASY"},
        {"title": "Cau Cau de Mondongo", "desc": "Mondongo picado muy pequeño cocido hasta extrema ternura", "prep": 30, "cook": 180, "diff": "HARD"},
        {"title": "Tamalito Verde", "desc": "Maíz choclo tierno licuado con culantro, textura de puré gelificado", "prep": 40, "cook": 45, "diff": "MEDIUM"},
    ],
    
    "Proteínas Animales": [
        {"title": "Sangrecita Guisada", "desc": "Sangre de pollo coagulada friable, se desmorona fácilmente", "prep": 10, "cook": 15, "diff": "EASY"},
        {"title": "Patita con Maní", "desc": "Patas de res con colágeno hidrolizado en salsa de maní", "prep": 20, "cook": 240, "diff": "HARD"},
        {"title": "Chanfainita de Bofe", "desc": "Pulmón de res con textura esponjosa y suave", "prep": 25, "cook": 60, "diff": "MEDIUM"},
        {"title": "Olluquito con Carne", "desc": "Tubérculo resbaladizo con carne molida", "prep": 20, "cook": 35, "diff": "MEDIUM"},
        {"title": "Caigua Rellena", "desc": "Cucurbitácea tierna rellena de carne molida con pan remojado", "prep": 30, "cook": 45, "diff": "MEDIUM"},
        {"title": "Hígado Encebollado Al Jugo", "desc": "Hígado en tiras cocido rápido o guisado hasta ablandarse", "prep": 15, "cook": 20, "diff": "MEDIUM"},
        {"title": "Adobo Arequipeño de Cerdo", "desc": "Cerdo marinado en chicha, cocción lenta hasta deshebrar", "prep": 60, "cook": 180, "diff": "HARD"},
        {"title": "Estofado de Pollo o Res", "desc": "Piezas oscuras de pollo o res en salsa de tomate y zanahoria", "prep": 20, "cook": 90, "diff": "MEDIUM"},
        {"title": "Seco de Res o Cabrito", "desc": "Guiso verde de culantro licuado con salsa abundante", "prep": 25, "cook": 120, "diff": "MEDIUM"},
        {"title": "Picante de Carne", "desc": "Carne y papa en dados de 1cm con salsa cremosa", "prep": 20, "cook": 40, "diff": "MEDIUM"},
        {"title": "Tallarines Rojos con Carne Molida", "desc": "Pasta bien cocida con salsa boloñesa peruana", "prep": 15, "cook": 35, "diff": "EASY"},
    ],
    
    "Pescados y Mariscos": [
        {"title": "Sudado de Pescado", "desc": "Pescado en sus jugos con chicha de jora, miotomos separados", "prep": 15, "cook": 20, "diff": "MEDIUM"},
        {"title": "Pescado a la Chorrillana Pochado", "desc": "Filete pochado en salsa de cebolla, tomate y ají amarillo", "prep": 15, "cook": 25, "diff": "MEDIUM"},
        {"title": "Sudado de Tramboyo", "desc": "Pez de textura gelatinosa que espesa el caldo naturalmente", "prep": 20, "cook": 30, "diff": "MEDIUM"},
        {"title": "Escabeche de Pescado Hervido", "desc": "Pescado sancochado en vinagre con cebollas cocidas", "prep": 20, "cook": 25, "diff": "MEDIUM"},
        {"title": "Quinoto de Pescado o Champiñones", "desc": "Quinua cremosa estilo risotto con pescado sudado", "prep": 15, "cook": 35, "diff": "MEDIUM"},
    ],
    
    "Vegetales y Guarniciones": [
        {"title": "Quinua Atamalada", "desc": "Quinua sobrecocida hasta masa densa con ají y queso", "prep": 10, "cook": 30, "diff": "EASY"},
        {"title": "Pastel de Acelga", "desc": "Acelgas blanqueadas con bechamel, huevo y queso", "prep": 25, "cook": 40, "diff": "MEDIUM"},
        {"title": "Pastel de Coliflor", "desc": "Coliflor muy tierna gratinada con salsa blanca", "prep": 20, "cook": 35, "diff": "MEDIUM"},
        {"title": "Puré de Espinaca", "desc": "Espinacas licuadas con leche, espesadas con roux", "prep": 10, "cook": 15, "diff": "EASY"},
        {"title": "Escribano Arequipeño", "desc": "Papas aplastadas con tomate pelado, vinagre y aceite", "prep": 15, "cook": 20, "diff": "EASY"},
        {"title": "Causa Rellena de Beterraga", "desc": "Puré de papa con remolacha, relleno de pollo con mayonesa", "prep": 30, "cook": 25, "diff": "MEDIUM"},
    ],
    
    "Postres y Dulces": [
        {"title": "Hummus con Pan Pita Blando", "desc": "Puré de garbanzos rico en magnesio con pan tibio", "prep": 10, "cook": 0, "diff": "EASY"},
        {"title": "Mazamorra Morada con Frutas", "desc": "Postre de maíz morado rico en antocianinas antioxidantes", "prep": 15, "cook": 45, "diff": "MEDIUM"},
        {"title": "Suspiro a la Limeña", "desc": "Manjar cremoso con merengue al oporto, textura sedosa", "prep": 20, "cook": 40, "diff": "MEDIUM"},
        {"title": "Mousse de Lúcuma", "desc": "Pulpa de lúcuma con crema batida, suave y vitamínico", "prep": 15, "cook": 0, "diff": "EASY"},
        {"title": "Flan de Plátano o Camote", "desc": "Postre horneado con potasio y fibra soluble", "prep": 20, "cook": 60, "diff": "MEDIUM"},
        {"title": "Pudín de Chía y Coco", "desc": "Semillas hidratadas ricas en Omega-3 antiinflamatorio", "prep": 5, "cook": 0, "diff": "EASY"},
        {"title": "Sanguito", "desc": "Pasta densa de harina de maíz, chancaca y manteca", "prep": 10, "cook": 30, "diff": "MEDIUM"},
        {"title": "Mazamorra de Cochino", "desc": "Pudín de maíz, leche, chancaca y manteca", "prep": 15, "cook": 40, "diff": "MEDIUM"},
        {"title": "Ranfañote", "desc": "Pan saturado en miel de chancaca con queso fresco", "prep": 20, "cook": 25, "diff": "MEDIUM"},
        {"title": "Frejol Colado", "desc": "Dulce de frejoles negros licuados punto manjar", "prep": 30, "cook": 90, "diff": "HARD"},
        {"title": "Champús de Guanábana", "desc": "Bebida caliente espesa con frutas cocidas y mote", "prep": 20, "cook": 45, "diff": "MEDIUM"},
        {"title": "Arroz Zambito", "desc": "Arroz con leche, chancaca, coco y pasas", "prep": 10, "cook": 40, "diff": "EASY"},
        {"title": "Machacado de Membrillo", "desc": "Dulce de corte de membrillo rico en pectina", "prep": 15, "cook": 60, "diff": "MEDIUM"},
        {"title": "Dulce de Camote", "desc": "Camote cocido en almíbar hasta traslúcido", "prep": 10, "cook": 35, "diff": "EASY"},
        {"title": "Leche Asada", "desc": "Postre horneado de leche y huevo con superficie dorada", "prep": 10, "cook": 45, "diff": "MEDIUM"},
        {"title": "Crema Volteada", "desc": "Flan peruano con leche condensada, denso y liso", "prep": 15, "cook": 50, "diff": "MEDIUM"},
    ],
}

def generate_sql():
    output = """-- ================================================================
-- Flavorique - TODAS LAS RECETAS DTM
-- Script completo con 60+ recetas de dieta blanda terapéutica
-- Basado en dtm.md - Disfunción Temporomandibular
-- ================================================================

-- Crear tags DTM
INSERT INTO tags (name, slug) VALUES
('Dieta Blanda', 'dieta-blanda'),
('DTM Friendly', 'dtm-friendly'),
('Antiinflamatorio', 'antiinflamatorio'),
('Textura Suave', 'textura-suave'),
('Sin Masticación', 'sin-masticacion')
ON CONFLICT (slug) DO NOTHING;

-- Crear categoría DTM
INSERT INTO categories (name, slug, description, icon) VALUES
('DTM Terapéutico', 'dtm-terapeutico', 'Recetas para disfunción temporomandibular', '🦷')
ON CONFLICT (slug) DO NOTHING;

"""
    
    recipe_count = 0
    for category, recipe_list in recipes.items():
        output += f"\n-- {'='*64}\n-- CATEGORÍA: {category.upper()}\n-- {'='*64}\n"
        
        for recipe in recipe_list:
            recipe_count += 1
            output += f"""
DO $$
DECLARE
    admin_id BIGINT;
    recipe_id BIGINT;
    cat_dtm_id BIGINT;
BEGIN
    SELECT id INTO admin_id FROM users WHERE username = 'Arubik';
    SELECT id INTO cat_dtm_id FROM categories WHERE slug = 'dtm-terapeutico';
    
    IF NOT EXISTS (SELECT 1 FROM recipes WHERE title = '{recipe['title']}') THEN
        INSERT INTO recipes (author_id, title, description, prep_time, cook_time, servings, difficulty, is_public)
        VALUES (
            admin_id,
            '{recipe['title']}',
            '{recipe['desc']}',
            {recipe['prep']},
            {recipe['cook']},
            4,
            '{recipe['diff']}',
            TRUE
        ) RETURNING id INTO recipe_id;
        
        INSERT INTO recipe_categories (recipe_id, category_id) VALUES (recipe_id, cat_dtm_id);
        INSERT INTO recipe_tags (recipe_id, tag_id)
        SELECT recipe_id, id FROM tags WHERE slug IN ('dieta-blanda', 'dtm-friendly');
        
        RAISE NOTICE '✅ Receta creada: {recipe['title']}';
    ELSE
        RAISE NOTICE '⚠️  Ya existe: {recipe['title']}';
    END IF;
END $$;
"""
    
    output += f"""
-- ================================================================
-- RESUMEN FINAL
-- ================================================================
DO $$
BEGIN
    RAISE NOTICE '================================';
    RAISE NOTICE '✅ Script DTM completo ejecutado';
    RAISE NOTICE '📊 Total de recetas DTM agregadas: {recipe_count}';
    RAISE NOTICE '📊 Total de recetas en DB: %', (SELECT COUNT(*) FROM recipes);
    RAISE NOTICE '================================';
END $$;
"""
    
    return output

if __name__ == "__main__":
    sql_content = generate_sql()
    
    with open("dtm-populate-complete.sql", "w", encoding="utf-8") as f:
        f.write(sql_content)
    
    print(f"✅ Archivo generado: dtm-populate-complete.sql")
    print(f"📊 Total de recetas: {sum(len(r) for r in recipes.values())}")
