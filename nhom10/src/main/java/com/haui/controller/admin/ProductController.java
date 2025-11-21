package com.haui.controller.admin;

import java.util.ArrayList;
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
    public String getProductPage(Model model) {
        List<Product> products = this.productService.getAllProduct();
        model.addAttribute("products", products);
        return "admin/product/show";
    }

    @GetMapping("/create")
    public String createProductPage(Model model) {
        Random rand = new Random();
        String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

        // 1. Khởi tạo Product (Cha)
        Product product = new Product();

        // --- Random thông tin chung ---
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

        // Giá hiển thị (Base price)
        double randomPrice = Math.round(rand.nextDouble() * 1000 * 100.0) / 100.0;
        product.setPrice(randomPrice);

        product.setFactory("Dell"); // Ví dụ
        product.setCategory("Gaming"); // Ví dụ

        // --- Set thông số cố định (Mới chuyển về Product) ---
        product.setPin(rand.nextInt(2000) + 3000); // 3000 - 5000 mAh
        product.setScreenSize(15.6);
        product.setScreenType("IPS LCD");

        // 2. Khởi tạo Variant mặc định (Con)
        ProConfiguration defaultVariant = new ProConfiguration();

        // --- Random thông tin cấu hình ---
        String[] colors = { "Black", "Silver", "Blue", "Red" };
        defaultVariant.setColor(colors[rand.nextInt(colors.length)]);

        int[] rams = { 8, 16, 32 };
        defaultVariant.setRam(rams[rand.nextInt(rams.length)]);

        // Số lượng tồn kho (Chuyển từ Product sang đây)
        defaultVariant.setQuantity(rand.nextLong(300));

        // Giá của cấu hình này (thường bằng hoặc cao hơn giá base)
        defaultVariant.setPrice(randomPrice);

        // Quan trọng: Link ngược lại Product (nếu cần thiết cho logic save sau này)
        defaultVariant.setProduct(product);

        // 3. Gán Variant vào Product list
        // (Để bên view có thể dùng th:field="*{productVariants[0].color}")
        List<ProConfiguration> variants = new ArrayList<>();
        variants.add(defaultVariant);
        product.setProductVariants(variants);

        model.addAttribute("newProduct", product);
        return "admin/product/create";
    }

    @PostMapping("/create")
    public String createProductPage(Model model,
            @ModelAttribute("newProduct") @Valid Product product,
            BindingResult bindingResult,
            @RequestParam("daominhducFile") MultipartFile file) {

        // ... validate bindingResult ...

        // XỬ LÝ UPLOAD
        if (!file.isEmpty()) {
            // Gọi hàm service, truyền file và tên thư mục "product"
            String fileName = this.uploadService.handleSaveUploadProductPicture(file, "product");
            product.setImage(fileName);
        }

        this.productService.handleSaveProduct(product);
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
        // 1. Lấy thông tin sản phẩm từ DB
        Optional<Product> currentProductOpt = this.productService.fetchProductById(deleteProduct.getId());

        if (currentProductOpt.isPresent()) {
            Product product = currentProductOpt.get();

            // 2. Xóa ảnh cũ (nếu có)
            // Gọi hàm service, truyền tên ảnh và tên thư mục "product"
            this.uploadService.handleDeleteFile(product.getImage(), "product");

            // 3. Xóa dữ liệu trong DB
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

        // 1. Validate dữ liệu
        if (bindingResult.hasErrors()) {
            return "admin/product/update";
        }

        // 2. Fetch sản phẩm cũ từ DB
        Optional<Product> productOpt = this.productService.fetchProductById(productFromForm.getId());

        if (productOpt.isPresent()) {
            Product currentProduct = productOpt.get();

            // --- A. Cập nhật thông tin chung ---
            currentProduct.setName(productFromForm.getName());
            currentProduct.setPrice(productFromForm.getPrice());
            currentProduct.setDetailDesc(productFromForm.getDetailDesc());
            currentProduct.setShortDesc(productFromForm.getShortDesc());
            currentProduct.setFactory(productFromForm.getFactory());
            currentProduct.setCategory(productFromForm.getCategory());

            // Cập nhật thông số kỹ thuật
            currentProduct.setPin(productFromForm.getPin());
            currentProduct.setScreenSize(productFromForm.getScreenSize());
            currentProduct.setScreenType(productFromForm.getScreenType());

            // --- B. Xử lý ảnh ---
            if (!file.isEmpty()) {
                this.uploadService.handleDeleteFile(currentProduct.getImage(), "product");
                String img = this.uploadService.handleSaveUploadProductPicture(file, "product");
                currentProduct.setImage(img);
            }
            // Nếu file rỗng thì giữ nguyên ảnh cũ (currentProduct.image không bị thay đổi)

            // --- C. Xử lý Variants (Quan trọng) ---
            if (productFromForm.getProductVariants() != null) {
                // Duyệt qua danh sách variant được gửi từ form lên
                for (ProConfiguration variant : productFromForm.getProductVariants()) {
                    // Gán ngược lại cha cho con (để cột product_id không bị null)
                    variant.setProduct(currentProduct);
                }

                // Ghi đè danh sách mới vào.
                // Hibernate sẽ tự động:
                // 1. Update các dòng có ID trùng.
                // 2. Insert các dòng không có ID (dòng mới thêm).
                // 3. Delete các dòng bị thiếu (nếu orphanRemoval=true trong Entity).
                currentProduct.setProductVariants(productFromForm.getProductVariants());
            } else {
                // Trường hợp xóa hết sạch variants
                currentProduct.getProductVariants().clear();
            }

            // 3. Lưu xuống DB
            this.productService.handleSaveProduct(currentProduct);
        }

        return "redirect:/admin/product";
    }
}
