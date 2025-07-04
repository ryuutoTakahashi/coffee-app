package com.coffeetasting.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.Set;

@Entity
@Table(name = "cupping_sessions")
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class CuppingSession extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    @NotBlank(message = "Session title is required")
    private String title;

    @Column(columnDefinition = "TEXT")
    private String notes;

    @Column(name = "brewing_method")
    private String brewingMethod;

    @Column(name = "water_temperature")
    private Integer waterTemperature;

    @Column(name = "grind_size")
    private String grindSize;

    @Column(name = "coffee_to_water_ratio")
    private String coffeeToWaterRatio;

    @Column(name = "brewing_time")
    private String brewingTime;

    @Column(name = "is_public", nullable = false)
    private Boolean isPublic = true;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "coffee_bean_id", nullable = false)
    private CoffeeBean coffeeBean;

    @OneToOne(mappedBy = "session", cascade = CascadeType.ALL, orphanRemoval = true)
    private CuppingScore cuppingScore;

    @OneToMany(mappedBy = "session", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<SessionImage> sessionImages;

    @OneToMany(mappedBy = "session", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Like> likes;

    @OneToMany(mappedBy = "session", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Comment> comments;
}