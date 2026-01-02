import { Component, EventEmitter, Input, Output, signal, inject, ViewChild, ElementRef } from '@angular/core';
import { UploadService, UploadProgress } from '@core/services';

export type ImageUploadType = 'recipe-image' | 'step-image' | 'avatar';

@Component({
  selector: 'app-image-upload',
  standalone: true,
  template: `
    <div class="image-upload-container" [class.has-image]="currentUrl()">
      <!-- Preview -->
      <div class="image-preview" (click)="triggerFileInput()">
        @if (currentUrl()) {
          <img [src]="currentUrl()" [alt]="altText" class="preview-image" />
          <div class="image-overlay">
            <span class="material-icons-outlined">edit</span>
            <span>Cambiar imagen</span>
          </div>
        } @else if (uploadService.isLoading()) {
          <div class="upload-placeholder">
            <span class="material-icons-outlined placeholder-icon rotating">sync</span>
            <span class="placeholder-text">Verificando servicio...</span>
          </div>
        } @else {
          <div class="upload-placeholder">
            <span class="material-icons-outlined placeholder-icon">add_photo_alternate</span>
            <span class="placeholder-text">{{ placeholder }}</span>
            <span class="placeholder-hint">
              @if (uploadService.isEnabled()) {
                JPEG, PNG, GIF, WebP (máx. 5MB)
              } @else {
                Ingresa una URL de imagen
              }
            </span>
          </div>
        }

        @if (uploading()) {
          <div class="upload-progress">
            <div class="progress-bar">
              <div class="progress-fill" [style.width.%]="progress()"></div>
            </div>
            <span class="progress-text">{{ progress() }}%</span>
          </div>
        }
      </div>

      <!-- Hidden file input -->
      <input
        #fileInput
        type="file"
        accept="image/jpeg,image/png,image/gif,image/webp"
        (change)="onFileSelected($event)"
        [disabled]="uploading()"
        style="display: none;"
      />

      <!-- URL input fallback -->
      @if (!uploadService.isEnabled() && !uploadService.isLoading()) {
        <div class="url-fallback">
          <label class="input-label">URL de la imagen</label>
          <input
            type="url"
            class="input"
            [value]="currentUrl() || ''"
            (input)="onUrlInput($event)"
            [placeholder]="urlPlaceholder"
          />
        </div>
      }

      <!-- Actions -->
      @if (currentUrl()) {
        <div class="image-actions">
          @if (uploadService.isEnabled()) {
            <button type="button" class="btn btn-sm btn-outline" (click)="triggerFileInput()">
              <span class="material-icons-outlined icon-sm">upload</span>
              Cambiar
            </button>
          }
          <button type="button" class="btn btn-sm btn-ghost" (click)="removeImage()">
            <span class="material-icons-outlined icon-sm">delete</span>
            Eliminar
          </button>
        </div>
      }

      <!-- Error message -->
      @if (error()) {
        <div class="upload-error">
          <span class="material-icons-outlined">error</span>
          {{ error() }}
        </div>
      }
    </div>
  `,
  styles: [`
    .image-upload-container {
      width: 100%;
    }

    .image-preview {
      position: relative;
      width: 100%;
      min-height: 200px;
      border: 2px dashed var(--border-default);
      border-radius: var(--border-radius-md);
      cursor: pointer;
      overflow: hidden;
      transition: all var(--duration-fast) var(--ease-default);
      display: flex;
      align-items: center;
      justify-content: center;
      background: var(--surface-card);

      &:hover {
        border-color: var(--color-primary-400);
        background: var(--color-primary-50);
      }

      .has-image & {
        border-style: solid;
        min-height: 250px;
      }
    }

    .preview-image {
      width: 100%;
      height: 100%;
      object-fit: cover;
      position: absolute;
      top: 0;
      left: 0;
    }

    .image-overlay {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.5);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: var(--space-2);
      color: white;
      opacity: 0;
      transition: opacity var(--duration-fast) var(--ease-default);

      &:hover {
        opacity: 1;
      }

      .material-icons-outlined {
        font-size: 32px;
      }
    }

    .upload-placeholder {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: var(--space-2);
      padding: var(--space-6);
      text-align: center;
    }

    .placeholder-icon {
      font-size: 48px;
      color: var(--text-secondary);
    }

    .placeholder-icon.rotating {
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      from { transform: rotate(0deg); }
      to { transform: rotate(360deg); }
    }

    .placeholder-text {
      font-size: 14px;
      font-weight: 500;
      color: var(--text-primary);
    }

    .placeholder-hint {
      font-size: 12px;
      color: var(--text-secondary);
    }

    .upload-progress {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(255, 255, 255, 0.9);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: var(--space-3);
    }

    .progress-bar {
      width: 80%;
      height: 8px;
      background: var(--color-gray-200);
      border-radius: var(--border-radius-full);
      overflow: hidden;
    }

    .progress-fill {
      height: 100%;
      background: var(--color-primary-500);
      transition: width 0.3s ease;
    }

    .progress-text {
      font-size: 14px;
      font-weight: 500;
      color: var(--color-primary-600);
    }

    .url-fallback {
      margin-top: var(--space-3);
    }

    .image-actions {
      display: flex;
      gap: var(--space-2);
      margin-top: var(--space-3);
    }

    .upload-error {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      margin-top: var(--space-2);
      padding: var(--space-2) var(--space-3);
      background: var(--color-error-light);
      color: var(--color-error);
      border-radius: var(--border-radius-sm);
      font-size: 13px;

      .material-icons-outlined {
        font-size: 18px;
      }
    }

    .btn-sm {
      padding: var(--space-1) var(--space-2);
      font-size: 13px;
    }

    .icon-sm {
      font-size: 16px;
    }
  `],
})
export class ImageUploadComponent {
  @Input() type: ImageUploadType = 'recipe-image';
  @Input() currentUrl = signal<string | null>(null);
  @Input() placeholder = 'Subir imagen';
  @Input() urlPlaceholder = 'https://ejemplo.com/imagen.jpg';
  @Input() altText = 'Imagen';

