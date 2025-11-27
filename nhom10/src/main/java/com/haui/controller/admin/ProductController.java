package com.haui.controller.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.haui.model.ProConfiguration;
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

    public ProductController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping
    public String getProductPage(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // Nếu param không phải số, giữ mặc định là 1
        }
        Pageable pageable = PageRequest.of(page - 1, 7);
        Page<Product> productsPage = this.productService.fetchAllProducts(pageable);
        List<Product> products = productsPage.getContent();
        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productsPage.getTotalPages());
        return "admin/product/show";
    }

    @GetMapping("/create")
    public String createProductPage(Model model) {
        Random rand = new Random();
        String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

        Product product = new Product();

        StringBuilder sbName = new StringBuilder();
        for (int i = 0; i < 5; i++) {
            sbName.append(CHARACTERS.charAt(rand.nextInt(CHARACTERS.length())));
        }
        product.setName("Laptop " + sbName.toString());

        StringBuilder sbDetail = new StringBuilder();
        for (int i = 0; i < 100; i++) {
            sbDetail.append(CHARACTERS.charAt(rand.nextInt(CHARACTERS.length())));
        }
        product.setDetailDesc(sbDetail.toString());

        StringBuilder sbShort = new StringBuilder();
        for (int i = 0; i < 10; i++) {
            sbShort.append(CHARACTERS.charAt(rand.nextInt(CHARACTERS.length())));
        }
        product.setShortDesc(sbShort.toString());

        double randomPrice = Math.round(rand.nextDouble() * 1000 * 100.0) / 100.0;
        product.setPrice(randomPrice);

        product.setFactory("Dell");
        product.setCategory("Gaming");

        product.setPin(rand.nextInt(2000) + 3000);
        product.setScreenSize(15.6);
        product.setScreenType("IPS LCD");
        String[] operatingSystems = { "Windows", "Android", "iOS" };
        product.setOperatingSystem(operatingSystems[rand.nextInt(operatingSystems.length)]);

        ProConfiguration defaultVariant = new ProConfiguration();

        String[] colors = { "Black", "Silver", "Blue", "Red" };
        defaultVariant.setColor(colors[rand.nextInt(colors.length)]);

        int[] rams = { 8, 16, 32 };
        defaultVariant.setRam(rams[rand.nextInt(rams.length)]);

        int[] storages = { 64, 128, 256, 512 };
        defaultVariant.setStorage(storages[rand.nextInt(storages.length)]);

        defaultVariant.setQuantity(rand.nextLong(300));

        defaultVariant.setPrice(randomPrice);

        defaultVariant.setProduct(product);
        // List<ProConfiguration> variants = new ArrayList<>();
        // variants.add(defaultVariant);
        // product.setProductVariants(variants);
        Product product1 = new Product();
        model.addAttribute("newProduct", product1);
        return "admin/product/create";
    }

    @PostMapping("/create")
    public String createProductPage(Model model,
            @ModelAttribute("newProduct") @Valid Product product,
            BindingResult bindingResult,
            @RequestParam("daominhducFile") MultipartFile file) {
        if (!file.isEmpty()) {
            String fileName = this.uploadService.handleSaveUploadProductPicture(file, "product");
            product.setImage(fileName);
        }
        if (product.getProductVariants() != null) {
            for (ProConfiguration variant : product.getProductVariants()) {
                variant.setProduct(product);
                if (variant.getPrice() == null || variant.getPrice() == 0) {
                    variant.setPrice(product.getPrice());
                }
            }
        }

        this.productService.handleSaveProduct(product);
        return "redirect:/admin/product";
    }

    @RequestMapping("/detail/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Optional<Product> products = this.productService.fetchProductById(id);
        model.addAttribute("product", products.get());
        return "admin/product/detail";
    }

    @GetMapping("/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable long id) {
        model.addAttribute("delete", new Product());
        return "admin/product/delete";
    }

    @PostMapping("/delete")
    public String postDeleteProductPage(Model model, @ModelAttribute("delete") Product deleteProduct) {
        Optional<Product> currentProductOpt = this.productService.fetchProductById(deleteProduct.getId());

        if (currentProductOpt.isPresent()) {
            Product product = currentProductOpt.get();
            this.uploadService.handleDeleteFile(product.getImage(), "product");
            this.productService.handleDeleteProduct(product.getId());
        }

        return "redirect:/admin/product";
    }

    @GetMapping("/update/{id}")
    public String getProductUpdatePage(Model model, @PathVariable long id) {
        Optional<Product> product = this.productService.fetchProductById(id);
        if (product.isPresent()) {
            model.addAttribute("newProduct", product.get());
            return "admin/product/update";
        }
        return "redirect:/admin/product";
    }

    @PostMapping("/update")
    public String updateProduct(Model model,
            @ModelAttribute("newProduct") @Valid Product productFromForm,
            BindingResult bindingResult,
            @RequestParam("daominhducFile") MultipartFile file) {
        if (bindingResult.hasErrors()) {
            return "admin/product/update";
        }
        Optional<Product> productOpt = this.productService.fetchProductById(productFromForm.getId());

        if (productOpt.isPresent()) {
            Product currentProduct = productOpt.get();
            currentProduct.setName(productFromForm.getName());
            currentProduct.setPrice(productFromForm.getPrice());
            currentProduct.setDetailDesc(productFromForm.getDetailDesc());
            currentProduct.setShortDesc(productFromForm.getShortDesc());
            currentProduct.setFactory(productFromForm.getFactory());
            currentProduct.setCategory(productFromForm.getCategory());
            currentProduct.setPin(productFromForm.getPin());
            currentProduct.setScreenSize(productFromForm.getScreenSize());
            currentProduct.setScreenType(productFromForm.getScreenType());
            if (!file.isEmpty()) {
                this.uploadService.handleDeleteFile(currentProduct.getImage(), "product");
                String img = this.uploadService.handleSaveUploadProductPicture(file, "product");
                currentProduct.setImage(img);
            }
            if (productFromForm.getProductVariants() != null) {
                for (ProConfiguration variant : productFromForm.getProductVariants()) {
                    variant.setProduct(currentProduct);
                }
                currentProduct.setProductVariants(productFromForm.getProductVariants());
            } else {
                currentProduct.getProductVariants().clear();
            }
            this.productService.handleSaveProduct(currentProduct);
        }

        return "redirect:/admin/product";
    }
}
