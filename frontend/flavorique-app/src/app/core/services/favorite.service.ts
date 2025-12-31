import { Injectable, signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, tap } from 'rxjs';
import { environment } from '@environments/environment';
import { Recipe } from '../models';

@Injectable({
  providedIn: 'root',
})
export class FavoriteService {
  private readonly apiUrl = `${environment.apiUrl}/favorites`;
  
  private favoritesSet = signal<Set<number>>(new Set());

  constructor(private http: HttpClient) {}

  getUserFavorites(): Observable<Recipe[]> {
    return this.http.get<Recipe[]>(`${this.apiUrl}/me`).pipe(
      tap((recipes) => {
        const ids = new Set(recipes.map(r => r.id));
        this.favoritesSet.set(ids);
      })
    );
  }

  toggleFavorite(recipeId: number): Observable<void> {
    return this.http.post<void>(`${this.apiUrl}/recipes/${recipeId}`, {}).pipe(
      tap(() => {
        const favorites = new Set(this.favoritesSet());
        if (favorites.has(recipeId)) {
          favorites.delete(recipeId);
        } else {
          favorites.add(recipeId);
        }
        this.favoritesSet.set(favorites);
      })
    );
  }

  isFavorite(recipeId: number): Observable<boolean> {
    return this.http.get<boolean>(`${this.apiUrl}/recipes/${recipeId}`).pipe(
      tap((isFav) => {
        const favorites = new Set(this.favoritesSet());
        if (isFav) {
          favorites.add(recipeId);
        } else {
          favorites.delete(recipeId);
        }
        this.favoritesSet.set(favorites);
      })
    );
  }

  isFavoriteLocal(recipeId: number): boolean {
    return this.favoritesSet().has(recipeId);
  }
}
