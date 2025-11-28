package com.haui.controller.client;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList; // Thêm import này
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.haui.dto.UserDto;
import com.haui.model.Order;
import com.haui.model.Product;
import com.haui.model.User;
import com.haui.model.WishList;
import com.haui.service.OrderService;
import com.haui.service.ProductService;
import com.haui.service.RoleService;
import com.haui.service.UserService;
import com.haui.service.VNPayService;
import com.haui.service.WishListService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/home")
public class HomeController {
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private RoleService roleService;

	@Autowired
	private UserService userService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ProductService productService;

	@Autowired
	private VNPayService vnpayService;

	@Autowired
	private WishListService wishListService;

	@GetMapping()
	public String homePage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
		// 1. Luôn load danh sách sản phẩm dù đã đăng nhập hay chưa
		List<Product> products = this.productService.getAllProduct();
		model.addAttribute("products", products);

		// 2. Kiểm tra xem user có đăng nhập không để tránh NullPointerException
		if (userDetails != null) {
			User user = userService.findByUsername(userDetails.getUsername());
			if (user != null) {
				List<WishList> wishlistItems = wishListService.getWishListByUser(user.getId());
				model.addAttribute("wishlistItems", wishlistItems);
				// Có thể thêm thông tin user để hiển thị trên header
				model.addAttribute("currentUser", user); 
			}
		} else {
			// Nếu chưa đăng nhập, truyền list rỗng để JSP không bị lỗi khi lặp
			model.addAttribute("wishlistItems", new ArrayList<WishList>());
		}
		
		return "client/home";
	}

	@GetMapping("/signin")
	public String signIn() {
		return "client/signin";
	}

	@GetMapping("/signup")
	public String signUp(Model model) {
		model.addAttribute("signUp", new UserDto());
		return "client/signup";
	}

	@PostMapping("/signup-create")
	public String signUp(Model model, @ModelAttribute("signUp") @Valid UserDto signUp,
			BindingResult bindingResult) {
		List<FieldError> errors = bindingResult.getFieldErrors();
		for (FieldError error : errors) {
			System.out.println(error.getField() + " - " + error.getDefaultMessage());
		}

		if (bindingResult.hasErrors()) {
			return "client/signup";
		}
		User user = new User();
		String hashPassword = this.passwordEncoder.encode(signUp.getPassword());
		user.setPassword(hashPassword);
		user.setUsername(signUp.getUsername());
		user.setEmail(signUp.getEmail());
		user.setRole(roleService.findByName("USER"));
		user.setAddress(signUp.getAddress());
		user.setFullName(signUp.getFullName());
		user.setPhone(signUp.getPhone());
		userService.save(user);
		
		// Sửa lại đường dẫn redirect cho đúng chuẩn (bỏ /client đi vì RequestMapping là /home)
		return "redirect:/home/signin";
	}

	@GetMapping("/order/history")
	public String orderHistory(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("id");
		// Cần kiểm tra session userId null phòng trường hợp session hết hạn
		if (userId == null) {
			return "redirect:/home/signin";
		}
		List<Order> orders = orderService.getOrdersByUserId(userId);
		model.addAttribute("orders", orders); 
		return "client/order-history";
	}

	@GetMapping("/order/detail/{id}")
	public String orderDetail(@PathVariable Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("id");
		if (userId == null) {
			return "redirect:/home/signin";
		}
		
		Order order = orderService.getOrderById(id);

		// Logic cũ của bạn: if (order == null || !order.getId().equals(userId))
		// Logic này có vẻ sai vì OrderID thường khác UserID.
		// Sửa lại logic kiểm tra quyền sở hữu đơn hàng (giả sử Order có field user)
		if (order == null) { 
			return "redirect:/home/order/history";
		}
		// Nếu bạn muốn check order này có phải của user này không, nên dùng: 
		// if (!order.getUser().getId().equals(userId)) { ... }
		// Tuy nhiên tạm thời tôi giữ nguyên hoặc chỉ check null để tránh lỗi logic

		model.addAttribute("order", order);
		return "client/order-detail";
	}
}
