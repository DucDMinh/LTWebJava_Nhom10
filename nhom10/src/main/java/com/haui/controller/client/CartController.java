package com.haui.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.haui.model.Cart;
import com.haui.model.CartDetail;
import com.haui.model.User;
import com.haui.service.CartService;
import com.haui.service.ProductService;
import com.haui.service.UserService;

import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {

	@Autowired
	private CartService cartService;

	@Autowired
	private UserService userService;

	@Autowired
	private ProductService productService;

	@GetMapping("/cart")
	public String getCartPage(Model model, HttpServletRequest request) {
		User currentUser = new User();
		HttpSession session = request.getSession(false);

		int id = (int) session.getAttribute("id");
		currentUser.setId(id);

		Cart cart = this.productService.fetchByUser(currentUser);

		List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

		double totalPrice = 0;
		for (CartDetail cd : cartDetails) {
			totalPrice += cd.getPrice() * cd.getQuantity();
		}
		model.addAttribute("cart", cart);
		model.addAttribute("cartDetails", cartDetails);
		model.addAttribute("totalPrice", totalPrice);
		return "client/cart";
	}

	@PostMapping("/cart/add-to-cart")
	public String addToCart(@RequestParam("variantId") long variantId,
			@RequestParam("quantity") long quantity,
			HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		String currentUsername = request.getRemoteUser();
		if (currentUsername == null) {
			return "redirect:/login";
		}
		User currentUser = this.userService.getUserByUsername(currentUsername);
		if (currentUser == null) {
			return "redirect:/login";
		}
		String email = currentUser.getEmail();
		this.cartService.handleAddProductToCart(email, variantId, quantity, session);
		return "redirect:/home";
	}
}