package com.haui.controller.client;

import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.GrantedAuthority;

import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@RestController
@RequestMapping("/api/qr")
public class QrCodeController {

    // Bộ nhớ tạm lưu trạng thái QR
    // Key: UUID, Value: Username (nếu đã quét) hoặc "PENDING"
    public static final Map<String, String> qrStore = new ConcurrentHashMap<>();

    private final UserDetailsService userDetailsService;

    public QrCodeController(UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    // Lấy mã UUID để tạo QR
    @GetMapping("/generate")
    public ResponseEntity<?> generateQr() {
        String uuid = UUID.randomUUID().toString();
        qrStore.put(uuid, "PENDING");
        return ResponseEntity.ok(Map.of("qrId", uuid));
    }

    // Hỏi liên tục xem đã quét chưa
    @GetMapping("/check/{qrId}")
    public ResponseEntity<?> checkStatus(@PathVariable String qrId, HttpSession session) {
        String username = qrStore.get(qrId);

        if (username == null)
            return ResponseEntity.notFound().build();

        if ("PENDING".equals(username)) {
            return ResponseEntity.ok(Map.of("status", "WAITING"));
        } else {
            // Thực hiện đăng nhập thủ công cho PC
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);
            UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(userDetails, null,
                    userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(authToken);
            session.setAttribute("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext());

            // LOGIC ĐIỀU HƯỚNG THEO ROLE
            String redirectUrl = "/home"; // Mặc định là trang chủ

            // Duyệt qua các quyền của user
            for (GrantedAuthority authority : userDetails.getAuthorities()) {
                String role = authority.getAuthority();
                // Kiểm tra nếu là ADMIN
                if (role.equals("ADMIN")) {
                    redirectUrl = "/admin";
                    break;
                }
            }

            // 3. Xóa mã QR và trả về URL
            qrStore.remove(qrId);
            return ResponseEntity.ok(Map.of("status", "SUCCESS", "redirectUrl", redirectUrl));
        }
    }

    // Gọi API này để xác nhận đăng nhập
    @PostMapping("/scan")
    public ResponseEntity<?> scanQr(@RequestBody Map<String, String> body) {
        String qrId = body.get("qrId");
        String username = body.get("username"); // Username người dùng muốn đăng nhập

        if (qrStore.containsKey(qrId)) {
            qrStore.put(qrId, username); // Gán user vào mã
            return ResponseEntity.ok("Đã xác nhận đăng nhập trên PC!");
        }
        return ResponseEntity.badRequest().body("Mã QR không tồn tại hoặc đã hết hạn");
    }

}