import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-cookies',
  standalone: true,
  imports: [RouterLink],
  template: `
    <div class="legal-page">
      <div class="container container-readable">
        <div class="legal-header">
          <h1>Política de Cookies</h1>
          <p class="last-updated">Última actualización: 1 de enero de 2025</p>
        </div>

        <div class="legal-content">
          <section>
            <h2>1. ¿Qué son las Cookies?</h2>
            <p>
              Las cookies son pequeños archivos de texto que se almacenan en tu dispositivo 
              cuando visitas un sitio web. Se utilizan ampliamente para hacer que los sitios 
              funcionen de manera más eficiente y proporcionar información a los propietarios.
            </p>
          </section>

          <section>
            <h2>2. Cookies que Utilizamos</h2>
            
            <h3>Cookies Esenciales</h3>
            <p>
              Estas cookies son necesarias para el funcionamiento básico del sitio y no pueden 
              ser desactivadas.
            </p>
            <div class="cookie-table">
              <div class="cookie-row">
                <span class="cookie-name">auth_token</span>
                <span class="cookie-purpose">Mantiene tu sesión iniciada</span>
                <span class="cookie-duration">7 días</span>
              </div>
              <div class="cookie-row">
                <span class="cookie-name">csrf_token</span>
                <span class="cookie-purpose">Protección contra ataques CSRF</span>
                <span class="cookie-duration">Sesión</span>
              </div>
            </div>

            <h3>Cookies de Preferencias</h3>
            <p>
              Estas cookies permiten recordar tus preferencias y personalizar tu experiencia.
            </p>
            <div class="cookie-table">
              <div class="cookie-row">
                <span class="cookie-name">theme</span>
                <span class="cookie-purpose">Guarda tu preferencia de tema (claro/oscuro)</span>
                <span class="cookie-duration">1 año</span>
              </div>
              <div class="cookie-row">
                <span class="cookie-name">language</span>
                <span class="cookie-purpose">Guarda tu preferencia de idioma</span>
                <span class="cookie-duration">1 año</span>
              </div>
            </div>

            <h3>Cookies Analíticas</h3>
            <p>
              Estas cookies nos ayudan a entender cómo los visitantes interactúan con el sitio.
            </p>
            <div class="cookie-table">
              <div class="cookie-row">
                <span class="cookie-name">_analytics</span>
                <span class="cookie-purpose">Estadísticas de uso anónimas</span>
                <span class="cookie-duration">2 años</span>
              </div>
            </div>
          </section>

          <section>
            <h2>3. Gestionar Cookies</h2>
            <p>
              Puedes controlar y gestionar las cookies de varias maneras. Ten en cuenta que 
              eliminar o bloquear cookies puede afectar tu experiencia de usuario.
            </p>
            
            <h3>Configuración del Navegador</h3>
            <p>
              La mayoría de los navegadores te permiten ver qué cookies tienes y eliminarlas 
              individualmente o bloquear cookies de sitios específicos o todos los sitios.
            </p>
            <ul>
              <li><a href="https://support.google.com/chrome/answer/95647" target="_blank" rel="noopener">Google Chrome</a></li>
              <li><a href="https://support.mozilla.org/es/kb/habilitar-y-deshabilitar-cookies-sitios-web" target="_blank" rel="noopener">Mozilla Firefox</a></li>
              <li><a href="https://support.apple.com/es-es/guide/safari/sfri11471/mac" target="_blank" rel="noopener">Safari</a></li>
              <li><a href="https://support.microsoft.com/es-es/microsoft-edge/eliminar-cookies-en-microsoft-edge" target="_blank" rel="noopener">Microsoft Edge</a></li>
            </ul>
          </section>

          <section>
            <h2>4. Cookies de Terceros</h2>
            <p>
              Actualmente no utilizamos cookies de terceros para publicidad. Si esto cambia, 
              actualizaremos esta política y te informaremos.
            </p>
          </section>

          <section>
            <h2>5. Cambios a esta Política</h2>
            <p>
              Podemos actualizar esta política de cookies ocasionalmente. Te recomendamos 
              revisar esta página periódicamente para estar informado sobre cualquier cambio.
            </p>
          </section>

          <section>
            <h2>6. Contacto</h2>
            <p>
              Si tienes preguntas sobre nuestra política de cookies, contáctanos a través de 
              nuestra <a routerLink="/contact">página de contacto</a>.
            </p>
          </section>
        </div>

        <div class="legal-footer">
          <a routerLink="/" class="btn btn-outline">Volver al Inicio</a>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .legal-page {
      padding: var(--space-8) 0 var(--space-16);
      min-height: 60vh;
    }

    .legal-header {
      text-align: center;
      margin-bottom: var(--space-10);
      padding-bottom: var(--space-6);
      border-bottom: 1px solid var(--border-default);

      h1 {
        font-size: 32px;
        font-weight: 700;
        color: var(--text-primary);
        margin-bottom: var(--space-2);
      }

      .last-updated {
        color: var(--text-secondary);
        font-size: 14px;
      }
    }

    .legal-content {
      section {
        margin-bottom: var(--space-8);

        h2 {
          font-size: 20px;
          font-weight: 600;
          color: var(--text-primary);
          margin-bottom: var(--space-4);
        }

        h3 {
          font-size: 16px;
          font-weight: 600;
          color: var(--text-primary);
          margin: var(--space-4) 0 var(--space-2);
        }

        p {
          color: var(--text-secondary);
          line-height: 1.7;
          margin-bottom: var(--space-4);
        }

        ul {
          color: var(--text-secondary);
          line-height: 1.7;
          padding-left: var(--space-6);
          margin-bottom: var(--space-4);

          li {
            margin-bottom: var(--space-2);
          }
        }

        a {
          color: var(--color-primary-500);
          text-decoration: none;

          &:hover {
            text-decoration: underline;
          }
        }
      }
    }

    .cookie-table {
      background: var(--surface-card);
      border-radius: var(--border-radius-md);
      border: 1px solid var(--border-default);
      overflow: hidden;
      margin-bottom: var(--space-4);
    }

    .cookie-row {
      display: grid;
      grid-template-columns: 1fr 2fr 1fr;
      padding: var(--space-3) var(--space-4);
      border-bottom: 1px solid var(--border-default);

      &:last-child {
        border-bottom: none;
      }
    }

    .cookie-name {
      font-family: monospace;
      font-size: 14px;
      color: var(--color-primary-500);
    }

    .cookie-purpose {
      color: var(--text-secondary);
      font-size: 14px;
    }

    .cookie-duration {
      color: var(--text-tertiary);
      font-size: 14px;
      text-align: right;
    }

    .legal-footer {
      margin-top: var(--space-10);
      padding-top: var(--space-6);
      border-top: 1px solid var(--border-default);
      text-align: center;
    }

    @media (max-width: 640px) {
      .cookie-row {
        grid-template-columns: 1fr;
        gap: var(--space-1);
      }

      .cookie-duration {
        text-align: left;
      }
    }
  `],
})
export class CookiesComponent {}
