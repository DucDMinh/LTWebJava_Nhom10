package com.haui.config;

import com.haui.service.CustomUserDetailsService;
import com.haui.service.UserService;
import com.haui.service.userinfo.CustomOAuth2UserService;

import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;

@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfiguration {
        @Bean
        public PasswordEncoder passwordEncoder() {
                return new BCryptPasswordEncoder();
        }

        @Bean
        public UserDetailsService userDetailsService(UserService userService) {
                return new CustomUserDetailsService(userService);
        }

        @Bean
        public SpringSessionRememberMeServices rememberMeServices() {
                SpringSessionRememberMeServices rememberMeServices = new SpringSessionRememberMeServices();
                rememberMeServices.setAlwaysRemember(true);
                rememberMeServices.setValiditySeconds(7 * 24 * 60 * 60);
                return rememberMeServices;
        }

        @Bean
        public CustomSuccessHandler customSuccessHandler() {
                return new CustomSuccessHandler();
        }

        @Bean
        public DaoAuthenticationProvider authProvider(
                        PasswordEncoder passwordEncoder,
                        UserDetailsService userDetailsService) {

                DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
                authProvider.setUserDetailsService(userDetailsService);
                authProvider.setPasswordEncoder(passwordEncoder);
                authProvider.setHideUserNotFoundExceptions(false);

                return authProvider;
        }

        @Bean
        SecurityFilterChain filterChain(HttpSecurity http,
                        UserService userService,
                        CustomUserDetailsService customUserDetailsService,
                        CustomRememberMeSuccessHandler rememberMeSuccessHandler) throws Exception {

                http
                                // ✅ Cho phép tất cả request không cần xác thực
                                .authorizeHttpRequests(authorize -> authorize
                                                .anyRequest().permitAll())

                                // ⚙️ Nếu bạn không cần OAuth2 login lúc test => tắt đi cho gọn
                                // .oauth2Login(oauth2 -> oauth2
                                // .loginPage("/home/signin")
                                // .successHandler(customSuccessHandler())
                                // .failureUrl("/signin?error")
                                // .userInfoEndpoint(user -> user
                                // .userService(new CustomOAuth2UserService(userService))))

                                // ⚙️ Session vẫn giữ nguyên (để nhớ đăng nhập khi test có cần)
                                .sessionManagement(session -> session
                                                .sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
                                                .invalidSessionUrl("/signin?expired")
                                                .maximumSessions(1)
                                                .maxSessionsPreventsLogin(false))

                                // ⚙️ Logout config — giữ lại nếu sau này dùng
                                .logout(logout -> logout
                                                .deleteCookies("JSESSIONID")
                                                .invalidateHttpSession(true))

                                // ⚙️ Remember-me — giữ nguyên để không lỗi bean
                                .rememberMe(remember -> remember
                                                .rememberMeServices(rememberMeServices()))

                                // ⚙️ Form login — vô hiệu hoá login form vì ta cho phép tất cả
                                .formLogin(formLogin -> formLogin
                                                .disable())

                                // ⚙️ Nếu không muốn bị lỗi 403 khi test => có thể bỏ hẳn
                                .exceptionHandling(ex -> ex
                                                .accessDeniedPage("/error/403"))

                                // ⚙️ CSRF nên tắt khi test để tránh lỗi POST
                                .csrf(csrf -> csrf.disable());

                return http.build();
        }

}
