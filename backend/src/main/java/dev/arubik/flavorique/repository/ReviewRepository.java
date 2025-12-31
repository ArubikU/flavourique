package dev.arubik.flavorique.repository;

import dev.arubik.flavorique.entity.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    
    Optional<Review> findByUserIdAndRecipeId(Long userId, Long recipeId);
    
    Page<Review> findByRecipeId(Long recipeId, Pageable pageable);
    
    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.recipe.id = :recipeId")
    Double getAverageRatingByRecipeId(@Param("recipeId") Long recipeId);
    
    Long countByRecipeId(Long recipeId);
    
    void deleteAllByUserId(Long userId);
}
