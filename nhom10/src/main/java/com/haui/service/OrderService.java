package com.haui.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.haui.model.Order;
import com.haui.model.OrderProduct;
import com.haui.repository.OrderProductRepository;
import com.haui.repository.OrderRepository;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderProductRepository orderProductRepository;

    @Transactional
    public void saveOrder(Order order, List<OrderProduct> orderProducts) {
        Order savedOrder = this.orderRepository.save(order);
        for (OrderProduct op : orderProducts) {
            op.setOrder(savedOrder);
            this.orderProductRepository.save(op);
        }
    }

    public List<Order> getAllProduct() {
        return this.orderRepository.findAll();
    }

    public Order getOrderById(Long id) {
        return this.orderRepository.findById(id).orElse(null);
    }

}