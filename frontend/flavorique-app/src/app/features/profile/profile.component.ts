import { Component, inject, signal, OnInit, computed } from '@angular/core';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { UserService, AuthService, RecipeService, FavoriteService } from '@core/services';
import { User, Recipe, PageResponse } from '@core/models';
import { RecipeCardComponent } from '@shared/components/recipe-card/recipe-card.component';
import { LoadingSpinnerComponent } from '@shared/components/loading-spinner/loading-spinner.component';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [RouterLink, RecipeCardComponent, LoadingSpinnerComponent],
  template: `
    <div class="profile-page">
      @if (loading()) {
        <app-loading-spinner fullScreen message="Cargando perfil..." />
      } @else if (user()) {
        <!-- Profile Header -->
        <div class="profile-header">
          <div class="container">
            <div class="profile-card">
              <div class="avatar-wrapper">
                @if (user()?.avatarUrl) {
                  <img [src]="user()?.avatarUrl" [alt]="user()?.displayName" class="avatar" />
                } @else {
                  <div class="avatar avatar-placeholder">
                    {{ user()?.displayName?.charAt(0)?.toUpperCase() || 'U' }}
                  </div>
                }
              </div>
              
              <div class="profile-info">
                <h1 class="display-name">{{ user()?.displayName }}</h1>
                <p class="username">&#64;{{ user()?.username }}</p>
                
                @if (user()?.bio) {
                  <p class="bio">{{ user()?.bio }}</p>
                }

                <div class="stats-row">
                  <div class="stat">
                    <span class="stat-value">{{ totalRecipes() }}</span>
                    <span class="stat-label">Recetas</span>
                  </div>
                </div>

                <div class="profile-actions">
                  @if (isOwnProfile()) {
                    <a routerLink="/profile/edit" class="btn btn-primary">
                      <span class="material-icons-outlined icon-sm">edit</span>
                      Editar Perfil
                    </a>
                    <a routerLink="/recipes/new" class="btn btn-outline">
                      <span class="material-icons-outlined icon-sm">add</span>
                      Nueva Receta
                    </a>
                  }
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Recipes Section -->
        <div class="profile-content container">
          <!-- Tabs for own profile -->
          @if (isOwnProfile()) {
            <div class="profile-tabs">
              <button 
                class="tab-btn" 
                [class.active]="activeTab() === 'recipes'"
                (click)="setActiveTab('recipes')"
              >
                <span class="material-icons-outlined icon-sm">restaurant_menu</span>
                Mis Recetas ({{ totalRecipes() }})
              </button>
              <button 
                class="tab-btn" 
                [class.active]="activeTab() === 'favorites'"
                (click)="setActiveTab('favorites')"
              >
                <span class="material-icons-outlined icon-sm">favorite</span>
                Guardadas ({{ favoriteRecipes().length }})
              </button>
            </div>
          } @else {
            <div class="section-header">
              <h2 class="section-title">
                Recetas de {{ user()?.displayName }}
              </h2>
            </div>
          }

          <!-- My Recipes Tab -->
          @if (activeTab() === 'recipes' || !isOwnProfile()) {
            @if (loadingRecipes()) {
              <div class="recipes-grid">
                @for (i of [1, 2, 3, 4, 5, 6]; track i) {
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
            } @else if (recipes().length === 0) {
              <div class="empty-state">
                <span class="material-icons-outlined empty-icon">restaurant_menu</span>
                <h3>No hay recetas todavía</h3>
                @if (isOwnProfile()) {
                  <p>¡Comparte tu primera creación culinaria!</p>
                  <a routerLink="/recipes/new" class="btn btn-primary">
                    <span class="material-icons-outlined icon-sm">add</span>
                    Crear Receta
                  </a>
                } @else {
                  <p>Este usuario aún no ha publicado recetas.</p>
                }
              </div>
            } @else {
              <div class="recipes-grid">
                @for (recipe of recipes(); track recipe.id) {
                  <app-recipe-card [recipe]="recipe" />
                }
              </div>

              @if (hasMoreRecipes()) {
                <div class="load-more">
                  <button 
                    class="btn btn-outline" 
                    (click)="loadMoreRecipes()"
                    [disabled]="loadingMoreRecipes()"
                  >
                    @if (loadingMoreRecipes()) {
                      <span class="btn-spinner"></span>
                      Cargando...
                    } @else {
                      Ver más recetas
                    }
                  </button>
                </div>
              }
            }
          }

          <!-- Favorites Tab -->
          @if (activeTab() === 'favorites' && isOwnProfile()) {
            @if (loadingFavorites()) {
              <div class="recipes-grid">
                @for (i of [1, 2, 3, 4, 5, 6]; track i) {
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
            } @else if (favoriteRecipes().length === 0) {
              <div class="empty-state">
                <span class="material-icons-outlined empty-icon">favorite_border</span>
                <h3>No tienes recetas guardadas</h3>
                <p>Guarda tus recetas favoritas haciendo clic en el corazón</p>
                <a routerLink="/recipes" class="btn btn-primary">
                  <span class="material-icons-outlined icon-sm">explore</span>
                  Explorar Recetas
                </a>
              </div>
            } @else {
              <div class="recipes-grid">
                @for (recipe of favoriteRecipes(); track recipe.id) {
                  <app-recipe-card [recipe]="recipe" [isFavorite]="true" />
                }
              </div>
            }
          }
        </div>
      } @else {
        <div class="not-found container">
          <span class="material-icons-outlined not-found-icon">person_off</span>
          <h2>Usuario no encontrado</h2>
          <p>El perfil que buscas no existe o ha sido eliminado.</p>
          <a routerLink="/" class="btn btn-primary">Volver al Inicio</a>
        </div>
      }
    </div>
  `,
  styles: [`
    .profile-page {
      min-height: 100vh;
    }

    .profile-header {
      background: linear-gradient(135deg, var(--color-primary-500) 0%, var(--color-primary-600) 100%);
      padding: var(--space-12) 0;
    }

    .profile-card {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: var(--space-6);
      text-align: center;

      @media (min-width: 768px) {
        flex-direction: row;
        text-align: left;
      }
    }

    .avatar-wrapper {
      flex-shrink: 0;
    }

    .avatar {
      width: 120px;
      height: 120px;
      border-radius: var(--border-radius-full);
      object-fit: cover;
      border: 4px solid white;
      box-shadow: var(--shadow-lg);

      @media (min-width: 768px) {
        width: 150px;
        height: 150px;
      }
    }

    .avatar-placeholder {
      background: white;
      color: var(--color-primary-500);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 48px;
      font-weight: 700;

      @media (min-width: 768px) {
        font-size: 60px;
      }
    }

    .profile-info {
      color: white;
    }

    .display-name {
      font-size: 28px;
      font-weight: 700;
      margin-bottom: var(--space-1);

      @media (min-width: 768px) {
        font-size: 36px;
      }
    }

    .username {
      font-size: 16px;
      opacity: 0.9;
      margin-bottom: var(--space-3);
    }

    .bio {
      font-size: 14px;
      opacity: 0.9;
      max-width: 500px;
      margin-bottom: var(--space-4);
    }

    .stats-row {
      display: flex;
      justify-content: center;
      gap: var(--space-8);
      margin-bottom: var(--space-6);

      @media (min-width: 768px) {
        justify-content: flex-start;
      }
    }

    .stat {
      display: flex;
      flex-direction: column;
      align-items: center;

      @media (min-width: 768px) {
        align-items: flex-start;
      }
    }

    .stat-value {
      font-size: 24px;
      font-weight: 700;
    }

    .stat-label {
      font-size: 14px;
      opacity: 0.8;
    }

    .profile-actions {
      display: flex;
      gap: var(--space-3);
      justify-content: center;

      @media (min-width: 768px) {
        justify-content: flex-start;
      }

      .btn {
        &.btn-primary {
          background: white;
          color: var(--color-primary-600);

          &:hover {
            background: var(--color-gray-100);
          }
        }

        &.btn-outline {
          border-color: white;
          color: white;

          &:hover {
            background: rgba(255, 255, 255, 0.1);
          }
        }
      }
    }

    .profile-content {
      padding: var(--space-8) var(--space-4);

      @media (min-width: 768px) {
        padding: var(--space-12) var(--space-6);
      }
    }

    .profile-tabs {
      display: flex;
      gap: var(--space-2);
      margin-bottom: var(--space-6);
      border-bottom: 1px solid var(--border-default);
      padding-bottom: var(--space-4);
    }

    .tab-btn {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      padding: var(--space-3) var(--space-4);
      background: transparent;
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      font-size: 14px;
      font-weight: 500;
      color: var(--text-secondary);
      cursor: pointer;
      transition: all var(--duration-fast) var(--ease-default);

      &:hover {
        border-color: var(--color-primary-300);
        color: var(--color-primary-600);
      }

      &.active {
        background: var(--color-primary-500);
        border-color: var(--color-primary-500);
        color: white;
      }
    }

    .section-header {
      margin-bottom: var(--space-6);
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
        grid-template-columns: repeat(3, 1fr);
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
      height: 20px;
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

    .empty-state {
      text-align: center;
      padding: var(--space-12) var(--space-4);
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

    .not-found {
      text-align: center;
      padding: var(--space-20) var(--space-4);
    }

    .not-found-icon {
      font-size: 80px;
      color: var(--color-gray-300);
      margin-bottom: var(--space-6);
    }

    .not-found h2 {
      font-size: 24px;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: var(--space-2);
    }

    .not-found p {
      color: var(--text-secondary);
      margin-bottom: var(--space-6);
    }
  `],
})
export class ProfileComponent implements OnInit {
  private route = inject(ActivatedRoute);
  private userService = inject(UserService);
  private authService = inject(AuthService);
  private recipeService = inject(RecipeService);
  private favoriteService = inject(FavoriteService);

