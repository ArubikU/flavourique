import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-footer',
  standalone: true,
  imports: [RouterLink],
  template: `
    <footer class="footer">
      <div class="footer-container container container-readable">
        <div class="footer-grid">
          <!-- Brand -->
          <div class="footer-brand">
            <a routerLink="/" class="footer-logo">
              <img src="/isotipo.png" alt="Flavorique" class="footer-logo-icon" />
              <span class="footer-logo-text">Flavorique</span>
            </a>
            <p class="footer-description">
              Descubre y comparte las mejores recetas con nuestra comunidad de amantes de la cocina.
            </p>
            <div class="footer-social">
              <a href="#" class="social-link" aria-label="Facebook">
                <span class="material-icons">facebook</span>
              </a>
              <a href="#" class="social-link" aria-label="Instagram">
                <span class="material-icons">camera_alt</span>
              </a>
              <a href="#" class="social-link" aria-label="Twitter">
                <span class="material-icons">tag</span>
              </a>
              <a href="#" class="social-link" aria-label="YouTube">
                <span class="material-icons">play_circle</span>
              </a>
            </div>
          </div>

          <!-- Quick Links -->
          <div class="footer-links">
            <h4 class="footer-title">Enlaces Rápidos</h4>
            <ul class="footer-list">
              <li><a routerLink="/">Inicio</a></li>
              <li><a routerLink="/recipes">Recetas</a></li>
              <li><a routerLink="/categories">Categorías</a></li>
              <li><a routerLink="/search">Buscar</a></li>
            </ul>
          </div>

          <!-- Categories -->
          <div class="footer-links">
            <h4 class="footer-title">Categorías Populares</h4>
            <ul class="footer-list">
              <li><a routerLink="/recipes" [queryParams]="{category: 'postres'}">Postres</a></li>
              <li><a routerLink="/recipes" [queryParams]="{category: 'carnes'}">Carnes</a></li>
              <li><a routerLink="/recipes" [queryParams]="{category: 'vegetariano'}">Vegetariano</a></li>
              <li><a routerLink="/recipes" [queryParams]="{category: 'rapidas'}">Recetas Rápidas</a></li>
            </ul>
          </div>

          <!-- Legal -->
          <div class="footer-links">
            <h4 class="footer-title">Legal</h4>
            <ul class="footer-list">
              <li><a routerLink="/terms">Términos de Servicio</a></li>
              <li><a routerLink="/privacy">Política de Privacidad</a></li>
              <li><a routerLink="/cookies">Cookies</a></li>
              <li><a routerLink="/contact">Contacto</a></li>
            </ul>
          </div>
        </div>

        <div class="footer-bottom">
          <p>&copy; {{ currentYear }} Flavorique. Todos los derechos reservados.</p>
          <p class="footer-made">{{ footerMessage }}</p>
        </div>
      </div>
    </footer>
  `,
  styles: [`
    .footer {
      background: var(--surface-card);
      border-top: 1px solid var(--border-default);
      padding: var(--space-12) 0 var(--space-6);
      margin-top: var(--space-16);
    }

    .footer-grid {
      display: grid;
      grid-template-columns: 1fr;
      gap: var(--space-8);

      @media (min-width: 640px) {
        grid-template-columns: repeat(2, 1fr);
      }

      @media (min-width: 1024px) {
        grid-template-columns: 2fr 1fr 1fr 1fr;
      }
    }

    .footer-brand {
      max-width: 300px;
    }

    .footer-logo {
      display: inline-flex;
      align-items: center;
      gap: var(--space-2);
      text-decoration: none;
      margin-bottom: var(--space-4);
    }

    .footer-logo-icon {
      height: 32px;
      width: auto;
    }

    .footer-logo-text {
      font-size: 20px;
      font-weight: 700;
      color: var(--color-primary-500);
    }

    .footer-description {
      color: var(--text-secondary);
      font-size: 14px;
      line-height: 1.6;
      margin-bottom: var(--space-4);
    }

    .footer-social {
      display: flex;
      gap: var(--space-2);
    }

    .social-link {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 40px;
      height: 40px;
      border-radius: var(--border-radius-full);
      background: var(--surface-page);
      color: var(--text-secondary);
      transition: all var(--duration-fast) var(--ease-default);

      &:hover {
        background: var(--color-primary-100);
        color: var(--color-primary-500);
      }

      .material-icons {
        font-size: 20px;
      }
    }

    .footer-title {
      font-size: 14px;
      font-weight: 600;
      color: var(--text-primary);
      margin-bottom: var(--space-4);
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .footer-list {
      list-style: none;
      padding: 0;
      margin: 0;

      li {
        margin-bottom: var(--space-2);
      }

      a {
        color: var(--text-secondary);
        font-size: 14px;
        text-decoration: none;
        transition: color var(--duration-fast) var(--ease-default);

        &:hover {
          color: var(--color-primary-500);
        }
      }
    }

    .footer-bottom {
      margin-top: var(--space-8);
      padding-top: var(--space-6);
      border-top: 1px solid var(--border-default);
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: var(--space-2);
      text-align: center;

      @media (min-width: 640px) {
        flex-direction: row;
        justify-content: space-between;
      }

      p {
        color: var(--text-secondary);
        font-size: 14px;
      }
    }

    .footer-made .heart {
      color: var(--color-error);
    }
  `],
})
export class FooterComponent {
  currentYear = new Date().getFullYear();
  
  get footerMessage(): string {
    const today = new Date();
    const isJanuary14 = today.getMonth() === 0 && today.getDate() === 14;
    
    if (isJanuary14) {
      return '💚 Dedicado a Lian Solorzano, quien inspiró esta web 💚';
    }
    
    return 'Hecho con ❤️ para amantes de la cocina';
  }
}
