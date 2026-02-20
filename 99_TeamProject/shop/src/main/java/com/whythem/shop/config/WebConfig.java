package com.whythem.shop.config;

import com.whythem.shop.common.DevLoginInterceptor;
import com.whythem.shop.common.CartInterceptor; // ★ 추가됨
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private DevLoginInterceptor devLoginInterceptor;

    @Autowired
    private CartInterceptor cartInterceptor; // ★ 추가됨

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**").addResourceLocations("/css/");
        registry.addResourceHandler("/js/**").addResourceLocations("/js/");
        registry.addResourceHandler("/images/**").addResourceLocations("/images/");
        registry.addResourceHandler("/upload/**")
                .addResourceLocations("file:///C:/shop/upload/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        // 1. 개발모드 자동 로그인 인터셉터 (먼저 실행되어야 세션이 생김!)
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

        // 2. ★ 장바구니 숫자 카운트 인터셉터 (로그인 이후에 실행됨)
        registry.addInterceptor(cartInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/upload/**",
                        "/favicon.ico",
                        "/error"
                );
    }
}