package com.haui.service;

import com.haui.model.Order;
import com.haui.model.OrderProduct;
import com.haui.repository.OrderRepository;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class JasperReportService {

    public byte[] generateOrderReport(Order order, List<OrderProduct> items) throws Exception {
        // Nạp file mẫu
        InputStream reportStream = new ClassPathResource("reports/order.jrxml").getInputStream();
        JasperReport jasperReport = JasperCompileManager.compileReport(reportStream);

        // Gán tham số đơn hàng
        Map<String, Object> params = new HashMap<>();
        params.put("orderId", "DH" + order.getId());
        params.put("customerName", order.getUser().getFullName());
        params.put("phone", order.getUser().getPhone());
        params.put("address", order.getAddress().toString());
        params.put("total", order.getTotalPrice());
        params.put("status", order.getStatus());

        // Dữ liệu chi tiết sản phẩm
        JRDataSource dataSource = new JRBeanCollectionDataSource(items);

        // Fill report (đổ dữ liệu vào mẫu)
        JasperPrint print = JasperFillManager.fillReport(jasperReport, params, dataSource);

        // Xuất ra PDF
        return JasperExportManager.exportReportToPdf(print);
    }
}
