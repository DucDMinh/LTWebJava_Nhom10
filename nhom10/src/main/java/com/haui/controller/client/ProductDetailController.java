package com.haui.controller.client;

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
		Product product = this.productService.fetchProductById(id).get();
		this.productService.handleIncreaseView(id);
		model.addAttribute("product", product);
		model.addAttribute("id", id);
		return "client/product-detail";
	}
}
