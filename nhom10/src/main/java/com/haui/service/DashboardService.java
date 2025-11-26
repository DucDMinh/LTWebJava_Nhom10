package com.haui.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.haui.model.Product;
import com.haui.repository.OrderProductRepository;
import com.haui.repository.OrderRepository;
import com.haui.repository.ProductRepository;

@Service
public class DashboardService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private OrderProductRepository orderProductRepository;

    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();

        // 1. Sản phẩm xem nhiều & Mua nhiều
        stats.put("mostViewedProducts", productRepository.findTop10ByOrderByViewDesc());
        stats.put("bestSellingProducts", productRepository.findTop10ByOrderBySoldDesc());

        // 2. Các chỉ số tổng quan
        stats.put("totalOrders", orderRepository.count());
        stats.put("totalRevenue", orderRepository.sumTotalRevenue() != null ? orderRepository.sumTotalRevenue() : 0.0);
        stats.put("totalProductsSold",
                orderProductRepository.sumTotalProductsSold() != null ? orderProductRepository.sumTotalProductsSold()
                        : 0);
        List<Object[]> revenueData = orderRepository.getRevenueTrend();
        List<String> labels = new ArrayList<>();
        List<Double> data = new ArrayList<>();

        for (Object[] row : revenueData) {
            if (row[0] != null) {
                labels.add(row[0].toString());
            } else {
                labels.add("Unknown");
            }
            if (row[1] != null) {
                double val = ((Number) row[1]).doubleValue();
                data.add(val);
            } else {
                data.add(0.0);
            }
        }
        stats.put("chartLabels", labels);
        stats.put("chartData", data);

        return stats;
    }

    public void incrementViewCount(long productId) {
        Product p = productRepository.findById(productId).orElse(null);
        if (p != null) {
            p.setView(p.getView() + 1);
            productRepository.save(p);
        }
    }
}
