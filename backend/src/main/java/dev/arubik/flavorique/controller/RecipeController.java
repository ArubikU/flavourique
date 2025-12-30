package dev.arubik.flavorique.controller;

import dev.arubik.flavorique.dto.RecipeDto;
import dev.arubik.flavorique.dto.RecipeRequest;
import dev.arubik.flavorique.security.UserPrincipal;
import dev.arubik.flavorique.service.RecipeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/recipes")
@RequiredArgsConstructor
@Tag(name = "Recipes", description = "Recipe management endpoints")
public class RecipeController {

    private final RecipeService recipeService;

    @GetMapping
    @Operation(summary = "Get all public recipes")
    public ResponseEntity<Page<RecipeDto>> getAllRecipes(
            @PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable) {
        Page<RecipeDto> recipes = recipeService.getAllPublicRecipes(pageable);
        return ResponseEntity.ok(recipes);
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get recipe by ID")
    public ResponseEntity<RecipeDto> getRecipeById(@PathVariable Long id) {
        RecipeDto recipe = recipeService.getRecipeById(id);
        return ResponseEntity.ok(recipe);
    }

    @PostMapping
    @Operation(summary = "Create a new recipe")
    public ResponseEntity<RecipeDto> createRecipe(
            @Valid @RequestBody RecipeRequest request,
            @AuthenticationPrincipal UserPrincipal currentUser) {
        RecipeDto recipe = recipeService.createRecipe(request, currentUser);
        return new ResponseEntity<>(recipe, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    @Operation(summary = "Update a recipe")
    public ResponseEntity<RecipeDto> updateRecipe(
            @PathVariable Long id,
            @Valid @RequestBody RecipeRequest request,
            @AuthenticationPrincipal UserPrincipal currentUser) {
        RecipeDto recipe = recipeService.updateRecipe(id, request, currentUser);
        return ResponseEntity.ok(recipe);
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete a recipe")
    public ResponseEntity<Void> deleteRecipe(
            @PathVariable Long id,
            @AuthenticationPrincipal UserPrincipal currentUser) {
        recipeService.deleteRecipe(id, currentUser);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/search")
    @Operation(summary = "Search recipes")
    public ResponseEntity<Page<RecipeDto>> searchRecipes(
            @RequestParam String q,
            @PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable) {
        Page<RecipeDto> recipes = recipeService.searchRecipes(q, pageable);
        return ResponseEntity.ok(recipes);
    }

    @GetMapping("/author/{authorId}")
    @Operation(summary = "Get recipes by author")
    public ResponseEntity<Page<RecipeDto>> getRecipesByAuthor(
            @PathVariable Long authorId,
            @PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable) {
        Page<RecipeDto> recipes = recipeService.getRecipesByAuthor(authorId, pageable);
        return ResponseEntity.ok(recipes);
    }
}
