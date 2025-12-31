package dev.arubik.flavorique.config;

import dev.arubik.flavorique.entity.*;
import dev.arubik.flavorique.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
@Profile("dev")
@Slf4j
public class DataLoader implements CommandLineRunner {

    private final CategoryRepository categoryRepository;
    private final TagRepository tagRepository;
    private final UserRepository userRepository;
    private final RecipeRepository recipeRepository;
    private final PasswordEncoder passwordEncoder;

    @Value("${app.admin.username:Arubik}")
    private String adminUsername;

    @Value("${app.admin.email:arubik4u@gmail.com}")
    private String adminEmail;

    @Value("${app.admin.password:Admin}")
    private String adminPassword;

    public DataLoader(CategoryRepository categoryRepository, TagRepository tagRepository,
                      UserRepository userRepository, RecipeRepository recipeRepository,
                      PasswordEncoder passwordEncoder) {
        this.categoryRepository = categoryRepository;
        this.tagRepository = tagRepository;
        this.userRepository = userRepository;
        this.recipeRepository = recipeRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        loadCategories();
        loadTags();
        loadAdminUser();
    }

    private void loadCategories() {
        if (categoryRepository.count() > 0) {
            log.info("Categorías ya existen, omitiendo carga inicial");
            return;
        }

        List<Category> categories = List.of(
            createCategory("Desayunos", "desayunos", "Recetas para comenzar el día con energía", "🍳"),
            createCategory("Almuerzos", "almuerzos", "Platos principales para el mediodía", "🍽️"),
            createCategory("Cenas", "cenas", "Recetas ligeras y deliciosas para la noche", "🌙"),
            createCategory("Postres", "postres", "Dulces tentaciones para cualquier momento", "🍰"),
            createCategory("Sopas y Cremas", "sopas-cremas", "Reconfortantes y nutritivas", "🍲"),
            createCategory("Ensaladas", "ensaladas", "Frescas y saludables", "🥗"),
            createCategory("Carnes", "carnes", "Recetas con carne de res, cerdo y más", "🥩"),
            createCategory("Aves", "aves", "Pollo, pavo y otras aves", "🍗"),
            createCategory("Pescados y Mariscos", "pescados-mariscos", "Del mar a tu mesa", "🐟"),
            createCategory("Vegetariano", "vegetariano", "Sin carne, lleno de sabor", "🥬"),
            createCategory("Vegano", "vegano", "100% basado en plantas", "🌱"),
            createCategory("Pastas", "pastas", "Italianas y más", "🍝"),
            createCategory("Arroces", "arroces", "Paellas, risottos y más", "🍚"),
            createCategory("Panes y Masas", "panes-masas", "Horneados caseros", "🍞"),
            createCategory("Bebidas", "bebidas", "Refrescantes y deliciosas", "🍹"),
            createCategory("Snacks", "snacks", "Bocadillos rápidos", "🍿"),
            createCategory("Salsas", "salsas", "Complementos perfectos", "🫙"),
            createCategory("Internacional", "internacional", "Sabores del mundo", "🌍")
        );

        categoryRepository.saveAll(categories);
        log.info("✅ {} categorías cargadas correctamente", categories.size());
    }

    private void loadTags() {
        if (tagRepository.count() > 0) {
            log.info("Tags ya existen, omitiendo carga inicial");
            return;
        }

        List<Tag> tags = List.of(
            createTag("Rápido", "rapido"),
            createTag("Fácil", "facil"),
            createTag("Económico", "economico"),
            createTag("Sin Gluten", "sin-gluten"),
            createTag("Sin Lactosa", "sin-lactosa"),
            createTag("Bajo en Calorías", "bajo-calorias"),
            createTag("Alto en Proteína", "alto-proteina"),
            createTag("Keto", "keto"),
            createTag("Comfort Food", "comfort-food"),
            createTag("Para Niños", "para-ninos"),
            createTag("Gourmet", "gourmet"),
            createTag("Tradicional", "tradicional"),
            createTag("Fusión", "fusion"),
            createTag("Picante", "picante"),
            createTag("Dulce", "dulce"),
            createTag("Salado", "salado"),
            createTag("Frío", "frio"),
            createTag("Caliente", "caliente"),
            createTag("Batch Cooking", "batch-cooking"),
            createTag("Meal Prep", "meal-prep")
        );

        tagRepository.saveAll(tags);
        log.info("✅ {} tags cargados correctamente", tags.size());
    }

