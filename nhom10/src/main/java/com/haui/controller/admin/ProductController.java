package com.haui.controller.admin;

import java.io.File;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.haui.model.Product;
import com.haui.service.ProductService;
import com.haui.service.UploadService;

import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequestMapping("/admin/product")
public class ProductController {

    private final ProductService productService;
    private final UploadService uploadService;
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    public ProductController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping
    public String getProductPage(Model model) {
        List<Product> products = this.productService.getAllProduct();
        model.addAttribute("products", products);
        return "admin/product/show";
    }

    @GetMapping("/create")
    public String getMethodName(Model model) {
        Product product = new Product();
        Random rand = new Random();
        double randomDouble = rand.nextDouble() * 1000;

        // name 5 ký tự
        StringBuilder sbName = new StringBuilder();
        for (int i = 0; i < 5; i++) {
            sbName.append(CHARACTERS.charAt(rand.nextInt(CHARACTERS.length())));
        }
        String name = "Laptop " + sbName;

        // detailDesc 100 ký tự
        StringBuilder sbDetail = new StringBuilder();
        for (int i = 0; i < 100; i++) {
            sbDetail.append(CHARACTERS.charAt(rand.nextInt(CHARACTERS.length())));
        }
        String detailDesc = sbDetail.toString();

        // shortDesc 5 ký tự
        StringBuilder sbShort = new StringBuilder();
        for (int i = 0; i < 10; i++) {
            sbShort.append(CHARACTERS.charAt(rand.nextInt(CHARACTERS.length())));
        }
        String shortDesc = sbShort.toString();

        long quantity = rand.nextLong(300);
        double price = Math.round(randomDouble * 1000.0) / 100.0;

        product.setName(name);
        product.setPrice(price);
        product.setDetailDesc(detailDesc);
        product.setShortDesc(shortDesc);
        product.setQuantity(quantity);

        model.addAttribute("newProduct", product);
        return "admin/product/create";
    }

    @PostMapping("/creates")
    public String postMethodName(Model model, @ModelAttribute("newProduct") @Valid Product laptop,
            BindingResult bindingResult, @RequestParam("daominhducFile") MultipartFile file) {
        if (bindingResult.hasErrors()) {
            // trả model và bindingResult về view
            return "admin/product/create";
        }
        String picture = this.uploadService.handleSaveUploadProductPicture(file, "product");
        laptop.setImage(picture);
        this.productService.handleSaveProduct(laptop);
        return "redirect:/admin/product";
    }

    @RequestMapping("/detail-{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Optional<Product> products = this.productService.fetchProductById(id);
        model.addAttribute("product", products.get());
        return "admin/product/detail";
    }

    @GetMapping("/delete-{id}")
    public String getDeleteProductPage(Model model, @PathVariable long id) {
        model.addAttribute("delete", new Product());
        return "admin/product/delete";
    }

    @PostMapping("/delete")
    public String postDeleteProductPage(Model model, @ModelAttribute("delete") Product deleteProduct) {
        Optional<Product> currentProduct = this.productService.fetchProductById(deleteProduct.getId());
        File file = new File("E:\\My New Project\\laptopshop\\src\\main\\webapp\\resources\\images\\product\\"
                + currentProduct.get().getImage());
        if (currentProduct != null) {
            file.delete();
            this.productService.handleDeleteProduct(deleteProduct.getId());
        }
        return "redirect:/admin/product";
    }

    @RequestMapping("/update-{id}")
    public String getProductUpdatePage(Model model, @PathVariable long id) {
        Optional<Product> product = this.productService.fetchProductById(id);
        model.addAttribute("update", product);
        return "admin/product/update";
    }

    @PostMapping("/update")
    public String postUserUpdatePage(
            Model model,
            @ModelAttribute("update") @Valid Product updateProduct,
            BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "admin/product/update";
        }

        Optional<Product> productOpt = this.productService.fetchProductById(updateProduct.getId());

        if (productOpt.isPresent()) {
            Product currentProduct = productOpt.get();
            currentProduct.setName(updateProduct.getName());
            currentProduct.setPrice(updateProduct.getPrice());
            currentProduct.setDetailDesc(updateProduct.getDetailDesc());
            currentProduct.setShortDesc(updateProduct.getShortDesc());
            currentProduct.setFactory(updateProduct.getFactory());
            currentProduct.setCategory(updateProduct.getCategory());
            productService.handleSaveProduct(currentProduct);

        } else {
            return "error/404";
        }
        return "redirect:/admin/product";
    }
}
