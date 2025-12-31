import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-not-found',
  standalone: true,
  imports: [RouterLink],
  template: `
    @if (isLianDay) {
      <!-- Versión especial 14 de enero -->
      <div class="not-found-page lian-special">
        <div class="lian-stars"></div>
        <div class="not-found-content">
          <div class="lian-badge">
            <span class="material-icons-outlined">auto_awesome</span>
            14 de Enero - Día Especial
          </div>
          <div class="error-code lian-glow">404</div>
          <div class="error-illustration lian-float">
            <span class="lian-emoji">💚</span>
          </div>
          <h1 class="error-title">¡Oops! Página no encontrada</h1>
          <p class="error-message lian-message">
            Esta receta se perdió, pero hoy es un día especial...
            <br>
            <strong>💚 Dedicado a Lian Solorzano 💚</strong>
            <br>
            <em>Gracias por inspirar Flavorique</em>
          </p>
          
          <div class="error-actions">
            <a routerLink="/" class="btn btn-primary btn-lg lian-btn">
              <span class="material-icons-outlined icon-sm">home</span>
              Volver al Inicio
            </a>
            <a routerLink="/recipes" class="btn btn-outline btn-lg">
              <span class="material-icons-outlined icon-sm">menu_book</span>
              Ver Recetas
            </a>
          </div>

          <div class="lian-hearts">
            <span class="floating-heart" style="--delay: 0s; --x: 10%">�</span>
            <span class="floating-heart" style="--delay: 1s; --x: 30%">💚</span>
            <span class="floating-heart" style="--delay: 2s; --x: 50%">💚</span>
            <span class="floating-heart" style="--delay: 3s; --x: 70%">💚</span>
            <span class="floating-heart" style="--delay: 4s; --x: 90%">💚</span>
          </div>
        </div>

        <!-- Decoraciones especiales -->
        <div class="decoration decoration-1 lian-sparkle">✨</div>
        <div class="decoration decoration-2 lian-sparkle">💚</div>
        <div class="decoration decoration-3 lian-sparkle">⭐</div>
        <div class="decoration decoration-4 lian-sparkle">💚</div>
      </div>
    } @else {
      <!-- Versión normal -->
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
    }
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

    /* Estilos especiales para el 14 de enero - Día de Lian */
    .lian-special {
      background: linear-gradient(135deg, #d1fae5 0%, #f0fdf4 50%, #dcfce7 100%) !important;
    }

    .lian-stars {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-image: 
        radial-gradient(2px 2px at 20px 30px, #22c55e, transparent),
        radial-gradient(2px 2px at 40px 70px, #4ade80, transparent),
        radial-gradient(2px 2px at 50px 160px, #22c55e, transparent),
        radial-gradient(2px 2px at 90px 40px, #4ade80, transparent),
        radial-gradient(2px 2px at 130px 80px, #22c55e, transparent),
        radial-gradient(2px 2px at 160px 120px, #4ade80, transparent);
      background-repeat: repeat;
      background-size: 200px 200px;
      animation: sparkle 4s ease-in-out infinite;
    }

    @keyframes sparkle {
      0%, 100% { opacity: 0.5; }
      50% { opacity: 1; }
    }

    .lian-badge {
      display: inline-flex;
      align-items: center;
      gap: var(--space-2);
      padding: var(--space-2) var(--space-4);
      background: linear-gradient(135deg, #22c55e, #16a34a);
      color: white;
      border-radius: var(--border-radius-full);
      font-size: 14px;
      font-weight: 600;
      margin-bottom: var(--space-4);
      animation: pulse-glow 2s ease-in-out infinite;

      .material-icons-outlined {
        font-size: 18px;
      }
    }

    @keyframes pulse-glow {
      0%, 100% { box-shadow: 0 0 20px rgba(34, 197, 94, 0.4); }
      50% { box-shadow: 0 0 40px rgba(34, 197, 94, 0.8); }
    }

    .lian-glow {
      background: linear-gradient(135deg, #22c55e, #16a34a, #22c55e);
      background-size: 200% 200%;
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      animation: gradient-shift 3s ease-in-out infinite;
    }

    @keyframes gradient-shift {
      0%, 100% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
    }

    .lian-float {
      .lian-emoji {
        font-size: 80px;
        display: inline-block;
        animation: heart-beat 1.5s ease-in-out infinite;
      }
    }

    @keyframes heart-beat {
      0%, 100% { transform: scale(1); }
      25% { transform: scale(1.1); }
      50% { transform: scale(1); }
      75% { transform: scale(1.15); }
    }

    .lian-message {
      strong {
        color: #16a34a;
        font-size: 18px;
      }
      em {
        color: #22c55e;
      }
    }

    .lian-btn {
      background: linear-gradient(135deg, #22c55e, #16a34a) !important;
      border: none !important;

      &:hover {
        background: linear-gradient(135deg, #16a34a, #15803d) !important;
      }
    }

    .lian-hearts {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      height: 100%;
      pointer-events: none;
      overflow: hidden;
    }

    .floating-heart {
      position: absolute;
      bottom: -50px;
      left: var(--x);
      font-size: 24px;
      animation: float-up 6s ease-in-out infinite;
      animation-delay: var(--delay);
      opacity: 0;
    }

    @keyframes float-up {
      0% {
        transform: translateY(0) rotate(0deg);
        opacity: 0;
      }
      10% {
        opacity: 0.8;
      }
      90% {
        opacity: 0.8;
      }
      100% {
        transform: translateY(-100vh) rotate(360deg);
        opacity: 0;
      }
    }

    .lian-sparkle {
      animation: sparkle-float 4s ease-in-out infinite !important;
    }

    @keyframes sparkle-float {
      0%, 100% { 
        transform: translateY(0) rotate(0deg) scale(1); 
        opacity: 0.7;
      }
      50% { 
        transform: translateY(-30px) rotate(180deg) scale(1.2); 
        opacity: 1;
      }
    }
  `],
})
export class NotFoundComponent {
  isLianDay = this.checkIfLianDay();

  private checkIfLianDay(): boolean {
    const today = new Date();
    return today.getMonth() === 0 && today.getDate() === 14;
  }
}
