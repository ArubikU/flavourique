package dev.arubik.flavorique.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecipeRequest {

    @NotBlank(message = "Title is required")
    @Size(max = 200, message = "Title must not exceed 200 characters")
    private String title;

    private String description;

    @NotBlank(message = "Instructions are required")
    private String instructions;

    private Integer prepTime;
    private Integer cookTime;
    private Integer servings;
    private String difficulty;
    private String imageUrl;
    private Boolean isPublic = true;

    private List<IngredientDto> ingredients;
    private List<StepDto> steps;
    private Set<Long> categoryIds;
    private Set<Long> tagIds;
}
