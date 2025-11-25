package com.haui.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haui.model.Order;
import com.haui.model.OrderProduct;
import com.haui.service.OrderService;

@Controller
@RequestMapping("/admin/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping()
    public String getOrderPage(Model model) {
        List<Order> orders = this.orderService.getAllProduct();
        model.addAttribute("orders", orders);
        return "admin/order/show";
    }

    @GetMapping("/{id}")
    public String view(@PathVariable("id") Long id, Model model) {
        Order order = this.orderService.getOrderById(id);
        List<OrderProduct> orderProducts = order.getOrderProducts();
        model.addAttribute("order", order);
        model.addAttribute("orderProducts", orderProducts);
        return "admin/order/view";
    }

}
