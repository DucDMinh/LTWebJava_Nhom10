package com.haui.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.haui.model.Cart;
import com.haui.model.CartDetail;
import com.haui.model.Order;
import com.haui.model.OrderProduct;
import com.haui.model.OrderProductKey;
import com.haui.model.ProConfiguration;
import com.haui.model.Product;
import com.haui.model.User;
import com.haui.repository.CartDetailRepository;
import com.haui.repository.CartRepository;
import com.haui.repository.OrderProductRepository;
import com.haui.repository.OrderRepository;
import com.haui.repository.ProductRepository;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class ProductService {

    @Autowired
    private CartDetailRepository cartDetailRepository;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderProductRepository orderProductRepository;

    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public Page<Product> fetchAllProducts(Pageable pageable) {
        return productRepository.findAll(pageable);
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

    public void handleIncreaseView(long productId) {
        Optional<Product> productOpt = this.productRepository.findById(productId);
        if (productOpt.isPresent()) {
            Product product = productOpt.get();
            long currentView = product.getView();
            product.setView(currentView + 1);
            this.productRepository.save(product);
        }
    }

    @Transactional
    public void updateProductSold(Order order) {
        for (OrderProduct detail : order.getOrderProducts()) {
            Product product = detail.getProduct();

            if (product != null) {
                long currentSold = product.getSold();
                long quantitySold = detail.getQuantity();

                product.setSold(currentSold + quantitySold);
                productRepository.save(product);
            }
        }
    }

}
