package com.coffeetasting.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;

@Entity
@Table(name = "cupping_scores")
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class CuppingScore extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "session_id", nullable = false)
    private CuppingSession session;

    @Column(name = "fragrance_aroma", precision = 4, scale = 2)
    @DecimalMin(value = "0.00", message = "Score must be at least 0.00")
    @DecimalMax(value = "10.00", message = "Score must be at most 10.00")
    private BigDecimal fragranceAroma;

    @Column(name = "flavor", precision = 4, scale = 2)
    @DecimalMin(value = "0.00", message = "Score must be at least 0.00")
    @DecimalMax(value = "10.00", message = "Score must be at most 10.00")
    private BigDecimal flavor;

    @Column(name = "aftertaste", precision = 4, scale = 2)
    @DecimalMin(value = "0.00", message = "Score must be at least 0.00")
    @DecimalMax(value = "10.00", message = "Score must be at most 10.00")
    private BigDecimal aftertaste;

    @Column(name = "acidity", precision = 4, scale = 2)
    @DecimalMin(value = "0.00", message = "Score must be at least 0.00")
    @DecimalMax(value = "10.00", message = "Score must be at most 10.00")
    private BigDecimal acidity;

    @Column(name = "body", precision = 4, scale = 2)
    @DecimalMin(value = "0.00", message = "Score must be at least 0.00")
    @DecimalMax(value = "10.00", message = "Score must be at most 10.00")
    private BigDecimal body;

    @Column(name = "balance", precision = 4, scale = 2)
    @DecimalMin(value = "0.00", message = "Score must be at least 0.00")
    @DecimalMax(value = "10.00", message = "Score must be at most 10.00")
    private BigDecimal balance;

    @Column(name = "overall", precision = 4, scale = 2)
    @DecimalMin(value = "0.00", message = "Score must be at least 0.00")
    @DecimalMax(value = "10.00", message = "Score must be at most 10.00")
    private BigDecimal overall;

    @Column(name = "cup_cleanliness", precision = 4, scale = 2)
    @DecimalMin(value = "0.00", message = "Score must be at least 0.00")
    @DecimalMax(value = "10.00", message = "Score must be at most 10.00")
    private BigDecimal cupCleanliness;

    @Column(name = "sweetness", precision = 4, scale = 2)
    @DecimalMin(value = "0.00", message = "Score must be at least 0.00")
    @DecimalMax(value = "10.00", message = "Score must be at most 10.00")
    private BigDecimal sweetness;

    @Column(name = "defects", nullable = false)
    private Integer defects = 0;

    @Column(name = "total_score", precision = 5, scale = 2)
    private BigDecimal totalScore;

    @Column(columnDefinition = "TEXT")
    private String notes;

    @PrePersist
    @PreUpdate
    private void calculateTotalScore() {
        if (fragranceAroma != null && flavor != null && aftertaste != null &&
                acidity != null && body != null && balance != null && overall != null &&
                cupCleanliness != null && sweetness != null) {

            totalScore = fragranceAroma
                    .add(flavor)
                    .add(aftertaste)
                    .add(acidity)
                    .add(body)
                    .add(balance)
                    .add(overall)
                    .add(cupCleanliness)
                    .add(sweetness)
                    .subtract(BigDecimal.valueOf(defects));
        }
    }
}