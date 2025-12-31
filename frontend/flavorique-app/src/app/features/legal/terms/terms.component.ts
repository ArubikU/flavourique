import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-terms',
  standalone: true,
  imports: [RouterLink],
  template: `
    <div class="legal-page">
      <div class="container container-readable">
        <div class="legal-header">
          <h1>Términos de Servicio</h1>
          <p class="last-updated">Última actualización: 1 de enero de 2025</p>
        </div>

        <div class="legal-content">
          <section>
            <h2>1. Aceptación de los Términos</h2>
            <p>
              Al acceder y utilizar Flavorique ("el Servicio"), aceptas estar sujeto a estos 
              Términos de Servicio. Si no estás de acuerdo con alguna parte de estos términos, 
              no podrás acceder al Servicio.
            </p>
          </section>

          <section>
            <h2>2. Descripción del Servicio</h2>
            <p>
              Flavorique es una plataforma comunitaria para compartir y descubrir recetas de cocina. 
              El Servicio permite a los usuarios:
            </p>
            <ul>
              <li>Crear y publicar recetas</li>
              <li>Buscar y guardar recetas de otros usuarios</li>
              <li>Interactuar con la comunidad mediante comentarios y valoraciones</li>
              <li>Personalizar su perfil y preferencias culinarias</li>
            </ul>
          </section>

          <section>
            <h2>3. Registro de Cuenta</h2>
            <p>
              Para utilizar ciertas funcionalidades del Servicio, debes crear una cuenta. 
              Te comprometes a:
            </p>
            <ul>
              <li>Proporcionar información precisa y actualizada</li>
              <li>Mantener la seguridad de tu contraseña</li>
              <li>Notificarnos inmediatamente sobre cualquier uso no autorizado</li>
              <li>Ser responsable de todas las actividades bajo tu cuenta</li>
            </ul>
          </section>

          <section>
            <h2>4. Contenido del Usuario</h2>
            <p>
              Al publicar contenido en Flavorique, declaras que:
            </p>
            <ul>
              <li>Eres el propietario del contenido o tienes derecho a publicarlo</li>
              <li>El contenido no infringe derechos de terceros</li>
              <li>El contenido es apropiado y no contiene material ofensivo</li>
              <li>Otorgas a Flavorique una licencia para usar, mostrar y distribuir tu contenido</li>
            </ul>
          </section>

          <section>
            <h2>5. Conducta del Usuario</h2>
            <p>Te comprometes a NO:</p>
            <ul>
              <li>Publicar contenido ilegal, dañino o engañoso</li>
              <li>Acosar, intimidar o discriminar a otros usuarios</li>
              <li>Intentar acceder a cuentas de otros usuarios</li>
              <li>Utilizar el Servicio para spam o publicidad no autorizada</li>
              <li>Interferir con el funcionamiento del Servicio</li>
            </ul>
          </section>

          <section>
            <h2>6. Propiedad Intelectual</h2>
            <p>
              Flavorique y su contenido original, características y funcionalidad son propiedad 
              de Flavorique y están protegidos por leyes de propiedad intelectual. Las recetas 
              publicadas por usuarios permanecen bajo la propiedad de sus respectivos autores.
            </p>
          </section>

          <section>
            <h2>7. Limitación de Responsabilidad</h2>
            <p>
              Flavorique se proporciona "tal cual" sin garantías de ningún tipo. No nos hacemos 
              responsables de:
            </p>
            <ul>
              <li>La precisión o seguridad de las recetas publicadas por usuarios</li>
              <li>Alergias o reacciones a ingredientes mencionados</li>
              <li>Pérdida de datos o interrupciones del servicio</li>
              <li>Daños directos o indirectos derivados del uso del Servicio</li>
            </ul>
          </section>

          <section>
            <h2>8. Modificaciones</h2>
            <p>
              Nos reservamos el derecho de modificar estos términos en cualquier momento. 
              Los cambios serán efectivos inmediatamente después de su publicación. El uso 
              continuado del Servicio constituye la aceptación de los términos modificados.
            </p>
          </section>

          <section>
            <h2>9. Terminación</h2>
            <p>
              Podemos suspender o terminar tu cuenta si violas estos términos o por cualquier 
              otra razón a nuestra discreción. Puedes eliminar tu cuenta en cualquier momento 
              desde la configuración de tu perfil.
            </p>
          </section>

          <section>
            <h2>10. Contacto</h2>
            <p>
              Si tienes preguntas sobre estos Términos de Servicio, puedes contactarnos a través 
              de nuestra <a routerLink="/contact">página de contacto</a>.
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
export class TermsComponent {}
