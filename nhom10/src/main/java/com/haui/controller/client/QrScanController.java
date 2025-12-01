package com.haui.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.security.Principal;

@Controller
public class QrScanController {

    @GetMapping("/user/qr/accept")
    public String scan(@RequestParam("qrId") String qrId, Principal principal) {
        if (principal != null) {
            // Truy cập biến static bên kia
            if (QrCodeController.qrStore.containsKey(qrId)) {
                QrCodeController.qrStore.put(qrId, principal.getName());
                return "client/qr-success"; // Trả về trang báo thành công
            }
        }
        return "redirect:/home/signin";
    }
}