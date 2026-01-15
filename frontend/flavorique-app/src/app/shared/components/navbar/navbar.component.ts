import { Component, inject } from '@angular/core';
import { Router, RouterLink, RouterLinkActive } from '@angular/router';
import { AuthService } from '@core/services';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [RouterLink, RouterLinkActive],
  template: `
    <nav class="navbar">
      <div class="navbar-container container container-readable">
        <!-- Logo -->
        <a routerLink="/" class="navbar-logo" [title]="logoTooltip">
          <img src="/isotipo.png" alt="Flavorique" class="navbar-logo-icon" />
          <span class="navbar-logo-text">Flavorique</span>
          @if (isLianDay) {
            <span class="lian-badge-mini">💚</span>
          }
        </a>

        <!-- Navigation Links -->
        <div class="navbar-links">
          <a routerLink="/" routerLinkActive="active" [routerLinkActiveOptions]="{exact: true}" class="nav-link">
            <span class="material-icons-outlined icon-sm">home</span>
            <span>Inicio</span>
          </a>
          <a routerLink="/recipes" routerLinkActive="active" class="nav-link">
            <span class="material-icons-outlined icon-sm">menu_book</span>
            <span>Recetas</span>
          </a>
          <a routerLink="/categories" routerLinkActive="active" class="nav-link">
            <span class="material-icons-outlined icon-sm">category</span>
            <span>Categorías</span>
          </a>
        </div>

        <!-- Search Bar -->
        <div class="navbar-search">
          <span class="material-icons-outlined search-icon">search</span>
          <input 
            type="text" 
            placeholder="Buscar recetas..." 
            class="search-input"
            (keydown.enter)="onSearch($event)"
          />
        </div>

        <!-- Auth Actions -->
        <div class="navbar-actions">
          @if (authService.isAuthenticated()) {
            <a routerLink="/recipes/new" class="btn btn-primary btn-sm">
              <span class="material-icons-outlined icon-sm">add</span>
              <span class="hide-mobile">Nueva Receta</span>
            </a>
            <div class="user-menu">
              <button class="user-avatar-btn" (click)="toggleUserMenu()">
                @if (authService.currentUser()?.avatarUrl) {
                  <img [src]="authService.currentUser()?.avatarUrl" [alt]="authService.currentUser()?.username" class="user-avatar" />
                } @else {
                  <div class="user-avatar-placeholder">
                    {{ authService.currentUser()?.username?.charAt(0)?.toUpperCase() }}
                  </div>
                }
              </button>
              @if (showUserMenu) {
                <div class="user-dropdown">
                  <div class="user-dropdown-header">
                    <span class="user-name">{{ authService.currentUser()?.displayName || authService.currentUser()?.username }}</span>
                    <span class="user-email">{{ authService.currentUser()?.email }}</span>
                  </div>
                  <div class="user-dropdown-divider"></div>
                  <a routerLink="/profile" class="user-dropdown-item" (click)="showUserMenu = false">
                    <span class="material-icons-outlined icon-sm">person</span>
                    Mi Perfil
                  </a>
                  <a routerLink="/profile/edit" class="user-dropdown-item" (click)="showUserMenu = false">
                    <span class="material-icons-outlined icon-sm">settings</span>
                    Configuración
                  </a>
                  <div class="user-dropdown-divider"></div>
                  <button class="user-dropdown-item text-error" (click)="logout()">
                    <span class="material-icons-outlined icon-sm">logout</span>
                    Cerrar Sesión
                  </button>
                </div>
              }
            </div>
          } @else {
            <a routerLink="/auth/login" class="btn btn-ghost btn-sm">Iniciar Sesión</a>
            <a routerLink="/auth/register" class="btn btn-primary btn-sm">Registrarse</a>
          }
        </div>

        <!-- Mobile Menu Button -->
        <button class="mobile-menu-btn" (click)="toggleMobileMenu()">
          <span class="material-icons">{{ showMobileMenu ? 'close' : 'menu' }}</span>
        </button>
      </div>

      <!-- Mobile Menu -->
      @if (showMobileMenu) {
        <div class="mobile-menu">
          <a routerLink="/" routerLinkActive="active" [routerLinkActiveOptions]="{exact: true}" class="mobile-nav-link" (click)="showMobileMenu = false">
            <span class="material-icons-outlined">home</span>
            Inicio
          </a>
          <a routerLink="/recipes" routerLinkActive="active" class="mobile-nav-link" (click)="showMobileMenu = false">
            <span class="material-icons-outlined">menu_book</span>
            Recetas
          </a>
          <a routerLink="/categories" routerLinkActive="active" class="mobile-nav-link" (click)="showMobileMenu = false">
            <span class="material-icons-outlined">category</span>
            Categorías
          </a>
          <div class="mobile-menu-divider"></div>
          @if (authService.isAuthenticated()) {
            <a routerLink="/recipes/new" class="mobile-nav-link" (click)="showMobileMenu = false">
              <span class="material-icons-outlined">add</span>
              Nueva Receta
            </a>
            <a routerLink="/profile" class="mobile-nav-link" (click)="showMobileMenu = false">
              <span class="material-icons-outlined">person</span>
              Mi Perfil
            </a>
            <button class="mobile-nav-link text-error" (click)="logout()">
              <span class="material-icons-outlined">logout</span>
              Cerrar Sesión
            </button>
          } @else {
            <a routerLink="/auth/login" class="mobile-nav-link" (click)="showMobileMenu = false">
              <span class="material-icons-outlined">login</span>
              Iniciar Sesión
            </a>
            <a routerLink="/auth/register" class="mobile-nav-link" (click)="showMobileMenu = false">
              <span class="material-icons-outlined">person_add</span>
              Registrarse
            </a>
          }
        </div>
      }
    </nav>
  `,
  styles: [`
    .navbar {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      height: 64px;
      background: var(--surface-card);
      border-bottom: 1px solid var(--border-default);
      z-index: 1000;
    }

    .navbar-container {
      display: flex;
      align-items: center;
      height: 100%;
      gap: var(--space-6);
    }

    .navbar-logo {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      text-decoration: none;
      color: var(--text-primary);
      flex-shrink: 0;
    }

    .navbar-logo-icon {
      height: 32px;
      width: auto;
    }

    .navbar-logo-text {
      font-size: 20px;
      font-weight: 700;
      color: var(--color-primary-500);
    }

    .lian-badge-mini {
      font-size: 12px;
      animation: pulse-heart 1.5s ease-in-out infinite;
    }

    @keyframes pulse-heart {
      0%, 100% { transform: scale(1); }
      50% { transform: scale(1.2); }
    }

    .navbar-links {
      display: none;
      align-items: center;
      gap: var(--space-1);

      @media (min-width: 768px) {
        display: flex;
      }
    }

    .nav-link {
      display: flex;
      align-items: center;
      gap: var(--space-1);
      padding: var(--space-2) var(--space-3);
      color: var(--text-secondary);
      text-decoration: none;
      font-size: 14px;
      font-weight: 500;
      border-radius: var(--border-radius-sm);
      transition: all var(--duration-fast) var(--ease-default);

      &:hover {
        color: var(--text-primary);
        background: var(--color-primary-50);
      }

      &.active {
        color: var(--color-primary-500);
        background: var(--color-primary-50);
      }
    }

    .navbar-search {
      flex: 1;
      max-width: 400px;
      position: relative;
      display: none;

      @media (min-width: 640px) {
        display: block;
      }
    }

    .search-icon {
      position: absolute;
      left: var(--space-3);
      top: 50%;
      transform: translateY(-50%);
      color: var(--text-disabled);
      font-size: 20px;
    }

    .search-input {
      width: 100%;
      padding: var(--space-2) var(--space-3) var(--space-2) 40px;
      font-size: 14px;
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-full);
      background: var(--surface-page);
      transition: all var(--duration-fast) var(--ease-default);

      &:focus {
        outline: none;
        border-color: var(--color-primary-500);
        background: var(--surface-card);
      }

      &::placeholder {
        color: var(--text-disabled);
      }
    }

    .navbar-actions {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      margin-left: auto;
    }

    .hide-mobile {
      display: none;

      @media (min-width: 768px) {
        display: inline;
      }
    }

    .user-menu {
      position: relative;
    }

    .user-avatar-btn {
      background: none;
      border: none;
      cursor: pointer;
      padding: 0;
      border-radius: var(--border-radius-full);

      &:focus-visible {
        outline: 2px solid var(--color-primary-500);
        outline-offset: 2px;
      }
    }

    .user-avatar {
      width: 36px;
      height: 36px;
      border-radius: var(--border-radius-full);
      object-fit: cover;
    }

    .user-avatar-placeholder {
      width: 36px;
      height: 36px;
      border-radius: var(--border-radius-full);
      background: var(--color-primary-100);
      color: var(--color-primary-600);
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      font-size: 14px;
    }

    .user-dropdown {
      position: absolute;
      top: calc(100% + 8px);
      right: 0;
      min-width: 220px;
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      animation: fadeInUp var(--duration-fast) var(--ease-default);
    }

    .user-dropdown-header {
      padding: var(--space-3) var(--space-4);
    }

    .user-name {
      display: block;
      font-weight: 600;
      color: var(--text-primary);
    }

    .user-email {
      display: block;
      font-size: 12px;
      color: var(--text-secondary);
      margin-top: 2px;
    }

    .user-dropdown-divider {
      height: 1px;
      background: var(--border-default);
    }

    .user-dropdown-item {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      width: 100%;
      padding: var(--space-3) var(--space-4);
      color: var(--text-primary);
      text-decoration: none;
      font-size: 14px;
      background: none;
      border: none;
      cursor: pointer;
      text-align: left;
      transition: background var(--duration-fast) var(--ease-default);

      &:hover {
        background: var(--color-primary-50);
      }

      &.text-error {
        color: var(--color-error);

        &:hover {
          background: var(--color-error-light);
        }
      }
    }

    .mobile-menu-btn {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 40px;
      height: 40px;
      background: none;
      border: none;
      cursor: pointer;
      color: var(--text-primary);

      @media (min-width: 768px) {
        display: none;
      }
    }

    .mobile-menu {
      position: fixed;
      top: 64px;
      left: 0;
      right: 0;
      bottom: 0;
      background: var(--surface-card);
      padding: var(--space-4);
      animation: fadeInUp var(--duration-fast) var(--ease-default);
      overflow-y: auto;

      @media (min-width: 768px) {
        display: none;
      }
    }

    .mobile-nav-link {
      display: flex;
      align-items: center;
      gap: var(--space-3);
      padding: var(--space-3) var(--space-4);
      color: var(--text-primary);
      text-decoration: none;
      font-size: 16px;
      border-radius: var(--border-radius-md);
      background: none;
      border: none;
      width: 100%;
      cursor: pointer;
      text-align: left;

      &:hover, &.active {
        background: var(--color-primary-50);
        color: var(--color-primary-500);
      }

      &.text-error {
        color: var(--color-error);

        &:hover {
          background: var(--color-error-light);
        }
      }
    }

    .mobile-menu-divider {
      height: 1px;
      background: var(--border-default);
      margin: var(--space-2) 0;
    }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(-8px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
  `],
})
export class NavbarComponent {
  private router = inject(Router);
  authService = inject(AuthService);
  showUserMenu = false;
  showMobileMenu = false;

  // Dedicatoria a Lian Solorzano
  isLianDay = this.checkIfLianDay();
  logoTooltip = this.isLianDay
    ? '💚 Hoy celebramos a Lian Solorzano, quien inspiró Flavorique 💚'
    : 'Inspirado por Lian Solorzano 💚';

  private checkIfLianDay(): boolean {
    const today = new Date();
    return today.getMonth() === 0 && today.getDate() === 14;
  }

  toggleUserMenu(): void {
    this.showUserMenu = !this.showUserMenu;
  }

  toggleMobileMenu(): void {
    this.showMobileMenu = !this.showMobileMenu;
    if (this.showMobileMenu) {
      this.showUserMenu = false;
    }
  }

  logout(): void {
    this.authService.logout();
    this.showUserMenu = false;
    this.showMobileMenu = false;
    this.router.navigate(['/']);
  }

  onSearch(event: Event): void {
    const input = event.target as HTMLInputElement;
    const query = input.value.trim();
    if (query) {
      this.router.navigate(['/search'], { queryParams: { q: query } });
      input.value = '';
    }
  }
}
