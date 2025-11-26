package com.haui.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.haui.model.Review;

public interface ReviewRepository extends JpaRepository<Review, Integer>{

    // Comment đã được duyệt
    @Query("SELECT r FROM Review r WHERE r.productId = :productId AND r.status = 'APPROVED' ORDER BY r.createdAt DESC")
    List<Review> findApprovedReviewByProductId(Integer productId);

    // Comment chờ duyệt
    List<Review> findByStatus(String status);
    
    // Lấy reviews theo status với phân trang
    Page<Review> findByStatusOrderByCreatedAtDesc(String status, Pageable pageable);
    
    // Lấy tất cả reviews với phân trang
    Page<Review> findAllByOrderByCreatedAtDesc(Pageable pageable);
}
