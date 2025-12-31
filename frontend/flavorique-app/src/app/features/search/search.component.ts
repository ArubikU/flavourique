import { Component, inject, signal, OnInit, computed } from '@angular/core';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { RecipeService, CategoryService, FavoriteService, AuthService } from '@core/services';
import { Recipe, Category, PageResponse, Difficulty } from '@core/models';
import { RecipeCardComponent } from '@shared/components/recipe-card/recipe-card.component';

@Component({
  selector: 'app-search',
  standalone: true,
  imports: [RouterLink, FormsModule, RecipeCardComponent],
  template: `
    <div class="search-page">
      <!-- Search Header -->
      <div class="search-header">
        <div class="container">
          <h1 class="search-title">Buscar Recetas</h1>
          
          <div class="search-box">
            <span class="material-icons-outlined search-icon">search</span>
            <input
              type="text"
              class="search-input"
              placeholder="¿Qué te gustaría cocinar hoy?"
              [(ngModel)]="searchQuery"
              (keydown.enter)="onSearch()"
              autofocus
            />
            <button 
              class="btn btn-primary search-btn"
              (click)="onSearch()"
              [disabled]="searching()"
            >
              @if (searching()) {
                <span class="btn-spinner"></span>
              } @else {
                Buscar
              }
            </button>
          </div>

          <!-- Quick Filters -->
          <div class="quick-filters">
            @for (filter of quickFilters; track filter.label) {
              <button 
                class="quick-filter"
                (click)="applyQuickFilter(filter.query)"
              >
                <span class="material-icons-outlined icon-sm">{{ filter.icon }}</span>
                {{ filter.label }}
              </button>
            }
          </div>
        </div>
      </div>

      <!-- Search Content -->
      <div class="search-content container">
        @if (hasSearched()) {
          <!-- Results Header -->
          <div class="results-header">
            <p class="results-info">
              @if (totalResults() > 0) {
                <strong>{{ totalResults() }}</strong> recetas encontradas 
                @if (searchQuery) {
                  para "<strong>{{ lastSearchQuery() }}</strong>"
                }
              } @else {
                No se encontraron resultados
                @if (lastSearchQuery()) {
                  para "<strong>{{ lastSearchQuery() }}</strong>"
                }
              }
            </p>

            @if (totalResults() > 0) {
              <div class="results-sort">
                <label for="sort">Ordenar:</label>
                <select id="sort" [(ngModel)]="sortBy" (change)="onSearch()">
                  <option value="createdAt,desc">Más recientes</option>
                  <option value="createdAt,asc">Más antiguos</option>
                  <option value="title,asc">A-Z</option>
                  <option value="title,desc">Z-A</option>
                  <option value="prepTime,asc">Tiempo (menor)</option>
                </select>
              </div>
            }
          </div>

          <!-- Search Filters -->
          @if (totalResults() > 0 || hasActiveFilters()) {
            <div class="search-filters">
              <div class="filter-group">
                <label>Dificultad:</label>
                <div class="filter-options">
                  <button 
                    class="filter-btn"
                    [class.active]="selectedDifficulty() === null"
                    (click)="setDifficulty(null)"
                  >
                    Todas
                  </button>
                  <button 
                    class="filter-btn"
                    [class.active]="selectedDifficulty() === 'EASY'"
                    (click)="setDifficulty('EASY')"
                  >
                    Fácil
                  </button>
                  <button 
                    class="filter-btn"
                    [class.active]="selectedDifficulty() === 'MEDIUM'"
                    (click)="setDifficulty('MEDIUM')"
                  >
                    Media
                  </button>
                  <button 
                    class="filter-btn"
                    [class.active]="selectedDifficulty() === 'HARD'"
                    (click)="setDifficulty('HARD')"
                  >
                    Difícil
                  </button>
                </div>
              </div>

              <div class="filter-group">
                <label>Categoría:</label>
                <select [(ngModel)]="selectedCategoryId" (change)="onSearch()">
                  <option [value]="null">Todas las categorías</option>
                  @for (category of categories(); track category.id) {
                    <option [value]="category.id">{{ category.name }}</option>
                  }
                </select>
              </div>

              @if (hasActiveFilters()) {
                <button class="btn btn-ghost btn-sm" (click)="clearFilters()">
                  <span class="material-icons-outlined icon-sm">close</span>
                  Limpiar filtros
                </button>
              }
            </div>
          }

          <!-- Results Grid -->
          @if (searching()) {
            <div class="recipes-grid">
              @for (i of [1, 2, 3, 4, 5, 6, 7, 8]; track i) {
                <div class="recipe-skeleton">
                  <div class="skeleton skeleton-image"></div>
                  <div class="skeleton-content">
                    <div class="skeleton skeleton-title"></div>
                    <div class="skeleton skeleton-text"></div>
                    <div class="skeleton skeleton-text short"></div>
                  </div>
                </div>
              }
            </div>
          } @else if (results().length === 0) {
            <div class="empty-state">
              <span class="material-icons-outlined empty-icon">search_off</span>
              <h3>No encontramos recetas</h3>
              <p>Intenta con otras palabras clave o ajusta los filtros</p>
              <div class="empty-suggestions">
                <p>Sugerencias:</p>
                <ul>
                  <li>Verifica la ortografía</li>
                  <li>Prueba con términos más generales</li>
                  <li>Usa ingredientes específicos</li>
                </ul>
              </div>
            </div>
          } @else {
            <div class="recipes-grid">
              @for (recipe of results(); track recipe.id) {
                <app-recipe-card 
                  [recipe]="recipe" 
                  [isFavorite]="favoriteIds().has(recipe.id)"
                  (toggleFavorite)="onToggleFavorite($event)"
                />
              }
            </div>

            @if (hasMore()) {
              <div class="load-more">
                <button 
                  class="btn btn-outline btn-lg" 
                  (click)="loadMore()"
                  [disabled]="loadingMore()"
                >
                  @if (loadingMore()) {
                    <span class="btn-spinner"></span>
                    Cargando...
                  } @else {
                    Cargar más resultados
                  }
                </button>
              </div>
            }
          }
        } @else {
          <!-- Initial State -->
          <div class="initial-state">
            <div class="popular-searches">
              <h2>Búsquedas populares</h2>
              <div class="popular-tags">
                @for (tag of popularSearches; track tag) {
                  <button class="popular-tag" (click)="applyQuickFilter(tag)">
                    {{ tag }}
                  </button>
                }
              </div>
            </div>

            <div class="browse-categories">
              <h2>O explora por categoría</h2>
              <div class="categories-grid">
                @for (category of categories(); track category.id) {
                  <a 
                    [routerLink]="['/recipes']" 
                    [queryParams]="{ category: category.id }"
                    class="category-link"
                  >
                    <span class="material-icons-outlined">restaurant_menu</span>
                    {{ category.name }}
                  </a>
                }
              </div>
            </div>
          </div>
        }
      </div>
    </div>
  `,
  styles: [`
    .search-page {
      min-height: 100vh;
    }

    .search-header {
      background: linear-gradient(135deg, var(--color-primary-500) 0%, var(--color-primary-600) 100%);
      padding: var(--space-10) 0;
    }

    .search-title {
      font-size: 32px;
      font-weight: 700;
      color: white;
      text-align: center;
      margin-bottom: var(--space-6);
    }

    .search-box {
      display: flex;
      align-items: center;
      background: white;
      border-radius: var(--border-radius-full);
      padding: var(--space-2);
      max-width: 700px;
      margin: 0 auto var(--space-6);
      box-shadow: var(--shadow-lg);
    }

    .search-icon {
      color: var(--text-secondary);
      margin-left: var(--space-3);
    }

    .search-input {
      flex: 1;
      border: none;
      outline: none;
      padding: var(--space-3);
      font-size: 16px;
      background: transparent;

      &::placeholder {
        color: var(--text-muted);
      }
    }

    .search-btn {
      border-radius: var(--border-radius-full);
      padding: var(--space-3) var(--space-6);
    }

    .btn-spinner {
      width: 16px;
      height: 16px;
      border: 2px solid transparent;
      border-top-color: currentColor;
      border-radius: 50%;
      animation: spin 0.8s linear infinite;
    }

    @keyframes spin {
      to { transform: rotate(360deg); }
    }

    .quick-filters {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: var(--space-2);
    }

    .quick-filter {
      display: flex;
      align-items: center;
      gap: var(--space-1);
      background: rgba(255, 255, 255, 0.2);
      border: 1px solid rgba(255, 255, 255, 0.3);
      color: white;
      padding: var(--space-2) var(--space-3);
      border-radius: var(--border-radius-full);
      font-size: 14px;
      cursor: pointer;
      transition: all var(--duration-fast) var(--ease-default);

      &:hover {
        background: rgba(255, 255, 255, 0.3);
      }
    }

    .search-content {
      padding: var(--space-8) var(--space-4);

      @media (min-width: 768px) {
        padding: var(--space-10) var(--space-6);
      }
    }

    .results-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: var(--space-4);
      margin-bottom: var(--space-6);
    }

    .results-info {
      font-size: 16px;
      color: var(--text-secondary);
    }

    .results-sort {
      display: flex;
      align-items: center;
      gap: var(--space-2);

      label {
        font-size: 14px;
        color: var(--text-secondary);
      }

      select {
        padding: var(--space-2) var(--space-3);
        border: 1px solid var(--border-default);
        border-radius: var(--border-radius-sm);
        background: var(--surface-card);
        font-size: 14px;
      }
    }

    .search-filters {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      gap: var(--space-4);
      padding: var(--space-4);
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      margin-bottom: var(--space-6);
    }

    .filter-group {
      display: flex;
      align-items: center;
      gap: var(--space-2);

      label {
        font-size: 14px;
        color: var(--text-secondary);
        white-space: nowrap;
      }

      select {
        padding: var(--space-2) var(--space-3);
        border: 1px solid var(--border-default);
        border-radius: var(--border-radius-sm);
        font-size: 14px;
      }
    }

    .filter-options {
      display: flex;
      gap: var(--space-1);
    }

    .filter-btn {
      padding: var(--space-1) var(--space-3);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-sm);
      background: transparent;
      font-size: 13px;
      cursor: pointer;
      transition: all var(--duration-fast) var(--ease-default);

      &:hover {
        border-color: var(--color-primary-300);
      }

      &.active {
        background: var(--color-primary-500);
        border-color: var(--color-primary-500);
        color: white;
      }
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
      margin-bottom: var(--space-3);
    }

    .skeleton-text {
      height: 14px;
      border-radius: var(--border-radius-sm);
      margin-bottom: var(--space-2);

      &.short {
        width: 60%;
      }
    }

    @keyframes skeleton-loading {
      0% { background-position: 200% 0; }
      100% { background-position: -200% 0; }
    }

    .load-more {
      display: flex;
      justify-content: center;
      margin-top: var(--space-8);
    }

    .empty-state {
      text-align: center;
      padding: var(--space-12);
      background: var(--surface-card);
      border-radius: var(--border-radius-md);
      border: 1px dashed var(--border-default);
    }

    .empty-icon {
      font-size: 64px;
      color: var(--color-gray-300);
      margin-bottom: var(--space-4);
    }

    .empty-state h3 {
      font-size: 20px;
      font-weight: 600;
      color: var(--text-primary);
      margin-bottom: var(--space-2);
    }

    .empty-state p {
      color: var(--text-secondary);
      margin-bottom: var(--space-6);
    }

    .empty-suggestions {
      text-align: left;
      background: var(--color-gray-50);
      padding: var(--space-4);
      border-radius: var(--border-radius-sm);
      display: inline-block;

      p {
        font-weight: 600;
        margin-bottom: var(--space-2);
      }

      ul {
        margin: 0;
        padding-left: var(--space-5);
      }

      li {
        font-size: 14px;
        margin-bottom: var(--space-1);
      }
    }

    .initial-state {
      max-width: 800px;
      margin: 0 auto;
    }

    .popular-searches,
    .browse-categories {
      margin-bottom: var(--space-10);

      h2 {
        font-size: 20px;
        font-weight: 600;
        color: var(--text-primary);
        margin-bottom: var(--space-4);
        text-align: center;
      }
    }

    .popular-tags {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: var(--space-2);
    }

    .popular-tag {
      padding: var(--space-2) var(--space-4);
      background: var(--color-primary-50);
      border: 1px solid var(--color-primary-200);
      border-radius: var(--border-radius-full);
      color: var(--color-primary-700);
      font-size: 14px;
      cursor: pointer;
      transition: all var(--duration-fast) var(--ease-default);

      &:hover {
        background: var(--color-primary-100);
        border-color: var(--color-primary-300);
      }
    }

    .categories-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: var(--space-3);

      @media (min-width: 640px) {
        grid-template-columns: repeat(3, 1fr);
      }

      @media (min-width: 768px) {
        grid-template-columns: repeat(4, 1fr);
      }
    }

    .category-link {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: var(--space-2);
      padding: var(--space-4);
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      text-decoration: none;
      color: var(--text-primary);
      transition: all var(--duration-fast) var(--ease-default);

      .material-icons-outlined {
        font-size: 32px;
        color: var(--color-secondary-500);
      }

      &:hover {
        border-color: var(--color-secondary-300);
        transform: translateY(-2px);
        box-shadow: var(--shadow-sm);
      }
    }
  `],
})
export class SearchComponent implements OnInit {
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private recipeService = inject(RecipeService);
  private categoryService = inject(CategoryService);
  private favoriteService = inject(FavoriteService);
  authService = inject(AuthService);
  
