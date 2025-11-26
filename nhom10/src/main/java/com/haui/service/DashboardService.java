package com.haui.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.haui.model.Product;
import com.haui.repository.OrderRepository;
import com.haui.repository.ProductRepository;

@Service
public class DashboardService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private OrderRepository orderRepository;

    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();

        stats.put("mostViewedProducts", productRepository.findTop10ByOrderByViewDesc());
        stats.put("bestSellingProducts", productRepository.findTop10ByOrderBySoldDesc());

        stats.put("totalOrders", orderRepository.count());
        stats.put("totalRevenue", orderRepository.sumTotalRevenue() != null ? orderRepository.sumTotalRevenue() : 0.0);
        Long totalProd = orderRepository.sumTotalProducts();
        stats.put("totalProductsSold", totalProd != null ? totalProd : 0);
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

        List<Object[]> orderData = orderRepository.getOrderTrend();
        List<Long> chartOrders = new ArrayList<>();
        for (Object[] row : orderData) {
            if (row[1] != null)
                chartOrders.add(((Number) row[1]).longValue());
            else
                chartOrders.add(0L);
        }
        stats.put("chartOrders", chartOrders);

        List<Object[]> soldData = orderRepository.getProductSoldTrend();
        List<Long> chartSold = new ArrayList<>();
        for (Object[] row : soldData) {
            if (row[1] != null)
                chartSold.add(((Number) row[1]).longValue());
            else
                chartSold.add(0L);
        }
        stats.put("chartSold", chartSold);
        List<Product> bestSellers = productRepository.findTop10ByOrderBySoldDesc();
        List<String> bestSellerLabels = new ArrayList<>();
        List<Long> bestSellerData = new ArrayList<>();

        int limit = Math.min(bestSellers.size(), 5);
        for (int i = 0; i < limit; i++) {
            Product p = bestSellers.get(i);
            bestSellerLabels.add(p.getName());
            bestSellerData.add(p.getSold());
        }

        stats.put("bestSellerLabels", bestSellerLabels);
        stats.put("bestSellerData", bestSellerData);

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
