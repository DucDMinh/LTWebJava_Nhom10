package com.haui.config;

import com.haui.model.User;
import com.haui.service.EmailService;
import com.haui.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class CustomSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserService userService;

    @Autowired
    private EmailService emailService;

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    // ============================================================
    // Xác định URL sau khi login theo role
    // ============================================================
    protected String determineTargetUrl(final Authentication authentication) {

        Map<String, String> roleTargetUrlMap = new HashMap<>();
        roleTargetUrlMap.put("ROLE_USER", "/home");
        roleTargetUrlMap.put("ROLE_ADMIN", "/admin");
        roleTargetUrlMap.put("ROLE_STAFF", "/admin");

        for (GrantedAuthority authority : authentication.getAuthorities()) {
            String roleName = authority.getAuthority();
            if (roleTargetUrlMap.containsKey(roleName)) {
                return roleTargetUrlMap.get(roleName);
            }
        }

        return "/home"; // fallback
    }

    // ============================================================
    // Xóa lỗi đăng nhập cũ trong session
    // ============================================================
    protected void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        }
    }

    // ============================================================
    // Lưu session sau khi login thành công
    // ============================================================
    protected void setAuthenticationSession(HttpServletRequest request, Authentication authentication) {

        HttpSession session = request.getSession(); // tự tạo session nếu chưa có

        String loginKey = authentication.getName(); // username/email
        User user = userService.getUserByUsername(loginKey);

        if (user == null) {
            user = userService.getUserByEmail(loginKey);
        }

        if (user != null) {
            session.setAttribute("id", user.getId());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("role", user.getRole().getName().trim());

            // Avatar mặc định
            String avatar = (user.getAvatar() != null && !user.getAvatar().isEmpty())
                    ? user.getAvatar()
                    : "/images/default-avatar.png";

            session.setAttribute("avatar", avatar);

            // Gửi email thông báo đăng nhập thành công
            emailService.sendLoginSuccessEmail(user.getEmail(), user.getFullName());
        }
    }

    // ============================================================
    // Xử lý khi đăng nhập thành công
    // ============================================================
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {

        // Xóa lỗi đăng nhập cũ
        clearAuthenticationAttributes(request);

        // Lưu các thông tin session
        setAuthenticationSession(request, authentication);

        // Xác định target
        String targetUrl = determineTargetUrl(authentication);

        // Redirect 1 lần duy nhất
        if (!response.isCommitted()) {
            redirectStrategy.sendRedirect(request, response, targetUrl);
        }
    }
}
