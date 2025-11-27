package com.haui.model;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "orders")
@Data
@NoArgsConstructor
public class Order implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "total_price")
    private Double totalPrice;

    @Column(name = "total_product")
    @NonNull
    private Integer quantity;

    @Column
    private String status;

    @Column(name = "address", length = 500)
    private String address;

    @Column(name = "payment_ref", length = 50)
    @NonNull
    private String paymentRef;

    @Column(name = "payment_status", length = 50)
    @NonNull
    private String paymentStatus;

    @Column(name = "payment_method", length = 50)
    @NonNull
    private String paymentMethod;

    private Date orderDate;

    @OneToMany(mappedBy = "order")
    private List<OrderProduct> orderProducts;

    @PrePersist
    public void onCreate() {
        this.orderDate = new Date();
    }
}
