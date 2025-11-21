package com.haui.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.haui.model.Cart;
import com.haui.model.CartDetail;
import com.haui.model.ProConfiguration;
import com.haui.model.Product;
import com.haui.model.User;
import com.haui.repository.CartDetailRepository;
import com.haui.repository.CartRepository;
import com.haui.repository.ProductRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class ProductService {

    @Autowired
    private CartDetailRepository cartDetailRepository;

    @Autowired
    private CartRepository cartRepository;

    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public Product handleSaveProduct(Product laptop) {
        return this.productRepository.save(laptop);
    }

    public List<Product> getAllProduct() {
        return this.productRepository.findAll();
    }

    public Optional<Product> fetchProductById(long id) {
        return this.productRepository.findById(id);
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handleDeleteProduct(long id) {
        Optional<Product> productOpt = this.productRepository.findById(id);

        if (productOpt.isPresent()) {
            Product product = productOpt.get();
            if (product.getProductVariants() != null) {
                for (ProConfiguration variant : product.getProductVariants()) {
                    List<CartDetail> cartItems = this.cartDetailRepository.findByProConfiguration(variant);
                    if (cartItems != null && !cartItems.isEmpty()) {
                        this.cartDetailRepository.deleteAll(cartItems);
                    }
                }
            }
            this.productRepository.deleteById(id);
        }
    }
}
