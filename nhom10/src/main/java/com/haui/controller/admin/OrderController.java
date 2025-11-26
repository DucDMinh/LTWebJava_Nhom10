package com.haui.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.haui.model.Order;
import com.haui.model.OrderProduct;
import com.haui.service.OrderService;
import com.haui.service.ProductService;

@Controller
@RequestMapping("/admin/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private ProductService productService;

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

    @GetMapping("/updates/{id}")
    public String updateStatus(@PathVariable("id") Long id, Model model) {
        Order order = this.orderService.getOrderById(id);
        model.addAttribute("updateOrder", order);
        return "admin/order/update";
    }

    @PostMapping("/update")
    public String updateOrder(@ModelAttribute("updateOrder") Order newOrder, @RequestParam("status") String newStatus) {
        Order order = this.orderService.getOrderById(newOrder.getId());
        if ("COMPLETED".equals(newStatus) && !"COMPLETED".equals(order.getStatus())) {
            productService.updateProductSold(order);
        }
        order.setStatus(newOrder.getStatus());
        this.orderService.save(order);
        return "redirect:/admin/orders";
    }

    @GetMapping("/deletes/{id}")
    public String deleteOrder(@PathVariable("id") Long id) {
        this.orderService.deleteOrder(id);
        return "redirect:/admin/orders";
    }

}
