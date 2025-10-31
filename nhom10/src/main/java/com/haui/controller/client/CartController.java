package com.haui.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class CartController {
	@GetMapping("carts")
	public String getCart() {
		return "client/cart";
	}
	
	@GetMapping("payments")
	public String getPayment() {
		return "client/payment";
	}
}
