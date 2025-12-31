import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, shareReplay } from 'rxjs';
import { environment } from '@environments/environment';
import { Category } from '../models';

@Injectable({
  providedIn: 'root',
})
export class CategoryService {
  private readonly apiUrl = `${environment.apiUrl}/categories`;
  private categories$: Observable<Category[]> | null = null;

  constructor(private http: HttpClient) {}

  getCategories(): Observable<Category[]> {
    if (!this.categories$) {
      this.categories$ = this.http.get<Category[]>(this.apiUrl).pipe(
        shareReplay(1)
      );
    }
    return this.categories$;
  }

  getCategoryById(id: number): Observable<Category> {
    return this.http.get<Category>(`${this.apiUrl}/${id}`);
  }
}
