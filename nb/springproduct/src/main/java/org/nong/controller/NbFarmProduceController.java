package org.nong.controller;

import org.nong.common.PageQuery;
import org.nong.common.Result;
import org.nong.entity.NbFarmProduce;
import org.nong.service.INbFarmProduceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 农产品Controller
 */
@RestController
@RequestMapping("/api/yjnb/produce")
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class NbFarmProduceController {
    
    @Autowired
    private INbFarmProduceService produceService;
    
    /**
     * 查询农产品列表
     */
    @GetMapping("/list")
    public Result<NbFarmProduce> list(PageQuery pageQuery,
                                      @RequestParam(required = false) String title,
                                      @RequestParam(required = false) String catgory,
                                      @RequestParam(required = false) String providerName,
                                      @RequestParam(required = false) Integer pushStatus,
                                      @RequestParam(required = false) Integer recommend) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("offset", pageQuery.getOffset());
            params.put("pageSize", pageQuery.getPageSize());
            params.put("title", title);
            params.put("catgory", catgory);
            params.put("providerName", providerName);
            params.put("pushStatus", pushStatus);
            params.put("recommend", recommend);
            
            return produceService.selectList(params);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    /**
     * 根据ID查询
     */
    @GetMapping("/{id}")
    public Result<NbFarmProduce> getById(@PathVariable String id) {
        try {
            NbFarmProduce produce = produceService.selectById(id);
            return Result.success(produce);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    /**
     * 新增
     */
    @PostMapping
    public Result<Void> add(@RequestBody NbFarmProduce produce) {
        try {
            produceService.insert(produce);
            return Result.success("新增成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("新增失败：" + e.getMessage());
        }
    }
    
    /**
     * 修改
     */
    @PutMapping
    public Result<Void> update(@RequestBody NbFarmProduce produce) {
        try {
            produceService.update(produce);
            return Result.success("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("修改失败：" + e.getMessage());
        }
    }
    
    /**
     * 删除
     */
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable String id) {
        try {
            produceService.deleteById(id);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
    
    /**
     * 批量删除
     */
    @DeleteMapping("/batch")
    public Result<Void> deleteBatch(@RequestBody String[] ids) {
        try {
            produceService.deleteBatch(ids);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
}