  favoriteIds = signal<Set<number>>(new Set());

  searchQuery = '';
  sortBy = 'createdAt,desc';
  selectedCategoryId: number | null = null;
  selectedDifficulty = signal<Difficulty | null>(null);

  results = signal<Recipe[]>([]);
  categories = signal<Category[]>([]);
  searching = signal(false);
  loadingMore = signal(false);
  hasSearched = signal(false);
  lastSearchQuery = signal('');
  currentPage = signal(0);
  totalPages = signal(0);
  totalResults = signal(0);

  hasMore = computed(() => this.currentPage() < this.totalPages() - 1);
  hasActiveFilters = computed(() => 
    this.selectedDifficulty() !== null || this.selectedCategoryId !== null
  );

  quickFilters = [
    { label: 'Rápidas', icon: 'bolt', query: 'rápido' },
    { label: 'Vegetarianas', icon: 'eco', query: 'vegetariano' },
    { label: 'Postres', icon: 'cake', query: 'postre' },
    { label: 'Saludables', icon: 'favorite', query: 'saludable' },
  ];

  popularSearches = [
    'pasta', 'ensalada', 'pollo', 'arroz', 'sopa', 
    'pizza', 'tacos', 'hamburguesa', 'chocolate', 'smoothie'
  ];

  ngOnInit(): void {
    this.loadCategories();
    this.loadFavorites();
    
    // Check for query params
    this.route.queryParams.subscribe((params) => {
      if (params['q']) {
        this.searchQuery = params['q'];
        this.onSearch();
      }
    });
  }

