import { Component, inject, signal } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { AuthService } from '@core/services';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [ReactiveFormsModule, RouterLink],
  template: `
    <div class="auth-page">
      <div class="auth-container animate-fade-in-up">
        <div class="auth-header">
          <a routerLink="/" class="auth-logo">
            <img src="/isotipo.png" alt="Flavorique" />
          </a>
          <h1 class="auth-title">Bienvenido de nuevo</h1>
          <p class="auth-subtitle">Inicia sesión para continuar</p>
        </div>

        @if (errorMessage()) {
          <div class="alert alert-error">
            <span class="material-icons-outlined">error</span>
            {{ errorMessage() }}
          </div>
        }

        <form [formGroup]="loginForm" (ngSubmit)="onSubmit()" class="auth-form">
          <div class="form-group">
            <label for="email" class="input-label">Correo electrónico</label>
            <input
              type="email"
              id="email"
              formControlName="email"
              class="input"
              [class.input-error]="isFieldInvalid('email')"
              placeholder="tu@email.com"
            />
            @if (isFieldInvalid('email')) {
              <span class="input-helper input-helper-error">
                @if (loginForm.get('email')?.errors?.['required']) {
                  El correo es requerido
                } @else if (loginForm.get('email')?.errors?.['email']) {
                  Ingresa un correo válido
                }
              </span>
            }
          </div>

          <div class="form-group">
            <label for="password" class="input-label">Contraseña</label>
            <div class="password-input-wrapper">
              <input
                [type]="showPassword() ? 'text' : 'password'"
                id="password"
                formControlName="password"
                class="input"
                [class.input-error]="isFieldInvalid('password')"
                placeholder="••••••••"
              />
              <button
                type="button"
                class="password-toggle"
                (click)="showPassword.set(!showPassword())"
                [attr.aria-label]="showPassword() ? 'Ocultar contraseña' : 'Mostrar contraseña'"
              >
                <span class="material-icons-outlined">
                  {{ showPassword() ? 'visibility_off' : 'visibility' }}
                </span>
              </button>
            </div>
            @if (isFieldInvalid('password')) {
              <span class="input-helper input-helper-error">La contraseña es requerida</span>
            }
          </div>

          <div class="form-actions">
            <a routerLink="/forgot-password" class="forgot-link">¿Olvidaste tu contraseña?</a>
          </div>

          <button 
            type="submit" 
            class="btn btn-primary btn-lg w-full"
            [disabled]="isLoading()"
          >
            @if (isLoading()) {
              <span class="btn-spinner"></span>
              Iniciando sesión...
            } @else {
              Iniciar Sesión
            }
          </button>
        </form>

        <div class="auth-footer">
          <p>¿No tienes cuenta? <a routerLink="/auth/register">Regístrate</a></p>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .auth-page {
      min-height: calc(100vh - 64px);
      display: flex;
      align-items: center;
      justify-content: center;
      padding: var(--space-4);
      background: linear-gradient(135deg, var(--color-primary-50) 0%, var(--surface-page) 100%);
    }

    .auth-container {
      width: 100%;
      max-width: 420px;
      background: var(--surface-card);
      border-radius: var(--border-radius-lg);
      padding: var(--space-8);
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    }

    .auth-header {
      text-align: center;
      margin-bottom: var(--space-6);
    }

    .auth-logo {
      display: inline-block;
      margin-bottom: var(--space-4);

      img {
        height: 48px;
        width: auto;
      }
    }

    .auth-title {
      font-size: 24px;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: var(--space-1);
    }

    .auth-subtitle {
      color: var(--text-secondary);
      font-size: 14px;
    }

    .alert {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      padding: var(--space-3) var(--space-4);
      border-radius: var(--border-radius-sm);
      font-size: 14px;
      margin-bottom: var(--space-4);

      &.alert-error {
        background: var(--color-error-light);
        color: #991B1B;
      }

      .material-icons-outlined {
        font-size: 20px;
      }
    }

    .auth-form {
      display: flex;
      flex-direction: column;
      gap: var(--space-4);
    }

    .form-group {
      display: flex;
      flex-direction: column;
    }

    .password-input-wrapper {
      position: relative;
    }

    .password-toggle {
      position: absolute;
      right: var(--space-3);
      top: 50%;
      transform: translateY(-50%);
      background: none;
      border: none;
      cursor: pointer;
      color: var(--text-secondary);
      padding: var(--space-1);

      &:hover {
        color: var(--text-primary);
      }
    }

    .form-actions {
      display: flex;
      justify-content: flex-end;
    }

    .forgot-link {
      font-size: 13px;
      color: var(--color-primary-500);

      &:hover {
        color: var(--color-primary-600);
      }
    }

    .w-full {
      width: 100%;
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

    .auth-footer {
      text-align: center;
      margin-top: var(--space-6);
      padding-top: var(--space-6);
      border-top: 1px solid var(--border-default);
      font-size: 14px;
      color: var(--text-secondary);

      a {
        color: var(--color-primary-500);
        font-weight: 500;

        &:hover {
          color: var(--color-primary-600);
        }
      }
    }
  `],
})
export class LoginComponent {
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private authService = inject(AuthService);

  loginForm: FormGroup;
  isLoading = signal(false);
  showPassword = signal(false);
  errorMessage = signal<string | null>(null);

  constructor() {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required]],
    });
  }

  isFieldInvalid(field: string): boolean {
    const control = this.loginForm.get(field);
    return !!(control?.invalid && control?.touched);
  }

  onSubmit(): void {
    if (this.loginForm.invalid) {
      this.loginForm.markAllAsTouched();
      return;
    }

    this.isLoading.set(true);
    this.errorMessage.set(null);

    this.authService.login(this.loginForm.value).subscribe({
      next: () => {
        this.router.navigate(['/']);
      },
      error: (error) => {
        this.isLoading.set(false);
        this.errorMessage.set(
          error.error?.message || 'Credenciales incorrectas. Intenta de nuevo.'
        );
      },
    });
  }
}
