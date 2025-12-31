import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-loading-spinner',
  standalone: true,
  template: `
    <div class="spinner-container" [class.fullscreen]="fullscreen">
      <div class="spinner" [style.width.px]="size" [style.height.px]="size">
        <div class="spinner-ring"></div>
      </div>
      @if (message) {
        <p class="spinner-message">{{ message }}</p>
      }
    </div>
  `,
  styles: [`
    .spinner-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: var(--space-4);
      padding: var(--space-8);

      &.fullscreen {
        position: fixed;
        inset: 0;
        background: rgba(255, 255, 255, 0.9);
        z-index: 9999;
      }
    }

    .spinner {
      position: relative;
    }

    .spinner-ring {
      width: 100%;
      height: 100%;
      border: 3px solid var(--color-primary-100);
      border-top-color: var(--color-primary-500);
      border-radius: 50%;
      animation: spin 0.8s linear infinite;
    }

    .spinner-message {
      color: var(--text-secondary);
      font-size: 14px;
    }

    @keyframes spin {
      to {
        transform: rotate(360deg);
      }
    }
  `],
})
export class LoadingSpinnerComponent {
  @Input() size = 40;
  @Input() fullscreen = false;
  @Input() message?: string;
}
