package com.haui.config;

import com.haui.model.User;
import com.haui.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

@Component
public class CustomRememberMeSuccessHandler {
    @Autowired
    private UserService userService;

    public void onRememberMeLoginSuccess(HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication) {

        HttpSession session = request.getSession(true);
        String username = authentication.getName();
        User user = userService.getUserByUsername(username);
        if (user == null) {
            user = userService.getUserByEmail(username);
        }

        if (user != null) {
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("avatar", user.getAvatar());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("id", user.getId());
            session.setAttribute("role", user.getRole().getName().toString().trim());
        }
    }
}
