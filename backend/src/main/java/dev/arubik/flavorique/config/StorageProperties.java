package dev.arubik.flavorique.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@ConfigurationProperties(prefix = "storage")
public class StorageProperties {
    private boolean enabled = false;
    private String endpoint;
    private String region;
    private String bucket;
    private String accessKey;
    private String secretKey;
}