  user = signal<User | null>(null);
  recipes = signal<Recipe[]>([]);
  favoriteRecipes = signal<Recipe[]>([]);
  loading = signal(true);
  loadingRecipes = signal(false);
  loadingFavorites = signal(false);
  loadingMoreRecipes = signal(false);
  currentPage = signal(0);
  totalPages = signal(0);
  totalRecipes = signal(0);
  activeTab = signal<'recipes' | 'favorites'>('recipes');

  hasMoreRecipes = computed(() => this.currentPage() < this.totalPages() - 1);
  
  isOwnProfile = computed(() => {
    const currentUser = this.authService.currentUser();
    const profileUser = this.user();
    return currentUser && profileUser && currentUser.id === profileUser.id;
  });

  ngOnInit(): void {
    this.route.params.subscribe((params) => {
      const username = params['username'];
      if (username) {
        this.loadProfile(username);
      } else {
        // Own profile
        const currentUser = this.authService.currentUser();
        if (currentUser) {
          this.loadProfile(currentUser.username);
        }
      }
    });
  }

  loadProfile(username: string): void {
    this.loading.set(true);
    
    this.userService.getUserByUsername(username).subscribe({
      next: (user) => {
        this.user.set(user);
        this.loading.set(false);
        this.loadUserRecipes(user.id);
        if (this.isOwnProfile()) {
          this.loadFavorites();
        }
      },
      error: () => {
        this.user.set(null);
        this.loading.set(false);
      },
    });
  }

