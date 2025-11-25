package com.haui.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.haui.model.Cart;
import com.haui.model.CartDetail;
import com.haui.repository.CartDetailRepository;
import com.haui.repository.CartRepository;

import jakarta.servlet.http.HttpSession;

@Service
public class CartDetailService {

    @Autowired
    public CartDetailRepository cartDetailRepository;

    @Autowired
    public CartRepository cartRepository;

    public CartDetail getCartDetailById(long id) {
        Optional<CartDetail> cartDetail = this.cartDetailRepository.findById(id);
        if (cartDetail.isPresent()) {
            return cartDetail.get();
        }
        return null;
    }

    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);

        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();
            Cart currentCart = cartDetail.getCart();
            this.cartDetailRepository.deleteById(cartDetailId);

            if (currentCart.getSum() > 0) {
                int s = currentCart.getSum() - 1;
                currentCart.setSum(s);
                this.cartRepository.save(currentCart);

                if (session != null) {
                    session.setAttribute("sum", s);
                }
            } else {
                currentCart.setSum(0);
                this.cartRepository.save(currentCart);
                if (session != null) {
                    session.setAttribute("sum", 0);
                }
            }
        }
    }
}
