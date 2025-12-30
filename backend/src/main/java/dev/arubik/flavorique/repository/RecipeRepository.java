package dev.arubik.flavorique.repository;

import dev.arubik.flavorique.entity.Recipe;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface RecipeRepository extends JpaRepository<Recipe, Long> {
    
    Page<Recipe> findByIsPublicTrue(Pageable pageable);
    
    Page<Recipe> findByAuthorId(Long authorId, Pageable pageable);
    
    @Query("SELECT r FROM Recipe r WHERE r.isPublic = true AND " +
           "(LOWER(r.title) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(r.description) LIKE LOWER(CONCAT('%', :query, '%')))")
    Page<Recipe> searchRecipes(@Param("query") String query, Pageable pageable);
    
    @Query("SELECT r FROM Recipe r JOIN r.categories c WHERE c.id = :categoryId AND r.isPublic = true")
    Page<Recipe> findByCategoryId(@Param("categoryId") Long categoryId, Pageable pageable);
}
