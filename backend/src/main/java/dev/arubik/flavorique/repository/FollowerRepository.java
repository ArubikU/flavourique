package dev.arubik.flavorique.repository;

import dev.arubik.flavorique.entity.Follower;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FollowerRepository extends JpaRepository<Follower, Long> {
    
    Optional<Follower> findByFollowerIdAndFollowingId(Long followerId, Long followingId);
    
    Page<Follower> findByFollowerId(Long followerId, Pageable pageable);
    
    Page<Follower> findByFollowingId(Long followingId, Pageable pageable);
    
    Boolean existsByFollowerIdAndFollowingId(Long followerId, Long followingId);
    
    Long countByFollowingId(Long followingId);
    
    Long countByFollowerId(Long followerId);
}
