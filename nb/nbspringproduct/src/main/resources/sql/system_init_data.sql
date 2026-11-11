-- 系统管理初始数据

-- 插入初始管理员用户
INSERT INTO `sys_user` (`id`, `username`, `nickname`, `password`, `email`, `phonenumber`, `sex`, `status`, `del_flag`, `create_time`) 
VALUES 
('1', 'admin', '超级管理员', '123456', 'admin@nongbao.com', '13800138000', 0, 0, 0, NOW()),
('2', 'user', '普通用户', '123456', 'user@nongbao.com', '13800138001', 0, 0, 0, NOW());

-- 插入初始角色
INSERT INTO `sys_role` (`id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `status`, `del_flag`, `create_time`) 
VALUES 
('1', '超级管理员', 'admin', 1, 1, 0, 0, NOW()),
('2', '普通用户', 'user', 2, 4, 0, 0, NOW()),
('3', '运营人员', 'operator', 3, 4, 0, 0, NOW());

-- 插入初始系统配置
INSERT INTO `sys_config` (`id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_time`) 
VALUES 
('1', '系统名称', 'systemName', '农宝智慧助农管理系统', 'Y', NOW()),
('2', '系统版本', 'systemVersion', 'V1.0.0', 'Y', NOW()),
('3', '系统LOGO', 'systemLogo', '/logo.png', 'Y', NOW()),
('4', '备案号', 'recordNumber', '京ICP备12345678号', 'Y', NOW()),
('5', '密码最小长度', 'passwordMinLength', '6', 'Y', NOW()),
('6', '登录失败锁定次数', 'loginFailLimit', '5', 'Y', NOW()),
('7', '会话超时时间', 'sessionTimeout', '30', 'Y', NOW());

