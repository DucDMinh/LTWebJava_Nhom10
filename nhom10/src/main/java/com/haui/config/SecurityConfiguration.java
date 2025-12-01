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
                                .authorizeHttpRequests(authorize -> authorize
                                                .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE)
                                                .permitAll()
                                                // Cho phép truy cập tài nguyên tĩnh và các trang public
                                                .requestMatchers(
                                                                "/home", "/home/**",
                                                                "/home/signin", "/home/signin/**",
                                                                "/signup/**",
                                                                "/client/**",
                                                                "/products/**",
                                                                "/css/**",
                                                                "/js/**",
                                                                "/images/**",
                                                                "/",
                                                                "/admin/css/**",
                                                                "/admin/assets/**",
                                                                "/admin/js/**",
                                                                "/admin/images/**")
                                                .permitAll()
                                                // --- THÊM MỚI: Cho phép API QR Code hoạt động không cần đăng nhập ---
                                                .requestMatchers("/api/qr/**").permitAll()
                                                // -------------------------------------------------------------------
                                                .requestMatchers("/admin/orders/**", "/admin/reviews/**", "/admin")
                                                .hasAnyRole("STAFF", "ADMIN")
                                                .requestMatchers("/admin/**").hasRole("ADMIN")
                                                .anyRequest().authenticated())
                                .oauth2Login(oauth2 -> oauth2
                                                .loginPage("/home/signin")
                                                .successHandler(customSuccessHandler())
                                                .failureUrl("/signin?error")
                                                .userInfoEndpoint(user -> user
                                                                .userService(new CustomOAuth2UserService(userService))))
                                .sessionManagement(session -> session
                                                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED))
                                .logout(logout -> logout
                                                .deleteCookies("JSESSIONID")
                                                .invalidateHttpSession(true))
                                .rememberMe(remember -> remember
                                                .rememberMeServices(rememberMeServices()))
                                .formLogin(formLogin -> formLogin
                                                .loginPage("/home/signin")
                                                .loginProcessingUrl("/home/signin")
                                                .failureUrl("/home/signin?error")
                                                .successHandler(customSuccessHandler())
                                                .permitAll())
                                .exceptionHandling(ex -> ex.accessDeniedPage("/error/403"));

                // --- THÊM MỚI: Tắt CSRF cho API QR scan để dễ dàng test từ Postman/External
                // ---
                http.csrf(csrf -> csrf.ignoringRequestMatchers("/api/qr/**"));

                return http.build();

        }

}