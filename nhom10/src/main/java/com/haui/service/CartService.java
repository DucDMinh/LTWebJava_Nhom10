package com.haui.service;

import java.util.Optional;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.haui.model.Cart;
import com.haui.model.CartDetail;
import com.haui.model.ProConfiguration;
import com.haui.model.User;
import com.haui.repository.CartDetailRepository;
import com.haui.repository.CartRepository;
import com.haui.repository.ProConfigurationRepository;
import jakarta.servlet.http.HttpSession;

@Service
public class CartService {

    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final ProConfigurationRepository proConfigurationRepository;

    public CartService(CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, UserService userService,
            ProConfigurationRepository proConfigurationRepository) {
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.proConfigurationRepository = proConfigurationRepository;
    }

    @Transactional
    public void handleAddProductToCart(String email, long variantId, long quantity, HttpSession session) {
        System.out.println("---- START ADD TO CART ----");
        System.out.println("Input: Email=" + email + ", VariantID=" + variantId + ", Quantity=" + quantity);
        User user = this.userService.getUserByEmail(email);
        if (user == null) {
            System.out.println("LỖI: Không tìm thấy User với email: " + email);
            return;
        }
        System.out.println("User found: ID=" + user.getId());
        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null) {
            System.out.println("User chưa có Cart -> Đang tạo mới...");
            Cart newCart = new Cart();
            newCart.setUser(user);
            newCart.setSum(0);
            cart = this.cartRepository.save(newCart);
            System.out.println("Tạo Cart thành công. Cart ID=" + cart.getId());
        } else {
            System.out.println("User đã có Cart. Cart ID=" + cart.getId());
        }
        Optional<ProConfiguration> variantOpt = this.proConfigurationRepository.findById(variantId);
        if (variantOpt.isEmpty()) {
            System.out.println("LỖI: Không tìm thấy Variant ID=" + variantId);
            return;
        }

        ProConfiguration currentVariant = variantOpt.get();
        System.out.println(
                "Variant found: " + currentVariant.getId() + " | Stock hiện tại: " + currentVariant.getQuantity());
        if (currentVariant.getQuantity() < quantity) {
            System.out.println(
                    "LỖI: Tồn kho không đủ! (Yêu cầu: " + quantity + ", Kho: " + currentVariant.getQuantity() + ")");
            return;
        }

        CartDetail oldDetail = this.cartDetailRepository.findByCartAndProConfiguration(cart, currentVariant);

        if (oldDetail == null) {
            System.out.println("Sản phẩm chưa có trong giỏ -> INSERT mới...");
            CartDetail cd = new CartDetail();
            cd.setCart(cart);
            cd.setProConfiguration(currentVariant);
            cd.setPrice(currentVariant.getPrice());
            cd.setQuantity(quantity);
            this.cartDetailRepository.save(cd);
            System.out.println("Đã lưu CartDetail mới.");
            int s = cart.getSum() + 1;
            cart.setSum(s);
            this.cartRepository.save(cart);
            session.setAttribute("sum", s);
        } else {
            System.out.println("Sản phẩm đã có trong giỏ -> UPDATE số lượng...");
            long newQuantity = oldDetail.getQuantity() + quantity;
            if (currentVariant.getQuantity() < newQuantity) {
                System.out.println("LỖI: Tổng số lượng vượt quá tồn kho!");
                return;
            }

            oldDetail.setQuantity(newQuantity);

            this.cartDetailRepository.save(oldDetail);
            System.out.println("Đã cập nhật CartDetail. Số lượng mới: " + newQuantity);
        }

        System.out.println("---- END ADD TO CART (SUCCESS) ----");
    }
}