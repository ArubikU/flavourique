import { User } from './user.model';

export interface Recipe {
  id: number;
  author: User;
  title: string;
  description: string;
  prepTime: number;
  cookTime: number;
  servings: number;
  difficulty: Difficulty;
  imageUrl: string | null;
  isPublic: boolean;
  createdAt: string;
  updatedAt: string;
  ingredients: Ingredient[];
  steps: Step[];
  categories: Category[];
  tags: Tag[];
  averageRating: number | null;
  reviewCount: number;
  favoritesCount: number;
}

export type Difficulty = 'EASY' | 'MEDIUM' | 'HARD';

export interface Ingredient {
  id?: number;
  name: string;
  quantity: number;
  unit: string;
}

export interface Step {
  id?: number;
  stepNumber: number;
  description: string;
  imageUrl?: string;
  duration?: number;
}

export interface Category {
  id: number;
  name: string;
  slug?: string;
  description?: string;
  icon?: string;
  recipeCount?: number;
}

export interface Tag {
  id: number;
  name: string;
}

export interface RecipeRequest {
  title: string;
  description?: string;
  prepTime: number;
  cookTime: number;
  servings: number;
  difficulty: Difficulty;
  imageUrl?: string;
  isPublic: boolean;
  ingredients: Ingredient[];
  steps: Step[];
  categoryIds: number[];
  tagIds?: number[];
}

export interface Review {
  id: number;
  user: User;
  rating: number;
  comment: string;
  createdAt: string;
}
