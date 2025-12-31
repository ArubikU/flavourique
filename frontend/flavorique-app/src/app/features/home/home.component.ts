import { Component, inject, signal, OnInit } from '@angular/core';
import { RouterLink } from '@angular/router';
import { RecipeService, CategoryService, FavoriteService, AuthService } from '@core/services';
import { Recipe, Category } from '@core/models';
import { RecipeCardComponent } from '@shared/components/recipe-card/recipe-card.component';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [RouterLink, RecipeCardComponent],
  template: `
    <!-- Hero Section -->
    <section class="hero">
      <div class="hero-content container container-readable">
        <div class="hero-text animate-fade-in-up">
          <h1 class="hero-title">
            Descubre el sabor de la <span class="text-gradient">cocina casera</span>
          </h1>
          <p class="hero-description">
            Explora miles de recetas deliciosas compartidas por nuestra comunidad de amantes de la cocina. 
            Desde platos tradicionales hasta creaciones innovadoras.
          </p>
          <div class="hero-actions">
            <a routerLink="/recipes" class="btn btn-primary btn-lg">
              <span class="material-icons-outlined">menu_book</span>
              Explorar Recetas
            </a>
            @if (!authService.isAuthenticated()) {
              <a routerLink="/register" class="btn btn-outline btn-lg">
                Unirse Gratis
              </a>
            } @else {
              <a routerLink="/recipes/new" class="btn btn-outline btn-lg">
                <span class="material-icons-outlined">add</span>
                Nueva Receta
              </a>
            }
          </div>
        </div>
        <div class="hero-image animate-fade-in-up">
          <img src="/hero-food.jpg" alt="Deliciosa comida casera" onerror="this.style.display='none'" />

        </div>
      </div>
      <div class="hero-wave">
        <svg viewBox="0 0 1440 120" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M0 120L60 110C120 100 240 80 360 70C480 60 600 60 720 65C840 70 960 80 1080 85C1200 90 1320 90 1380 90L1440 90V120H1380C1320 120 1200 120 1080 120C960 120 840 120 720 120C600 120 480 120 360 120C240 120 120 120 60 120H0V120Z" fill="var(--surface-page)"/>
        </svg>
      </div>
    </section>

    <!-- Categories Section -->
    <section class="section">
      <div class="container container-readable">
        <div class="section-header">
          <h2 class="section-title">Categorías Populares</h2>
          <a routerLink="/categories" class="section-link">
            Ver todas
            <span class="material-icons-outlined icon-sm">arrow_forward</span>
          </a>
        </div>
        
        @if (loadingCategories()) {
          <div class="categories-skeleton">
            @for (i of [1, 2, 3, 4, 5, 6]; track i) {
              <div class="category-card-skeleton skeleton"></div>
            }
          </div>
        } @else {
          <div class="categories-grid">
            @for (category of categories(); track category.id) {
              <a [routerLink]="['/recipes']" [queryParams]="{category: category.name}" class="category-card">
                <div class="category-card__icon">
                  <span class="material-icons-outlined">{{ getCategoryIcon(category.name) }}</span>
                </div>
                <span class="category-card__name">{{ category.name }}</span>
              </a>
            }
          </div>
        }
      </div>
    </section>

    <!-- Latest Recipes Section -->
    <section class="section section-alt">
      <div class="container container-readable">
        <div class="section-header">
          <h2 class="section-title">Recetas Recientes</h2>
          <a routerLink="/recipes" class="section-link">
            Ver todas
            <span class="material-icons-outlined icon-sm">arrow_forward</span>
          </a>
        </div>

        @if (loadingRecipes()) {
          <div class="recipes-grid">
            @for (i of [1, 2, 3, 4, 5, 6]; track i) {
              <div class="recipe-card-skeleton">
                <div class="skeleton-image skeleton"></div>
                <div class="skeleton-content">
                  <div class="skeleton-category skeleton"></div>
                  <div class="skeleton-title skeleton"></div>
                  <div class="skeleton-meta skeleton"></div>
                </div>
              </div>
            }
          </div>
        } @else {
          <div class="recipes-grid">
            @for (recipe of latestRecipes(); track recipe.id; let i = $index) {
              <app-recipe-card 
                [recipe]="recipe" 
                [animate]="true"
                [isFavorite]="favoriteService.isFavoriteLocal(recipe.id)"
                (toggleFavorite)="onToggleFavorite($event)"
              />
            }
          </div>
        }

        <div class="section-cta">
          <a routerLink="/recipes" class="btn btn-primary">
            <span class="material-icons-outlined">menu_book</span>
            Ver Más Recetas
          </a>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    @if (!authService.isAuthenticated()) {
      <section class="section cta-section">
        <div class="container container-readable">
          <div class="cta-content">
            <h2 class="cta-title">¿Listo para compartir tus recetas?</h2>
            <p class="cta-description">
              Únete a nuestra comunidad y comparte tus creaciones culinarias con miles de personas.
            </p>
            <a routerLink="/register" class="btn btn-primary btn-lg">
              <span class="material-icons-outlined">person_add</span>
              Crear Cuenta Gratis
            </a>
          </div>
        </div>
      </section>
    }
  `,
  styles: [`
    /* Hero Section */
    .hero {
      background: linear-gradient(135deg, var(--color-primary-50) 0%, var(--color-secondary-50) 100%);
      padding: var(--space-12) 0 var(--space-16);
      position: relative;
      overflow: hidden;
    }

    .hero-content {
      display: grid;
      grid-template-columns: 1fr;
      gap: var(--space-8);
      align-items: center;
      position: relative;
      z-index: 2;

      @media (min-width: 1024px) {
        grid-template-columns: 1fr 1fr;
      }
    }

    .hero-title {
      font-size: 36px;
      font-weight: 700;
      line-height: 1.2;
      color: var(--text-primary);
      margin-bottom: var(--space-4);

      @media (min-width: 768px) {
        font-size: 48px;
      }
    }

    .text-gradient {
      background: linear-gradient(135deg, var(--color-primary-500) 0%, var(--color-primary-600) 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    .hero-description {
      font-size: 18px;
      color: var(--text-secondary);
      line-height: 1.6;
      margin-bottom: var(--space-6);
      max-width: 500px;
    }

    .hero-actions {
      display: flex;
      flex-wrap: wrap;
      gap: var(--space-3);
      position: relative;
      z-index: 3;
    }

    .hero-image {
      position: relative;
      display: none;

      @media (min-width: 1024px) {
        display: block;
      }

      img {
        width: 100%;
        max-width: 500px;
        border-radius: var(--border-radius-lg);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      }
    }

    .hero-image-placeholder {
      width: 100%;
      max-width: 500px;
      aspect-ratio: 4 / 3;
      background: linear-gradient(135deg, var(--color-primary-100) 0%, var(--color-primary-200) 100%);
      border-radius: var(--border-radius-lg);
      display: flex;
      align-items: center;
      justify-content: center;

      .material-icons-outlined {
        font-size: 120px;
        color: var(--color-primary-300);
      }
    }

    .hero-wave {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      line-height: 0;
      z-index: 1;
      pointer-events: none;

      svg {
        width: 100%;
        height: auto;
      }
    }

    /* Section Styles */
    .section {
      padding: var(--space-12) 0;
    }

    .section-alt {
      background: var(--surface-page);
    }

    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: var(--space-6);
    }

    .section-title {
      font-size: 24px;
      font-weight: 700;
      color: var(--text-primary);

      @media (min-width: 768px) {
        font-size: 30px;
      }
    }

    .section-link {
      display: inline-flex;
      align-items: center;
      gap: var(--space-1);
      color: var(--color-primary-500);
      font-size: 14px;
      font-weight: 500;

      &:hover {
        color: var(--color-primary-600);
      }
    }

    /* Categories Grid */
    .categories-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: var(--space-3);

      @media (min-width: 640px) {
        grid-template-columns: repeat(3, 1fr);
      }

      @media (min-width: 1024px) {
        grid-template-columns: repeat(6, 1fr);
      }
    }

    .categories-skeleton {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: var(--space-3);

      @media (min-width: 640px) {
        grid-template-columns: repeat(3, 1fr);
      }

      @media (min-width: 1024px) {
        grid-template-columns: repeat(6, 1fr);
      }
    }

    .category-card-skeleton {
      aspect-ratio: 1;
      border-radius: var(--border-radius-md);
    }

    .category-card {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: var(--space-2);
      padding: var(--space-4);
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      text-decoration: none;
      transition: all var(--duration-fast) var(--ease-default);

      &:hover {
        border-color: var(--color-primary-500);
        transform: translateY(-2px);

        .category-card__icon {
          background: var(--color-primary-500);
          color: white;
        }
      }
    }

    .category-card__icon {
      width: 48px;
      height: 48px;
      border-radius: var(--border-radius-full);
      background: var(--color-primary-100);
      color: var(--color-primary-500);
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all var(--duration-fast) var(--ease-default);

      .material-icons-outlined {
        font-size: 24px;
      }
    }

    .category-card__name {
      font-size: 13px;
      font-weight: 500;
      color: var(--text-primary);
      text-align: center;
    }

    /* Recipes Grid */
    .recipes-grid {
      display: grid;
      grid-template-columns: 1fr;
      gap: var(--space-4);

      @media (min-width: 640px) {
        grid-template-columns: repeat(2, 1fr);
      }

      @media (min-width: 1024px) {
        grid-template-columns: repeat(3, 1fr);
        gap: var(--space-6);
      }
    }

    .recipe-card-skeleton {
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      overflow: hidden;
    }

    .skeleton-image {
      aspect-ratio: 1;
    }

    .skeleton-content {
      padding: var(--space-4);
    }

    .skeleton-category {
      width: 60px;
      height: 12px;
      border-radius: var(--border-radius-sm);
      margin-bottom: var(--space-2);
    }

    .skeleton-title {
      width: 80%;
      height: 20px;
      border-radius: var(--border-radius-sm);
      margin-bottom: var(--space-2);
    }

    .skeleton-meta {
      width: 50%;
      height: 14px;
      border-radius: var(--border-radius-sm);
    }

    .section-cta {
      text-align: center;
      margin-top: var(--space-8);
    }

    /* CTA Section */
    .cta-section {
      background: linear-gradient(135deg, var(--color-primary-500) 0%, var(--color-primary-600) 100%);
    }

    .cta-content {
      text-align: center;
      padding: var(--space-8) 0;
    }

    .cta-title {
      font-size: 30px;
      font-weight: 700;
      color: white;
      margin-bottom: var(--space-3);

      @media (min-width: 768px) {
        font-size: 36px;
      }
    }

    .cta-description {
      font-size: 18px;
      color: rgba(255, 255, 255, 0.9);
      margin-bottom: var(--space-6);
      max-width: 500px;
      margin-left: auto;
      margin-right: auto;
    }

    .cta-section .btn-primary {
      background: white;
      color: var(--color-primary-500);

      &:hover {
        background: var(--color-primary-50);
      }
    }
  `],
})
export class HomeComponent implements OnInit {
  authService = inject(AuthService);
  private recipeService = inject(RecipeService);
  private categoryService = inject(CategoryService);
  favoriteService = inject(FavoriteService);

