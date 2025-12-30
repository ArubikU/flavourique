package dev.arubik.flavorique.mapper;

import dev.arubik.flavorique.dto.*;
import dev.arubik.flavorique.entity.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class RecipeMapper {

    private final UserMapper userMapper;

    public RecipeDto toDto(Recipe recipe) {
        if (recipe == null) {
            return null;
        }

        RecipeDto dto = new RecipeDto();
        dto.setId(recipe.getId());
        dto.setAuthor(userMapper.toDto(recipe.getAuthor()));
        dto.setTitle(recipe.getTitle());
        dto.setDescription(recipe.getDescription());
        dto.setInstructions(recipe.getInstructions());
        dto.setPrepTime(recipe.getPrepTime());
        dto.setCookTime(recipe.getCookTime());
        dto.setServings(recipe.getServings());
        dto.setDifficulty(recipe.getDifficulty() != null ? recipe.getDifficulty().name() : null);
        dto.setImageUrl(recipe.getImageUrl());
        dto.setIsPublic(recipe.getIsPublic());
        dto.setCreatedAt(recipe.getCreatedAt());
        dto.setUpdatedAt(recipe.getUpdatedAt());

        if (recipe.getIngredients() != null) {
            dto.setIngredients(recipe.getIngredients().stream()
                    .map(this::ingredientToDto)
                    .collect(Collectors.toList()));
        }

        if (recipe.getSteps() != null) {
            dto.setSteps(recipe.getSteps().stream()
                    .map(this::stepToDto)
                    .collect(Collectors.toList()));
        }

        if (recipe.getCategories() != null) {
            dto.setCategories(recipe.getCategories().stream()
                    .map(this::categoryToDto)
                    .collect(Collectors.toSet()));
        }

        if (recipe.getTags() != null) {
            dto.setTags(recipe.getTags().stream()
                    .map(this::tagToDto)
                    .collect(Collectors.toSet()));
        }

        return dto;
    }

    public Recipe toEntity(RecipeRequest request, User author) {
        Recipe recipe = new Recipe();
        recipe.setAuthor(author);
        recipe.setTitle(request.getTitle());
        recipe.setDescription(request.getDescription());
        recipe.setInstructions(request.getInstructions());
        recipe.setPrepTime(request.getPrepTime());
        recipe.setCookTime(request.getCookTime());
        recipe.setServings(request.getServings());
        
        if (request.getDifficulty() != null) {
            recipe.setDifficulty(Difficulty.valueOf(request.getDifficulty()));
        }
        
        recipe.setImageUrl(request.getImageUrl());
        recipe.setIsPublic(request.getIsPublic());
        recipe.setIngredients(new HashSet<>());
        recipe.setSteps(new HashSet<>());
        recipe.setCategories(new HashSet<>());
        recipe.setTags(new HashSet<>());

        return recipe;
    }

    private IngredientDto ingredientToDto(Ingredient ingredient) {
        IngredientDto dto = new IngredientDto();
        dto.setId(ingredient.getId());
        dto.setName(ingredient.getName());
        dto.setQuantity(ingredient.getQuantity());
        dto.setUnit(ingredient.getUnit());
        dto.setNotes(ingredient.getNotes());
        dto.setSortOrder(ingredient.getSortOrder());
        return dto;
    }

    private StepDto stepToDto(Step step) {
        StepDto dto = new StepDto();
        dto.setId(step.getId());
        dto.setStepNumber(step.getStepNumber());
        dto.setDescription(step.getDescription());
        dto.setImageUrl(step.getImageUrl());
        dto.setDuration(step.getDuration());
        return dto;
    }

    private CategoryDto categoryToDto(Category category) {
        CategoryDto dto = new CategoryDto();
        dto.setId(category.getId());
        dto.setName(category.getName());
        dto.setSlug(category.getSlug());
        dto.setDescription(category.getDescription());
        dto.setIcon(category.getIcon());
        return dto;
    }

    private TagDto tagToDto(Tag tag) {
        TagDto dto = new TagDto();
        dto.setId(tag.getId());
        dto.setName(tag.getName());
        dto.setSlug(tag.getSlug());
        return dto;
    }
}
