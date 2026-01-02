package dev.arubik.flavorique.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;

import java.net.URI;

@Configuration
@ConditionalOnProperty(name = "storage.enabled", havingValue = "true")
@Slf4j
public class StorageConfig {

    @Value("${storage.endpoint:}")
    private String endpoint;

    @Value("${storage.region:us-east-005}")
    private String region;

    @Value("${storage.access-key:}")
    private String accessKey;

    @Value("${storage.secret-key:}")
    private String secretKey;

    @Bean
    public S3Client s3Client() {
        // Validate required configuration
        if (endpoint == null || endpoint.isBlank() || 
            accessKey == null || accessKey.isBlank() || 
            secretKey == null || secretKey.isBlank()) {
            log.warn("Storage configuration incomplete - B2_ENDPOINT, B2_ACCESS_KEY, or B2_SECRET_KEY not set. Storage will be disabled.");
            return null;
        }

        try {
            AwsBasicCredentials credentials = AwsBasicCredentials.create(accessKey, secretKey);
            
            S3Client client = S3Client.builder()
                    .endpointOverride(URI.create(endpoint))
                    .region(Region.of(region))
                    .credentialsProvider(StaticCredentialsProvider.create(credentials))
                    .forcePathStyle(true)
                    .build();
            
            log.info("S3 Storage client initialized successfully for endpoint: {}", endpoint);
            return client;
        } catch (Exception e) {
            log.error("Failed to initialize S3 client: {}", e.getMessage());
            return null;
        }
    }
}
