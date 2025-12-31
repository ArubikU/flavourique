import { Component, inject, signal, OnInit, Input } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { RecipeService, FavoriteService, AuthService } from '@core/services';
import { Recipe } from '@core/models';
import { LoadingSpinnerComponent } from '@shared/components/loading-spinner/loading-spinner.component';

@Component({
  selector: 'app-recipe-detail',
  standalone: true,
  imports: [RouterLink, LoadingSpinnerComponent],
  template: `
    @if (loading()) {
      <app-loading-spinner [fullscreen]="true" message="Cargando receta..." />
    } @else if (recipe()) {
      <article class="recipe-detail">
        <!-- Hero -->
        <div class="recipe-hero">
          <div class="recipe-hero-image">
            @if (recipe()?.imageUrl) {
              <img [src]="recipe()?.imageUrl" [alt]="recipe()?.title" />
            } @else {
              <div class="hero-placeholder">
                <span class="material-icons-outlined">restaurant</span>
              </div>
            }
          </div>
          <div class="recipe-hero-overlay"></div>
          <div class="recipe-hero-content container container-readable">
            <div class="recipe-categories">
              @for (category of recipe()?.categories || []; track category.id) {
                <span class="chip chip-primary">{{ category.name }}</span>
              }
            </div>
            <h1 class="recipe-title">{{ recipe()?.title }}</h1>
            <div class="recipe-meta">
              <a [routerLink]="['/profile', recipe()?.author?.username]" class="recipe-author">
                @if (recipe()?.author?.avatarUrl) {
                  <img [src]="recipe()?.author?.avatarUrl" [alt]="recipe()?.author?.username" class="author-avatar" />
                } @else {
                  <div class="author-avatar-placeholder">
                    {{ recipe()?.author?.username?.charAt(0)?.toUpperCase() }}
                  </div>
                }
                <span>{{ recipe()?.author?.displayName || recipe()?.author?.username }}</span>
              </a>
              <span class="meta-separator">•</span>
              <span class="meta-item">
                <span class="material-icons-outlined icon-sm">calendar_today</span>
                {{ formatDate(recipe()?.createdAt) }}
              </span>
            </div>
          </div>
        </div>

        <div class="recipe-content container container-readable">
          <div class="recipe-grid">
            <!-- Main Content -->
            <div class="recipe-main">
              <!-- Stats Bar -->
              <div class="stats-bar">
                <div class="stat-item">
                  <span class="material-icons-outlined">schedule</span>
                  <div class="stat-info">
                    <span class="stat-value">{{ recipe()?.prepTime }} min</span>
                    <span class="stat-label">Preparación</span>
                  </div>
                </div>
                <div class="stat-item">
                  <span class="material-icons-outlined">local_fire_department</span>
                  <div class="stat-info">
                    <span class="stat-value">{{ recipe()?.cookTime }} min</span>
                    <span class="stat-label">Cocción</span>
                  </div>
                </div>
                <div class="stat-item">
                  <span class="material-icons-outlined">restaurant</span>
                  <div class="stat-info">
                    <span class="stat-value">{{ recipe()?.servings }}</span>
                    <span class="stat-label">Porciones</span>
                  </div>
                </div>
                <div class="stat-item">
                  <span class="material-icons" [class]="'difficulty-icon-' + recipe()?.difficulty?.toLowerCase()">{{ getDifficultyIcon() }}</span>
                  <div class="stat-info">
                    <span class="difficulty-badge" [class]="'difficulty-' + recipe()?.difficulty?.toLowerCase()">
                      {{ getDifficultyLabel() }}
                    </span>
                    <span class="stat-label">Dificultad</span>
                  </div>
                </div>
              </div>

              <!-- Description -->
              @if (recipe()?.description) {
                <section class="recipe-section">
                  <p class="recipe-description">{{ recipe()?.description }}</p>
                </section>
              }

              <!-- Ingredients -->
              <section class="recipe-section">
                <h2 class="section-title">
                  <span class="material-icons-outlined">shopping_basket</span>
                  Ingredientes
                </h2>
                <ul class="ingredients-list">
                  @for (ingredient of recipe()?.ingredients || []; track ingredient.id) {
                    <li class="ingredient-item">
                      <span class="ingredient-checkbox">
                        <input type="checkbox" [id]="'ing-' + ingredient.id" />
                        <span class="checkmark"></span>
                      </span>
                      <label [for]="'ing-' + ingredient.id">
                        <span class="ingredient-quantity">{{ ingredient.quantity }} {{ ingredient.unit }}</span>
                        <span class="ingredient-name">{{ ingredient.name }}</span>
                      </label>
                    </li>
                  }
                </ul>
              </section>

              <!-- Instructions -->
              <section class="recipe-section">
                <h2 class="section-title">
                  <span class="material-icons-outlined">format_list_numbered</span>
                  Instrucciones
                </h2>
                @if (recipe()?.steps && recipe()!.steps.length > 0) {
                  <ol class="steps-list">
                    @for (step of getSortedSteps(); track step.stepNumber) {
                      <li class="step-item">
                        <div class="step-number">{{ step.stepNumber }}</div>
                        <div class="step-content">
                          <p>{{ step.description }}</p>
                          @if (step.imageUrl) {
                            <img [src]="step.imageUrl" [alt]="'Paso ' + step.stepNumber" class="step-image" />
                          }
                        </div>
                      </li>
                    }
                  </ol>
                }
              </section>

              <!-- Tags -->
              @if (recipe()?.tags && recipe()!.tags.length > 0) {
                <section class="recipe-section">
                  <h2 class="section-title">
                    <span class="material-icons-outlined">local_offer</span>
                    Etiquetas
                  </h2>
                  <div class="tags-list">
                    @for (tag of recipe()?.tags || []; track tag.id) {
                      <span class="chip">{{ tag.name }}</span>
                    }
                  </div>
                </section>
              }
            </div>

            <!-- Sidebar -->
            <aside class="recipe-sidebar">
              <!-- Actions Card -->
              <div class="sidebar-card actions-card">
                <div class="recipe-stats">
                  @if (recipe()?.averageRating) {
                    <div class="stat-badge">
                      <span class="material-icons" style="color: #EAB308;">star</span>
                      <span class="stat-value">{{ recipe()?.averageRating?.toFixed(1) }}</span>
                      <span class="stat-label">({{ recipe()?.reviewCount }} reseñas)</span>
                    </div>
                  }
                  <div class="stat-badge">
                    <span class="material-icons-outlined">favorite</span>
                    <span class="stat-value">{{ recipe()?.favoritesCount }}</span>
                    <span class="stat-label">favoritos</span>
                  </div>
                </div>

                @if (authService.isAuthenticated()) {
                  <div class="actions-buttons">
                    <button 
                      class="btn btn-lg w-full"
                      [class.btn-primary]="!isFavorite()"
                      [class.btn-outline]="isFavorite()"
                      (click)="toggleFavorite()"
                    >
                      <span class="material-icons">{{ isFavorite() ? 'favorite' : 'favorite_border' }}</span>
                      {{ isFavorite() ? 'Guardado' : 'Guardar' }}
                    </button>

                    @if (isOwner()) {
                      <div class="owner-actions">
                        <a [routerLink]="['/recipes', recipe()?.id, 'edit']" class="btn btn-outline w-full">
                          <span class="material-icons-outlined">edit</span>
                          Editar
                        </a>
                        <button class="btn btn-outline w-full text-error" (click)="confirmDelete()">
                          <span class="material-icons-outlined">delete</span>
                          Eliminar
                        </button>
                      </div>
                    }
                  </div>
                }

                <button class="btn btn-ghost w-full" (click)="shareRecipe()">
                  <span class="material-icons-outlined">share</span>
                  Compartir
                </button>

                <button class="btn btn-ghost w-full" (click)="printRecipe()">
                  <span class="material-icons-outlined">print</span>
                  Imprimir
                </button>
              </div>

              <!-- Author Card -->
              <div class="sidebar-card author-card">
                <h3 class="card-title">Sobre el autor</h3>
                <a [routerLink]="['/profile', recipe()?.author?.username]" class="author-info">
                  @if (recipe()?.author?.avatarUrl) {
                    <img [src]="recipe()?.author?.avatarUrl" [alt]="recipe()?.author?.username" class="author-avatar-lg" />
                  } @else {
                    <div class="author-avatar-lg-placeholder">
                      {{ recipe()?.author?.username?.charAt(0)?.toUpperCase() }}
                    </div>
                  }
                  <div class="author-details">
                    <span class="author-name">{{ recipe()?.author?.displayName || recipe()?.author?.username }}</span>
                    <span class="author-username">&#64;{{ recipe()?.author?.username }}</span>
                  </div>
                </a>
                @if (recipe()?.author?.bio) {
                  <p class="author-bio">{{ recipe()?.author?.bio }}</p>
                }
                <a [routerLink]="['/profile', recipe()?.author?.username]" class="btn btn-outline btn-sm w-full">
                  Ver Perfil
                </a>
              </div>
            </aside>
          </div>
        </div>
      </article>
    } @else {
      <div class="not-found container container-readable">
        <span class="material-icons-outlined empty-icon">search_off</span>
        <h2>Receta no encontrada</h2>
        <p>La receta que buscas no existe o ha sido eliminada.</p>
        <a routerLink="/recipes" class="btn btn-primary">Ver Todas las Recetas</a>
      </div>
    }
  `,
  styles: [`
    .recipe-hero {
      position: relative;
      height: 400px;
      overflow: hidden;

      @media (min-width: 768px) {
        height: 500px;
      }
    }

    .recipe-hero-image {
      position: absolute;
      inset: 0;

      img {
        width: 100%;
        height: 100%;
        object-fit: cover;
      }
    }

    .hero-placeholder {
      width: 100%;
      height: 100%;
      background: linear-gradient(135deg, var(--color-primary-100) 0%, var(--color-primary-200) 100%);
      display: flex;
      align-items: center;
      justify-content: center;

      .material-icons-outlined {
        font-size: 120px;
        color: var(--color-primary-300);
      }
    }

    .recipe-hero-overlay {
      position: absolute;
      inset: 0;
      background: linear-gradient(to top, rgba(0,0,0,0.8) 0%, transparent 60%);
    }

    .recipe-hero-content {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      padding: var(--space-8);
      color: white;
    }

    .recipe-categories {
      display: flex;
      flex-wrap: wrap;
      gap: var(--space-2);
      margin-bottom: var(--space-3);
    }

    .recipe-title {
      font-size: 32px;
      font-weight: 700;
      margin-bottom: var(--space-3);

      @media (min-width: 768px) {
        font-size: 42px;
      }
    }

    .recipe-meta {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      gap: var(--space-3);
      color: rgba(255,255,255,0.9);
    }

    .recipe-author {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      color: inherit;
      text-decoration: none;

      &:hover {
        color: white;
      }
    }

    .author-avatar {
      width: 32px;
      height: 32px;
      border-radius: var(--border-radius-full);
      object-fit: cover;
    }

    .author-avatar-placeholder {
      width: 32px;
      height: 32px;
      border-radius: var(--border-radius-full);
      background: var(--color-primary-500);
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      font-size: 14px;
    }

    .meta-separator {
      color: rgba(255,255,255,0.5);
    }

    .meta-item {
      display: flex;
      align-items: center;
      gap: var(--space-1);
    }

    .recipe-content {
      padding: var(--space-8) var(--space-4);

      @media (min-width: 768px) {
        padding: var(--space-8);
      }
    }

    .recipe-grid {
      display: grid;
      grid-template-columns: 1fr;
      gap: var(--space-8);

      @media (min-width: 1024px) {
        grid-template-columns: 2fr 1fr;
      }
    }

    .stats-bar {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: var(--space-4);
      padding: var(--space-4);
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      margin-bottom: var(--space-6);

      @media (min-width: 640px) {
        grid-template-columns: repeat(4, 1fr);
      }
    }

    .stat-item {
      display: flex;
      align-items: center;
      gap: var(--space-3);

      .material-icons-outlined {
        font-size: 24px;
        color: var(--color-primary-500);
      }
    }

    .stat-info {
      display: flex;
      flex-direction: column;
    }

    .stat-value {
      font-weight: 600;
      color: var(--text-primary);
    }

    .difficulty-icon-easy { color: #166534; }
    .difficulty-icon-medium { color: #854D0E; }
    .difficulty-icon-hard { color: #991B1B; }

    .difficulty-badge {
      display: inline-flex;
      align-items: center;
      padding: 2px 8px;
      font-size: 12px;
      font-weight: 600;
      border-radius: var(--border-radius-sm);
      text-transform: uppercase;
      letter-spacing: 0.3px;

      &.difficulty-easy {
        background: var(--color-success-light);
        color: #166534;
      }

      &.difficulty-medium {
        background: var(--color-warning-light);
        color: #854D0E;
      }

      &.difficulty-hard {
        background: var(--color-error-light);
        color: #991B1B;
      }
    }

    .stat-label {
      font-size: 12px;
      color: var(--text-secondary);
    }

    .recipe-section {
      margin-bottom: var(--space-8);
    }

    .section-title {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      font-size: 20px;
      font-weight: 600;
      color: var(--text-primary);
      margin-bottom: var(--space-4);

      .material-icons-outlined {
        color: var(--color-primary-500);
      }
    }

    .recipe-description {
      font-size: 18px;
      line-height: 1.7;
      color: var(--text-secondary);
    }

    .ingredients-list {
      list-style: none;
      padding: 0;
    }

    .ingredient-item {
      display: flex;
      align-items: center;
      gap: var(--space-3);
      padding: var(--space-3) 0;
      border-bottom: 1px solid var(--border-default);

      &:last-child {
        border-bottom: none;
      }

      label {
        display: flex;
        gap: var(--space-2);
        cursor: pointer;
      }
    }

    .ingredient-checkbox {
      position: relative;

      input {
        width: 20px;
        height: 20px;
        accent-color: var(--color-primary-500);
      }
    }

    .ingredient-quantity {
      font-weight: 500;
      color: var(--color-primary-600);
      min-width: 80px;
    }

    .ingredient-name {
      color: var(--text-primary);
    }

    .steps-list {
      list-style: none;
      padding: 0;
      counter-reset: step;
    }

    .step-item {
      display: flex;
      gap: var(--space-4);
      margin-bottom: var(--space-6);

      &:last-child {
        margin-bottom: 0;
      }
    }

    .step-number {
      flex-shrink: 0;
      width: 32px;
      height: 32px;
      background: var(--color-primary-500);
      color: white;
      border-radius: var(--border-radius-full);
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      font-size: 14px;
    }

    .step-content {
      flex: 1;

      p {
        line-height: 1.7;
        color: var(--text-primary);
      }
    }

    .step-image {
      margin-top: var(--space-3);
      max-width: 100%;
      border-radius: var(--border-radius-md);
    }

    .tags-list {
      display: flex;
      flex-wrap: wrap;
      gap: var(--space-2);
    }

    .recipe-sidebar {
      display: flex;
      flex-direction: column;
      gap: var(--space-4);
      position: sticky;
      top: 80px;
      align-self: start;
    }

    .sidebar-card {
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      padding: var(--space-4);
    }

    .recipe-stats {
      display: flex;
      justify-content: center;
      gap: var(--space-6);
      padding-bottom: var(--space-4);
      border-bottom: 1px solid var(--border-default);
      margin-bottom: var(--space-4);
    }

    .stat-badge {
      display: flex;
      align-items: center;
      gap: var(--space-1);

      .stat-value {
        font-size: 18px;
      }

      .stat-label {
        font-size: 12px;
      }
    }

    .actions-buttons {
      display: flex;
      flex-direction: column;
      gap: var(--space-2);
      margin-bottom: var(--space-3);
    }

    .owner-actions {
      display: flex;
      gap: var(--space-2);
    }

    .w-full {
      width: 100%;
    }

    .text-error {
      color: var(--color-error) !important;

      &:hover {
        background: var(--color-error-light) !important;
        border-color: var(--color-error) !important;
      }
    }

    .card-title {
      font-size: 14px;
      font-weight: 600;
      color: var(--text-secondary);
      text-transform: uppercase;
      letter-spacing: 0.5px;
      margin-bottom: var(--space-4);
    }

    .author-info {
      display: flex;
      align-items: center;
      gap: var(--space-3);
      text-decoration: none;
      margin-bottom: var(--space-3);
    }

    .author-avatar-lg {
      width: 48px;
      height: 48px;
      border-radius: var(--border-radius-full);
      object-fit: cover;
    }

    .author-avatar-lg-placeholder {
      width: 48px;
      height: 48px;
      border-radius: var(--border-radius-full);
      background: var(--color-primary-100);
      color: var(--color-primary-600);
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      font-size: 18px;
    }

    .author-details {
      display: flex;
      flex-direction: column;
    }

    .author-name {
      font-weight: 600;
      color: var(--text-primary);
    }

    .author-username {
      font-size: 13px;
      color: var(--text-secondary);
    }

    .author-bio {
      font-size: 14px;
      color: var(--text-secondary);
      line-height: 1.5;
      margin-bottom: var(--space-3);
    }

    .not-found {
      text-align: center;
      padding: var(--space-16) var(--space-4);

      .empty-icon {
        font-size: 80px;
        color: var(--color-primary-200);
        margin-bottom: var(--space-4);
      }

      h2 {
        font-size: 24px;
        color: var(--text-primary);
        margin-bottom: var(--space-2);
      }

      p {
        color: var(--text-secondary);
        margin-bottom: var(--space-6);
      }
    }
  `],
})
export class RecipeDetailComponent implements OnInit {
  @Input() id!: string;

