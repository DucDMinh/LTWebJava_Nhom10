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
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

@Component
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserService userService;

    @Autowired
    private EmailService emailService;

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication)
            throws IOException, ServletException {

        Object principal = authentication.getPrincipal();
        User user = null;

        // LOGIN FORM
        if (principal instanceof org.springframework.security.core.userdetails.User userDetails) {
            user = userService.getUserByUsername(userDetails.getUsername());
        }

        // LOGIN GOOGLE OAUTH2
        else if (principal instanceof org.springframework.security.oauth2.core.user.DefaultOAuth2User oauthUser) {
            String email = oauthUser.getAttribute("email");
            user = userService.getUserByEmail(email);
        }

        // SET SESSION + SEND EMAIL
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("avatar", user.getAvatar());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("id", user.getId());
            session.setAttribute("role", user.getRole().getName());

            emailService.sendLoginSuccessEmail(user.getEmail(), user.getFullName());
        }

        // REDIRECT SAU LOGIN
        String targetUrl = determineTargetUrl(authentication);
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    // CHỌN TRANG REDIRECT THEO ROLE
    protected String determineTargetUrl(final Authentication authentication) {

        Map<String, String> map = new HashMap<>();
        map.put("ROLE_USER", "/home");
        map.put("ROLE_ADMIN", "/admin");
        map.put("ROLE_STAFF", "/admin");

        for (GrantedAuthority authority : authentication.getAuthorities()) {
            String role = authority.getAuthority().trim();
            if (map.containsKey(role)) {
                return map.get(role);
            }
        }

        return "/home";
    }
}
