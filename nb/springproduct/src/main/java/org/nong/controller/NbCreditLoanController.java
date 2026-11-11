package org.nong.controller;

import org.nong.common.PageQuery;
import org.nong.common.Result;
import org.nong.entity.NbCreditLoan;
import org.nong.service.INbCreditLoanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/yjnb/loan")
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class NbCreditLoanController {
    
    @Autowired
    private INbCreditLoanService loanService;
    
    @GetMapping("/list")
    public Result<NbCreditLoan> list(PageQuery pageQuery,
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
            return loanService.selectList(params);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    @GetMapping("/{id}")
    public Result<NbCreditLoan> getById(@PathVariable String id) {
        try {
            return Result.success(loanService.selectById(id));
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    @PostMapping
    public Result<Void> add(@RequestBody NbCreditLoan loan) {
        try {
            loanService.insert(loan);
            return Result.success("新增成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("新增失败：" + e.getMessage());
        }
    }
    
    @PutMapping
    public Result<Void> update(@RequestBody NbCreditLoan loan) {
        try {
            loanService.update(loan);
            return Result.success("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("修改失败：" + e.getMessage());
        }
    }
    
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable String id) {
        try {
            loanService.deleteById(id);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
    
    @DeleteMapping("/batch")
    public Result<Void> deleteBatch(@RequestBody String[] ids) {
        try {
            loanService.deleteBatch(ids);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
}

