import { Component, signal } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-contact',
  standalone: true,
  imports: [ReactiveFormsModule],
  template: `
    <div class="contact-page">
      <div class="container container-readable">
        <div class="contact-header">
          <h1>Contacto</h1>
          <p class="contact-subtitle">
            ¿Tienes alguna pregunta, sugerencia o problema? Estamos aquí para ayudarte.
          </p>
        </div>

        <div class="contact-grid">
          <!-- Contact Form -->
          <div class="contact-form-section">
            <h2>Envíanos un Mensaje</h2>
            
            @if (submitted()) {
              <div class="success-message">
                <span class="material-icons-outlined">check_circle</span>
                <div>
                  <h3>¡Mensaje Enviado!</h3>
                  <p>Gracias por contactarnos. Te responderemos lo antes posible.</p>
                </div>
              </div>
            } @else {
              <form [formGroup]="contactForm" (ngSubmit)="onSubmit()">
                <div class="form-group">
                  <label for="name" class="form-label">Nombre</label>
                  <input 
                    type="text" 
                    id="name" 
                    formControlName="name" 
                    class="form-input"
                    placeholder="Tu nombre"
                  />
                  @if (isFieldInvalid('name')) {
                    <span class="error-message">El nombre es requerido</span>
                  }
                </div>

                <div class="form-group">
                  <label for="email" class="form-label">Correo Electrónico</label>
                  <input 
                    type="email" 
                    id="email" 
                    formControlName="email" 
                    class="form-input"
                    placeholder="tu@email.com"
                  />
                  @if (isFieldInvalid('email')) {
                    <span class="error-message">Ingresa un correo válido</span>
                  }
                </div>

                <div class="form-group">
                  <label for="subject" class="form-label">Asunto</label>
                  <select id="subject" formControlName="subject" class="form-input">
                    <option value="">Selecciona un asunto</option>
                    <option value="general">Consulta General</option>
                    <option value="bug">Reportar un Error</option>
                    <option value="suggestion">Sugerencia</option>
                    <option value="account">Problema con mi Cuenta</option>
                    <option value="recipe">Problema con una Receta</option>
                    <option value="privacy">Privacidad y Datos</option>
                    <option value="other">Otro</option>
                  </select>
                  @if (isFieldInvalid('subject')) {
                    <span class="error-message">Selecciona un asunto</span>
                  }
                </div>

                <div class="form-group">
                  <label for="message" class="form-label">Mensaje</label>
                  <textarea 
                    id="message" 
                    formControlName="message" 
                    class="form-input form-textarea"
                    placeholder="Escribe tu mensaje aquí..."
                    rows="6"
                  ></textarea>
                  @if (isFieldInvalid('message')) {
                    <span class="error-message">El mensaje debe tener al menos 20 caracteres</span>
                  }
                </div>

                <button type="submit" class="btn btn-primary btn-lg btn-block" [disabled]="loading()">
                  @if (loading()) {
                    <span class="material-icons-outlined spinning">refresh</span>
                    Enviando...
                  } @else {
                    <span class="material-icons-outlined">send</span>
                    Enviar Mensaje
                  }
                </button>
              </form>
            }
          </div>

          <!-- Contact Info -->
          <div class="contact-info-section">
            <h2>Otras Formas de Contacto</h2>

            <div class="contact-card">
              <div class="contact-icon">
                <span class="material-icons-outlined">email</span>
              </div>
              <div class="contact-details">
                <h3>Correo Electrónico</h3>
                <p>soporte&#64;flavorique.com</p>
              </div>
            </div>

            <div class="contact-card">
              <div class="contact-icon">
                <span class="material-icons-outlined">schedule</span>
              </div>
              <div class="contact-details">
                <h3>Tiempo de Respuesta</h3>
                <p>Respondemos en 24-48 horas hábiles</p>
              </div>
            </div>

            <div class="contact-card">
              <div class="contact-icon">
                <span class="material-icons-outlined">help_outline</span>
              </div>
              <div class="contact-details">
                <h3>Preguntas Frecuentes</h3>
                <p>Revisa nuestras FAQ antes de contactarnos</p>
              </div>
            </div>

            <div class="social-section">
              <h3>Síguenos en Redes</h3>
              <div class="social-links">
                <a href="#" class="social-link" aria-label="Facebook">
                  <span class="material-icons">facebook</span>
                </a>
                <a href="#" class="social-link" aria-label="Instagram">
                  <span class="material-icons">camera_alt</span>
                </a>
                <a href="#" class="social-link" aria-label="Twitter">
                  <span class="material-icons">tag</span>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .contact-page {
      padding: var(--space-8) 0 var(--space-16);
      min-height: 60vh;
    }

    .contact-header {
      text-align: center;
      margin-bottom: var(--space-10);

      h1 {
        font-size: 32px;
        font-weight: 700;
        color: var(--text-primary);
        margin-bottom: var(--space-2);
      }

      .contact-subtitle {
        color: var(--text-secondary);
        font-size: 18px;
        max-width: 500px;
        margin: 0 auto;
      }
    }

    .contact-grid {
      display: grid;
      grid-template-columns: 1fr;
      gap: var(--space-8);

      @media (min-width: 768px) {
        grid-template-columns: 1.5fr 1fr;
      }
    }

    .contact-form-section,
    .contact-info-section {
      h2 {
        font-size: 20px;
        font-weight: 600;
        color: var(--text-primary);
        margin-bottom: var(--space-6);
      }
    }

    .contact-form-section {
      background: var(--surface-card);
      padding: var(--space-6);
      border-radius: var(--border-radius-lg);
      border: 1px solid var(--border-default);
    }

    .form-group {
      margin-bottom: var(--space-4);
    }

    .form-label {
      display: block;
      font-size: 14px;
      font-weight: 500;
      color: var(--text-primary);
      margin-bottom: var(--space-2);
    }

    .form-input {
      width: 100%;
      padding: var(--space-3);
      font-size: 16px;
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      background: var(--surface-page);
      color: var(--text-primary);
      transition: border-color var(--duration-fast);

      &:focus {
        outline: none;
        border-color: var(--color-primary-500);
      }

      &::placeholder {
        color: var(--text-tertiary);
      }
    }

    .form-textarea {
      resize: vertical;
      min-height: 120px;
    }

    .error-message {
      display: block;
      color: var(--color-error);
      font-size: 12px;
      margin-top: var(--space-1);
    }

    .btn-block {
      width: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: var(--space-2);
    }

    .btn-lg {
      padding: var(--space-4) var(--space-6);
      font-size: 16px;
    }

    .spinning {
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      from { transform: rotate(0deg); }
      to { transform: rotate(360deg); }
    }

    .success-message {
      display: flex;
      align-items: flex-start;
      gap: var(--space-4);
      padding: var(--space-6);
      background: var(--color-success-light, #dcfce7);
      border-radius: var(--border-radius-md);
      border: 1px solid var(--color-success, #22c55e);

      .material-icons-outlined {
        font-size: 32px;
        color: var(--color-success, #22c55e);
      }

      h3 {
        font-size: 18px;
        font-weight: 600;
        color: var(--text-primary);
        margin-bottom: var(--space-1);
      }

      p {
        color: var(--text-secondary);
      }
    }

    .contact-card {
      display: flex;
      align-items: flex-start;
      gap: var(--space-4);
      padding: var(--space-4);
      background: var(--surface-card);
      border-radius: var(--border-radius-md);
      border: 1px solid var(--border-default);
      margin-bottom: var(--space-4);
    }

    .contact-icon {
      width: 48px;
      height: 48px;
      display: flex;
      align-items: center;
      justify-content: center;
      background: var(--color-primary-100);
      border-radius: var(--border-radius-md);

      .material-icons-outlined {
        font-size: 24px;
        color: var(--color-primary-500);
      }
    }

    .contact-details {
      h3 {
        font-size: 16px;
        font-weight: 600;
        color: var(--text-primary);
        margin-bottom: var(--space-1);
      }

      p {
        color: var(--text-secondary);
        font-size: 14px;
      }
    }

    .social-section {
      margin-top: var(--space-6);
      padding-top: var(--space-6);
      border-top: 1px solid var(--border-default);

      h3 {
        font-size: 16px;
        font-weight: 600;
        color: var(--text-primary);
        margin-bottom: var(--space-4);
      }
    }

    .social-links {
      display: flex;
      gap: var(--space-2);
    }

    .social-link {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 44px;
      height: 44px;
      border-radius: var(--border-radius-full);
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      color: var(--text-secondary);
      transition: all var(--duration-fast);

      &:hover {
        background: var(--color-primary-100);
        border-color: var(--color-primary-200);
        color: var(--color-primary-500);
      }

      .material-icons {
        font-size: 20px;
      }
    }
  `],
})
export class ContactComponent {
  private fb = new FormBuilder();
  
  loading = signal(false);
  submitted = signal(false);

  contactForm: FormGroup = this.fb.group({
    name: ['', [Validators.required]],
    email: ['', [Validators.required, Validators.email]],
    subject: ['', [Validators.required]],
    message: ['', [Validators.required, Validators.minLength(20)]],
  });

  isFieldInvalid(field: string): boolean {
    const control = this.contactForm.get(field);
    return control ? control.invalid && control.touched : false;
  }

  onSubmit(): void {
    if (this.contactForm.invalid) {
      this.contactForm.markAllAsTouched();
      return;
    }

    this.loading.set(true);

    // Simulate API call
    setTimeout(() => {
      this.loading.set(false);
      this.submitted.set(true);
      console.log('Contact form submitted:', this.contactForm.value);
    }, 1500);
  }
}
