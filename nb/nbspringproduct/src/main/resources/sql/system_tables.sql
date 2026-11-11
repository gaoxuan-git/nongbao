-- 系统管理相关表

-- 创建系统用户表
CREATE TABLE IF NOT EXISTS `sys_user` (
  `id` varchar(50) NOT NULL COMMENT '用户ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `nickname` varchar(100) DEFAULT NULL COMMENT '昵称',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `phonenumber` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `sex` int DEFAULT 2 COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(500) DEFAULT NULL COMMENT '头像地址',
  `status` int DEFAULT 0 COMMENT '状态（0正常 1停用）',
  `del_flag` int DEFAULT 0 COMMENT '删除标志（0代表存在 1代表删除）',
  `login_ip` varchar(50) DEFAULT NULL COMMENT '最后登录IP',
  `login_date` varchar(50) DEFAULT NULL COMMENT '最后登录时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间',
  `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户表';

-- 创建角色表
CREATE TABLE IF NOT EXISTS `sys_role` (
  `id` varchar(50) NOT NULL COMMENT '角色ID',
  `role_name` varchar(50) NOT NULL COMMENT '角色名称',
  `role_key` varchar(50) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int DEFAULT 0 COMMENT '显示顺序',
  `data_scope` int DEFAULT 1 COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `status` int DEFAULT 0 COMMENT '角色状态（0正常 1停用）',
  `del_flag` int DEFAULT 0 COMMENT '删除标志（0代表存在 1代表删除）',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间',
  `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- 创建系统配置表
CREATE TABLE IF NOT EXISTS `sys_config` (
  `id` varchar(50) NOT NULL COMMENT '配置ID',
  `config_name` varchar(100) NOT NULL COMMENT '配置名称',
  `config_key` varchar(100) NOT NULL COMMENT '配置键名',
  `config_value` varchar(500) DEFAULT NULL COMMENT '配置键值',
  `config_type` varchar(10) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` varchar(50) DEFAULT NULL COMMENT '创建时间',
  `update_time` varchar(50) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_config_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';


