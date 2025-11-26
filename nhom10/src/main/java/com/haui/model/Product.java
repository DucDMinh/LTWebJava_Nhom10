package com.haui.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Entity
@Table(name = "products")
@Getter
@Setter
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotEmpty(message = "- Không được để trống")
    @Size(min = 2, message = "- Tên phải có ít nhất 2 ký tự")
    private String name;

    @DecimalMin(value = "0", inclusive = false, message = "- lớn hơn 0")
    private double price;

    private String image;

    @NotEmpty(message = "- Không được để trống")
    @Column(columnDefinition = "MEDIUMTEXT")
    private String detailDesc;

    @NotEmpty(message = "- Không được để trống")
    private String shortDesc;

    private long sold;

    @NotBlank
    private String factory;

    @NotEmpty
    private String category;

    private Integer pin;
    private String screenType;
    private Double screenSize;
    private String operatingSystem;
    private long view;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<ProConfiguration> productVariants;
}