  latestRecipes = signal<Recipe[]>([]);
  categories = signal<Category[]>([]);
  loadingRecipes = signal(true);
  loadingCategories = signal(true);

  private categoryIcons: Record<string, string> = {
    'postres': 'cake',
    'desayunos': 'free_breakfast',
    'almuerzos': 'lunch_dining',
    'cenas': 'dinner_dining',
    'carnes': 'kebab_dining',
    'pescados': 'set_meal',
    'vegetariano': 'eco',
    'vegano': 'spa',
    'sopas': 'soup_kitchen',
    'ensaladas': 'grass',
    'pastas': 'ramen_dining',
    'bebidas': 'local_bar',
    'snacks': 'tapas',
    'default': 'restaurant_menu',
  };

  ngOnInit(): void {
    this.loadLatestRecipes();
    this.loadCategories();
  }

  loadLatestRecipes(): void {
    this.recipeService.getLatestRecipes(6).subscribe({
      next: (recipes) => {
        this.latestRecipes.set(recipes);
        this.loadingRecipes.set(false);
      },
      error: () => {
        this.loadingRecipes.set(false);
      },
    });
  }

  loadCategories(): void {
    this.categoryService.getCategories().subscribe({
      next: (categories) => {
        this.categories.set(categories.slice(0, 6));
        this.loadingCategories.set(false);
      },
      error: () => {
        this.loadingCategories.set(false);
      },
    });
  }

  getCategoryIcon(name: string): string {
    const normalizedName = name.toLowerCase();
    return this.categoryIcons[normalizedName] || this.categoryIcons['default'];
  }

  onToggleFavorite(recipeId: number): void {
    this.favoriteService.toggleFavorite(recipeId).subscribe();
  }
}
