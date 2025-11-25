package com.haui.model;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;

@Entity
@Table(name = "order_product")
@Getter
@Setter
@NoArgsConstructor
@RequiredArgsConstructor
public class OrderProduct implements Serializable {
    private static final long serialVersionUID = 1L;

    @EmbeddedId
    private OrderProductKey orderProductKey;

    @NonNull
    @Column
    private Integer quantity;

    @Column
    private Double price;

    @ManyToOne
    @MapsId("orderId")
    @JoinColumn(name = "order_id")
    private Order order;

    @ManyToOne
    @MapsId("productId")
    @JoinColumn(name = "product_id")
    private Product product;

}
