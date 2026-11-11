-- ==================== 修复数据库表备注乱码 ====================
-- 
-- 问题说明：如果数据库表的备注显示为乱码，通常是字符集设置不正确导致
-- 解决方案：
--   1. 确保数据库使用 utf8mb4 字符集
--   2. 重新设置表和列的备注
--   3. 确保连接字符串正确配置
--
-- 使用方法：
--   在 MySQL 客户端或 Navicat 等工具中执行此脚本
-- ==================== 

USE nb_database;

-- 1. 修改数据库字符集为 utf8mb4
ALTER DATABASE nb_database CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. 修复系统用户表（sys_user）的备注
ALTER TABLE `sys_user` COMMENT = '系统用户表';
ALTER TABLE `sys_user` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '用户ID';
ALTER TABLE `sys_user` MODIFY COLUMN `username` varchar(50) NOT NULL COMMENT '用户名';
ALTER TABLE `sys_user` MODIFY COLUMN `nickname` varchar(100) DEFAULT NULL COMMENT '昵称';
ALTER TABLE `sys_user` MODIFY COLUMN `password` varchar(100) NOT NULL COMMENT '密码';
ALTER TABLE `sys_user` MODIFY COLUMN `email` varchar(100) DEFAULT NULL COMMENT '邮箱';
ALTER TABLE `sys_user` MODIFY COLUMN `phonenumber` varchar(20) DEFAULT NULL COMMENT '手机号码';
ALTER TABLE `sys_user` MODIFY COLUMN `sex` int DEFAULT 2 COMMENT '用户性别（0男 1女 2未知）';
ALTER TABLE `sys_user` MODIFY COLUMN `avatar` varchar(500) DEFAULT NULL COMMENT '头像地址';
ALTER TABLE `sys_user` MODIFY COLUMN `status` int DEFAULT 0 COMMENT '状态（0正常 1停用）';
ALTER TABLE `sys_user` MODIFY COLUMN `del_flag` int DEFAULT 0 COMMENT '删除标志（0代表存在 1代表删除）';
ALTER TABLE `sys_user` MODIFY COLUMN `login_ip` varchar(50) DEFAULT NULL COMMENT '最后登录IP';
ALTER TABLE `sys_user` MODIFY COLUMN `login_date` varchar(50) DEFAULT NULL COMMENT '最后登录时间';
ALTER TABLE `sys_user` MODIFY COLUMN `remark` varchar(500) DEFAULT NULL COMMENT '备注';
ALTER TABLE `sys_user` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `sys_user` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 3. 修复角色表（sys_role）的备注
ALTER TABLE `sys_role` COMMENT = '系统角色表';
ALTER TABLE `sys_role` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '角色ID';
ALTER TABLE `sys_role` MODIFY COLUMN `role_name` varchar(50) NOT NULL COMMENT '角色名称';
ALTER TABLE `sys_role` MODIFY COLUMN `role_key` varchar(50) NOT NULL COMMENT '角色权限字符串';
ALTER TABLE `sys_role` MODIFY COLUMN `role_sort` int DEFAULT 0 COMMENT '显示顺序';
ALTER TABLE `sys_role` MODIFY COLUMN `data_scope` int DEFAULT 1 COMMENT '数据范围（1全部 2自定义 3本部门 4本部门及以下）';
ALTER TABLE `sys_role` MODIFY COLUMN `status` int DEFAULT 0 COMMENT '角色状态（0正常 1停用）';
ALTER TABLE `sys_role` MODIFY COLUMN `del_flag` int DEFAULT 0 COMMENT '删除标志（0代表存在 1代表删除）';
ALTER TABLE `sys_role` MODIFY COLUMN `remark` varchar(500) DEFAULT NULL COMMENT '备注';
ALTER TABLE `sys_role` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `sys_role` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 4. 修复系统配置表（sys_config）的备注
ALTER TABLE `sys_config` COMMENT = '系统配置表';
ALTER TABLE `sys_config` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '配置ID';
ALTER TABLE `sys_config` MODIFY COLUMN `config_name` varchar(100) NOT NULL COMMENT '配置名称';
ALTER TABLE `sys_config` MODIFY COLUMN `config_key` varchar(100) NOT NULL COMMENT '配置键名';
ALTER TABLE `sys_config` MODIFY COLUMN `config_value` varchar(500) DEFAULT NULL COMMENT '配置键值';
ALTER TABLE `sys_config` MODIFY COLUMN `config_type` varchar(10) DEFAULT 'N' COMMENT '系统内置（Y是 N否）';
ALTER TABLE `sys_config` MODIFY COLUMN `remark` varchar(500) DEFAULT NULL COMMENT '备注';
ALTER TABLE `sys_config` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `sys_config` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 5. 修复专家表（nb_expert）的备注
ALTER TABLE `nb_expert` COMMENT = '农业专家表';
ALTER TABLE `nb_expert` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '专家ID';
ALTER TABLE `nb_expert` MODIFY COLUMN `name` varchar(100) NOT NULL COMMENT '专家姓名';
ALTER TABLE `nb_expert` MODIFY COLUMN `title` varchar(100) DEFAULT NULL COMMENT '职称';
ALTER TABLE `nb_expert` MODIFY COLUMN `specialty` varchar(200) DEFAULT NULL COMMENT '专业领域';
ALTER TABLE `nb_expert` MODIFY COLUMN `phone` varchar(20) DEFAULT NULL COMMENT '联系电话';
ALTER TABLE `nb_expert` MODIFY COLUMN `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱';
ALTER TABLE `nb_expert` MODIFY COLUMN `avatar` varchar(500) DEFAULT NULL COMMENT '头像';
ALTER TABLE `nb_expert` MODIFY COLUMN `introduction` text COMMENT '个人简介';
ALTER TABLE `nb_expert` MODIFY COLUMN `status` int DEFAULT 0 COMMENT '状态（0正常 1停用）';
ALTER TABLE `nb_expert` MODIFY COLUMN `sort_order` int DEFAULT 0 COMMENT '排序';
ALTER TABLE `nb_expert` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `nb_expert` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 6. 修复服务表（nb_service）的备注
ALTER TABLE `nb_service` COMMENT = '农业服务表';
ALTER TABLE `nb_service` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '服务ID';
ALTER TABLE `nb_service` MODIFY COLUMN `service_name` varchar(200) NOT NULL COMMENT '服务名称';
ALTER TABLE `nb_service` MODIFY COLUMN `category` varchar(100) DEFAULT NULL COMMENT '服务类别';
ALTER TABLE `nb_service` MODIFY COLUMN `description` text COMMENT '服务描述';
ALTER TABLE `nb_service` MODIFY COLUMN `price` decimal(10,2) DEFAULT NULL COMMENT '服务价格';
ALTER TABLE `nb_service` MODIFY COLUMN `cover_image` varchar(500) DEFAULT NULL COMMENT '封面图片';
ALTER TABLE `nb_service` MODIFY COLUMN `expert_id` varchar(50) DEFAULT NULL COMMENT '专家ID';
ALTER TABLE `nb_service` MODIFY COLUMN `status` int DEFAULT 0 COMMENT '状态（0正常 1停用）';
ALTER TABLE `nb_service` MODIFY COLUMN `sort_order` int DEFAULT 0 COMMENT '排序';
ALTER TABLE `nb_service` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `nb_service` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 7. 修复视频课程表（nb_video_course）的备注
ALTER TABLE `nb_video_course` COMMENT = '视频课程表';
ALTER TABLE `nb_video_course` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '课程ID';
ALTER TABLE `nb_video_course` MODIFY COLUMN `title` varchar(200) NOT NULL COMMENT '课程标题';
ALTER TABLE `nb_video_course` MODIFY COLUMN `category` varchar(100) DEFAULT NULL COMMENT '课程分类';
ALTER TABLE `nb_video_course` MODIFY COLUMN `description` text COMMENT '课程描述';
ALTER TABLE `nb_video_course` MODIFY COLUMN `video_url` varchar(500) DEFAULT NULL COMMENT '视频地址';
ALTER TABLE `nb_video_course` MODIFY COLUMN `cover_image` varchar(500) DEFAULT NULL COMMENT '封面图片';
ALTER TABLE `nb_video_course` MODIFY COLUMN `duration` int DEFAULT NULL COMMENT '时长（秒）';
ALTER TABLE `nb_video_course` MODIFY COLUMN `view_count` int DEFAULT 0 COMMENT '观看次数';
ALTER TABLE `nb_video_course` MODIFY COLUMN `expert_id` varchar(50) DEFAULT NULL COMMENT '专家ID';
ALTER TABLE `nb_video_course` MODIFY COLUMN `status` int DEFAULT 0 COMMENT '状态（0正常 1停用）';
ALTER TABLE `nb_video_course` MODIFY COLUMN `sort_order` int DEFAULT 0 COMMENT '排序';
ALTER TABLE `nb_video_course` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `nb_video_course` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 8. 修复图文课程表（nb_graphic_course）的备注
ALTER TABLE `nb_graphic_course` COMMENT = '图文课程表';
ALTER TABLE `nb_graphic_course` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '课程ID';
ALTER TABLE `nb_graphic_course` MODIFY COLUMN `title` varchar(200) NOT NULL COMMENT '课程标题';
ALTER TABLE `nb_graphic_course` MODIFY COLUMN `category` varchar(100) DEFAULT NULL COMMENT '课程分类';
ALTER TABLE `nb_graphic_course` MODIFY COLUMN `content` text COMMENT '课程内容';
ALTER TABLE `nb_graphic_course` MODIFY COLUMN `cover_image` varchar(500) DEFAULT NULL COMMENT '封面图片';
ALTER TABLE `nb_graphic_course` MODIFY COLUMN `view_count` int DEFAULT 0 COMMENT '阅读次数';
ALTER TABLE `nb_graphic_course` MODIFY COLUMN `expert_id` varchar(50) DEFAULT NULL COMMENT '专家ID';
ALTER TABLE `nb_graphic_course` MODIFY COLUMN `status` int DEFAULT 0 COMMENT '状态（0正常 1停用）';
ALTER TABLE `nb_graphic_course` MODIFY COLUMN `sort_order` int DEFAULT 0 COMMENT '排序';
ALTER TABLE `nb_graphic_course` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `nb_graphic_course` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 9. 修复农产品表（nb_farm_produce）的备注
ALTER TABLE `nb_farm_produce` COMMENT = '农产品表';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '产品ID';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `product_name` varchar(200) NOT NULL COMMENT '产品名称';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `category` varchar(100) DEFAULT NULL COMMENT '产品分类';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `description` text COMMENT '产品描述';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `price` decimal(10,2) DEFAULT NULL COMMENT '价格';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `unit` varchar(20) DEFAULT NULL COMMENT '单位';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `stock` int DEFAULT 0 COMMENT '库存';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `cover_image` varchar(500) DEFAULT NULL COMMENT '封面图片';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `status` int DEFAULT 0 COMMENT '状态（0正常 1下架）';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `sort_order` int DEFAULT 0 COMMENT '排序';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `nb_farm_produce` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 10. 修复市场表（nb_farm_market）的备注
ALTER TABLE `nb_farm_market` COMMENT = '农产品市场表';
ALTER TABLE `nb_farm_market` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '市场ID';
ALTER TABLE `nb_farm_market` MODIFY COLUMN `market_name` varchar(200) NOT NULL COMMENT '市场名称';
ALTER TABLE `nb_farm_market` MODIFY COLUMN `address` varchar(500) DEFAULT NULL COMMENT '市场地址';
ALTER TABLE `nb_farm_market` MODIFY COLUMN `contact_person` varchar(100) DEFAULT NULL COMMENT '联系人';
ALTER TABLE `nb_farm_market` MODIFY COLUMN `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系电话';
ALTER TABLE `nb_farm_market` MODIFY COLUMN `description` text COMMENT '市场描述';
ALTER TABLE `nb_farm_market` MODIFY COLUMN `cover_image` varchar(500) DEFAULT NULL COMMENT '封面图片';
ALTER TABLE `nb_farm_market` MODIFY COLUMN `status` int DEFAULT 0 COMMENT '状态（0正常 1停用）';
ALTER TABLE `nb_farm_market` MODIFY COLUMN `sort_order` int DEFAULT 0 COMMENT '排序';
ALTER TABLE `nb_farm_market` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `nb_farm_market` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 11. 修复贷款表（nb_credit_loan）的备注
ALTER TABLE `nb_credit_loan` COMMENT = '信用贷款表';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '贷款ID';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `loan_name` varchar(200) NOT NULL COMMENT '贷款产品名称';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `loan_type` varchar(100) DEFAULT NULL COMMENT '贷款类型';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `max_amount` decimal(10,2) DEFAULT NULL COMMENT '最高额度';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `interest_rate` decimal(5,2) DEFAULT NULL COMMENT '利率（%）';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `loan_period` varchar(100) DEFAULT NULL COMMENT '贷款期限';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `description` text COMMENT '产品描述';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `requirements` text COMMENT '申请条件';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `bank_name` varchar(100) DEFAULT NULL COMMENT '银行名称';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系电话';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `status` int DEFAULT 0 COMMENT '状态（0正常 1停用）';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `sort_order` int DEFAULT 0 COMMENT '排序';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `nb_credit_loan` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 12. 修复惠农政策表（nb_allowance_policy）的备注
ALTER TABLE `nb_allowance_policy` COMMENT = '惠农政策表';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '政策ID';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `policy_name` varchar(200) NOT NULL COMMENT '政策名称';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `policy_type` varchar(100) DEFAULT NULL COMMENT '政策类型';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `content` text COMMENT '政策内容';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `publish_date` varchar(50) DEFAULT NULL COMMENT '发布日期';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `expire_date` varchar(50) DEFAULT NULL COMMENT '截止日期';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `department` varchar(200) DEFAULT NULL COMMENT '发布部门';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `contact_phone` varchar(20) DEFAULT NULL COMMENT '咨询电话';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `status` int DEFAULT 0 COMMENT '状态（0正常 1过期）';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `sort_order` int DEFAULT 0 COMMENT '排序';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `nb_allowance_policy` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 13. 修复广告表（nb_advertisement）的备注
ALTER TABLE `nb_advertisement` COMMENT = '广告表';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `id` varchar(50) NOT NULL COMMENT '广告ID';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `ad_name` varchar(200) NOT NULL COMMENT '广告名称';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `ad_type` varchar(100) DEFAULT NULL COMMENT '广告类型';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `image_url` varchar(500) DEFAULT NULL COMMENT '图片地址';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `link_url` varchar(500) DEFAULT NULL COMMENT '链接地址';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `position` varchar(100) DEFAULT NULL COMMENT '展示位置';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `start_time` varchar(50) DEFAULT NULL COMMENT '开始时间';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `end_time` varchar(50) DEFAULT NULL COMMENT '结束时间';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `click_count` int DEFAULT 0 COMMENT '点击次数';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `status` int DEFAULT 0 COMMENT '状态（0正常 1停用）';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `sort_order` int DEFAULT 0 COMMENT '排序';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间';
ALTER TABLE `nb_advertisement` MODIFY COLUMN `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间';

-- 执行完成提示
SELECT '✅ 数据库表备注修复完成！' AS message;
SELECT '✅ 所有表的字符集已设置为 utf8mb4' AS message;
SELECT '✅ 如果仍有乱码，请检查连接字符串是否包含：useUnicode=true&characterEncoding=utf8' AS message;

