package com.haui.controller.client;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	@PostMapping("/add-to-cart")
	public String addToCart(@RequestParam("variantId") long variantId,
			@RequestParam("quantity") long quantity,
			HttpServletRequest request, RedirectAttributes redirectAttributes) {
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
		redirectAttributes.addFlashAttribute("successMessage", "Đã thêm sản phẩm vào giỏ hàng thành công!");
		return "redirect:/home";
	}

	@PostMapping("/delete-cart-product/{id}")
	public String deleteCartDetail(@PathVariable long id, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		long cartDetailId = id;
		this.cartService.handleRemoveCartDetail(cartDetailId, session);
		return "redirect:/cart";
	}

	@PostMapping("/checkout")
	public String getCheckOutPage(@ModelAttribute("cart") Cart cart, Model model, Principal principal) {

		User currentUser = new User();
		if (principal != null) {
			currentUser = this.userService.getUserByUsername(principal.getName());
		}

		List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();
		double totalPrice = 0;
		List<CartDetail> selectedItems = new ArrayList<>();

		for (CartDetail cd : cartDetails) {
			if (cd.getId() != 0) {
				CartDetail currentCartDetail = this.cartService.getCartDetailById(cd.getId());
				if (currentCartDetail != null) {
					currentCartDetail.setQuantity(cd.getQuantity());
					totalPrice += currentCartDetail.getPrice() * currentCartDetail.getQuantity();
					selectedItems.add(currentCartDetail);
				}
			}
		}

		model.addAttribute("cartDetails", selectedItems);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("user", currentUser);
		model.addAttribute("cart", new Cart());

		return "client/checkout";
	}

}