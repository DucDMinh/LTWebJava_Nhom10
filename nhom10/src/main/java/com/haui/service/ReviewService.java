package com.haui.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.haui.model.Product;
import com.haui.model.Review;
import com.haui.model.User;
import com.haui.repository.ProductRepository;
import com.haui.repository.ReviewRepository;
import com.haui.repository.UserRepository;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepo;

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private ProductRepository productRepo;

    public void saveReview(Review review) {
        review.setStatus("PENDING");
        reviewRepo.save(review);
    }

    public List<Review> getApprovedReviews(Integer productId) {
        List<Review> list = reviewRepo.findApprovedReviewByProductId(productId);

        // join thủ công thêm tên + avatar
        for (Review r : list) {
            User u = userRepo.findById(r.getUserId()).orElse(null);
            if (u != null) {
                r.setFullName(u.getFullName());
                r.setAvatar(u.getAvatar());
            }
        }
        return list;
    }

    public List<Review> getPendingReviews() {
        return reviewRepo.findByStatus("PENDING");
    }

    public Page<Review> getAllReviewsWithDetails(String status, String search, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Review> reviewsPage;
        
        if (status != null && !status.isEmpty() && !status.equals("ALL")) {
            reviewsPage = reviewRepo.findByStatusOrderByCreatedAtDesc(status, pageable);
        } else {
            reviewsPage = reviewRepo.findAllByOrderByCreatedAtDesc(pageable);
        }
        
        // Join thủ công thêm thông tin user và product
        for (Review r : reviewsPage.getContent()) {
            User u = userRepo.findById(r.getUserId()).orElse(null);
            if (u != null) {
                r.setFullName(u.getFullName());
                r.setAvatar(u.getAvatar());
            }
        }
        
        // Note: Search filtering should be implemented at repository level for better performance
        // For now, basic search can be done client-side or implement custom repository query
        
        return reviewsPage;
    }

    public Optional<Review> getReviewById(Integer id) {
        Optional<Review> reviewOpt = reviewRepo.findById(id);
        if (reviewOpt.isPresent()) {
            Review r = reviewOpt.get();
            User u = userRepo.findById(r.getUserId()).orElse(null);
            if (u != null) {
                r.setFullName(u.getFullName());
                r.setAvatar(u.getAvatar());
            }
        }
        return reviewOpt;
    }

    public void approve(Integer id) {
        Review r = reviewRepo.findById(id).orElse(null);
        if (r != null) {
            r.setStatus("APPROVED");
            reviewRepo.save(r);
        }
    }

    public void reject(Integer id) {
        Review r = reviewRepo.findById(id).orElse(null);
        if (r != null) {
            r.setStatus("REJECTED");
            reviewRepo.save(r);
        }
    }

    public void delete(Integer id) {
        reviewRepo.deleteById(id);
    }
}
