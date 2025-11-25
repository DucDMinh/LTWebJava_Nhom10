package com.haui.controller.client;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

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
import com.haui.model.Order;
import com.haui.model.OrderProduct;
import com.haui.model.OrderProductKey;
import com.haui.model.Product;
import com.haui.model.User;
import com.haui.service.CartDetailService;
import com.haui.service.CartService;
import com.haui.service.OrderService;
import com.haui.service.ProductService;
import com.haui.service.UserService;
import com.haui.service.VNPayService;

import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {

	@Autowired
	private CartService cartService;

	@Autowired
	private CartDetailService cartDetailService;

	@Autowired
	private UserService userService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ProductService productService;

	@Autowired
	private VNPayService vnpayService;

	@GetMapping("/cart")
	public String getCartPage(Model model, HttpServletRequest request) {
		User currentUser = new User();
		HttpSession session = request.getSession(false);

		Object idObj = session.getAttribute("id");
		if (idObj != null) {
			Long id = Long.valueOf(idObj.toString());
			currentUser.setId(id);
		}
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

	@PostMapping("/place-order")
	public String handlePlaceOrder(
			HttpServletRequest request,
			@ModelAttribute("cart") Cart cart,
			@RequestParam("paymentMethod") String paymentMethod,
			@RequestParam("shippingMethod") String shippingMethod,
			@RequestParam("note") String note,
			Principal principal) throws UnsupportedEncodingException {

		if (principal == null)
			return "redirect:/login";

		User currentUser = this.userService.getUserByUsername(principal.getName());
		if (currentUser == null)
			return "redirect:/login";

		double shippingFee = switch (shippingMethod) {
			case "FAST" -> 22000;
			case "EXPRESS" -> 33000;
			default -> 11000;
		};

		List<CartDetail> formCartDetails = cart.getCartDetails();
		List<OrderProduct> orderProducts = new ArrayList<>();
		double totalItemPrice = 0;
		int totalQuantity = 0;

		if (formCartDetails != null) {
			for (CartDetail cd : formCartDetails) {
				if (cd.getId() > 0) {
					CartDetail dbCd = cartDetailService.getCartDetailById(cd.getId());
					if (dbCd != null) {
						Product product = dbCd.getProConfiguration().getProduct();

						OrderProduct op = new OrderProduct();
						op.setProduct(product);
						op.setPrice(dbCd.getPrice());
						op.setQuantity((int) cd.getQuantity());

						OrderProductKey key = new OrderProductKey();
						key.setProductId(product.getId());
						op.setOrderProductKey(key);

						orderProducts.add(op);

						totalItemPrice += dbCd.getPrice() * cd.getQuantity();
						totalQuantity += cd.getQuantity();

						cartDetailService.handleRemoveCartDetail(dbCd.getId(), request.getSession());
					}
				}
			}
		}

		// ====== TẠO ORDER ======
		Order order = new Order();
		order.setUser(currentUser);
		order.setAddress(currentUser.getAddress());
		order.setQuantity(totalQuantity);
		order.setTotalPrice(totalItemPrice + shippingFee);
		order.setStatus("PENDING");

		// Lưu trước khi redirect
		this.orderService.saveOrder(order, orderProducts);

		// ====== THANH TOÁN ONLINE ======
		if ("VNPAY".equals(paymentMethod)) {

			String paymentRef = "VN_" + System.currentTimeMillis();
			order.setPaymentMethod("VNPAY");
			order.setPaymentStatus("PENDING");
			order.setPaymentRef(paymentRef);
			orderService.updateOrder(order);

			String ip = vnpayService.getIpAddress(request);
			String vnpUrl = vnpayService.generateVNPayURL(order.getTotalPrice(), paymentRef, ip);

			return "redirect:" + vnpUrl;
		} else {
			order.setPaymentMethod("COD");
			order.setPaymentStatus("PENDING");
		}

		// COD
		order.setPaymentStatus("UNKNOWN");
		order.setPaymentRef("COD_" + System.currentTimeMillis());
		orderService.updateOrder(order);

		return "redirect:/thank-you";
	}

	@GetMapping("/thank-you")
	public String getThankYouPage(
			@RequestParam("vnp_ResponseCode") Optional<String> vnpayResponse,
			@RequestParam("vnp_TxnRef") Optional<String> paymentRef) {

		if (vnpayResponse.isPresent() && paymentRef.isPresent()) {

			Order order = orderService.getOrderByPaymentRef(paymentRef.get());
			if (order != null) {
				if ("00".equals(vnpayResponse.get())) {
					order.setPaymentStatus("PAID");
					order.setStatus("SUCCESS");
				} else {
					order.setPaymentStatus("FAILED");
					order.setStatus("CANCELLED");
				}
				orderService.updateOrder(order);
			}
		}

		return "client/thank-you";
	}
}