import { Component, inject, signal, OnInit } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { AuthService, UserService } from '@core/services';
import { User } from '@core/models';
import { LoadingSpinnerComponent } from '@shared/components/loading-spinner/loading-spinner.component';

@Component({
  selector: 'app-profile-edit',
  standalone: true,
  imports: [ReactiveFormsModule, RouterLink, LoadingSpinnerComponent],
  template: `
    <div class="page-header">
      <div class="container container-readable">
        <h1 class="page-title">Editar Perfil</h1>
        <p class="page-subtitle">Actualiza tu información personal</p>
      </div>
    </div>

    <div class="page-content container container-readable">
      @if (loading()) {
        <app-loading-spinner message="Cargando perfil..." />
      } @else {
        <form [formGroup]="profileForm" (ngSubmit)="onSubmit()" class="profile-form">
          <!-- Avatar Section -->
          <section class="form-section avatar-section">
            <div class="avatar-wrapper">
              @if (avatarPreview()) {
                <img [src]="avatarPreview()" alt="Avatar" class="avatar" />
              } @else {
                <div class="avatar avatar-placeholder">
                  {{ currentUser()?.displayName?.charAt(0)?.toUpperCase() || 'U' }}
                </div>
              }
            </div>
            
            <div class="avatar-actions">
              <div class="form-group">
                <label for="avatarUrl" class="input-label">URL del Avatar</label>
                <input
                  type="url"
                  id="avatarUrl"
                  formControlName="avatarUrl"
                  class="input"
                  placeholder="https://ejemplo.com/avatar.jpg"
                  (input)="updateAvatarPreview()"
                />
                <span class="input-helper">Usa una URL de imagen pública</span>
              </div>
            </div>
          </section>

          <!-- Basic Info -->
          <section class="form-section">
            <h2 class="section-title">Información Personal</h2>
            
            <div class="form-row">
              <div class="form-group">
                <label for="displayName" class="input-label">Nombre para mostrar *</label>
                <input
                  type="text"
                  id="displayName"
                  formControlName="displayName"
                  class="input"
                  [class.input-error]="isFieldInvalid('displayName')"
                  placeholder="Tu nombre"
                />
                @if (isFieldInvalid('displayName')) {
                  <span class="input-helper input-helper-error">
                    El nombre es requerido (2-50 caracteres)
                  </span>
                }
              </div>

              <div class="form-group">
                <label class="input-label">Nombre de usuario</label>
                <input
                  type="text"
                  class="input"
                  [value]="currentUser()?.username"
                  disabled
                />
                <span class="input-helper">El nombre de usuario no puede cambiarse</span>
              </div>
            </div>

            <div class="form-group">
              <label for="email" class="input-label">Correo Electrónico *</label>
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
                  Ingresa un correo válido
                </span>
              }
            </div>

            <div class="form-group">
              <label for="bio" class="input-label">Biografía</label>
              <textarea
                id="bio"
                formControlName="bio"
                class="input textarea"
                rows="4"
                placeholder="Cuéntanos sobre ti y tu pasión por la cocina..."
                maxlength="500"
              ></textarea>
              <span class="input-helper">
                {{ profileForm.get('bio')?.value?.length || 0 }}/500 caracteres
              </span>
            </div>
          </section>

          <!-- Social Links -->
          <section class="form-section">
            <h2 class="section-title">Redes Sociales</h2>
            <p class="section-description">Conecta tus perfiles sociales (opcional)</p>

            <div class="social-link-row">
              <div class="social-icon">
                <span class="material-icons-outlined">language</span>
              </div>
              <input
                type="url"
                formControlName="websiteUrl"
                class="input"
                placeholder="https://tusitio.com"
              />
            </div>

            <div class="social-link-row">
              <div class="social-icon instagram">
                <svg viewBox="0 0 24 24" fill="currentColor">
                  <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
                </svg>
              </div>
              <input
                type="text"
                formControlName="instagramHandle"
                class="input"
                placeholder="tu_usuario"
              />
            </div>

            <div class="social-link-row">
              <div class="social-icon twitter">
                <svg viewBox="0 0 24 24" fill="currentColor">
                  <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
                </svg>
              </div>
              <input
                type="text"
                formControlName="twitterHandle"
                class="input"
                placeholder="tu_usuario"
              />
            </div>
          </section>

          <!-- Preferences -->
          <section class="form-section">
            <h2 class="section-title">Preferencias</h2>

            <div class="preference-row">
              <label class="checkbox-label">
                <input type="checkbox" formControlName="emailNotifications" />
                <span class="checkbox-text">Recibir notificaciones por correo</span>
              </label>
              <span class="preference-description">
                Te avisaremos cuando alguien comente o siga tus recetas
              </span>
            </div>

            <div class="preference-row">
              <label class="checkbox-label">
                <input type="checkbox" formControlName="publicProfile" />
                <span class="checkbox-text">Perfil público</span>
              </label>
              <span class="preference-description">
                Otros usuarios pueden ver tu perfil y recetas
              </span>
            </div>
          </section>

          <!-- Error Message -->
          @if (errorMessage()) {
            <div class="alert alert-error">
              <span class="material-icons-outlined">error_outline</span>
              {{ errorMessage() }}
            </div>
          }

          <!-- Success Message -->
          @if (successMessage()) {
            <div class="alert alert-success">
              <span class="material-icons-outlined">check_circle_outline</span>
              {{ successMessage() }}
            </div>
          }

          <!-- Actions -->
          <div class="form-actions">
            <a routerLink="/profile" class="btn btn-outline">Cancelar</a>
            <button 
              type="submit" 
              class="btn btn-primary btn-lg"
              [disabled]="saving() || profileForm.invalid"
            >
              @if (saving()) {
                <span class="btn-spinner"></span>
                Guardando...
              } @else {
                <span class="material-icons-outlined">save</span>
                Guardar Cambios
              }
            </button>
          </div>
        </form>
      }
    </div>
  `,
  styles: [`
    .page-header {
      background: linear-gradient(135deg, var(--color-primary-50) 0%, var(--surface-page) 100%);
      padding: var(--space-8) 0;
      margin-bottom: var(--space-6);
    }

    .page-title {
      font-size: 30px;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: var(--space-2);
    }

    .page-subtitle {
      font-size: 16px;
      color: var(--text-secondary);
    }

    .page-content {
      padding-bottom: var(--space-12);
    }

    .profile-form {
      max-width: 700px;
      margin: 0 auto;
    }

    .form-section {
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      padding: var(--space-6);
      margin-bottom: var(--space-6);
    }

    .section-title {
      font-size: 18px;
      font-weight: 600;
      color: var(--text-primary);
      margin-bottom: var(--space-2);
    }

    .section-description {
      font-size: 14px;
      color: var(--text-secondary);
      margin-bottom: var(--space-4);
    }

    .avatar-section {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: var(--space-6);
      text-align: center;

      @media (min-width: 640px) {
        flex-direction: row;
        text-align: left;
      }
    }

    .avatar-wrapper {
      flex-shrink: 0;
    }

    .avatar {
      width: 120px;
      height: 120px;
      border-radius: var(--border-radius-full);
      object-fit: cover;
      border: 3px solid var(--border-default);
    }

    .avatar-placeholder {
      background: var(--color-primary-100);
      color: var(--color-primary-600);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 48px;
      font-weight: 700;
    }

    .avatar-actions {
      flex: 1;
      width: 100%;
    }

    .form-group {
      margin-bottom: var(--space-4);

      &:last-child {
        margin-bottom: 0;
      }
    }

    .form-row {
      display: grid;
      grid-template-columns: 1fr;
      gap: var(--space-4);

      @media (min-width: 640px) {
        grid-template-columns: repeat(2, 1fr);
      }
    }

    .textarea {
      resize: vertical;
      min-height: 100px;
    }

    .social-link-row {
      display: flex;
      align-items: center;
      gap: var(--space-3);
      margin-bottom: var(--space-3);

      &:last-child {
        margin-bottom: 0;
      }
    }

    .social-icon {
      width: 40px;
      height: 40px;
      border-radius: var(--border-radius-sm);
      background: var(--color-gray-100);
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
      color: var(--text-secondary);

      svg {
        width: 20px;
        height: 20px;
      }

      &.instagram {
        background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888);
        color: white;
      }

      &.twitter {
        background: #000;
        color: white;
      }
    }

    .preference-row {
      padding: var(--space-4);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-sm);
      margin-bottom: var(--space-3);

      &:last-child {
        margin-bottom: 0;
      }
    }

    .checkbox-label {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      cursor: pointer;
      margin-bottom: var(--space-1);

      input[type="checkbox"] {
        width: 18px;
        height: 18px;
        accent-color: var(--color-primary-500);
      }
    }

    .checkbox-text {
      font-size: 14px;
      font-weight: 500;
      color: var(--text-primary);
    }

    .preference-description {
      font-size: 13px;
      color: var(--text-secondary);
      margin-left: 26px;
    }

    .alert {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      padding: var(--space-3) var(--space-4);
      border-radius: var(--border-radius-sm);
      margin-bottom: var(--space-4);
      font-size: 14px;
    }

    .alert-error {
      background: var(--color-error-light);
      color: var(--color-error);
    }

    .alert-success {
      background: var(--color-success-light);
      color: var(--color-success);
    }

    .form-actions {
      display: flex;
      justify-content: flex-end;
      gap: var(--space-3);
      padding-top: var(--space-6);
      border-top: 1px solid var(--border-default);
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
  `],
})
export class ProfileEditComponent implements OnInit {
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private authService = inject(AuthService);
  private userService = inject(UserService);

