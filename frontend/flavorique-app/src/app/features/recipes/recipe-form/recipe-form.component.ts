import { Component, inject, signal, OnInit, Input } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { FormBuilder, FormGroup, FormArray, Validators, ReactiveFormsModule } from '@angular/forms';
import { RecipeService, CategoryService, AuthService } from '@core/services';
import { Recipe, Category, Difficulty, RecipeRequest } from '@core/models';
import { LoadingSpinnerComponent } from '@shared/components/loading-spinner/loading-spinner.component';

@Component({
  selector: 'app-recipe-form',
  standalone: true,
  imports: [ReactiveFormsModule, RouterLink, LoadingSpinnerComponent],
  template: `
    <div class="page-header">
      <div class="container container-readable">
        <h1 class="page-title">{{ isEditMode ? 'Editar Receta' : 'Nueva Receta' }}</h1>
        <p class="page-subtitle">
          {{ isEditMode ? 'Actualiza los detalles de tu receta' : 'Comparte tu creación culinaria con la comunidad' }}
        </p>
      </div>
    </div>

    <div class="page-content container container-readable">
      @if (loadingRecipe()) {
        <app-loading-spinner message="Cargando receta..." />
      } @else {
        <form [formGroup]="recipeForm" (ngSubmit)="onSubmit()" class="recipe-form">
          <!-- Basic Info -->
          <section class="form-section">
            <h2 class="section-title">Información Básica</h2>
            
            <div class="form-group">
              <label for="title" class="input-label">Título de la Receta *</label>
              <input
                type="text"
                id="title"
                formControlName="title"
                class="input"
                [class.input-error]="isFieldInvalid('title')"
                placeholder="Ej: Paella Valenciana Tradicional"
              />
              @if (isFieldInvalid('title')) {
                <span class="input-helper input-helper-error">El título es requerido (3-100 caracteres)</span>
              }
            </div>

            <div class="form-group">
              <label for="description" class="input-label">Descripción</label>
              <textarea
                id="description"
                formControlName="description"
                class="input textarea"
                rows="3"
                placeholder="Una breve descripción de tu receta..."
              ></textarea>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="prepTime" class="input-label">Tiempo de Preparación (min) *</label>
                <input
                  type="number"
                  id="prepTime"
                  formControlName="prepTime"
                  class="input"
                  [class.input-error]="isFieldInvalid('prepTime')"
                  min="1"
                  placeholder="30"
                />
              </div>

              <div class="form-group">
                <label for="cookTime" class="input-label">Tiempo de Cocción (min) *</label>
                <input
                  type="number"
                  id="cookTime"
                  formControlName="cookTime"
                  class="input"
                  [class.input-error]="isFieldInvalid('cookTime')"
                  min="0"
                  placeholder="45"
                />
              </div>

              <div class="form-group">
                <label for="servings" class="input-label">Porciones *</label>
                <input
                  type="number"
                  id="servings"
                  formControlName="servings"
                  class="input"
                  [class.input-error]="isFieldInvalid('servings')"
                  min="1"
                  placeholder="4"
                />
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="difficulty" class="input-label">Dificultad *</label>
                <select
                  id="difficulty"
                  formControlName="difficulty"
                  class="input"
                  [class.input-error]="isFieldInvalid('difficulty')"
                >
                  <option value="">Seleccionar dificultad</option>
                  <option value="EASY">Fácil</option>
                  <option value="MEDIUM">Medio</option>
                  <option value="HARD">Difícil</option>
                </select>
              </div>

              <div class="form-group">
                <label for="imageUrl" class="input-label">URL de Imagen</label>
                <input
                  type="url"
                  id="imageUrl"
                  formControlName="imageUrl"
                  class="input"
                  placeholder="https://ejemplo.com/imagen.jpg"
                />
              </div>
            </div>

            <div class="form-group">
              <label class="checkbox-label">
                <input type="checkbox" formControlName="isPublic" />
                <span class="checkbox-text">Receta pública (visible para todos)</span>
              </label>
            </div>
          </section>

          <!-- Categories -->
          <section class="form-section">
            <h2 class="section-title">Categorías</h2>
            <div class="categories-grid">
              @for (category of categories(); track category.id) {
                <label class="category-checkbox">
                  <input 
                    type="checkbox" 
                    [value]="category.id"
                    [checked]="isCategorySelected(category.id)"
                    (change)="toggleCategory(category.id)"
                  />
                  <span class="category-label">{{ category.name }}</span>
                </label>
              }
            </div>
          </section>

          <!-- Ingredients -->
          <section class="form-section">
            <div class="section-header">
              <h2 class="section-title">Ingredientes *</h2>
              <button type="button" class="btn btn-outline btn-sm" (click)="addIngredient()">
                <span class="material-icons-outlined icon-sm">add</span>
                Añadir
              </button>
            </div>

            <div formArrayName="ingredients" class="ingredients-form">
              @for (ingredient of ingredientsArray.controls; track $index; let i = $index) {
                <div class="ingredient-row" [formGroupName]="i">
                  <input
                    type="number"
                    formControlName="quantity"
                    class="input quantity-input"
                    placeholder="Cantidad"
                    min="0"
                    step="0.1"
                  />
                  <input
                    type="text"
                    formControlName="unit"
                    class="input unit-input"
                    placeholder="Unidad"
                  />
                  <input
                    type="text"
                    formControlName="name"
                    class="input name-input"
                    placeholder="Nombre del ingrediente"
                  />
                  <button 
                    type="button" 
                    class="btn btn-ghost btn-sm remove-btn"
                    (click)="removeIngredient(i)"
                    [disabled]="ingredientsArray.length <= 1"
                  >
                    <span class="material-icons-outlined">close</span>
                  </button>
                </div>
              }
            </div>
          </section>

          <!-- Steps -->
          <section class="form-section">
            <div class="section-header">
              <h2 class="section-title">Pasos de Preparación *</h2>
              <button type="button" class="btn btn-outline btn-sm" (click)="addStep()">
                <span class="material-icons-outlined icon-sm">add</span>
                Añadir Paso
              </button>
            </div>

            <div formArrayName="steps" class="steps-form">
              @for (step of stepsArray.controls; track $index; let i = $index) {
                <div class="step-row" [formGroupName]="i">
                  <div class="step-number">{{ i + 1 }}</div>
                  <div class="step-content">
                    <textarea
                      formControlName="description"
                      class="input textarea"
                      rows="2"
                      placeholder="Describe este paso..."
                    ></textarea>
                    <input
                      type="url"
                      formControlName="imageUrl"
                      class="input"
                      placeholder="URL de imagen (opcional)"
                    />
                  </div>
                  <button 
                    type="button" 
                    class="btn btn-ghost btn-sm remove-btn"
                    (click)="removeStep(i)"
                    [disabled]="stepsArray.length <= 1"
                  >
                    <span class="material-icons-outlined">close</span>
                  </button>
                </div>
              }
            </div>
          </section>

          <!-- Tags -->
          <section class="form-section">
            <h2 class="section-title">Etiquetas</h2>
            <div class="form-group">
              <input
                type="text"
                class="input"
                placeholder="Escribe una etiqueta y presiona Enter"
                (keydown.enter)="addTag($event)"
              />
              <span class="input-helper">Ej: sin-gluten, vegano, rápido</span>
            </div>
            <div class="tags-list">
              @for (tag of tags(); track tag) {
                <span class="chip chip-primary">
                  {{ tag }}
                  <button type="button" class="tag-remove" (click)="removeTag(tag)">
                    <span class="material-icons icon-sm">close</span>
                  </button>
                </span>
              }
            </div>
          </section>

          <!-- Actions -->
          <div class="form-actions">
            <a routerLink="/recipes" class="btn btn-outline">Cancelar</a>
            <button 
              type="submit" 
              class="btn btn-primary btn-lg"
              [disabled]="saving() || recipeForm.invalid"
            >
              @if (saving()) {
                <span class="btn-spinner"></span>
                Guardando...
              } @else {
                <span class="material-icons-outlined">save</span>
                {{ isEditMode ? 'Guardar Cambios' : 'Publicar Receta' }}
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

    .recipe-form {
      max-width: 800px;
      margin: 0 auto;
    }

    .form-section {
      background: var(--surface-card);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-md);
      padding: var(--space-6);
      margin-bottom: var(--space-6);
    }

    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: var(--space-4);
    }

    .section-title {
      font-size: 18px;
      font-weight: 600;
      color: var(--text-primary);
      margin-bottom: var(--space-4);

      .section-header & {
        margin-bottom: 0;
      }
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
        grid-template-columns: repeat(3, 1fr);
      }
    }

    .textarea {
      resize: vertical;
      min-height: 80px;
    }

    .checkbox-label {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      cursor: pointer;

      input[type="checkbox"] {
        width: 18px;
        height: 18px;
        accent-color: var(--color-primary-500);
      }
    }

    .checkbox-text {
      font-size: 14px;
      color: var(--text-primary);
    }

    .categories-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: var(--space-2);

      @media (min-width: 640px) {
        grid-template-columns: repeat(3, 1fr);
      }
    }

    .category-checkbox {
      display: flex;
      align-items: center;
      gap: var(--space-2);
      padding: var(--space-2) var(--space-3);
      border: 1px solid var(--border-default);
      border-radius: var(--border-radius-sm);
      cursor: pointer;
      transition: all var(--duration-fast) var(--ease-default);

      &:hover {
        border-color: var(--color-primary-300);
      }

      &:has(input:checked) {
        border-color: var(--color-primary-500);
        background: var(--color-primary-50);
      }

      input {
        accent-color: var(--color-primary-500);
      }
    }

    .category-label {
      font-size: 14px;
      color: var(--text-primary);
    }

    .ingredients-form,
    .steps-form {
      display: flex;
      flex-direction: column;
      gap: var(--space-3);
    }

    .ingredient-row {
      display: grid;
      grid-template-columns: 80px 80px 1fr 40px;
      gap: var(--space-2);
      align-items: start;

      @media (max-width: 640px) {
        grid-template-columns: 1fr 1fr;
        
        .name-input {
          grid-column: span 2;
        }
      }
    }

    .step-row {
      display: flex;
      gap: var(--space-3);
      align-items: flex-start;
    }

    .step-number {
      flex-shrink: 0;
      width: 32px;
      height: 32px;
      background: var(--color-primary-100);
      color: var(--color-primary-600);
      border-radius: var(--border-radius-full);
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      font-size: 14px;
    }

    .step-content {
      flex: 1;
      display: flex;
      flex-direction: column;
      gap: var(--space-2);
    }

    .remove-btn {
      color: var(--text-secondary);

      &:hover:not(:disabled) {
        color: var(--color-error);
        background: var(--color-error-light);
      }

      &:disabled {
        opacity: 0.3;
      }
    }

    .tags-list {
      display: flex;
      flex-wrap: wrap;
      gap: var(--space-2);
      margin-top: var(--space-3);
    }

    .tag-remove {
      background: none;
      border: none;
      cursor: pointer;
      padding: 0;
      margin-left: var(--space-1);
      color: inherit;
      opacity: 0.7;

      &:hover {
        opacity: 1;
      }
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
export class RecipeFormComponent implements OnInit {
  @Input() id?: string;

  private fb = inject(FormBuilder);
  private router = inject(Router);
  private recipeService = inject(RecipeService);
  private categoryService = inject(CategoryService);
  private authService = inject(AuthService);

  recipeForm!: FormGroup;
  categories = signal<Category[]>([]);
  selectedCategoryIds = signal<number[]>([]);
  tags = signal<string[]>([]);
  saving = signal(false);
  loadingRecipe = signal(false);

  get isEditMode(): boolean {
    return !!this.id;
  }

  get ingredientsArray(): FormArray {
    return this.recipeForm.get('ingredients') as FormArray;
  }

  get stepsArray(): FormArray {
    return this.recipeForm.get('steps') as FormArray;
  }

  ngOnInit(): void {
    this.initForm();
    this.loadCategories();
    
    if (this.isEditMode) {
      this.loadRecipe();
    }
  }

  initForm(): void {
    this.recipeForm = this.fb.group({
      title: ['', [Validators.required, Validators.minLength(3), Validators.maxLength(100)]],
      description: [''],
      prepTime: [30, [Validators.required, Validators.min(1)]],
      cookTime: [30, [Validators.required, Validators.min(0)]],
      servings: [4, [Validators.required, Validators.min(1)]],
      difficulty: ['MEDIUM', Validators.required],
      imageUrl: [''],
      isPublic: [true],
      ingredients: this.fb.array([this.createIngredientGroup()]),
      steps: this.fb.array([this.createStepGroup(1)]),
    });
  }

  createIngredientGroup(): FormGroup {
    return this.fb.group({
      quantity: [1, Validators.required],
      unit: ['', Validators.required],
      name: ['', Validators.required],
    });
  }

  createStepGroup(stepNumber: number): FormGroup {
    return this.fb.group({
      stepNumber: [stepNumber],
      description: ['', Validators.required],
      imageUrl: [''],
    });
  }

  loadCategories(): void {
    this.categoryService.getCategories().subscribe({
      next: (categories) => this.categories.set(categories),
    });
  }

  loadRecipe(): void {
    this.loadingRecipe.set(true);
    const recipeId = parseInt(this.id!, 10);

    this.recipeService.getRecipeById(recipeId).subscribe({
      next: (recipe) => {
        this.populateForm(recipe);
        this.loadingRecipe.set(false);
      },
      error: () => {
        this.loadingRecipe.set(false);
        this.router.navigate(['/recipes']);
      },
    });
  }

  populateForm(recipe: Recipe): void {
    this.recipeForm.patchValue({
      title: recipe.title,
      description: recipe.description,
      prepTime: recipe.prepTime,
      cookTime: recipe.cookTime,
      servings: recipe.servings,
      difficulty: recipe.difficulty,
      imageUrl: recipe.imageUrl || '',
      isPublic: recipe.isPublic,
    });

    // Populate ingredients
    this.ingredientsArray.clear();
    recipe.ingredients.forEach((ing) => {
      this.ingredientsArray.push(this.fb.group({
        quantity: [ing.quantity],
        unit: [ing.unit],
        name: [ing.name],
      }));
    });

    // Populate steps
    this.stepsArray.clear();
    recipe.steps.forEach((step) => {
      this.stepsArray.push(this.fb.group({
        stepNumber: [step.stepNumber],
        description: [step.description],
        imageUrl: [step.imageUrl || ''],
      }));
    });

    // Populate categories
    this.selectedCategoryIds.set(recipe.categories.map(c => c.id));

    // Populate tags
    this.tags.set(recipe.tags.map(t => t.name));
  }

  isFieldInvalid(field: string): boolean {
    const control = this.recipeForm.get(field);
    return !!(control?.invalid && control?.touched);
  }

  isCategorySelected(categoryId: number): boolean {
    return this.selectedCategoryIds().includes(categoryId);
  }

  toggleCategory(categoryId: number): void {
    const current = this.selectedCategoryIds();
    if (current.includes(categoryId)) {
      this.selectedCategoryIds.set(current.filter(id => id !== categoryId));
    } else {
      this.selectedCategoryIds.set([...current, categoryId]);
    }
  }

  addIngredient(): void {
    this.ingredientsArray.push(this.createIngredientGroup());
  }

  removeIngredient(index: number): void {
    if (this.ingredientsArray.length > 1) {
      this.ingredientsArray.removeAt(index);
    }
  }

  addStep(): void {
    const newStepNumber = this.stepsArray.length + 1;
    this.stepsArray.push(this.createStepGroup(newStepNumber));
  }

  removeStep(index: number): void {
    if (this.stepsArray.length > 1) {
      this.stepsArray.removeAt(index);
      // Update step numbers
      this.stepsArray.controls.forEach((control, i) => {
        control.get('stepNumber')?.setValue(i + 1);
      });
    }
  }

  addTag(event: Event): void {
    event.preventDefault();
    const input = event.target as HTMLInputElement;
    const tag = input.value.trim().toLowerCase();
    
    if (tag && !this.tags().includes(tag)) {
      this.tags.update(tags => [...tags, tag]);
    }
    input.value = '';
  }

  removeTag(tag: string): void {
    this.tags.update(tags => tags.filter(t => t !== tag));
  }

  onSubmit(): void {
    if (this.recipeForm.invalid) {
      this.recipeForm.markAllAsTouched();
      return;
    }

    this.saving.set(true);

    const formValue = this.recipeForm.value;
    const request: RecipeRequest = {
      ...formValue,
      categoryIds: this.selectedCategoryIds(),
      tagIds: [], // Por ahora vacío - se necesita TagController en backend
    };

    const operation = this.isEditMode
      ? this.recipeService.updateRecipe(parseInt(this.id!, 10), request)
      : this.recipeService.createRecipe(request);

    operation.subscribe({
      next: (recipe) => {
        this.router.navigate(['/recipes', recipe.id]);
      },
      error: () => {
        this.saving.set(false);
        alert('Error al guardar la receta. Intenta de nuevo.');
      },
    });
  }
}
