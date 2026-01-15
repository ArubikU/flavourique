import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '@environments/environment';
import { Recipe, RecipeRequest, PageResponse, Difficulty } from '../models';

export interface RecipeFilters {
  q?: string;
  category?: string;
  difficulty?: string;
  maxPrepTime?: number;
  page?: number;
  size?: number;
  sort?: string;
}

@Injectable({
  providedIn: 'root',
})
export class RecipeService {
  private readonly apiUrl = `${environment.apiUrl}/recipes`;

  constructor(private http: HttpClient) { }

  getRecipes(
    page = 0,
    size = 12,
    sort?: string,
    difficulty?: Difficulty,
    categoryId?: number,
    tag?: string
  ): Observable<PageResponse<Recipe>> {
    let params = new HttpParams()
      .set('page', page.toString())
      .set('size', size.toString());

    if (sort) params = params.set('sort', sort);
    if (difficulty) params = params.set('difficulty', difficulty);
    if (categoryId) params = params.set('categoryId', categoryId.toString());
    if (tag) params = params.set('tag', tag);

    return this.http.get<PageResponse<Recipe>>(this.apiUrl, { params });
  }

  getRecipeById(id: number): Observable<Recipe> {
    return this.http.get<Recipe>(`${this.apiUrl}/${id}`);
  }

  createRecipe(request: RecipeRequest): Observable<Recipe> {
    return this.http.post<Recipe>(this.apiUrl, request);
  }

  updateRecipe(id: number, request: RecipeRequest): Observable<Recipe> {
    return this.http.put<Recipe>(`${this.apiUrl}/${id}`, request);
  }

  deleteRecipe(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }

  searchRecipes(
    query: string,
    page = 0,
    size = 12,
    sort?: string,
    difficulty?: Difficulty,
    categoryId?: number,
    tag?: string
  ): Observable<PageResponse<Recipe>> {
    let params = new HttpParams()
      .set('q', query)
      .set('page', page.toString())
      .set('size', size.toString());

    if (sort) params = params.set('sort', sort);
    if (difficulty) params = params.set('difficulty', difficulty);
    if (categoryId) params = params.set('categoryId', categoryId.toString());
    if (tag) params = params.set('tag', tag);

    return this.http.get<PageResponse<Recipe>>(`${this.apiUrl}/search`, { params });
  }

  getRecipesByAuthor(
    authorId: number,
    page = 0,
    size = 12,
    sort?: string
  ): Observable<PageResponse<Recipe>> {
    let params = new HttpParams()
      .set('page', page.toString())
      .set('size', size.toString());

    if (sort) params = params.set('sort', sort);

    return this.http.get<PageResponse<Recipe>>(`${this.apiUrl}/author/${authorId}`, { params });
  }

  getLatestRecipes(size = 6): Observable<Recipe[]> {
    const params = new HttpParams()
      .set('page', '0')
      .set('size', size.toString())
      .set('sort', 'createdAt,desc');

    return new Observable<Recipe[]>(observer => {
      this.http.get<PageResponse<Recipe>>(this.apiUrl, { params }).subscribe({
        next: (response) => {
          observer.next(response.content);
          observer.complete();
        },
        error: (err) => observer.error(err),
      });
    });
  }
}
