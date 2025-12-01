package com.haui.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "product_review")
@Data
public class Review {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	private Integer productId;

	private Integer userId;

	private Integer rating;

	@Column(columnDefinition = "TEXT")
	private String comment;

	@Column(nullable = false)
	private String status; // PENDING, APPROVED, REJECTED

	private LocalDateTime createdAt = LocalDateTime.now();

	// Không map CSDL – dùng để JOIN thủ công hoặc DTO
	@Transient
	private String fullName;

	@Transient
	private String avatar;

}