  profileForm!: FormGroup;
  currentUser = this.authService.currentUser;
  loading = signal(true);
  saving = signal(false);
  errorMessage = signal('');
  successMessage = signal('');
  avatarPreview = signal<string | null>(null);

  ngOnInit(): void {
    this.initForm();
    this.loadProfile();
  }

  initForm(): void {
    this.profileForm = this.fb.group({
      displayName: ['', [Validators.required, Validators.minLength(2), Validators.maxLength(50)]],
      email: ['', [Validators.required, Validators.email]],
      bio: ['', Validators.maxLength(500)],
      avatarUrl: [''],
      websiteUrl: [''],
      instagramHandle: [''],
      twitterHandle: [''],
      emailNotifications: [true],
      publicProfile: [true],
    });
  }

  loadProfile(): void {
    const user = this.currentUser();
    if (!user) {
      this.router.navigate(['/auth/login']);
      return;
    }

    this.userService.getUserById(user.id).subscribe({
      next: (userData) => {
        this.profileForm.patchValue({
          displayName: userData.displayName,
          email: userData.email,
          bio: userData.bio || '',
          avatarUrl: userData.avatarUrl || '',
        });
        this.avatarPreview.set(userData.avatarUrl || null);
        this.loading.set(false);
      },
      error: () => {
        this.loading.set(false);
        this.errorMessage.set('Error al cargar el perfil');
      },
    });
  }

  isFieldInvalid(field: string): boolean {
    const control = this.profileForm.get(field);
    return !!(control?.invalid && control?.touched);
  }

  updateAvatarPreview(): void {
    const url = this.profileForm.get('avatarUrl')?.value;
    this.avatarPreview.set(url || null);
  }

  onSubmit(): void {
    if (this.profileForm.invalid) {
      this.profileForm.markAllAsTouched();
      return;
    }

    const user = this.currentUser();
    if (!user) return;

    this.saving.set(true);
    this.errorMessage.set('');
    this.successMessage.set('');

    const formValue = this.profileForm.value;

    this.userService.updateUser(user.id, {
      displayName: formValue.displayName,
      email: formValue.email,
      bio: formValue.bio,
      avatarUrl: formValue.avatarUrl,
    }).subscribe({
      next: () => {
        this.saving.set(false);
        this.successMessage.set('¡Perfil actualizado correctamente!');
        // Update local user data
        this.authService.updateCurrentUser({
          displayName: formValue.displayName,
          email: formValue.email,
          avatarUrl: formValue.avatarUrl,
        });
      },
      error: (error) => {
        this.saving.set(false);
        this.errorMessage.set(error.error?.message || 'Error al actualizar el perfil');
      },
    });
  }
}
