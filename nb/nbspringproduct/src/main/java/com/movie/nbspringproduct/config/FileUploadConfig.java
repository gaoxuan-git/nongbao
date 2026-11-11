package com.movie.nbspringproduct.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 文件上传配置
 */
@Configuration
public class FileUploadConfig implements WebMvcConfigurer {
    
    @Value("${file.upload.path:./uploads}")
    private String uploadPath;
    
    @Value("${file.access.prefix:/uploads}")
    private String accessPrefix;
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 配置静态资源访问路径
        registry.addResourceHandler(accessPrefix + "/**")
                .addResourceLocations("file:" + uploadPath + "/");
    }
}

