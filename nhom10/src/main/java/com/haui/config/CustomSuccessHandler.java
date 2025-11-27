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

    // ============== Xác định trang đích sau login ====================
    protected String determineTargetUrl(final Authentication authentication) {

        Map<String, String> roleTargetUrlMap = new HashMap<>();
        roleTargetUrlMap.put("ROLE_USER", "/home");
        roleTargetUrlMap.put("ROLE_ADMIN", "/admin");
        roleTargetUrlMap.put("ROLE_STAFF", "/admin");

        for (GrantedAuthority auth : authentication.getAuthorities()) {
            String roleName = auth.getAuthority();
            if (roleTargetUrlMap.containsKey(roleName)) {
                return roleTargetUrlMap.get(roleName);
            }
        }
        return "/home"; // fallback
    }

    // ============== Set Session sau khi login ========================
    protected void setAuthenticationSession(HttpServletRequest request, Authentication authentication) {
        HttpSession session = request.getSession(); // LUÔN tạo session nếu chưa có

        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);

        String loginKey = authentication.getName();
        User user = userService.getUserByUsername(loginKey);

        if (user == null) {
            user = userService.getUserByEmail(loginKey);
        }

        if (user != null) {
            session.setAttribute("id", user.getId());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("role", user.getRole().getName().trim());

            // avatar mặc định nếu null
            String avatar = (user.getAvatar() != null && !user.getAvatar().isEmpty())
                    ? user.getAvatar()
                    : "/images/default-avatar.png";

            session.setAttribute("avatar", avatar);

            // gửi mail đăng nhập thành công
            emailService.sendLoginSuccessEmail(user.getEmail(), user.getFullName());
        }
    }

    // ============== Xử lý khi login thành công =======================
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        clearAuthenticationAttributes(request, authentication);

        // 2️⃣ Redirect sau
        String targetUrl = determineTargetUrl(authentication);
        if (!response.isCommitted()) {
            redirectStrategy.sendRedirect(request, response, targetUrl);

        if (!response.isCommitted()) {
            redirectStrategy.sendRedirect(request, response, targetUrl);
        }

    }
}
