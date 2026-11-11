package org.nong.controller;

import org.nong.common.PageQuery;
import org.nong.common.Result;
import org.nong.entity.NbAdvertisement;
import org.nong.service.INbAdvertisementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/yjnb/advertisement")
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class NbAdvertisementController {
    
    @Autowired
    private INbAdvertisementService adService;
    
    @GetMapping("/list")
    public Result<NbAdvertisement> list(PageQuery pageQuery,
                                        @RequestParam(required = false) String title,
                                        @RequestParam(required = false) String position,
                                        @RequestParam(required = false) Integer status) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("offset", pageQuery.getOffset());
            params.put("pageSize", pageQuery.getPageSize());
            params.put("title", title);
            params.put("position", position);
            params.put("status", status);
            return adService.selectList(params);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    @GetMapping("/{id}")
    public Result<NbAdvertisement> getById(@PathVariable String id) {
        try {
            return Result.success(adService.selectById(id));
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    @PostMapping
    public Result<Void> add(@RequestBody NbAdvertisement ad) {
        try {
            adService.insert(ad);
            return Result.success("新增成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("新增失败：" + e.getMessage());
        }
    }
    
    @PutMapping
    public Result<Void> update(@RequestBody NbAdvertisement ad) {
        try {
            adService.update(ad);
            return Result.success("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("修改失败：" + e.getMessage());
        }
    }
    
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable String id) {
        try {
            adService.deleteById(id);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
    
    @DeleteMapping("/batch")
    public Result<Void> deleteBatch(@RequestBody String[] ids) {
        try {
            adService.deleteBatch(ids);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
}

