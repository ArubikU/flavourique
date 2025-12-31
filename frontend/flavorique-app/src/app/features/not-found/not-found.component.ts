import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-not-found',
  standalone: true,
  imports: [RouterLink],
  template: `
    <div class="not-found-page">
      <div class="not-found-content">
        <div class="error-code">404</div>
        <div class="error-illustration">
          <span class="material-icons-outlined">restaurant_menu</span>
        </div>
        <h1 class="error-title">¡Oops! Página no encontrada</h1>
        <p class="error-message">
          Parece que esta receta se quemó en el horno. 
          La página que buscas no existe o ha sido movida.
        </p>
        
        <div class="error-actions">
          <a routerLink="/" class="btn btn-primary btn-lg">
            <span class="material-icons-outlined icon-sm">home</span>
            Volver al Inicio
          </a>
          <a routerLink="/recipes" class="btn btn-outline btn-lg">
            <span class="material-icons-outlined icon-sm">menu_book</span>
            Ver Recetas
          </a>
        </div>

        <div class="error-suggestions">
          <p class="suggestions-title">¿Qué puedes hacer?</p>
          <ul class="suggestions-list">
            <li>
              <span class="material-icons-outlined icon-sm">search</span>
              <a routerLink="/search">Buscar una receta específica</a>
            </li>
            <li>
              <span class="material-icons-outlined icon-sm">category</span>
              <a routerLink="/categories">Explorar categorías</a>
            </li>
            <li>
              <span class="material-icons-outlined icon-sm">trending_up</span>
              <a routerLink="/recipes">Ver recetas populares</a>
            </li>
          </ul>
        </div>
      </div>

      <!-- Decorative elements -->
      <div class="decoration decoration-1">🍳</div>
      <div class="decoration decoration-2">🥗</div>
      <div class="decoration decoration-3">🍰</div>
      <div class="decoration decoration-4">🍕</div>
    </div>
  `,
  styles: [`
    .not-found-page {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: var(--space-8);
      background: linear-gradient(135deg, var(--color-primary-50) 0%, var(--surface-page) 50%, var(--color-secondary-50) 100%);
      position: relative;
      overflow: hidden;
    }

    .not-found-content {
      text-align: center;
      max-width: 500px;
      position: relative;
      z-index: 1;
    }

    .error-code {
      font-size: 120px;
      font-weight: 900;
      color: var(--color-primary-200);
      line-height: 1;
      margin-bottom: var(--space-2);

      @media (min-width: 640px) {
        font-size: 180px;
      }
    }

    .error-illustration {
      margin-bottom: var(--space-6);

      .material-icons-outlined {
        font-size: 64px;
        color: var(--color-primary-400);
        animation: bounce 2s ease-in-out infinite;
      }
    }

    @keyframes bounce {
      0%, 100% { transform: translateY(0); }
      50% { transform: translateY(-10px); }
    }

    .error-title {
      font-size: 28px;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: var(--space-3);

      @media (min-width: 640px) {
        font-size: 36px;
      }
    }

    .error-message {
      font-size: 16px;
      color: var(--text-secondary);
      line-height: 1.6;
      margin-bottom: var(--space-8);
    }

    .error-actions {
      display: flex;
      flex-direction: column;
      gap: var(--space-3);
      margin-bottom: var(--space-10);

      @media (min-width: 640px) {
        flex-direction: row;
        justify-content: center;
      }
    }

    .error-suggestions {
      background: var(--surface-card);
      padding: var(--space-6);
      border-radius: var(--border-radius-md);
      border: 1px solid var(--border-default);
    }

    .suggestions-title {
      font-weight: 600;
      color: var(--text-primary);
      margin-bottom: var(--space-4);
    }

    .suggestions-list {
      list-style: none;
      padding: 0;
      margin: 0;

      li {
        display: flex;
        align-items: center;
        gap: var(--space-2);
        margin-bottom: var(--space-2);

        &:last-child {
          margin-bottom: 0;
        }

        .material-icons-outlined {
          color: var(--color-primary-500);
        }

        a {
          color: var(--text-primary);
          text-decoration: none;
          transition: color var(--duration-fast) var(--ease-default);

          &:hover {
            color: var(--color-primary-600);
            text-decoration: underline;
          }
        }
      }
    }

    .decoration {
      position: absolute;
      font-size: 48px;
      opacity: 0.3;
      animation: float 6s ease-in-out infinite;

      @media (min-width: 768px) {
        font-size: 64px;
        opacity: 0.5;
      }
    }

    .decoration-1 {
      top: 10%;
      left: 10%;
      animation-delay: 0s;
    }

    .decoration-2 {
      top: 20%;
      right: 15%;
      animation-delay: 1.5s;
    }

    .decoration-3 {
      bottom: 20%;
      left: 15%;
      animation-delay: 3s;
    }

    .decoration-4 {
      bottom: 10%;
      right: 10%;
      animation-delay: 4.5s;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0) rotate(0deg); }
      50% { transform: translateY(-20px) rotate(10deg); }
    }
  `],
})
export class NotFoundComponent {}
