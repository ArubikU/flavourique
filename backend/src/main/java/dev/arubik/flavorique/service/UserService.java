package dev.arubik.flavorique.service;

import dev.arubik.flavorique.dto.ChangePasswordRequest;
import dev.arubik.flavorique.dto.UserDto;
import dev.arubik.flavorique.entity.User;
import dev.arubik.flavorique.exception.BadRequestException;
import dev.arubik.flavorique.exception.ResourceNotFoundException;
import dev.arubik.flavorique.mapper.UserMapper;
import dev.arubik.flavorique.repository.FavoriteRepository;
import dev.arubik.flavorique.repository.RecipeRepository;
import dev.arubik.flavorique.repository.ReviewRepository;
import dev.arubik.flavorique.repository.UserRepository;
import dev.arubik.flavorique.security.UserPrincipal;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;
    private final RecipeRepository recipeRepository;
    private final ReviewRepository reviewRepository;
    private final FavoriteRepository favoriteRepository;

    @Transactional(readOnly = true)
    public UserDto getUserById(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", id));

        return userMapper.toDto(user);
    }

    @Transactional(readOnly = true)
    public UserDto getUserByUsername(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new ResourceNotFoundException("User", "username", username));

        return userMapper.toDto(user);
    }

    @Transactional
    public UserDto updateUser(Long id, UserDto userDto) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", id));

        if (userDto.getDisplayName() != null) {
            user.setDisplayName(userDto.getDisplayName());
        }
        if (userDto.getBio() != null) {
            user.setBio(userDto.getBio());
        }
        if (userDto.getAvatarUrl() != null) {
            user.setAvatarUrl(userDto.getAvatarUrl());
        }

        user = userRepository.save(user);
        return userMapper.toDto(user);
    }

    @Transactional
    public void changePassword(UserPrincipal currentUser, ChangePasswordRequest request) {
        User user = userRepository.findById(currentUser.getId())
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", currentUser.getId()));

        // Verify current password
        if (!passwordEncoder.matches(request.getCurrentPassword(), user.getPassword())) {
            throw new BadRequestException("Current password is incorrect");
        }

        // Verify new password matches confirmation
        if (!request.getNewPassword().equals(request.getConfirmPassword())) {
            throw new BadRequestException("New password and confirmation do not match");
        }

        // Verify new password is different from current
        if (passwordEncoder.matches(request.getNewPassword(), user.getPassword())) {
            throw new BadRequestException("New password must be different from current password");
        }

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);
    }

    @Transactional
    public void deleteAccount(UserPrincipal currentUser, String password) {
        User user = userRepository.findById(currentUser.getId())
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", currentUser.getId()));

        // Verify password
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new BadRequestException("Password is incorrect");
        }

        // Delete user's favorites
        favoriteRepository.deleteAllByUserId(user.getId());
        
        // Delete user's reviews
        reviewRepository.deleteAllByUserId(user.getId());
        
        // Delete user's recipes (this will cascade delete ingredients, steps, etc.)
        recipeRepository.deleteAllByAuthorId(user.getId());
        
        // Finally delete the user
        userRepository.delete(user);
    }
}
