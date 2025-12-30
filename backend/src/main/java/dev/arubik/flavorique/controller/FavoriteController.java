package dev.arubik.flavorique.controller;

import dev.arubik.flavorique.security.UserPrincipal;
import dev.arubik.flavorique.service.FavoriteService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/favorites")
@RequiredArgsConstructor
@Tag(name = "Favorites", description = "Favorite management endpoints")
public class FavoriteController {

    private final FavoriteService favoriteService;

    @PostMapping("/recipes/{recipeId}")
    @Operation(summary = "Toggle favorite for a recipe")
    public ResponseEntity<Void> toggleFavorite(
            @PathVariable Long recipeId,
            @AuthenticationPrincipal UserPrincipal currentUser) {
        favoriteService.toggleFavorite(recipeId, currentUser);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/recipes/{recipeId}")
    @Operation(summary = "Check if recipe is favorite")
    public ResponseEntity<Boolean> isFavorite(
            @PathVariable Long recipeId,
            @AuthenticationPrincipal UserPrincipal currentUser) {
        Boolean isFavorite = favoriteService.isFavorite(recipeId, currentUser);
        return ResponseEntity.ok(isFavorite);
    }
}
