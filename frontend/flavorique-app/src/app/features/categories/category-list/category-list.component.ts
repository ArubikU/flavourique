import { Component, inject, signal, OnInit } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CategoryService, RecipeService } from '@core/services';
import { Category, Recipe } from '@core/models';
import { RecipeCardComponent } from '@shared/components/recipe-card/recipe-card.component';
import { LoadingSpinnerComponent } from '@shared/components/loading-spinner/loading-spinner.component';

@Component({
  selector: 'app-category-list',
  standalone: true,
  imports: [RouterLink, RecipeCardComponent, LoadingSpinnerComponent],
  template: `
    <div class="page-header">
      <div class="container">
        <h1 class="page-title">Categorías</h1>
        <p class="page-subtitle">Explora recetas por categoría culinaria</p>
      </div>
    </div>

    <div class="page-content container">
      @if (loading()) {
        <app-loading-spinner fullScreen message="Cargando categorías..." />
      } @else {
        <!-- Categories Grid -->
        <div class="categories-grid">
          @for (category of categories(); track category.id) {
            <button 
              class="category-card"
              [class.active]="selectedCategory()?.id === category.id"
              (click)="selectCategory(category)"
            >
              <div class="category-icon">
                <span class="material-icons-outlined">{{ getCategoryIcon(category.name) }}</span>
              </div>
              <h3 class="category-name">{{ category.name }}</h3>
              @if (category.description) {
                <p class="category-description">{{ category.description }}</p>
              }
              <span class="category-count">{{ category.recipeCount || 0 }} recetas</span>
            </button>
          }
        </div>

        <!-- Selected Category Recipes -->
        @if (selectedCategory()) {
          <section class="category-recipes">
            <div class="section-header">
              <h2 class="section-title">
                Recetas de {{ selectedCategory()?.name }}
              </h2>
              <a 
                [routerLink]="['/recipes']" 
                [queryParams]="{ category: selectedCategory()?.id }"
                class="btn btn-outline"
              >
                Ver todas
                <span class="material-icons-outlined icon-sm">arrow_forward</span>
              </a>
            </div>

            @if (loadingRecipes()) {
              <div class="recipes-grid">
                @for (i of [1, 2, 3, 4]; track i) {
                  <div class="recipe-skeleton">
                    <div class="skeleton skeleton-image"></div>
                    <div class="skeleton-content">
                      <div class="skeleton skeleton-title"></div>
                      <div class="skeleton skeleton-text"></div>
                    </div>
                  </div>
                }
              </div>
            } @else if (categoryRecipes().length === 0) {
              <div class="empty-state">
                <span class="material-icons-outlined">restaurant</span>
                <p>No hay recetas en esta categoría todavía.</p>
              </div>
            } @else {
              <div class="recipes-grid">
                @for (recipe of categoryRecipes(); track recipe.id) {
                  <app-recipe-card [recipe]="recipe" />
                }
              </div>
            }
          </section>
        }

        <!-- All Categories Info -->
        <section class="categories-info">
          <h2 class="info-title">¿Buscas inspiración?</h2>
          <p class="info-text">
            Navega por nuestras categorías para descubrir recetas deliciosas. 
            Desde desayunos energéticos hasta postres irresistibles, 
            tenemos algo para cada ocasión.
          </p>
          <a routerLink="/recipes" class="btn btn-primary btn-lg">
            Explorar Todas las Recetas
            <span class="material-icons-outlined icon-sm">arrow_forward</span>
          </a>
        </section>
      }
    </div>
  `,
  styles: [`
    .page-header {
      background: linear-gradient(135deg, var(--color-secondary-500) 0%, var(--color-secondary-600) 100%);
      padding: var(--space-12) 0;
      color: white;
    }

    .page-title {
      font-size: 36px;
      font-weight: 700;
      margin-bottom: var(--space-2);
    }

    .page-subtitle {
      font-size: 18px;
      opacity: 0.9;
    }

    .page-content {
      padding: var(--space-8) var(--space-4);

      @media (min-width: 768px) {
        padding: var(--space-12) var(--space-6);
      }
    }

    .categories-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: var(--space-4);
      margin-bottom: var(--space-10);

      @media (min-width: 640px) {
        grid-template-columns: repeat(3, 1fr);
      }

      @media (min-width: 1024px) {
        grid-template-columns: repeat(4, 1fr);
      }
    }

    .category-card {
      background: var(--surface-card);
      border: 2px solid var(--border-default);
      border-radius: var(--border-radius-md);
      padding: var(--space-5);
      text-align: center;
      cursor: pointer;
      transition: all var(--duration-normal) var(--ease-default);

      &:hover {
        border-color: var(--color-secondary-300);
        transform: translateY(-2px);
        box-shadow: var(--shadow-md);
      }

      &.active {
        border-color: var(--color-secondary-500);
        background: var(--color-secondary-50);

        .category-icon {
          background: var(--color-secondary-500);
          color: white;
        }
      }
    }

    .category-icon {
      width: 56px;
      height: 56px;
      border-radius: var(--border-radius-full);
      background: var(--color-secondary-100);
      color: var(--color-secondary-600);
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto var(--space-3);
      transition: all var(--duration-normal) var(--ease-default);

      .material-icons-outlined {
        font-size: 28px;
      }
    }

    .category-name {
      font-size: 16px;
      font-weight: 600;
      color: var(--text-primary);
      margin-bottom: var(--space-1);
    }

    .category-description {
      font-size: 13px;
      color: var(--text-secondary);
      margin-bottom: var(--space-2);
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .category-count {
      font-size: 12px;
      color: var(--color-secondary-600);
      font-weight: 500;
    }

    .category-recipes {
      margin-bottom: var(--space-12);
    }

    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: var(--space-6);
      flex-wrap: wrap;
      gap: var(--space-3);
    }

    .section-title {
      font-size: 24px;
      font-weight: 700;
      color: var(--text-primary);
    }

    .recipes-grid {
      display: grid;
      grid-template-columns: repeat(1, 1fr);
      gap: var(--space-6);

      @media (min-width: 640px) {
        grid-template-columns: repeat(2, 1fr);
      }

      @media (min-width: 1024px) {
        grid-template-columns: repeat(4, 1fr);
      }
    }

    .recipe-skeleton {
      background: var(--surface-card);
      border-radius: var(--border-radius-md);
      overflow: hidden;
    }

    .skeleton {
      background: linear-gradient(90deg, var(--color-gray-200) 25%, var(--color-gray-100) 50%, var(--color-gray-200) 75%);
      background-size: 200% 100%;
      animation: skeleton-loading 1.5s infinite;
    }

    .skeleton-image {
      aspect-ratio: 1;
      width: 100%;
    }

    .skeleton-content {
      padding: var(--space-4);
    }

    .skeleton-title {
      height: 18px;
      border-radius: var(--border-radius-sm);
      margin-bottom: var(--space-2);
    }

    .skeleton-text {
      height: 14px;
      border-radius: var(--border-radius-sm);
      width: 70%;
    }

    @keyframes skeleton-loading {
      0% { background-position: 200% 0; }
      100% { background-position: -200% 0; }
    }

    .empty-state {
      text-align: center;
      padding: var(--space-10);
      background: var(--surface-card);
      border-radius: var(--border-radius-md);
      border: 1px dashed var(--border-default);

      .material-icons-outlined {
        font-size: 48px;
        color: var(--color-gray-300);
        margin-bottom: var(--space-3);
      }

      p {
        color: var(--text-secondary);
      }
    }

    .categories-info {
      background: linear-gradient(135deg, var(--color-primary-50) 0%, var(--color-secondary-50) 100%);
      border-radius: var(--border-radius-lg);
      padding: var(--space-10);
      text-align: center;
    }

    .info-title {
      font-size: 28px;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: var(--space-3);
    }

    .info-text {
      font-size: 16px;
      color: var(--text-secondary);
      max-width: 600px;
      margin: 0 auto var(--space-6);
      line-height: 1.6;
    }
  `],
})
export class CategoryListComponent implements OnInit {
  private categoryService = inject(CategoryService);
  private recipeService = inject(RecipeService);

