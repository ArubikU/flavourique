package dev.arubik.flavorique.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StepDto {

    private Long id;
    private Integer stepNumber;
    private String description;
    private String imageUrl;
    private Integer duration;
}
