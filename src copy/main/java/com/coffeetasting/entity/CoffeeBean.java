package com.coffeetasting.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.Set;

@Entity
@Table(name = "coffee_beans")
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class CoffeeBean extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    @NotBlank(message = "Coffee bean name is required")
    private String name;

    @Column(name = "origin_country")
    private String originCountry;

    @Column(name = "origin_region")
    private String originRegion;

    @Column(name = "origin_farm")
    private String originFarm;

    @Column(name = "variety")
    private String variety;

    @Column(name = "processing_method")
    private String processingMethod;

    @Column(name = "roast_level")
    @Enumerated(EnumType.STRING)
    private RoastLevel roastLevel;

    @Column(name = "roast_date")
    private String roastDate;

    @Column(name = "roaster_name")
    private String roasterName;

    @Column(name = "altitude")
    private Integer altitude;

    @Column(name = "harvest_year")
    private Integer harvestYear;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(columnDefinition = "TEXT")
    private String notes;

    @OneToMany(mappedBy = "coffeeBean", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<CuppingSession> cuppingSessions;

    public enum RoastLevel {
        LIGHT,
        MEDIUM_LIGHT,
        MEDIUM,
        MEDIUM_DARK,
        DARK,
        FRENCH,
        ITALIAN
    }
}