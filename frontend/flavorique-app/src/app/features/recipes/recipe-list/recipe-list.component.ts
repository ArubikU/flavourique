import { Component, inject, signal, OnInit } from '@angular/core';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { RecipeService, FavoriteService, AuthService } from '@core/services';
import { Recipe, PageResponse, Difficulty } from '@core/models';
import { RecipeCardComponent } from '@shared/components/recipe-card/recipe-card.component';

@Component({
  selector: 'app-recipe-list',
  standalone: true,
  imports: [RouterLink, RecipeCardComponent],
  template: `
    <div class="page-header">
      <div class="container container-readable">
        <h1 class="page-title">
          @if (searchQuery()) {
            Resultados para "{{ searchQuery() }}"
          } @else if (categoryFilter()) {
            Recetas de {{ categoryFilter() }}
          } @else if (tagFilter()) {
            Recetas con tag: #{{ tagFilter() }}
          } @else {
            Todas las Recetas
          }
        </h1>
        <p class="page-subtitle">
          @if (totalRecipes() > 0) {
            {{ totalRecipes() }} recetas encontradas
          } @else if (!loading()) {
            No se encontraron recetas
          }
        </p>
      </div>
    </div>

    <div class="page-content container container-readable">
      <!-- Filters -->
      <div class="filters-bar">
        <div class="filters-left">
          <select 
            class="input filter-select" 
            (change)="onSortChange($event)"
            [value]="currentSort()"
          >
            <option value="createdAt,desc">Más recientes</option>
            <option value="createdAt,asc">Más antiguas</option>
            <option value="title,asc">Título A-Z</option>
            <option value="title,desc">Título Z-A</option>
            <option value="prepTime,asc">Tiempo de preparación</option>
          </select>

          <select 
            class="input filter-select" 
            (change)="onDifficultyChange($event)"
            [value]="difficultyFilter()"
          >
            <option value="">Todas las dificultades</option>
            <option value="EASY">Fácil</option>
            <option value="MEDIUM">Medio</option>
            <option value="HARD">Difícil</option>
          </select>
        </div>

        @if (authService.isAuthenticated()) {
          <a routerLink="/recipes/new" class="btn btn-primary">
            <span class="material-icons-outlined icon-sm">add</span>
            Nueva Receta
          </a>
        }
      </div>

      <!-- Recipes Grid -->
      @if (loading()) {
        <div class="recipes-grid">
          @for (i of [1,2,3,4,5,6,7,8,9]; track i) {
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
      } @else if (recipes().length === 0) {
        <div class="empty-state">
          <span class="material-icons-outlined empty-icon">menu_book</span>
          <h3>No hay recetas disponibles</h3>
          <p>Sé el primero en compartir una receta</p>
          @if (authService.isAuthenticated()) {
            <a routerLink="/recipes/new" class="btn btn-primary">
              <span class="material-icons-outlined">add</span>
              Crear Receta
            </a>
          }
        </div>
      } @else {
        <div class="recipes-grid">
          @for (recipe of recipes(); track recipe.id) {
            <app-recipe-card 
              [recipe]="recipe"
              [isFavorite]="favoriteService.isFavoriteLocal(recipe.id)"
              (toggleFavorite)="onToggleFavorite($event)"
              [animate]="true"
            />
          }
        </div>

        <!-- Pagination -->
        @if (totalPages() > 1) {
          <div class="pagination">
            <button 
              class="btn btn-outline btn-sm"
              [disabled]="currentPage() === 0"
              (click)="goToPage(currentPage() - 1)"
            >
              <span class="material-icons-outlined icon-sm">chevron_left</span>
              Anterior
            </button>
            
            <div class="pagination-info">
              Página {{ currentPage() + 1 }} de {{ totalPages() }}
            </div>

            <button 
              class="btn btn-outline btn-sm"
              [disabled]="currentPage() >= totalPages() - 1"
              (click)="goToPage(currentPage() + 1)"
            >
              Siguiente
              <span class="material-icons-outlined icon-sm">chevron_right</span>
            </button>
          </div>
        }
      }
    </div>
  `,
  styles: [`
    .page-header {
      background: linear-gradient(135deg, var(--color-primary-50) 0%, var(--surface-page) 100%);
      padding: var(--space-8) 0;
      margin-bottom: var(--space-6);
    }

    .page-title {
      font-size: 30px;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: var(--space-2);

      @media (min-width: 768px) {
        font-size: 36px;
      }
    }

    .page-subtitle {
      font-size: 16px;
      color: var(--text-secondary);
    }

    .page-content {
      padding-bottom: var(--space-12);
    }

    .filters-bar {
      display: flex;
      flex-wrap: wrap;
      gap: var(--space-3);
      justify-content: space-between;
      align-items: center;
      margin-bottom: var(--space-6);
      padding: var(--space-4);
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
    }

    .filters-left {
      display: flex;
      flex-wrap: wrap;
      gap: var(--space-3);
    }

    .filter-select {
      width: auto;
      min-width: 180px;
      padding: var(--space-2) var(--space-3);
      font-size: 14px;
    }

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

    .empty-state {
      text-align: center;
      padding: var(--space-16) var(--space-4);

      .empty-icon {
        font-size: 64px;
        color: var(--color-primary-200);
        margin-bottom: var(--space-4);
      }

      h3 {
        font-size: 20px;
        font-weight: 600;
        color: var(--text-primary);
        margin-bottom: var(--space-2);
      }

      p {
        color: var(--text-secondary);
        margin-bottom: var(--space-4);
      }
    }

    .pagination {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: var(--space-4);
      margin-top: var(--space-8);
      padding-top: var(--space-6);
      border-top: 1px solid var(--border-default);
    }

    .pagination-info {
      font-size: 14px;
      color: var(--text-secondary);
    }
  `],
})
export class RecipeListComponent implements OnInit {
  private route = inject(ActivatedRoute);
  private recipeService = inject(RecipeService);
  authService = inject(AuthService);
  favoriteService = inject(FavoriteService);

