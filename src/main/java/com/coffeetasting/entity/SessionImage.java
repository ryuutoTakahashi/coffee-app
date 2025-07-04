package com.coffeetasting.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "session_images")
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class SessionImage extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "session_id", nullable = false)
    private CuppingSession session;

    @Column(name = "image_url", nullable = false)
    @NotBlank(message = "Image URL is required")
    private String imageUrl;

    @Column(name = "image_type")
    @Enumerated(EnumType.STRING)
    private ImageType imageType;

    @Column(name = "file_name")
    private String fileName;

    @Column(name = "file_size")
    private Long fileSize;

    @Column(name = "content_type")
    private String contentType;

    private String caption;

    public enum ImageType {
        BEANS,
        BREWING,
        CUP,
        SETUP,
        OTHER
    }
}