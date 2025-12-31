package dev.arubik.flavorique.controller;

import dev.arubik.flavorique.service.StorageService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.services.s3.model.HeadObjectResponse;
import software.amazon.awssdk.services.s3.model.NoSuchKeyException;

import java.util.Map;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/blob")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "Blob", description = "Image serving endpoint")
public class BlobController {

    private final StorageService storageService;

    @GetMapping("/{folder}/{filename}")
    @Operation(summary = "Get an image from storage")
    public ResponseEntity<?> getBlob(
            @PathVariable String folder,
            @PathVariable String filename
    ) {
        if (!storageService.isEnabled()) {
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                    .body(Map.of("error", "Storage service is not configured"));
        }

        String key = folder + "/" + filename;

        try {
            // Get file metadata first for content-type and caching
            HeadObjectResponse metadata = storageService.getFileMetadata(key);
            
            // Get the actual file
            ResponseInputStream<GetObjectResponse> s3Object = storageService.getFile(key);
            
            String contentType = metadata.contentType();
            if (contentType == null) {
                contentType = guessContentType(filename);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.parseMediaType(contentType));
            headers.setContentLength(metadata.contentLength());
            headers.setCacheControl(CacheControl.maxAge(30, TimeUnit.DAYS).cachePublic());

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(new InputStreamResource(s3Object));

        } catch (NoSuchKeyException e) {
            log.warn("File not found: {}", key);
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            log.error("Error retrieving file: {}", key, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Failed to retrieve file"));
        }
    }

    private String guessContentType(String filename) {
        String lower = filename.toLowerCase();
        if (lower.endsWith(".jpg") || lower.endsWith(".jpeg")) {
            return "image/jpeg";
        } else if (lower.endsWith(".png")) {
            return "image/png";
        } else if (lower.endsWith(".gif")) {
            return "image/gif";
        } else if (lower.endsWith(".webp")) {
            return "image/webp";
        }
        return "application/octet-stream";
    }
}