  recipes = signal<Recipe[]>([]);
  loading = signal(true);
  totalRecipes = signal(0);
  totalPages = signal(0);
  currentPage = signal(0);
  currentSort = signal('createdAt,desc');
  difficultyFilter = signal('');
  searchQuery = signal('');
  categoryFilter = signal('');
  tagFilter = signal('');

  ngOnInit(): void {
    this.route.queryParams.subscribe((params) => {
      this.searchQuery.set(params['q'] || '');
      this.categoryFilter.set(params['category'] || '');
      this.tagFilter.set(params['tag'] || '');
      this.currentPage.set(0);
      this.loadRecipes();
    });
  }

  loadRecipes(): void {
    this.loading.set(true);

    const page = this.currentPage();
    const size = 9;
    const sort = this.currentSort();
    const difficulty = this.difficultyFilter() as Difficulty | undefined;
    const categoryId = this.categoryFilter() ? parseInt(this.categoryFilter(), 10) : undefined;
    const tag = this.tagFilter();

    if (this.searchQuery()) {
      this.recipeService.searchRecipes(
        this.searchQuery(),
        page,
        size,
        sort,
        difficulty,
        categoryId,
        tag
      ).subscribe({
        next: (response) => this.handleResponse(response),
        error: () => this.loading.set(false),
      });
    } else {
      this.recipeService.getRecipes(
        page,
        size,
        sort,
        difficulty,
        categoryId,
        tag
      ).subscribe({
        next: (response) => this.handleResponse(response),
        error: () => this.loading.set(false),
      });
    }
  }

  handleResponse(response: PageResponse<Recipe>): void {
    this.recipes.set(response.content);
    this.totalRecipes.set(response.totalElements);
    this.totalPages.set(response.totalPages);
    this.loading.set(false);
  }

  onSortChange(event: Event): void {
    const select = event.target as HTMLSelectElement;
    this.currentSort.set(select.value);
    this.currentPage.set(0);
    this.loadRecipes();
  }

  onDifficultyChange(event: Event): void {
    const select = event.target as HTMLSelectElement;
    this.difficultyFilter.set(select.value);
    this.currentPage.set(0);
    this.loadRecipes();
  }

  goToPage(page: number): void {
    this.currentPage.set(page);
    this.loadRecipes();
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  onToggleFavorite(recipeId: number): void {
    this.favoriteService.toggleFavorite(recipeId).subscribe();
  }
}
