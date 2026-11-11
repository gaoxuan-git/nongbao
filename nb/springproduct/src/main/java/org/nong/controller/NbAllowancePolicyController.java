package org.nong.controller;

import org.nong.common.PageQuery;
import org.nong.common.Result;
import org.nong.entity.NbAllowancePolicy;
import org.nong.service.INbAllowancePolicyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/yjnb/policy")
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class NbAllowancePolicyController {
    
    @Autowired
    private INbAllowancePolicyService policyService;
    
    @GetMapping("/list")
    public Result<NbAllowancePolicy> list(PageQuery pageQuery,
                                          @RequestParam(required = false) String title,
                                          @RequestParam(required = false) String author,
                                          @RequestParam(required = false) Integer publishStatus,
                                          @RequestParam(required = false) Integer recommend) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("offset", pageQuery.getOffset());
            params.put("pageSize", pageQuery.getPageSize());
            params.put("title", title);
            params.put("author", author);
            params.put("publishStatus", publishStatus);
            params.put("recommend", recommend);
            return policyService.selectList(params);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    @GetMapping("/{id}")
    public Result<NbAllowancePolicy> getById(@PathVariable String id) {
        try {
            return Result.success(policyService.selectById(id));
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    @PostMapping
    public Result<Void> add(@RequestBody NbAllowancePolicy policy) {
        try {
            policyService.insert(policy);
            return Result.success("新增成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("新增失败：" + e.getMessage());
        }
    }
    
    @PutMapping
    public Result<Void> update(@RequestBody NbAllowancePolicy policy) {
        try {
            policyService.update(policy);
            return Result.success("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("修改失败：" + e.getMessage());
        }
    }
    
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable String id) {
        try {
            policyService.deleteById(id);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
    
    @DeleteMapping("/batch")
    public Result<Void> deleteBatch(@RequestBody String[] ids) {
        try {
            policyService.deleteBatch(ids);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
}

