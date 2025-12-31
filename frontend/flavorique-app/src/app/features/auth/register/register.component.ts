import { Component, inject, signal } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule, AbstractControl, ValidationErrors } from '@angular/forms';
import { AuthService } from '@core/services';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [ReactiveFormsModule, RouterLink],
  template: `
    <div class="auth-page">
      <div class="auth-container animate-fade-in-up">
        <div class="auth-header">
          <a routerLink="/" class="auth-logo">
            <img src="/isotipo.png" alt="Flavorique" />
          </a>
          <h1 class="auth-title">Crear cuenta</h1>
          <p class="auth-subtitle">Únete a nuestra comunidad de cocina</p>
        </div>

        @if (errorMessage()) {
          <div class="alert alert-error">
            <span class="material-icons-outlined">error</span>
            {{ errorMessage() }}
          </div>
        }

        <form [formGroup]="registerForm" (ngSubmit)="onSubmit()" class="auth-form">
          <div class="form-group">
            <label for="username" class="input-label">Nombre de usuario</label>
            <input
              type="text"
              id="username"
              formControlName="username"
              class="input"
              [class.input-error]="isFieldInvalid('username')"
              placeholder="chef_ejemplo"
            />
            @if (isFieldInvalid('username')) {
              <span class="input-helper input-helper-error">
                @if (registerForm.get('username')?.errors?.['required']) {
                  El nombre de usuario es requerido
                } @else if (registerForm.get('username')?.errors?.['minlength']) {
                  Mínimo 3 caracteres
                } @else if (registerForm.get('username')?.errors?.['maxlength']) {
                  Máximo 20 caracteres
                } @else if (registerForm.get('username')?.errors?.['pattern']) {
                  Solo letras, números y guiones bajos
                }
              </span>
            }
          </div>

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
                @if (registerForm.get('email')?.errors?.['required']) {
                  El correo es requerido
                } @else if (registerForm.get('email')?.errors?.['email']) {
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
              >
                <span class="material-icons-outlined">
                  {{ showPassword() ? 'visibility_off' : 'visibility' }}
                </span>
              </button>
            </div>
            @if (isFieldInvalid('password')) {
              <span class="input-helper input-helper-error">
                @if (registerForm.get('password')?.errors?.['required']) {
                  La contraseña es requerida
                } @else if (registerForm.get('password')?.errors?.['minlength']) {
                  Mínimo 8 caracteres
                } @else if (registerForm.get('password')?.errors?.['pattern']) {
                  Debe incluir mayúscula, minúscula y número
                }
              </span>
            }
            <div class="password-requirements">
              <span [class.valid]="hasMinLength()">✓ Mínimo 8 caracteres</span>
              <span [class.valid]="hasUppercase()">✓ Una mayúscula</span>
              <span [class.valid]="hasLowercase()">✓ Una minúscula</span>
              <span [class.valid]="hasNumber()">✓ Un número</span>
            </div>
          </div>

          <div class="form-group">
            <label for="confirmPassword" class="input-label">Confirmar contraseña</label>
            <input
              [type]="showPassword() ? 'text' : 'password'"
              id="confirmPassword"
              formControlName="confirmPassword"
              class="input"
              [class.input-error]="isFieldInvalid('confirmPassword')"
              placeholder="••••••••"
            />
            @if (isFieldInvalid('confirmPassword')) {
              <span class="input-helper input-helper-error">
                @if (registerForm.get('confirmPassword')?.errors?.['required']) {
                  Confirma tu contraseña
                } @else if (registerForm.get('confirmPassword')?.errors?.['passwordMismatch']) {
                  Las contraseñas no coinciden
                }
              </span>
            }
          </div>

          <div class="form-group">
            <label class="checkbox-label">
              <input type="checkbox" formControlName="terms" />
              <span class="checkbox-text">
                Acepto los <a routerLink="/terms">Términos de Servicio</a> y la <a routerLink="/privacy">Política de Privacidad</a>
              </span>
            </label>
            @if (isFieldInvalid('terms')) {
              <span class="input-helper input-helper-error">Debes aceptar los términos</span>
            }
          </div>

          <button 
            type="submit" 
            class="btn btn-primary btn-lg w-full"
            [disabled]="isLoading()"
          >
            @if (isLoading()) {
              <span class="btn-spinner"></span>
              Creando cuenta...
            } @else {
              Crear Cuenta
            }
          </button>
        </form>

        <div class="auth-footer">
          <p>¿Ya tienes cuenta? <a routerLink="/auth/login">Inicia sesión</a></p>
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

    .password-requirements {
      display: flex;
      flex-wrap: wrap;
      gap: var(--space-2);
      margin-top: var(--space-2);

      span {
        font-size: 11px;
        color: var(--text-disabled);
        transition: color var(--duration-fast) var(--ease-default);

        &.valid {
          color: var(--color-success);
        }
      }
    }

    .checkbox-label {
      display: flex;
      align-items: flex-start;
      gap: var(--space-2);
      cursor: pointer;

      input[type="checkbox"] {
        width: 18px;
        height: 18px;
        margin-top: 2px;
        accent-color: var(--color-primary-500);
      }
    }

    .checkbox-text {
      font-size: 13px;
      color: var(--text-secondary);

      a {
        color: var(--color-primary-500);

        &:hover {
          color: var(--color-primary-600);
        }
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
export class RegisterComponent {
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private authService = inject(AuthService);

  registerForm: FormGroup;
  isLoading = signal(false);
  showPassword = signal(false);
  errorMessage = signal<string | null>(null);

  constructor() {
    this.registerForm = this.fb.group({
      username: ['', [
        Validators.required, 
        Validators.minLength(3), 
        Validators.maxLength(20),
        Validators.pattern(/^[a-zA-Z0-9_]+$/)
      ]],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [
        Validators.required, 
        Validators.minLength(8),
        Validators.pattern(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/)
      ]],
      confirmPassword: ['', [Validators.required, this.passwordMatchValidator.bind(this)]],
      terms: [false, [Validators.requiredTrue]],
    });

    // Re-validate confirmPassword when password changes
    this.registerForm.get('password')?.valueChanges.subscribe(() => {
      this.registerForm.get('confirmPassword')?.updateValueAndValidity();
    });
  }

  passwordMatchValidator(control: AbstractControl): ValidationErrors | null {
    const password = this.registerForm?.get('password')?.value;
    const confirmPassword = control.value;
    
    if (password !== confirmPassword) {
      return { passwordMismatch: true };
    }
    return null;
  }

  isFieldInvalid(field: string): boolean {
    const control = this.registerForm.get(field);
    return !!(control?.invalid && control?.touched);
  }

  hasMinLength(): boolean {
    return (this.registerForm.get('password')?.value?.length || 0) >= 8;
  }

  hasUppercase(): boolean {
    return /[A-Z]/.test(this.registerForm.get('password')?.value || '');
  }

  hasLowercase(): boolean {
    return /[a-z]/.test(this.registerForm.get('password')?.value || '');
  }

  hasNumber(): boolean {
    return /\d/.test(this.registerForm.get('password')?.value || '');
  }

  onSubmit(): void {
    if (this.registerForm.invalid) {
      this.registerForm.markAllAsTouched();
      return;
    }

    this.isLoading.set(true);
    this.errorMessage.set(null);

    const { terms, ...formData } = this.registerForm.value;

    this.authService.register(formData).subscribe({
      next: () => {
        this.router.navigate(['/']);
      },
      error: (error) => {
        this.isLoading.set(false);
        this.errorMessage.set(
          error.error?.message || 'Error al crear la cuenta. Intenta de nuevo.'
        );
      },
    });
  }
}
