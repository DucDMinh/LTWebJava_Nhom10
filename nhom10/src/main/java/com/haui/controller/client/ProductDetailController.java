package com.haui.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product-detail")
public class ProductDetailController {
	@GetMapping()
	public String productDetailPage() {
		return "client/product-detail";
	}
}