    private Category createCategory(String name, String slug, String description, String icon) {
        Category category = new Category();
        category.setName(name);
        category.setSlug(slug);
        category.setDescription(description);
        category.setIcon(icon);
        return category;
    }

    private Tag createTag(String name, String slug) {
        Tag tag = new Tag();
        tag.setName(name);
        tag.setSlug(slug);
        return tag;
    }

    private void loadAdminUser() {
        if (userRepository.findByEmail(adminEmail).isPresent()) {
            log.info("Usuario admin ya existe, omitiendo creación");
            return;
        }

        // Crear usuario admin
        User admin = new User();
        admin.setEmail(adminEmail);
        admin.setUsername(adminUsername);
        admin.setPasswordHash(passwordEncoder.encode(adminPassword));
        admin.setDisplayName(adminUsername);
        admin.setRole(UserRole.ADMIN);
        admin.setIsVerified(true);
        admin.setBio("Chef y administrador de Flavorique. Apasionado por la cocina italiana y las técnicas culinarias avanzadas.");
        
        admin = userRepository.save(admin);
        log.info("✅ Usuario admin '{}' creado correctamente", adminUsername);

        // Crear receta de demostración
        createBologneseRecipe(admin);
    }

    private void createBologneseRecipe(User author) {
        Recipe recipe = new Recipe();
        recipe.setAuthor(author);
        recipe.setTitle("Ragù alla Bolognese de Larga Cocción Técnica");
        recipe.setDescription("Elaboración de salsa boloñesa tradicional mediante técnica de cocción lenta (5 horas). El proceso prioriza la reacción de Maillard en la proteína, el desglasado con vino tinto de cuerpo y la suavización de fibras mediante la incorporación de lácteos, resultando en un ragù de textura compleja y acidez equilibrada.");
        recipe.setPrepTime(45);
        recipe.setCookTime(300);
        recipe.setServings(3);
        recipe.setDifficulty(Difficulty.HARD);
        recipe.setIsPublic(true);
        recipe.setImageUrl("https://i.imgur.com/NZvqCMM.png");

        // Agregar categorías
        Set<Category> categories = new HashSet<>();
        categoryRepository.findBySlug("carnes").ifPresent(categories::add);
        categoryRepository.findBySlug("pastas").ifPresent(categories::add);
        categoryRepository.findBySlug("internacional").ifPresent(categories::add);
        recipe.setCategories(categories);

        // Agregar tags
        Set<Tag> tags = new HashSet<>();
        tagRepository.findBySlug("gourmet").ifPresent(tags::add);
        tagRepository.findBySlug("tradicional").ifPresent(tags::add);
        recipe.setTags(tags);

        recipe = recipeRepository.save(recipe);

        // Agregar ingredientes
        Set<Ingredient> ingredients = new HashSet<>();
        ingredients.add(createIngredient(recipe, "Entraña de res", new BigDecimal("400"), "g", "Picada manualmente a cuchillo", 1));
        ingredients.add(createIngredient(recipe, "Panceta de cerdo curada", new BigDecimal("100"), "g", "Picada en brunoise fino", 2));
        ingredients.add(createIngredient(recipe, "Cebolla blanca", new BigDecimal("1"), "unidad", "Picado fino (brunoise)", 3));
        ingredients.add(createIngredient(recipe, "Zanahoria", new BigDecimal("1"), "unidad", "Picado fino (brunoise)", 4));
        ingredients.add(createIngredient(recipe, "Apio", new BigDecimal("1"), "tallo", "Picado fino (brunoise)", 5));
        ingredients.add(createIngredient(recipe, "Tomates San Marzano", new BigDecimal("1"), "lata", "Triturados manualmente", 6));
        ingredients.add(createIngredient(recipe, "Tomates cherry", new BigDecimal("150"), "g", "Maduros, para guarnición técnica", 7));
        ingredients.add(createIngredient(recipe, "Vino tinto (Malbec o Cabernet)", new BigDecimal("2"), "tazas", "Alta estructura tánica", 8));
        ingredients.add(createIngredient(recipe, "Leche entera", new BigDecimal("0.5"), "taza", "Para control de acidez y texturizado", 9));
        ingredients.add(createIngredient(recipe, "Caldo de res", new BigDecimal("1"), "taza", "Concentrado natural sin aditivos", 10));
        ingredients.add(createIngredient(recipe, "Pasta larga (Pappardelle)", new BigDecimal("400"), "g", "De sémola de trigo duro", 11));
        ingredients.add(createIngredient(recipe, "Aceite de oliva virgen extra", null, "c/n", "Para cocción inicial", 12));
        ingredients.add(createIngredient(recipe, "Mantequilla sin sal", new BigDecimal("30"), "g", "Para emulsión de soffritto", 13));
        ingredients.add(createIngredient(recipe, "Sal de mar, pimienta y laurel", null, "al gusto", "Especias base", 14));
        recipe.setIngredients(ingredients);

        // Agregar pasos
        Set<Step> steps = new HashSet<>();
        steps.add(createStep(recipe, 1, "Base de Soffritto: En una olla de fondo difusor, fundir la grasa de la panceta con el aceite de oliva y la mantequilla. Añadir la cebolla, zanahoria y apio. Sofreír a fuego bajo durante 20 minutos hasta lograr la caramelización de los azúcares naturales sin llegar a dorar excesivamente.", 20));
        steps.add(createStep(recipe, 2, "Sellado de Proteína: Incrementar la temperatura y añadir la carne de res picada. Sellar uniformemente hasta obtener una costra de caramelización (reacción de Maillard).", 10));
        steps.add(createStep(recipe, 3, "Desglasado y Reducción: Verter el vino tinto y desglasar el fondo de la olla para recuperar los compuestos de sabor. Reducir el líquido hasta que el alcohol se haya evaporado y el volumen disminuya al 50%.", 15));
        steps.add(createStep(recipe, 4, "Tratamiento Lácteo: Añadir la leche y una pizca de nuez moscada. Cocinar hasta que el líquido se evapore; este paso permite proteger la textura de la carne frente a la acidez del tomate.", 10));
        steps.add(createStep(recipe, 5, "Cocción Prolongada: Incorporar los tomates San Marzano y el laurel. Reducir el fuego al mínimo (simmering). Mantener la cocción tapada entre 4 y 5 horas, hidratando con caldo de res según sea necesario para mantener la humedad.", 270));
        steps.add(createStep(recipe, 6, "Preparación de Tomates Cherry: 30 minutos antes de finalizar, saltear los tomates cherry en una sartén aparte con aceite de oliva y ajo hasta que la piel se rompa y caramelice. Incorporar a la salsa principal.", 30));
        steps.add(createStep(recipe, 7, "Finalización: Cocer la pasta al dente y terminar su cocción directamente en la salsa para asegurar la emulsión y adherencia.", 12));
        steps.add(createStep(recipe, 8, "Servicio: Emplatar y añadir queso Parmigiano Reggiano madurado para aportar salinidad y umami.", 5));
        recipe.setSteps(steps);

        recipeRepository.save(recipe);
        log.info("✅ Receta 'Ragù alla Bolognese' creada correctamente");
    }

    private Ingredient createIngredient(Recipe recipe, String name, BigDecimal quantity, String unit, String notes, int sortOrder) {
        Ingredient ingredient = new Ingredient();
        ingredient.setRecipe(recipe);
        ingredient.setName(name);
        ingredient.setQuantity(quantity);
        ingredient.setUnit(unit);
        ingredient.setNotes(notes);
        ingredient.setSortOrder(sortOrder);
        return ingredient;
    }

    private Step createStep(Recipe recipe, int stepNumber, String description, int duration) {
        Step step = new Step();
        step.setRecipe(recipe);
        step.setStepNumber(stepNumber);
        step.setDescription(description);
        step.setDuration(duration);
        return step;
    }
}
