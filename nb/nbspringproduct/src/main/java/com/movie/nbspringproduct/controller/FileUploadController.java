package com.movie.nbspringproduct.controller;

import com.movie.nbspringproduct.common.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 文件上传Controller
 */
@RestController
@RequestMapping("/dev-api/yjnb/upload")
public class FileUploadController {
    
    // 文件上传路径（可在 application.yml 中配置）
    @Value("${file.upload.path:./uploads}")
    private String uploadPath;
    
    // 文件访问路径前缀
    @Value("${file.access.prefix:/uploads}")
    private String accessPrefix;
    
    /**
     * 上传图片
     */
    @PostMapping("/image")
    public Result<Map<String, String>> uploadImage(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return Result.error("请选择要上传的文件");
        }
        
        try {
            // 获取原始文件名
            String originalFilename = file.getOriginalFilename();
            if (originalFilename == null) {
                return Result.error("文件名不能为空");
            }
            
            // 检查文件类型
            String contentType = file.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                return Result.error("只能上传图片文件");
            }
            
            // 获取文件扩展名
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            
            // 按日期创建子目录
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            String datePath = sdf.format(new Date());
            
            // 生成唯一文件名
            String fileName = UUID.randomUUID().toString().replace("-", "") + extension;
            
            // 完整的文件保存路径
            String fullPath = uploadPath + File.separator + datePath;
            File dir = new File(fullPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            // 保存文件
            Path filePath = Paths.get(fullPath, fileName);
            Files.write(filePath, file.getBytes());
            
            // 返回文件访问URL
            String fileUrl = accessPrefix + "/" + datePath.replace("\\", "/") + "/" + fileName;
            
            Map<String, String> result = new HashMap<>();
            result.put("url", fileUrl);
            result.put("fileName", originalFilename);
            result.put("fileSize", String.valueOf(file.getSize()));
            
            return Result.success(result);
            
        } catch (IOException e) {
            e.printStackTrace();
            return Result.error("文件上传失败：" + e.getMessage());
        }
    }
    
    /**
     * 批量上传图片
     */
    @PostMapping("/images")
    public Result<Map<String, Object>> uploadImages(@RequestParam("files") MultipartFile[] files) {
        if (files == null || files.length == 0) {
            return Result.error("请选择要上传的文件");
        }
        
        Map<String, Object> result = new HashMap<>();
        result.put("total", files.length);
        result.put("success", 0);
        result.put("failed", 0);
        
        for (MultipartFile file : files) {
            try {
                Result<Map<String, String>> uploadResult = uploadImage(file);
                if (uploadResult.getCode() == 200) {
                    result.put("success", (int) result.get("success") + 1);
                } else {
                    result.put("failed", (int) result.get("failed") + 1);
                }
            } catch (Exception e) {
                result.put("failed", (int) result.get("failed") + 1);
            }
        }
        
        return Result.success(result);
    }
}

