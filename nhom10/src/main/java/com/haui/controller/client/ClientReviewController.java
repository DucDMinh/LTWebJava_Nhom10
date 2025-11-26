package com.haui.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.haui.model.Review;
import com.haui.service.ReviewService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/client/review")
public class ClientReviewController {

    @Autowired
    private ReviewService reviewService;

    @PostMapping("/add")
    public String addReview(
            @RequestParam Integer productId,
            @RequestParam Integer rating,
            @RequestParam("commentText") String comment,
            HttpSession session,
            RedirectAttributes redirect
    ) {
        // Check if user is logged in
        Integer userId = (Integer) session.getAttribute("id");
        if (userId == null) {
            redirect.addFlashAttribute("error", "Vui lòng đăng nhập để đánh giá sản phẩm!");
            return "redirect:/home/signin";
        }

        // Validation
        if (productId == null || productId <= 0) {
            redirect.addFlashAttribute("error", "Sản phẩm không hợp lệ!");
            return "redirect:/product/" + productId;
        }

        if (rating == null || rating < 1 || rating > 5) {
            redirect.addFlashAttribute("error", "Đánh giá phải từ 1 đến 5 sao!");
            return "redirect:/product/" + productId;
        }

        if (comment == null || comment.trim().length() < 10) {
            redirect.addFlashAttribute("error", "Bình luận phải có ít nhất 10 ký tự!");
            return "redirect:/product/" + productId;
        }

        if (comment.trim().length() > 1000) {
            redirect.addFlashAttribute("error", "Bình luận không được vượt quá 1000 ký tự!");
            return "redirect:/product/" + productId;
        }

        try {
            Review r = new Review();
            r.setProductId(productId);
            r.setUserId(userId);
            r.setRating(rating);
            r.setComment(comment.trim());

            reviewService.saveReview(r);

            redirect.addFlashAttribute("msg", "Cảm ơn bạn đã đánh giá! Bình luận của bạn đang chờ xét duyệt và sẽ được hiển thị sau khi được duyệt.");

        } catch (Exception e) {
            redirect.addFlashAttribute("error", "Có lỗi xảy ra khi gửi đánh giá. Vui lòng thử lại!");
            e.printStackTrace();
        }

        return "redirect:/product/" + productId;
    }
}
