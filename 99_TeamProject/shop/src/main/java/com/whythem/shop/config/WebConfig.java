package com.whythem.shop.config;

import com.whythem.shop.common.DevLoginInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Autowired
    private DevLoginInterceptor devLoginInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(devLoginInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/resources/**", "/css/**", "/js/**");
    }
}
