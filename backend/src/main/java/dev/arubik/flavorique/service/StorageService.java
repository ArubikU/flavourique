package dev.arubik.flavorique.service;

import dev.arubik.flavorique.config.StorageProperties;
import dev.arubik.flavorique.dto.UploadResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.services.s3.model.HeadObjectRequest;
import software.amazon.awssdk.services.s3.model.HeadObjectResponse;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Service
@Slf4j
public class StorageService {

    private static final List<String> ALLOWED_CONTENT_TYPES = Arrays.asList(
            "image/jpeg",
            "image/png",
            "image/gif",
            "image/webp"
    );

    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB

    @Autowired(required = false)
    private S3Client s3Client;

    @Autowired
    private StorageProperties storageProperties;

    @Value("${server.servlet.context-path:}")
    private String contextPath;

    public boolean isEnabled() {
        return storageProperties.isEnabled() && s3Client != null;
    }

    public UploadResponse uploadFile(MultipartFile file, String folder) throws IOException {
        if (!isEnabled()) {
            throw new IllegalStateException("Storage service is not enabled");
        }

        validateFile(file);

        String originalFilename = file.getOriginalFilename();
        String extension = getFileExtension(originalFilename);
        String key = generateKey(folder, extension);

        PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(storageProperties.getBucket())
                .key(key)
                .contentType(file.getContentType())
                .contentLength(file.getSize())
                .build();

        s3Client.putObject(putObjectRequest, RequestBody.fromBytes(file.getBytes()));

        // URL points to our backend proxy instead of B2 directly
        String proxyUrl = buildProxyUrl(key);

        log.info("File uploaded successfully: {} -> {}", key, proxyUrl);

        return UploadResponse.builder()
                .url(proxyUrl)
                .key(key)
                .filename(originalFilename)
                .size(file.getSize())
                .contentType(file.getContentType())
                .build();
    }

    public ResponseInputStream<GetObjectResponse> getFile(String key) {
        if (!isEnabled()) {
            throw new IllegalStateException("Storage service is not enabled");
        }

        GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                .bucket(storageProperties.getBucket())
                .key(key)
                .build();

        return s3Client.getObject(getObjectRequest);
    }

    public HeadObjectResponse getFileMetadata(String key) {
        if (!isEnabled()) {
            throw new IllegalStateException("Storage service is not enabled");
        }

        HeadObjectRequest headObjectRequest = HeadObjectRequest.builder()
                .bucket(storageProperties.getBucket())
                .key(key)
                .build();

        return s3Client.headObject(headObjectRequest);
    }

    public void deleteFile(String key) {
        if (!isEnabled()) {
            log.warn("Storage service is not enabled, cannot delete file");
            return;
        }

        try {
            DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
                    .bucket(storageProperties.getBucket())
                    .key(key)
                    .build();

            s3Client.deleteObject(deleteObjectRequest);
            log.info("File deleted successfully: {}", key);
        } catch (Exception e) {
            log.error("Error deleting file: {}", key, e);
        }
    }

    public String extractKeyFromUrl(String url) {
        if (url == null || url.isEmpty()) {
            return null;
        }
        
        // URL format: /api/blob/folder/filename.ext
        if (url.contains("/blob/")) {
            int index = url.indexOf("/blob/") + 6;
            return url.substring(index);
        }
        
        return null;
    }

    private void validateFile(MultipartFile file) {
        if (file.isEmpty()) {
            throw new IllegalArgumentException("File is empty");
        }

        if (file.getSize() > MAX_FILE_SIZE) {
            throw new IllegalArgumentException("File size exceeds maximum allowed size of 5MB");
        }

        String contentType = file.getContentType();
        if (contentType == null || !ALLOWED_CONTENT_TYPES.contains(contentType)) {
            throw new IllegalArgumentException("Invalid file type. Allowed types: JPEG, PNG, GIF, WebP");
        }
    }

    private String getFileExtension(String filename) {
        if (filename == null || !filename.contains(".")) {
            return "jpg";
        }
        return filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
    }

    private String generateKey(String folder, String extension) {
        String uuid = UUID.randomUUID().toString();
        return String.format("%s/%s.%s", folder, uuid, extension);
    }

    private String buildProxyUrl(String key) {
        // Returns relative URL that will be served by our backend
        return "/api/blob/" + key;
    }
}
