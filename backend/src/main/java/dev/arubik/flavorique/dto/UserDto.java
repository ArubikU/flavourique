package dev.arubik.flavorique.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {

    private Long id;
    private String email;
    private String username;
    private String displayName;
    private String bio;
    private String avatarUrl;
    private String role;
    private Boolean isVerified;
    private LocalDateTime createdAt;
}
