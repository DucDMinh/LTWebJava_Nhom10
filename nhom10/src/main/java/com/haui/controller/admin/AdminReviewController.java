package com.haui.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.haui.model.Review;
import com.haui.service.ReviewService;

@Controller
@RequestMapping("/admin/reviews")
public class AdminReviewController {

    @Autowired
    private ReviewService reviewService;

    @GetMapping
    public String listReviews(
            Model model,
            @RequestParam(defaultValue = "ALL") String status,
            @RequestParam(required = false) String search,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        
        Page<Review> reviewsPage = reviewService.getAllReviewsWithDetails(status, search, page, size);
        
        model.addAttribute("reviews", reviewsPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", reviewsPage.getTotalPages());
        model.addAttribute("totalItems", reviewsPage.getTotalElements());
        model.addAttribute("statusFilter", status);
        model.addAttribute("search", search);
        model.addAttribute("size", size);
        
        return "admin/review/review-list";
    }

    @GetMapping("/{id}")
    public String viewDetail(@PathVariable Integer id, Model model) {
        model.addAttribute("review", reviewService.getReviewById(id).orElse(null));
        return "admin/review/detail";
    }

    @PostMapping("/approve")
    public String approve(@RequestParam Integer id,
                         @RequestParam(defaultValue = "ALL") String status,
                         @RequestParam(required = false) String search,
                         @RequestParam(defaultValue = "0") int page) {
        reviewService.approve(id);
        return "redirect:/admin/reviews?status=" + status + 
               (search != null ? "&search=" + search : "") + 
               "&page=" + page;
    }

    @PostMapping("/reject")
    public String reject(@RequestParam Integer id,
                        @RequestParam(defaultValue = "ALL") String status,
                        @RequestParam(required = false) String search,
                        @RequestParam(defaultValue = "0") int page) {
        reviewService.reject(id);
        return "redirect:/admin/reviews?status=" + status + 
               (search != null ? "&search=" + search : "") + 
               "&page=" + page;
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Integer id,
                        @RequestParam(defaultValue = "ALL") String status,
                        @RequestParam(required = false) String search,
                        @RequestParam(defaultValue = "0") int page) {
        reviewService.delete(id);
        return "redirect:/admin/reviews?status=" + status + 
               (search != null ? "&search=" + search : "") + 
               "&page=" + page;
    }
}
