-- 创建数据库
CREATE DATABASE IF NOT EXISTS nb_database DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE nb_database;

-- 补贴政策表
CREATE TABLE IF NOT EXISTS `nb_allowance_policy` (
  `id` VARCHAR(50) PRIMARY KEY COMMENT '主键ID',
  `title` VARCHAR(255) DEFAULT NULL COMMENT '标题',
  `author` VARCHAR(100) DEFAULT NULL COMMENT '作者',
  `resume` TEXT COMMENT '摘要',
  `content` LONGTEXT COMMENT '内容',
  `browse_num` INT DEFAULT 0 COMMENT '浏览数',
  `publish_status` INT DEFAULT 0 COMMENT '发布状态（0未发布 1已发布）',
  `publish_time` DATETIME DEFAULT NULL COMMENT '发布时间',
  `recommend` INT DEFAULT 0 COMMENT '推荐状态（0不推荐 1推荐）',
  `created_time` VARCHAR(50) DEFAULT NULL COMMENT '创建时间',
  `updated_time` VARCHAR(50) DEFAULT NULL COMMENT '更新时间',
  `create_by` VARCHAR(50) DEFAULT NULL COMMENT '创建者',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` VARCHAR(50) DEFAULT NULL COMMENT '更新者',
  `update_time` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` VARCHAR(500) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='补贴政策表';

-- 信贷信息表
CREATE TABLE IF NOT EXISTS `nb_credit_loan` (
  `id` VARCHAR(50) PRIMARY KEY COMMENT '主键ID',
  `title` VARCHAR(255) DEFAULT NULL COMMENT '标题',
  `author` VARCHAR(100) DEFAULT NULL COMMENT '作者',
  `resume` TEXT COMMENT '摘要',
  `content` LONGTEXT COMMENT '内容',
  `image` VARCHAR(500) DEFAULT NULL COMMENT '图片',
  `browse_num` INT DEFAULT 0 COMMENT '浏览数',
  `publish_status` INT DEFAULT 0 COMMENT '发布状态（0未发布 1已发布）',
  `publish_time` DATETIME DEFAULT NULL COMMENT '发布时间',
  `recommend` INT DEFAULT 0 COMMENT '推荐状态（0不推荐 1推荐）',
  `created_time` VARCHAR(50) DEFAULT NULL COMMENT '创建时间',
  `updated_time` VARCHAR(50) DEFAULT NULL COMMENT '更新时间',
  `create_by` VARCHAR(50) DEFAULT NULL COMMENT '创建者',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` VARCHAR(50) DEFAULT NULL COMMENT '更新者',
  `update_time` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` VARCHAR(500) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='信贷信息表';

-- 农贸市场表
CREATE TABLE IF NOT EXISTS `nb_farm_market` (
  `id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
  `name` VARCHAR(255) DEFAULT NULL COMMENT '市场名称',
  `region_id` VARCHAR(50) DEFAULT NULL COMMENT '区域ID',
  `created_time` VARCHAR(50) DEFAULT NULL COMMENT '创建时间',
  `updated_time` VARCHAR(50) DEFAULT NULL COMMENT '更新时间',
  `create_by` VARCHAR(50) DEFAULT NULL COMMENT '创建者',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` VARCHAR(50) DEFAULT NULL COMMENT '更新者',
  `update_time` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` VARCHAR(500) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='农贸市场表';

-- 农产品表
CREATE TABLE IF NOT EXISTS `nb_farm_produce` (
  `id` VARCHAR(50) PRIMARY KEY COMMENT '主键ID',
  `title` VARCHAR(255) DEFAULT NULL COMMENT '标题',
  `resume` TEXT COMMENT '摘要',
  `description` TEXT COMMENT '描述',
  `image` VARCHAR(500) DEFAULT NULL COMMENT '图片',
  `catgory` VARCHAR(100) DEFAULT NULL COMMENT '分类',
  `produce_type` VARCHAR(100) DEFAULT NULL COMMENT '产品类型',
  `price` DECIMAL(10,2) DEFAULT NULL COMMENT '价格',
  `browse_num` INT DEFAULT 0 COMMENT '浏览数',
  `push_status` INT DEFAULT 0 COMMENT '推送状态（0未推送 1已推送）',
  `push_time` DATETIME DEFAULT NULL COMMENT '推送时间',
  `recommend` INT DEFAULT 0 COMMENT '推荐状态（0不推荐 1推荐）',
  `provider_name` VARCHAR(255) DEFAULT NULL COMMENT '供应商名称',
  `account_id` VARCHAR(50) DEFAULT NULL COMMENT '账户ID',
  `created_time` VARCHAR(50) DEFAULT NULL COMMENT '创建时间',
  `updated_time` VARCHAR(50) DEFAULT NULL COMMENT '更新时间',
  `create_by` VARCHAR(50) DEFAULT NULL COMMENT '创建者',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` VARCHAR(50) DEFAULT NULL COMMENT '更新者',
  `update_time` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` VARCHAR(500) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='农产品表';

-- 测试用户表
CREATE TABLE IF NOT EXISTS `test_user` (
  `user_id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
  `username` VARCHAR(100) DEFAULT NULL COMMENT '用户名称',
  `mobile` VARCHAR(20) DEFAULT NULL COMMENT '用户手机',
  `password` VARCHAR(255) DEFAULT NULL COMMENT '用户密码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='测试用户表';

-- 插入测试数据
INSERT INTO `test_user` (`username`, `mobile`, `password`) VALUES 
('张三', '13800138001', '123456'),
('李四', '13800138002', '123456'),
('王五', '13800138003', '123456');

