package dev.arubik.flavorique.controller;

import dev.arubik.flavorique.dto.UploadResponse;
import dev.arubik.flavorique.service.StorageService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@RestController
@RequestMapping("/upload")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "Upload", description = "Image upload endpoints")
public class UploadController {

    private final StorageService storageService;

    @PostMapping(value = "/recipe-image", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "Upload a recipe image")
    public ResponseEntity<?> uploadRecipeImage(@RequestParam("file") MultipartFile file) {
        return uploadImage(file, "recipes");
    }

    @PostMapping(value = "/step-image", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "Upload a step image")
    public ResponseEntity<?> uploadStepImage(@RequestParam("file") MultipartFile file) {
        return uploadImage(file, "steps");
    }

    @PostMapping(value = "/avatar", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "Upload a user avatar")
    public ResponseEntity<?> uploadAvatar(@RequestParam("file") MultipartFile file) {
        return uploadImage(file, "avatars");
    }

    @GetMapping("/status")
    @Operation(summary = "Check if upload service is available")
    public ResponseEntity<?> getUploadStatus() {
        boolean enabled = storageService.isEnabled();
        return ResponseEntity.ok(Map.of(
                "enabled", enabled,
                "message", enabled ? "Upload service is available" : "Upload service is not configured"
        ));
    }

    @DeleteMapping
    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "Delete an uploaded file")
    public ResponseEntity<?> deleteFile(@RequestParam("key") String key) {
        if (!storageService.isEnabled()) {
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                    .body(Map.of("error", "Upload service is not configured"));
        }

        try {
            storageService.deleteFile(key);
            return ResponseEntity.ok(Map.of("message", "File deleted successfully"));
        } catch (Exception e) {
            log.error("Error deleting file", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Failed to delete file"));
        }
    }

    private ResponseEntity<?> uploadImage(MultipartFile file, String folder) {
        if (!storageService.isEnabled()) {
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                    .body(Map.of("error", "Upload service is not configured. Please use image URLs instead."));
        }

        try {
            UploadResponse response = storageService.uploadFile(file, folder);
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            log.warn("Invalid file upload attempt: {}", e.getMessage());
            return ResponseEntity.badRequest()
                    .body(Map.of("error", e.getMessage()));
        } catch (IOException e) {
            log.error("Error uploading file", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Failed to upload file"));
        }
    }
}
