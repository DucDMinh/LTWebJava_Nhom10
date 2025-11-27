package com.haui.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    private final UserService userService;

    public CustomUserDetailsService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String usernameOrEmail) throws UsernameNotFoundException {
        // Tìm user theo username trước
        com.haui.model.User user = userService.getUserByUsername(usernameOrEmail);

        // Nếu không có thì tìm theo email
        if (user == null) {
            user = userService.getUserByEmail(usernameOrEmail);
        }

        if (user == null) {
            throw new UsernameNotFoundException("User not found: " + usernameOrEmail);
        }

        // Lấy role từ DB
        String roleName = user.getRole().getName().toString();

        return org.springframework.security.core.userdetails.User
                .withUsername(user.getUsername())
                .password(user.getPassword())
                .roles(roleName)
                .build();
    }
}