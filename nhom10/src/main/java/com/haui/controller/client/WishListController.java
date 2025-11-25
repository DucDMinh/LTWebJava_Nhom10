package com.haui.controller.client;

import com.haui.model.Product;
import com.haui.model.User;
import com.haui.model.WishList;
import com.haui.service.ProductService;
import com.haui.service.UserService;
import com.haui.service.WishListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/wishlist")
public class WishListController {

    @Autowired
    private WishListService wishListService;

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @GetMapping
    public String viewWishList(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        User user = userService.findByUsername(userDetails.getUsername());
        List<WishList> wishlistItems = wishListService.getWishListByUser(user.getId());
        model.addAttribute("wishlistItems", wishlistItems);
        return "client/wishlist";
    }

    @PostMapping
    public String toggleWishList(@AuthenticationPrincipal UserDetails userDetails,
            @RequestParam("productId") Long productId) {
        User user = userService.findByUsername(userDetails.getUsername());
        Product product = productService.fetchProductById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        WishList wishItem = wishListService.findByUserAndProduct(user, product);

        if (wishItem != null) {

            wishListService.removeFromWishList(user.getId(), wishItem.getId());
        } else {

            wishListService.addToWishList(user, product);
        }

        return "redirect:/home";
    }

    @PostMapping("/remove")
    public String removeWishList(
            @RequestParam("wishId") Long wishId,
            @AuthenticationPrincipal UserDetails userDetails) {

        User user = userService.findByUsername(userDetails.getUsername());

        wishListService.removeFromWishList(user.getId(), wishId);

        return "redirect:/wishlist"; // load lại trang
    }
}
