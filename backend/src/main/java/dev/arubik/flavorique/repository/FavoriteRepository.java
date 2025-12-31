package dev.arubik.flavorique.repository;

import dev.arubik.flavorique.entity.Favorite;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FavoriteRepository extends JpaRepository<Favorite, Long> {
    
    Optional<Favorite> findByUserIdAndRecipeId(Long userId, Long recipeId);
    
    List<Favorite> findAllByUserId(Long userId);
    
    Page<Favorite> findByUserId(Long userId, Pageable pageable);
    
    Boolean existsByUserIdAndRecipeId(Long userId, Long recipeId);
    
    Long countByRecipeId(Long recipeId);
}
