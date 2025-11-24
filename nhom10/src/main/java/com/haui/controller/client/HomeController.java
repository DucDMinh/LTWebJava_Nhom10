package com.haui.controller.client;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.haui.dto.UserDto;
import com.haui.model.Product;
import com.haui.model.User;
import com.haui.service.ProductService;
import com.haui.service.RoleService;
import com.haui.service.UserService;
import com.haui.service.VNPayService;

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
	private ProductService productService;

	@Autowired
	private VNPayService vnpayService;

	@GetMapping()
	public String homePage(Model model) {
		List<Product> products = this.productService.getAllProduct();
		model.addAttribute("products", products);
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
		return "redirect:/client/home/signin";
	}

	@GetMapping("/wishlist")
	public String wishlist(Model model) {
		;
		return "client/wishlist";
	}

	@GetMapping("/checkout/success")
	public String checkoutSuccess(Model model) {

		return "client/checkout-success";
	}

	@PostMapping("/checkout")
	public String checkout(@RequestParam("paymentMethod") String paymentType,
			HttpServletRequest request,
			@RequestParam("totalPrice") String totalPrice) throws UnsupportedEncodingException {
		HttpSession session = request.getSession();
		User currentUser = new User();
		long id = (long) session.getAttribute("id");
		currentUser.setId(id);
		final String uuid = UUID.randomUUID().toString().replace("-", "");
		// this.productService.handlePlaceOrder(currentUser, session,
		// paymentType, uuid);
		if (!paymentType.equals("COD")) {
			String ip = vnpayService.getIpAddress(request);
			String vnpUrl = this.vnpayService.generateVNPayURL(Double.parseDouble(totalPrice), uuid, ip);
			return "redirect:" + vnpUrl;
		}
		return "redirect:/home/checkout/success";
	}

}
