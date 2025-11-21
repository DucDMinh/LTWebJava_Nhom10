package com.haui.model;

import jakarta.persistence.*;
import lombok.*;
import java.io.Serializable;

@Entity
@Table(name = "pro_configuration")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProConfiguration implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "color")
    private String color;

    @Column(name = "ram", nullable = false)
    private Integer ram;

    @Column(name = "variant_price")
    private Double price;

    @Column(name = "quantity")
    private Long quantity;
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    public String getVariantName() {
        return (product != null ? product.getName() : "") + " " + ram + "GB - " + color;
    }
}