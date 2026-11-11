package org.nong.controller;

import org.nong.common.PageQuery;
import org.nong.common.Result;
import org.nong.entity.SysConfig;
import org.nong.entity.SysRole;
import org.nong.entity.SysUser;
import org.nong.service.ISysConfigService;
import org.nong.service.ISysRoleService;
import org.nong.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 系统管理Controller
 */
@RestController
@RequestMapping("/api/system")
@CrossOrigin(originPatterns = "*", allowCredentials = "true")
public class SystemManagementController {
    
    @Autowired
    private ISysUserService userService;
    
    @Autowired
    private ISysRoleService roleService;
    
    @Autowired
    private ISysConfigService configService;
    
    /**
     * 测试接口
     */
    @GetMapping("/test")
    public Result<String> test() {
        return Result.success("SSM系统管理接口正常");
    }
    
    /**
     * 查询用户列表
     */
    @GetMapping("/user/list")
    public Result<SysUser> getUserList(PageQuery pageQuery,
                                       @RequestParam(required = false) String username,
                                       @RequestParam(required = false) String nickname,
                                       @RequestParam(required = false) String phonenumber,
                                       @RequestParam(required = false) Integer status) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("offset", pageQuery.getOffset());
            params.put("pageSize", pageQuery.getPageSize());
            params.put("username", username);
            params.put("nickname", nickname);
            params.put("phonenumber", phonenumber);
            params.put("status", status);
            
            return userService.selectList(params);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    /**
     * 根据ID查询用户
     */
    @GetMapping("/user/{id}")
    public Result<SysUser> getUserById(@PathVariable String id) {
        try {
            SysUser user = userService.selectById(id);
            return Result.success(user);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    /**
     * 新增用户
     */
    @PostMapping("/user")
    public Result<Void> addUser(@RequestBody SysUser user) {
        try {
            // 检查用户名是否已存在
            SysUser existUser = userService.selectByUsername(user.getUsername());
            if (existUser != null) {
                return Result.error("用户名已存在");
            }
            
            userService.insert(user);
            return Result.success("新增成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("新增失败：" + e.getMessage());
        }
    }
    
    /**
     * 修改用户
     */
    @PutMapping("/user")
    public Result<Void> updateUser(@RequestBody SysUser user) {
        try {
            userService.update(user);
            return Result.success("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("修改失败：" + e.getMessage());
        }
    }
    
    /**
     * 删除用户
     */
    @DeleteMapping("/user/{id}")
    public Result<Void> deleteUser(@PathVariable String id) {
        try {
            userService.deleteById(id);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
    
    /**
     * 重置密码
     */
    @PutMapping("/user/resetPassword/{id}")
    public Result<Void> resetPassword(@PathVariable String id) {
        try {
            // 默认密码：123456
            userService.resetPassword(id, "123456");
            return Result.success("密码重置成功，默认密码：123456");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("密码重置失败：" + e.getMessage());
        }
    }
    
    // ==================== 角色管理 ====================
    
    /**
     * 查询角色列表
     */
    @GetMapping("/role/list")
    public Result<SysRole> getRoleList(PageQuery pageQuery,
                                       @RequestParam(required = false) String roleName,
                                       @RequestParam(required = false) String roleKey,
                                       @RequestParam(required = false) Integer status) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("offset", pageQuery.getOffset());
            params.put("pageSize", pageQuery.getPageSize());
            params.put("roleName", roleName);
            params.put("roleKey", roleKey);
            params.put("status", status);
            return roleService.selectList(params);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    /**
     * 根据ID查询角色
     */
    @GetMapping("/role/{id}")
    public Result<SysRole> getRoleById(@PathVariable String id) {
        try {
            return Result.success(roleService.selectById(id));
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    /**
     * 新增角色
     */
    @PostMapping("/role")
    public Result<Void> addRole(@RequestBody SysRole role) {
        try {
            roleService.insert(role);
            return Result.success("新增成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("新增失败：" + e.getMessage());
        }
    }
    
    /**
     * 修改角色
     */
    @PutMapping("/role")
    public Result<Void> updateRole(@RequestBody SysRole role) {
        try {
            roleService.update(role);
            return Result.success("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("修改失败：" + e.getMessage());
        }
    }
    
    /**
     * 删除角色
     */
    @DeleteMapping("/role/{id}")
    public Result<Void> deleteRole(@PathVariable String id) {
        try {
            roleService.deleteById(id);
            return Result.success("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("删除失败：" + e.getMessage());
        }
    }
    
    // ==================== 系统配置 ====================
    
    /**
     * 查询所有配置
     */
    @GetMapping("/config/all")
    public Result<List<SysConfig>> getAllConfigs() {
        try {
            List<SysConfig> configs = configService.selectAll();
            return Result.success(configs);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    /**
     * 根据配置键查询
     */
    @GetMapping("/config/key/{configKey}")
    public Result<SysConfig> getConfigByKey(@PathVariable String configKey) {
        try {
            return Result.success(configService.selectByKey(configKey));
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败：" + e.getMessage());
        }
    }
    
    /**
     * 批量更新配置
     */
    @PostMapping("/config/batch")
    public Result<Void> batchUpdateConfig(@RequestBody List<SysConfig> configs) {
        try {
            configService.batchUpdate(configs);
            return Result.success("更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("更新失败：" + e.getMessage());
        }
    }
}

