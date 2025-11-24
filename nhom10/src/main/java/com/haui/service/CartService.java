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

    public CartDetail getCartDetailById(long id) {
        Optional<CartDetail> cd = this.cartDetailRepository.findById(id);
        if (cd.isPresent()) {
            return cd.get();
        }
        return null;
    }

    @Transactional
    public void handleAddProductToCart(String email, long variantId, long quantity, HttpSession session) {

        User user = this.userService.getUserByEmail(email);
        if (user == null) {
            System.out.println("LỖI: Không tìm thấy User với email: " + email);
            return;
        }

        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null) {
            Cart newCart = new Cart();
            newCart.setUser(user);
            newCart.setSum(0);
            cart = this.cartRepository.save(newCart);
        } else {

        }
        Optional<ProConfiguration> variantOpt = this.proConfigurationRepository.findById(variantId);
        if (variantOpt.isEmpty()) {
            System.out.println("LỖI: Không tìm thấy Variant ID =" + variantId);
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
            CartDetail cd = new CartDetail();
            cd.setCart(cart);
            cd.setProConfiguration(currentVariant);
            cd.setPrice(currentVariant.getPrice());
            cd.setQuantity(quantity);
            this.cartDetailRepository.save(cd);
            int s = cart.getSum() + 1;
            cart.setSum(s);
            this.cartRepository.save(cart);
            session.setAttribute("sum", s);
        } else {
            long newQuantity = oldDetail.getQuantity() + quantity;
            if (currentVariant.getQuantity() < newQuantity) {
                return;
            }

            oldDetail.setQuantity(newQuantity);

            this.cartDetailRepository.save(oldDetail);
        }
    }

    @Transactional
    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);

        if (cartDetailOptional.isEmpty()) {
            return;
        }

        CartDetail cartDetailToRemove = cartDetailOptional.get();
        Cart currentCart = cartDetailToRemove.getCart();
        currentCart.getCartDetails().remove(cartDetailToRemove);

        if (currentCart.getCartDetails().isEmpty()) {
            this.cartRepository.delete(currentCart);
            session.setAttribute("sum", 0);
        } else {
            this.cartRepository.save(currentCart);
            session.setAttribute("sum", currentCart.getCartDetails().size());
        }
    }
}