  private router = inject(Router);
  private recipeService = inject(RecipeService);
  private favoriteService = inject(FavoriteService);
  authService = inject(AuthService);

  recipe = signal<Recipe | null>(null);
  loading = signal(true);
  isFavorite = signal(false);

  ngOnInit(): void {
    this.loadRecipe();
  }

  loadRecipe(): void {
    const recipeId = parseInt(this.id, 10);
    if (isNaN(recipeId)) {
      this.loading.set(false);
      return;
    }

    this.recipeService.getRecipeById(recipeId).subscribe({
      next: (recipe) => {
        this.recipe.set(recipe);
        this.loading.set(false);
        if (this.authService.isAuthenticated()) {
          this.checkFavorite(recipeId);
        }
      },
      error: () => {
        this.loading.set(false);
      },
    });
  }

  checkFavorite(recipeId: number): void {
    this.favoriteService.isFavorite(recipeId).subscribe({
      next: (isFav) => this.isFavorite.set(isFav),
    });
  }

  getDifficultyLabel(): string {
    const labels: Record<string, string> = {
      EASY: 'Fácil',
      MEDIUM: 'Medio',
      HARD: 'Difícil',
    };
    return labels[this.recipe()?.difficulty || ''] || this.recipe()?.difficulty || '';
  }

