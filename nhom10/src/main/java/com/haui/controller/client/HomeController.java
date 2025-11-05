package com.haui.controller.client;

import java.util.List;

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

import com.haui.dto.UserDto;
import com.haui.model.User;
import com.haui.service.RoleService;
import com.haui.service.UserService;

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

	@GetMapping()
	public String homePage() {
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
}
