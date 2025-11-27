package com.haui.repository;

import com.haui.model.OrderProduct;
import com.haui.model.OrderProductKey;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderProductRepository extends JpaRepository<OrderProduct, OrderProductKey> {
    @Query("SELECT SUM(od.quantity) FROM OrderProduct od JOIN od.order o WHERE o.status = 'COMPLETED'")
    Long sumTotalProductsSold();
}
