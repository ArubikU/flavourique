package dev.arubik.flavorique.service;

import dev.arubik.flavorique.dto.RecipeDto;
import dev.arubik.flavorique.entity.Favorite;
import dev.arubik.flavorique.entity.Recipe;
import dev.arubik.flavorique.entity.User;
import dev.arubik.flavorique.exception.ResourceNotFoundException;
import dev.arubik.flavorique.mapper.RecipeMapper;
import dev.arubik.flavorique.repository.FavoriteRepository;
import dev.arubik.flavorique.repository.RecipeRepository;
import dev.arubik.flavorique.repository.UserRepository;
import dev.arubik.flavorique.security.UserPrincipal;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class FavoriteService {

    private final FavoriteRepository favoriteRepository;
    private final RecipeRepository recipeRepository;
    private final UserRepository userRepository;
    private final RecipeMapper recipeMapper;

    @Transactional(readOnly = true)
    public List<RecipeDto> getUserFavorites(UserPrincipal currentUser) {
        return favoriteRepository.findAllByUserId(currentUser.getId()).stream()
                .map(Favorite::getRecipe)
                .map(recipeMapper::toDto)
                .collect(Collectors.toList());
    }

    @Transactional
    public void toggleFavorite(Long recipeId, UserPrincipal currentUser) {
        User user = userRepository.findById(currentUser.getId())
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", currentUser.getId()));

        Recipe recipe = recipeRepository.findById(recipeId)
                .orElseThrow(() -> new ResourceNotFoundException("Recipe", "id", recipeId));

        favoriteRepository.findByUserIdAndRecipeId(user.getId(), recipeId)
                .ifPresentOrElse(
                        favoriteRepository::delete,
                        () -> {
                            Favorite favorite = new Favorite();
                            favorite.setUser(user);
                            favorite.setRecipe(recipe);
                            favoriteRepository.save(favorite);
                        }
                );
    }

    @Transactional(readOnly = true)
    public Boolean isFavorite(Long recipeId, UserPrincipal currentUser) {
        return favoriteRepository.existsByUserIdAndRecipeId(currentUser.getId(), recipeId);
    }
}
