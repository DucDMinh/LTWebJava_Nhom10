package com.haui;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder; // 1. Import dòng này
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer; // 2. Import dòng này
@SpringBootApplication
public class Nhom10Application extends SpringBootServletInitializer{

	public static void main(String[] args) {
		SpringApplication.run(Nhom10Application.class, args);
	}
	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Nhom10Application.class);
    }
}
