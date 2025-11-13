package com.haui.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
        @Bean
        public ViewResolver viewResolver() {
                final InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
                viewResolver.setViewClass(JstlView.class);
                viewResolver.setPrefix("/WEB-INF/view/");
                viewResolver.setSuffix(".jsp");
                return viewResolver;
        }

        @Override
        public void addResourceHandlers(ResourceHandlerRegistry registry) {
                // Serve static resources from client directory
                registry.addResourceHandler("/client/**")
                                .addResourceLocations("/WEB-INF/resources/client/");

                // Serve static resources from admin directory
                registry.addResourceHandler("/admin/**")
                                .addResourceLocations("/WEB-INF/resources/admin/");
                registry.addResourceHandler("/images/**").addResourceLocations("/resources/images/");
        }

}
