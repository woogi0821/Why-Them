package com.whythem.shop.config;

import com.whythem.shop.common.DevLoginInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private DevLoginInterceptor devLoginInterceptor;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**").addResourceLocations("/css/");
        registry.addResourceHandler("/js/**").addResourceLocations("/js/");
        registry.addResourceHandler("/images/**").addResourceLocations("/images/");
        String desktopPath = "C:/Users/khuser/Desktop/images/";

        registry.addResourceHandler("/upload/**")
                .addResourceLocations("file:///C:/Users/khuser/Desktop/images/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(devLoginInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/member/join",
                        "/member/login",
                        "/member/idCheck",
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/upload/**",   // [중요] 이미지 경로를 인터셉터 제외 대상에 추가
                        "/favicon.ico",
                        "/error"

                );
    }
}