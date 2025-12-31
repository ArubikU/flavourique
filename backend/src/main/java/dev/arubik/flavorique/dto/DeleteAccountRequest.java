package dev.arubik.flavorique.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class DeleteAccountRequest {
    
    @NotBlank(message = "Password is required to delete account")
    private String password;
}
