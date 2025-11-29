package com.haui.controller;

import com.haui.model.CartDetail;
import com.haui.model.Order;
import com.haui.model.OrderProduct;
import com.haui.repository.OrderRepository;
import com.haui.service.JasperReportService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class ReportController {
    @Autowired
    private JasperReportService reportService;

    @Autowired
    private OrderRepository orderRepository;

    @GetMapping("/report/order/{id}")
    public void exportOrder(@PathVariable("id") long id, HttpServletResponse response) throws Exception {
        Order order = orderRepository.findById(id).get();
        if (order != null) {
            List<OrderProduct> orserProducts = order.getOrderProducts();
            byte[] pdfBytes = reportService.generateOrderReport(order, orserProducts);
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=order_" + id + ".pdf");
            response.getOutputStream().write(pdfBytes);
        }
    }
}
