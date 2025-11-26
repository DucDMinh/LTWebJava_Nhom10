package com.haui.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.haui.model.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    Optional<Order> findByPaymentRef(String paymentRef);

    long count();

    @Query("SELECT SUM(o.totalPrice) FROM Order o WHERE o.status = 'COMPLETED'")
    Double sumTotalRevenue();

    @Query(value = "SELECT DATE(order_date) as date, SUM(total_price) as revenue " +
            "FROM orders " +
            "WHERE status = 'COMPLETED' " +
            "GROUP BY DATE(order_date) " +
            "ORDER BY DATE(order_date) ASC", nativeQuery = true)
    List<Object[]> getRevenueTrend();

    @Query(value = "SELECT DATE(order_date) as date, COUNT(*) as count " +
            "FROM orders " +
            "WHERE status = 'COMPLETED' " +
            "GROUP BY DATE(order_date) " +
            "ORDER BY DATE(order_date) ASC", nativeQuery = true)
    List<Object[]> getOrderTrend();

    // --- THÊM MỚI 2: Số lượng sản phẩm bán ra theo ngày ---
    @Query(value = "SELECT DATE(order_date) as date, SUM(total_product) as sold " +
            "FROM orders " +
            "WHERE status = 'COMPLETED' " +
            "GROUP BY DATE(order_date) " +
            "ORDER BY DATE(order_date) ASC", nativeQuery = true)
    List<Object[]> getProductSoldTrend();

    @Query("SELECT SUM(o.quantity) FROM Order o WHERE o.status = 'COMPLETED'")
    Long sumTotalProducts();
}
