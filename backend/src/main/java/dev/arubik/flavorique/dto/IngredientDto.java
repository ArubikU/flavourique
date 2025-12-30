package dev.arubik.flavorique.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class IngredientDto {

    private Long id;
    private String name;
    private BigDecimal quantity;
    private String unit;
    private String notes;
    private Integer sortOrder;
}
