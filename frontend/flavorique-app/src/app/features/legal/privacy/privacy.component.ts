import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-privacy',
  standalone: true,
  imports: [RouterLink],
  template: `
    <div class="legal-page">
      <div class="container container-readable">
        <div class="legal-header">
          <h1>Política de Privacidad</h1>
          <p class="last-updated">Última actualización: 1 de enero de 2025</p>
        </div>

        <div class="legal-content">
          <section>
            <h2>1. Información que Recopilamos</h2>
            <p>Recopilamos información que nos proporcionas directamente:</p>
            <ul>
              <li><strong>Información de cuenta:</strong> nombre, correo electrónico, nombre de usuario y contraseña</li>
              <li><strong>Información de perfil:</strong> foto de perfil, biografía y preferencias culinarias</li>
              <li><strong>Contenido:</strong> recetas, comentarios, valoraciones y favoritos</li>
              <li><strong>Comunicaciones:</strong> mensajes que nos envías</li>
            </ul>
          </section>

          <section>
            <h2>2. Información Recopilada Automáticamente</h2>
            <p>Cuando usas nuestro Servicio, recopilamos automáticamente:</p>
            <ul>
              <li>Dirección IP y tipo de navegador</li>
              <li>Páginas visitadas y tiempo de permanencia</li>
              <li>Información del dispositivo</li>
              <li>Cookies y tecnologías similares</li>
            </ul>
          </section>

          <section>
            <h2>3. Uso de la Información</h2>
            <p>Utilizamos tu información para:</p>
            <ul>
              <li>Proporcionar, mantener y mejorar el Servicio</li>
              <li>Personalizar tu experiencia y recomendaciones</li>
              <li>Comunicarnos contigo sobre actualizaciones y novedades</li>
              <li>Detectar y prevenir fraudes o actividades maliciosas</li>
              <li>Cumplir con obligaciones legales</li>
            </ul>
          </section>

          <section>
            <h2>4. Compartir Información</h2>
            <p>No vendemos tu información personal. Podemos compartirla con:</p>
            <ul>
              <li><strong>Otros usuarios:</strong> tu perfil público, recetas y comentarios son visibles</li>
              <li><strong>Proveedores de servicios:</strong> empresas que nos ayudan a operar el Servicio</li>
              <li><strong>Requisitos legales:</strong> cuando sea necesario por ley</li>
              <li><strong>Protección:</strong> para proteger derechos y seguridad</li>
            </ul>
          </section>

          <section>
            <h2>5. Seguridad de Datos</h2>
            <p>
              Implementamos medidas de seguridad técnicas y organizativas para proteger tu 
              información, incluyendo cifrado de contraseñas y conexiones seguras (HTTPS). 
              Sin embargo, ningún sistema es completamente seguro.
            </p>
          </section>

          <section>
            <h2>6. Tus Derechos</h2>
            <p>Tienes derecho a:</p>
            <ul>
              <li><strong>Acceder:</strong> solicitar una copia de tu información</li>
              <li><strong>Rectificar:</strong> corregir información incorrecta</li>
              <li><strong>Eliminar:</strong> solicitar la eliminación de tu cuenta y datos</li>
              <li><strong>Oponerte:</strong> rechazar ciertos usos de tu información</li>
              <li><strong>Portabilidad:</strong> recibir tus datos en formato estructurado</li>
            </ul>
          </section>

          <section>
            <h2>7. Cookies</h2>
            <p>
              Utilizamos cookies para mejorar tu experiencia. Puedes gestionar tus preferencias 
              de cookies en la configuración de tu navegador. Para más información, consulta 
              nuestra <a routerLink="/cookies">Política de Cookies</a>.
            </p>
          </section>

          <section>
            <h2>8. Retención de Datos</h2>
            <p>
              Conservamos tu información mientras mantengas una cuenta activa o según sea 
              necesario para proporcionarte el Servicio. Al eliminar tu cuenta, eliminaremos 
              tu información personal en un plazo de 30 días.
            </p>
          </section>

          <section>
            <h2>9. Menores de Edad</h2>
            <p>
              El Servicio no está dirigido a menores de 16 años. No recopilamos intencionalmente 
              información de menores. Si eres padre y crees que tu hijo nos ha proporcionado 
              información, contáctanos.
            </p>
          </section>

          <section>
            <h2>10. Cambios a esta Política</h2>
            <p>
              Podemos actualizar esta política ocasionalmente. Te notificaremos sobre cambios 
              significativos por correo electrónico o mediante un aviso en el Servicio.
            </p>
          </section>

          <section>
            <h2>11. Contacto</h2>
            <p>
              Para ejercer tus derechos o si tienes preguntas sobre esta política, contáctanos 
              en nuestra <a routerLink="/contact">página de contacto</a>.
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

            strong {
              color: var(--text-primary);
            }
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

    .legal-footer {
      margin-top: var(--space-10);
      padding-top: var(--space-6);
      border-top: 1px solid var(--border-default);
      text-align: center;
    }
  `],
})
export class PrivacyComponent {}