  loadFavorites(): void {
    if (!this.authService.isAuthenticated()) return;
    
    this.favoriteService.getUserFavorites().subscribe({
      next: (recipes) => {
        const ids = new Set(recipes.map(r => r.id));
        this.favoriteIds.set(ids);
      },
    });
  }

  onToggleFavorite(recipeId: number): void {
    this.favoriteService.toggleFavorite(recipeId).subscribe({
      next: () => {
        const favorites = new Set(this.favoriteIds());
        if (favorites.has(recipeId)) {
          favorites.delete(recipeId);
        } else {
          favorites.add(recipeId);
        }
        this.favoriteIds.set(favorites);
      },
    });
  }

  loadCategories(): void {
    this.categoryService.getCategories().subscribe({
      next: (categories) => this.categories.set(categories),
    });
  }

  onSearch(): void {
    if (!this.searchQuery.trim() && !this.hasActiveFilters()) {
      return;
    }

    this.searching.set(true);
    this.hasSearched.set(true);
    this.lastSearchQuery.set(this.searchQuery);
    this.currentPage.set(0);

    // Update URL with search query
    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: { q: this.searchQuery || null },
      queryParamsHandling: 'merge',
    });

    this.recipeService.searchRecipes(
      this.searchQuery,
      0,
      12,
      this.sortBy,
      this.selectedDifficulty() || undefined,
      this.selectedCategoryId || undefined
    ).subscribe({
      next: (response: PageResponse<Recipe>) => {
        this.results.set(response.content);
        this.totalPages.set(response.totalPages);
        this.totalResults.set(response.totalElements);
        this.searching.set(false);
      },
      error: () => {
        this.searching.set(false);
      },
    });
  }

  loadMore(): void {
    if (this.loadingMore() || !this.hasMore()) return;

    this.loadingMore.set(true);
    const nextPage = this.currentPage() + 1;

    this.recipeService.searchRecipes(
      this.searchQuery,
      nextPage,
      12,
      this.sortBy,
      this.selectedDifficulty() || undefined,
      this.selectedCategoryId || undefined
    ).subscribe({
      next: (response: PageResponse<Recipe>) => {
        this.results.update(recipes => [...recipes, ...response.content]);
        this.currentPage.set(nextPage);
        this.loadingMore.set(false);
      },
      error: () => {
        this.loadingMore.set(false);
      },
    });
  }

  setDifficulty(difficulty: Difficulty | null): void {
    this.selectedDifficulty.set(difficulty);
    this.onSearch();
  }

  applyQuickFilter(query: string): void {
    this.searchQuery = query;
    this.onSearch();
  }

  clearFilters(): void {
    this.selectedDifficulty.set(null);
    this.selectedCategoryId = null;
    this.onSearch();
  }
}
