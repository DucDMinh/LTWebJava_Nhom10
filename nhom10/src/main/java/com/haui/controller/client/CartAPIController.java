package com.haui.controller.client;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.haui.service.CartDetailService;
import java.util.HashMap;
import java.util.Map;

@RestController
public class CartAPIController {

    @Autowired
    private CartDetailService cartDetailService;

    @PostMapping("/api/delete-cart-product/{id}")
    public ResponseEntity<Map<String, Object>> deleteCartProduct(@PathVariable long id, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

        try {
            HttpSession session = request.getSession(false);
            this.cartDetailService.handleRemoveCartDetail(id, session);

            response.put("status", "success");
            if (session != null) {
                response.put("newCartSum", session.getAttribute("sum"));
            } else {
                response.put("newCartSum", 0);
            }

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "error");
            response.put("message", e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
}