  loadFavorites(): void {
    this.loadingFavorites.set(true);
    this.favoriteService.getUserFavorites().subscribe({
      next: (recipes) => {
        this.favoriteRecipes.set(recipes);
        this.loadingFavorites.set(false);
      },
      error: () => {
        this.loadingFavorites.set(false);
      },
    });
  }

  setActiveTab(tab: 'recipes' | 'favorites'): void {
    this.activeTab.set(tab);
  }

  loadUserRecipes(userId: number): void {
    this.loadingRecipes.set(true);
    this.currentPage.set(0);

    this.recipeService.getRecipesByAuthor(userId, 0, 9).subscribe({
      next: (response: PageResponse<Recipe>) => {
        this.recipes.set(response.content);
        this.totalPages.set(response.totalPages);
        this.totalRecipes.set(response.totalElements);
        this.loadingRecipes.set(false);
      },
      error: () => {
        this.loadingRecipes.set(false);
      },
    });
  }

  loadMoreRecipes(): void {
    if (this.loadingMoreRecipes() || !this.hasMoreRecipes()) return;

    const userId = this.user()?.id;
    if (!userId) return;

    this.loadingMoreRecipes.set(true);
    const nextPage = this.currentPage() + 1;

    this.recipeService.getRecipesByAuthor(userId, nextPage, 9).subscribe({
      next: (response: PageResponse<Recipe>) => {
        this.recipes.update(recipes => [...recipes, ...response.content]);
        this.currentPage.set(nextPage);
        this.loadingMoreRecipes.set(false);
      },
      error: () => {
        this.loadingMoreRecipes.set(false);
      },
    });
  }
}