  @Output() imageUploaded = new EventEmitter<string>();
  @Output() imageRemoved = new EventEmitter<void>();
  @Output() urlChanged = new EventEmitter<string>();

  uploadService = inject(UploadService);

  @ViewChild('fileInput') fileInput!: ElementRef<HTMLInputElement>;

  uploading = signal(false);
  progress = signal(0);
  error = signal<string | null>(null);

  triggerFileInput(): void {
    if (!this.uploadService.isEnabled()) {
      // Si el upload no está habilitado, el usuario usará el campo de URL
      return;
    }
    if (this.fileInput?.nativeElement) {
      this.fileInput.nativeElement.click();
    }
  }

  onFileSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    const file = input.files?.[0];
    
    if (!file) return;

    // Validate file
    const validation = this.uploadService.validateFile(file);
    if (!validation.valid) {
      this.error.set(validation.error || 'Error de validación');
      return;
    }

    this.error.set(null);
    this.uploading.set(true);
    this.progress.set(0);

    const upload$ = this.getUploadObservable(file);

    upload$.subscribe({
      next: (result: UploadProgress) => {
        this.progress.set(result.progress);
        
        if (result.completed) {
          this.uploading.set(false);
          
          if (result.error) {
            this.error.set(result.error);
          } else if (result.response) {
            this.currentUrl.set(result.response.url);
            this.imageUploaded.emit(result.response.url);
          }
        }
      },
      error: (err) => {
        this.uploading.set(false);
        this.error.set('Error al subir la imagen');
        console.error('Upload error:', err);
      },
    });

    // Reset input
    input.value = '';
  }

  private getUploadObservable(file: File) {
    switch (this.type) {
      case 'recipe-image':
        return this.uploadService.uploadRecipeImage(file);
      case 'step-image':
        return this.uploadService.uploadStepImage(file);
      case 'avatar':
        return this.uploadService.uploadAvatar(file);
      default:
        return this.uploadService.uploadRecipeImage(file);
    }
  }

  onUrlInput(event: Event): void {
    const input = event.target as HTMLInputElement;
    const url = input.value;
    this.currentUrl.set(url);
    this.urlChanged.emit(url);
  }

  removeImage(): void {
    this.currentUrl.set(null);
    this.error.set(null);
    this.imageRemoved.emit();
  }
}
