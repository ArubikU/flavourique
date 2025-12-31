import { Component, Input, Output, EventEmitter, inject } from '@angular/core';
import { RouterLink } from '@angular/router';
import { Recipe } from '@core/models';
import { AuthService, FavoriteService } from '@core/services';

@Component({
  selector: 'app-recipe-card',
  standalone: true,
  imports: [RouterLink],
  template: `
    <article class="recipe-card" [class.animate-fade-in-up]="animate">
      <a [routerLink]="['/recipes', recipe.id]" class="recipe-card__image">
        @if (recipe.imageUrl) {
          <img [src]="recipe.imageUrl" [alt]="recipe.title" loading="lazy" />
        } @else {
          <div class="recipe-card__placeholder">
            <span class="material-icons-outlined">restaurant</span>
          </div>
        }
        @if (authService.isAuthenticated()) {
          <button 
            class="recipe-card__favorite" 
            [class.active]="isFavorite"
            (click)="onToggleFavorite($event)"
            [attr.aria-label]="isFavorite ? 'Quitar de favoritos' : 'Añadir a favoritos'"
          >
            <span class="material-icons">{{ isFavorite ? 'favorite' : 'favorite_border' }}</span>
          </button>
        }
      </a>
      <div class="recipe-card__content">
        @if (recipe.categories && recipe.categories.length > 0) {
          <span class="recipe-card__category">{{ recipe.categories[0].name }}</span>
        }
        <h3 class="recipe-card__title">
          <a [routerLink]="['/recipes', recipe.id]">{{ recipe.title }}</a>
        </h3>
        <div class="recipe-card__meta">
          <span class="meta-item">
            <span class="material-icons-outlined icon-sm">schedule</span>
            {{ getTotalTime() }} min
          </span>
          <span class="difficulty-badge" [class]="'difficulty-' + recipe.difficulty.toLowerCase()">
            <span class="material-icons icon-sm">{{ getDifficultyIcon() }}</span>
            {{ getDifficultyLabel() }}
          </span>
        </div>
        <div class="recipe-card__footer">
          <a [routerLink]="['/profile', recipe.author.username]" class="recipe-card__author">
            @if (recipe.author.avatarUrl) {
              <img [src]="recipe.author.avatarUrl" [alt]="recipe.author.username" class="author-avatar" />
            } @else {
              <div class="author-avatar-placeholder">
                {{ recipe.author.username.charAt(0).toUpperCase() }}
              </div>
            }
            <span class="author-name">{{ recipe.author.displayName || recipe.author.username }}</span>
          </a>
          <div class="recipe-card__stats">
            @if (recipe.averageRating) {
              <span class="stat-item">
                <span class="material-icons icon-sm" style="color: #EAB308;">star</span>
                {{ recipe.averageRating.toFixed(1) }}
              </span>
            }
            <span class="stat-item">
              <span class="material-icons-outlined icon-sm">favorite_border</span>
              {{ recipe.favoritesCount }}
            </span>
          </div>
        </div>
      </div>
    </article>
  `,
  styles: [`
    .recipe-card {
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      overflow: hidden;
      transition: border-color var(--duration-fast) var(--ease-default);

      &:hover {
        border-color: var(--border-hover);

        .recipe-card__image img {
          transform: scale(1.05);
        }
      }
    }

    .recipe-card__image {
      position: relative;
      aspect-ratio: 1 / 1;
      overflow: hidden;
      display: block;

      img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform var(--duration-slow) var(--ease-default);
      }
    }

    .recipe-card__placeholder {
      width: 100%;
      height: 100%;
      background: linear-gradient(135deg, var(--color-primary-100) 0%, var(--color-primary-200) 100%);
      display: flex;
      align-items: center;
      justify-content: center;

      .material-icons-outlined {
        font-size: 64px;
        color: var(--color-primary-400);
      }
    }

    .recipe-card__favorite {
      position: absolute;
      top: var(--space-2);
      right: var(--space-2);
      background: var(--surface-card);
      border: none;
      border-radius: var(--border-radius-full);
      padding: var(--space-2);
      cursor: pointer;
      transition: all var(--duration-fast) var(--ease-default);
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);

      .material-icons {
        font-size: 20px;
        color: var(--text-secondary);
        transition: color var(--duration-fast) var(--ease-default);
      }

      &:hover {
        background: var(--color-primary-50);

        .material-icons {
          color: var(--color-error);
        }
      }

      &.active {
        .material-icons {
          color: var(--color-error);
        }

        &:hover {
          background: var(--color-error-light);
        }
      }

      &:active {
        transform: scale(0.9);
      }
    }

    .recipe-card__content {
      padding: var(--space-4);
    }

    .recipe-card__category {
      font-size: 11px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: var(--color-primary-500);
    }

    .recipe-card__title {
      font-size: 18px;
      font-weight: 600;
      color: var(--text-primary);
      margin: var(--space-1) 0 var(--space-2);
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;

      a {
        color: inherit;
        text-decoration: none;

        &:hover {
          color: var(--color-primary-500);
        }
      }
    }

    .recipe-card__meta {
      display: flex;
      gap: var(--space-3);
      margin-bottom: var(--space-3);
      flex-wrap: wrap;
    }

    .meta-item {
      display: inline-flex;
      align-items: center;
      gap: var(--space-1);
      color: var(--text-secondary);
      font-size: 13px;

      .material-icons-outlined {
        font-size: 16px;
      }
    }

    .difficulty-badge {
      display: inline-flex;
      align-items: center;
      gap: 4px;
      padding: 2px 8px;
      font-size: 11px;
      font-weight: 600;
      border-radius: var(--border-radius-sm);
      text-transform: uppercase;
      letter-spacing: 0.3px;

      .material-icons {
        font-size: 14px;
      }

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

    .recipe-card__footer {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding-top: var(--space-3);
      border-top: 1px solid var(--border-default);
    }

    .recipe-card__author {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      text-decoration: none;
      color: var(--text-secondary);
      font-size: 13px;

      &:hover {
        color: var(--color-primary-500);
      }
    }

    .author-avatar {
      width: 24px;
      height: 24px;
      border-radius: var(--border-radius-full);
      object-fit: cover;
    }

    .author-avatar-placeholder {
      width: 24px;
      height: 24px;
      border-radius: var(--border-radius-full);
      background: var(--color-primary-100);
      color: var(--color-primary-600);
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      font-size: 11px;
    }

    .author-name {
      max-width: 100px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .recipe-card__stats {
      display: flex;
      gap: var(--space-3);
    }

    .stat-item {
      display: inline-flex;
      align-items: center;
      gap: 2px;
      color: var(--text-secondary);
      font-size: 13px;
    }
  `],
})
export class RecipeCardComponent {
  @Input({ required: true }) recipe!: Recipe;
  @Input() isFavorite = false;
  @Input() animate = false;
  @Output() toggleFavorite = new EventEmitter<number>();

  authService = inject(AuthService);
  favoriteService = inject(FavoriteService);

  getTotalTime(): number {
    return (this.recipe.prepTime || 0) + (this.recipe.cookTime || 0);
  }

  getDifficultyLabel(): string {
    const labels: Record<string, string> = {
      EASY: 'Fácil',
      MEDIUM: 'Medio',
      HARD: 'Difícil',
    };
    return labels[this.recipe.difficulty] || this.recipe.difficulty;
  }

  getDifficultyIcon(): string {
    const icons: Record<string, string> = {
      EASY: 'sentiment_satisfied',
      MEDIUM: 'sentiment_neutral',
      HARD: 'local_fire_department',
    };
    return icons[this.recipe.difficulty] || 'help_outline';
  }

  onToggleFavorite(event: Event): void {
    event.preventDefault();
    event.stopPropagation();
    this.toggleFavorite.emit(this.recipe.id);
  }
}