  getSortedSteps() {
    const steps = this.recipe()?.steps || [];
    return [...steps].sort((a, b) => a.stepNumber - b.stepNumber);
  }

  getDifficultyIcon(): string {
    const icons: Record<string, string> = {
      EASY: 'sentiment_satisfied',
      MEDIUM: 'sentiment_neutral',
      HARD: 'local_fire_department',
    };
    return icons[this.recipe()?.difficulty || ''] || 'help_outline';
  }

  formatDate(dateString?: string): string {
    if (!dateString) return '';
    const date = new Date(dateString);
    return date.toLocaleDateString('es-ES', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
    });
  }

  isOwner(): boolean {
    const currentUser = this.authService.currentUser();
    return currentUser?.id === this.recipe()?.author?.id;
  }

  toggleFavorite(): void {
    const recipeId = this.recipe()?.id;
    if (!recipeId) return;

    this.favoriteService.toggleFavorite(recipeId).subscribe({
      next: () => {
        this.isFavorite.update(v => !v);
      },
    });
  }

  shareRecipe(): void {
    const url = window.location.href;
    if (navigator.share) {
      navigator.share({
        title: this.recipe()?.title,
        text: this.recipe()?.description,
        url,
      });
    } else {
      navigator.clipboard.writeText(url);
      alert('Enlace copiado al portapapeles');
    }
  }

  printRecipe(): void {
    window.print();
  }

  confirmDelete(): void {
    if (confirm('¿Estás seguro de que quieres eliminar esta receta? Esta acción no se puede deshacer.')) {
      const recipeId = this.recipe()?.id;
      if (!recipeId) return;

      this.recipeService.deleteRecipe(recipeId).subscribe({
        next: () => {
          this.router.navigate(['/recipes']);
        },
        error: () => {
          alert('Error al eliminar la receta');
        },
      });
    }
  }
}
