package dev.arubik.flavorique.service;

import dev.arubik.flavorique.dto.RecipeDto;
import dev.arubik.flavorique.dto.RecipeRequest;
import dev.arubik.flavorique.entity.*;
import dev.arubik.flavorique.exception.BadRequestException;
import dev.arubik.flavorique.exception.ResourceNotFoundException;
import dev.arubik.flavorique.mapper.RecipeMapper;
import dev.arubik.flavorique.repository.*;
import dev.arubik.flavorique.security.UserPrincipal;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class RecipeService {

    private final RecipeRepository recipeRepository;
    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;
    private final TagRepository tagRepository;
    private final ReviewRepository reviewRepository;
    private final FavoriteRepository favoriteRepository;
    private final RecipeMapper recipeMapper;

    @Transactional(readOnly = true)
    public Page<RecipeDto> getAllPublicRecipes(Pageable pageable) {
        return recipeRepository.findByIsPublicTrue(pageable)
                .map(this::enrichRecipeDto);
    }

    @Transactional(readOnly = true)
    public RecipeDto getRecipeById(Long id) {
        Recipe recipe = recipeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Recipe", "id", id));

        return enrichRecipeDto(recipe);
    }

    @Transactional
    public RecipeDto createRecipe(RecipeRequest request, UserPrincipal currentUser) {
        User author = userRepository.findById(currentUser.getId())
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", currentUser.getId()));

        final Recipe recipe = recipeMapper.toEntity(request, author);

        if (request.getIngredients() != null) {
            request.getIngredients().forEach(ingredientDto -> {
                Ingredient ingredient = new Ingredient();
                ingredient.setRecipe(recipe);
                ingredient.setName(ingredientDto.getName());
                ingredient.setQuantity(ingredientDto.getQuantity());
                ingredient.setUnit(ingredientDto.getUnit());
                ingredient.setNotes(ingredientDto.getNotes());
                ingredient.setSortOrder(ingredientDto.getSortOrder());
                recipe.getIngredients().add(ingredient);
            });
        }

        if (request.getSteps() != null) {
            request.getSteps().forEach(stepDto -> {
                Step step = new Step();
                step.setRecipe(recipe);
                step.setStepNumber(stepDto.getStepNumber());
                step.setDescription(stepDto.getDescription());
                step.setImageUrl(stepDto.getImageUrl());
                step.setDuration(stepDto.getDuration());
                recipe.getSteps().add(step);
            });
        }

        if (request.getCategoryIds() != null) {
            Set<Category> categories = new HashSet<>();
            request.getCategoryIds().forEach(categoryId -> {
                Category category = categoryRepository.findById(categoryId)
                        .orElseThrow(() -> new ResourceNotFoundException("Category", "id", categoryId));
                categories.add(category);
            });
            recipe.setCategories(categories);
        }

        if (request.getTagIds() != null) {
            Set<Tag> tags = new HashSet<>();
            request.getTagIds().forEach(tagId -> {
                Tag tag = tagRepository.findById(tagId)
                        .orElseThrow(() -> new ResourceNotFoundException("Tag", "id", tagId));
                tags.add(tag);
            });
            recipe.setTags(tags);
        }

        Recipe savedRecipe = recipeRepository.save(recipe);
        return enrichRecipeDto(savedRecipe);
    }

    @Transactional
    public RecipeDto updateRecipe(Long id, RecipeRequest request, UserPrincipal currentUser) {
        Recipe recipe = recipeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Recipe", "id", id));

        if (!recipe.getAuthor().getId().equals(currentUser.getId())) {
            throw new AccessDeniedException("You don't have permission to update this recipe");
        }

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

        final Recipe finalRecipe = recipe;
        
        recipe.getIngredients().clear();
        if (request.getIngredients() != null) {
            request.getIngredients().forEach(ingredientDto -> {
                Ingredient ingredient = new Ingredient();
                ingredient.setRecipe(finalRecipe);
                ingredient.setName(ingredientDto.getName());
                ingredient.setQuantity(ingredientDto.getQuantity());
                ingredient.setUnit(ingredientDto.getUnit());
                ingredient.setNotes(ingredientDto.getNotes());
                ingredient.setSortOrder(ingredientDto.getSortOrder());
                finalRecipe.getIngredients().add(ingredient);
            });
        }

        recipe.getSteps().clear();
        if (request.getSteps() != null) {
            request.getSteps().forEach(stepDto -> {
                Step step = new Step();
                step.setRecipe(finalRecipe);
                step.setStepNumber(stepDto.getStepNumber());
                step.setDescription(stepDto.getDescription());
                step.setImageUrl(stepDto.getImageUrl());
                step.setDuration(stepDto.getDuration());
                finalRecipe.getSteps().add(step);
            });
        }

        Recipe savedRecipe = recipeRepository.save(recipe);
        return enrichRecipeDto(savedRecipe);
    }

    @Transactional
    public void deleteRecipe(Long id, UserPrincipal currentUser) {
        Recipe recipe = recipeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Recipe", "id", id));

        if (!recipe.getAuthor().getId().equals(currentUser.getId())) {
            throw new AccessDeniedException("You don't have permission to delete this recipe");
        }

        recipeRepository.delete(recipe);
    }

    @Transactional(readOnly = true)
    public Page<RecipeDto> searchRecipes(String query, Pageable pageable) {
        return recipeRepository.searchRecipes(query, pageable)
                .map(this::enrichRecipeDto);
    }

    @Transactional(readOnly = true)
    public Page<RecipeDto> getRecipesByAuthor(Long authorId, Pageable pageable) {
        return recipeRepository.findByAuthorId(authorId, pageable)
                .map(this::enrichRecipeDto);
    }

    private RecipeDto enrichRecipeDto(Recipe recipe) {
        RecipeDto dto = recipeMapper.toDto(recipe);
        dto.setAverageRating(reviewRepository.getAverageRatingByRecipeId(recipe.getId()));
        dto.setReviewCount(reviewRepository.countByRecipeId(recipe.getId()));
        dto.setFavoritesCount(favoriteRepository.countByRecipeId(recipe.getId()));
        return dto;
    }
}
