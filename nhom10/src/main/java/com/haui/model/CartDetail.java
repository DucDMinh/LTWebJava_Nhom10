package com.haui.model;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "cart_detail")
public class CartDetail implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private long quantity;

    private double price; // Giá tại thời điểm thêm vào giỏ

    // cart_id: long
    @ManyToOne
    @JoinColumn(name = "cart_id")
    private Cart cart;

    // --- QUAN TRỌNG: Link đến Cấu hình chi tiết thay vì Product chung ---
    @ManyToOne
    @JoinColumn(name = "pro_configuration_id")
    private ProConfiguration proConfiguration;

    // Getter & Setter
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public ProConfiguration getProConfiguration() {
        return proConfiguration;
    }

    public void setProConfiguration(ProConfiguration proConfiguration) {
        this.proConfiguration = proConfiguration;
    }

    // Helper để lấy thông tin Product cha khi cần hiển thị
    // public Product getProduct() {
    // return proConfiguration != null ? proConfiguration.getProduct() : null;
    // }
}