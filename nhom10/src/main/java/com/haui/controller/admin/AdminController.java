package com.haui.controller.admin;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.haui.service.DashboardService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private DashboardService dashboardService;

	@GetMapping("")
	public String getDashboard(Model model) throws JsonProcessingException {
		Map<String, Object> stats = dashboardService.getDashboardStats();
		model.addAttribute("countRevenue", stats.get("totalRevenue"));
		model.addAttribute("countOrders", stats.get("totalOrders"));
		model.addAttribute("countSold", stats.get("totalProductsSold"));
		model.addAttribute("mostViewedProducts", stats.get("mostViewedProducts"));
		model.addAttribute("bestSellers", stats.get("bestSellingProducts"));
		ObjectMapper mapper = new ObjectMapper();
		String chartLabelsJson = mapper.writeValueAsString(stats.get("chartLabels"));
		String chartDataJson = mapper.writeValueAsString(stats.get("chartData"));
		String chartOrdersJson = mapper.writeValueAsString(stats.get("chartOrders"));
		String chartSoldJson = mapper.writeValueAsString(stats.get("chartSold"));

		model.addAttribute("chartOrdersJson", chartOrdersJson);
		model.addAttribute("chartSoldJson", chartSoldJson);
		model.addAttribute("chartLabelsJson", chartLabelsJson);
		model.addAttribute("chartDataJson", chartDataJson);

		return "admin/index";
	}
}
