package com.haui.service.userinfo;

import com.haui.model.Role;
import com.haui.model.User;
import com.haui.service.UserService;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Map;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
    private final UserService userService;

    public CustomOAuth2UserService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);
        Map<String, Object> attributes = oAuth2User.getAttributes();

        Role userRole = this.userService.getRoleByName("USER");

        // GOOGLE
        String email = (String) attributes.get("email");
        String fullName = (String) attributes.get("name");

        User user = this.userService.getUserByEmail(email);
        if (user == null) {
            user = new User();
            user.setEmail(email);
            user.setFullName(fullName);
            user.setProvider("GOOGLE");
            user.setAvatar("default-google.png");
            user.setRole(userRole);
            this.userService.save(user);
        }

        return new DefaultOAuth2User(
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + userRole.getName())),
                oAuth2User.getAttributes(),
                "email");

    }

}