  categories = signal<Category[]>([]);
  selectedCategory = signal<Category | null>(null);
  categoryRecipes = signal<Recipe[]>([]);
  loading = signal(true);
  loadingRecipes = signal(false);

  private categoryIcons: Record<string, string> = {
    'desayuno': 'free_breakfast',
    'almuerzo': 'lunch_dining',
    'cena': 'dinner_dining',
    'postre': 'cake',
    'snack': 'cookie',
    'bebida': 'local_cafe',
    'entrante': 'tapas',
    'ensalada': 'eco',
    'sopa': 'soup_kitchen',
    'pasta': 'ramen_dining',
    'arroz': 'rice_bowl',
    'carne': 'kebab_dining',
    'pescado': 'set_meal',
    'vegetariano': 'grass',
    'vegano': 'spa',
    'default': 'restaurant_menu',
  };

  ngOnInit(): void {
    this.loadCategories();
  }

  loadCategories(): void {
    this.categoryService.getCategories().subscribe({
      next: (categories) => {
        this.categories.set(categories);
        this.loading.set(false);
        
        // Select first category by default
        if (categories.length > 0) {
          this.selectCategory(categories[0]);
        }
      },
      error: () => {
        this.loading.set(false);
      },
    });
  }

  selectCategory(category: Category): void {
    this.selectedCategory.set(category);
    this.loadCategoryRecipes(category.id);
  }

  loadCategoryRecipes(categoryId: number): void {
    this.loadingRecipes.set(true);

    this.recipeService.searchRecipes('', 0, 4, undefined, undefined, categoryId).subscribe({
      next: (response) => {
        this.categoryRecipes.set(response.content);
        this.loadingRecipes.set(false);
      },
      error: () => {
        this.loadingRecipes.set(false);
      },
    });
  }

  getCategoryIcon(name: string): string {
    const normalizedName = name.toLowerCase();
    return this.categoryIcons[normalizedName] || this.categoryIcons['default'];
  }
}
