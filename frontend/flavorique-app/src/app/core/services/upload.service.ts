import { Injectable, inject, signal } from '@angular/core';
import { HttpClient, HttpEvent, HttpEventType } from '@angular/common/http';
import { Observable, map, catchError, of } from 'rxjs';
import { environment } from '@environments/environment';

export interface UploadResponse {
  url: string;
  key: string;
  filename: string;
  size: number;
  contentType: string;
}

export interface UploadStatus {
  enabled: boolean;
  message: string;
}

export interface UploadProgress {
  progress: number;
  completed: boolean;
  response?: UploadResponse;
  error?: string;
}

@Injectable({
  providedIn: 'root',
})
export class UploadService {
  private readonly apiUrl = `${environment.apiUrl}/upload`;
  private http = inject(HttpClient);

  isEnabled = signal<boolean>(false);
  isLoading = signal<boolean>(true);

  constructor() {
    this.checkUploadStatus().subscribe();
  }

  checkUploadStatus(): Observable<UploadStatus> {
    this.isLoading.set(true);
    return this.http.get<UploadStatus>(`${this.apiUrl}/status`).pipe(
      map((status) => {
        this.isEnabled.set(status.enabled);
        this.isLoading.set(false);
        return status;
      }),
      catchError(() => {
        this.isEnabled.set(false);
        this.isLoading.set(false);
        return of({ enabled: false, message: 'Upload service unavailable' });
      })
    );
  }

  uploadRecipeImage(file: File): Observable<UploadProgress> {
    return this.uploadFile(file, 'recipe-image');
  }

  uploadStepImage(file: File): Observable<UploadProgress> {
    return this.uploadFile(file, 'step-image');
  }

  uploadAvatar(file: File): Observable<UploadProgress> {
    return this.uploadFile(file, 'avatar');
  }

  deleteFile(key: string): Observable<void> {
    return this.http.delete<void>(this.apiUrl, { params: { key } });
  }

  private uploadFile(file: File, endpoint: string): Observable<UploadProgress> {
    const formData = new FormData();
    formData.append('file', file);

    return this.http
      .post<UploadResponse>(`${this.apiUrl}/${endpoint}`, formData, {
        reportProgress: true,
        observe: 'events',
      })
      .pipe(
        map((event: HttpEvent<UploadResponse>) => {
          switch (event.type) {
            case HttpEventType.UploadProgress:
              const progress = event.total
                ? Math.round((100 * event.loaded) / event.total)
                : 0;
              return { progress, completed: false };

            case HttpEventType.Response:
              return {
                progress: 100,
                completed: true,
                response: event.body as UploadResponse,
              };

            default:
              return { progress: 0, completed: false };
          }
        }),
        catchError((error) => {
          const errorMessage =
            error.error?.error || error.message || 'Upload failed';
          return of({ progress: 0, completed: true, error: errorMessage });
        })
      );
  }

  validateFile(file: File): { valid: boolean; error?: string } {
    const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
    const maxSize = 5 * 1024 * 1024; // 5MB

    if (!allowedTypes.includes(file.type)) {
      return {
        valid: false,
        error: 'Tipo de archivo no válido. Solo se permiten: JPEG, PNG, GIF, WebP',
      };
    }

    if (file.size > maxSize) {
      return {
        valid: false,
        error: 'El archivo es muy grande. Máximo permitido: 5MB',
      };
    }

    return { valid: true };
  }
}
