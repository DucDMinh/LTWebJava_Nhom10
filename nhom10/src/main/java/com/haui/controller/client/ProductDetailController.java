package com.haui.controller.client;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.haui.model.Product;
import com.haui.service.ProductService;

@Controller
public class ProductDetailController {

	@Autowired
	private ProductService productService;

	@GetMapping("/product/{id}")
	public String getProductDetailPage(Model model, @PathVariable long id) {
		Optional<Product> products = this.productService.fetchProductById(id);
		model.addAttribute("product", products.get());
		return "client/product-detail";
	}
}
