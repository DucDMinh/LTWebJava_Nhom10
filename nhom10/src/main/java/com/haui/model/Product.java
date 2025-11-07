package com.haui.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "products")
@Getter
@Setter
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

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

    @Min(value = 1, message = "- Số lượng phải lớn hơn 0")
    private long quantity;

    private long sold;

    @NotBlank
    private String factory;

    @NotEmpty
    private String category;
}
