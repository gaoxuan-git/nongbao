package org.nong.controller;

import org.nong.common.PageQuery;
import org.nong.common.Result;
import org.nong.entity.NbVideoCourse;
import org.nong.service.INbVideoCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/yjnb/videoCourse")
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class NbVideoCourseController {
    
    @Autowired
    private INbVideoCourseService courseService;
    
    @GetMapping("/list")
    public Result<NbVideoCourse> list(PageQuery pageQuery,
                                      @RequestParam(required = false) String title,
                                      @RequestParam(required = false) String teacher,
                                      @RequestParam(required = false) String category,
                                      @RequestParam(required = false) Integer publishStatus,
                                      @RequestParam(required = false) Integer recommend) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("offset", pageQuery.getOffset());
            params.put("pageSize", pageQuery.getPageSize());
            params.put("title", title);
            params.put("teacher", teacher);
            params.put("category", category);
            params.put("publishStatus", publishStatus);
            params.put("recommend", recommend);
            return courseService.selectList(params);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    @GetMapping("/{id}")
    public Result<NbVideoCourse> getById(@PathVariable String id) {
        try {
            return Result.success(courseService.selectById(id));
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    @PostMapping
    public Result<Void> add(@RequestBody NbVideoCourse course) {
        try {
            courseService.insert(course);
            return Result.success("新增成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("新增失败：" + e.getMessage());
        }
    }
    
    @PutMapping
    public Result<Void> update(@RequestBody NbVideoCourse course) {
        try {
            courseService.update(course);
            return Result.success("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("修改失败：" + e.getMessage());
        }
    }
    
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable String id) {
        try {
            courseService.deleteById(id);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
    
    @DeleteMapping("/batch")
    public Result<Void> deleteBatch(@RequestBody String[] ids) {
        try {
            courseService.deleteBatch(ids);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
}

