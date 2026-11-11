-- 创建广告表
CREATE TABLE IF NOT EXISTS `nb_advertisement` (
  `id` varchar(50) NOT NULL COMMENT '主键ID',
  `title` varchar(200) DEFAULT NULL COMMENT '广告标题',
  `image` longtext COMMENT '广告图片',
  `position` varchar(50) DEFAULT NULL COMMENT '广告位置(banner/sidebar/popup/footer)',
  `link_url` varchar(500) DEFAULT NULL COMMENT '链接地址',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `sort` int DEFAULT 0 COMMENT '排序',
  `status` int DEFAULT 0 COMMENT '状态(0未发布 1已发布)',
  `click_count` int DEFAULT 0 COMMENT '点击量',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_position` (`position`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='广告表';

-- 插入测试数据
INSERT INTO `nb_advertisement` (`id`, `title`, `image`, `position`, `link_url`, `start_time`, `end_time`, `sort`, `status`, `click_count`, `create_time`) VALUES
('1', '春季农产品促销活动', 'https://via.placeholder.com/400x200/409eff/fff?text=广告图片1', 'banner', 'https://example.com/promo', '2025-01-01 00:00:00', '2025-12-31 23:59:59', 1, 1, 1250, NOW()),
('2', '助农政策宣传', 'https://via.placeholder.com/400x200/67c23a/fff?text=广告图片2', 'sidebar', 'https://example.com/policy', '2025-01-15 00:00:00', '2025-06-30 23:59:59', 2, 1, 850, NOW()),
('3', '农贸市场招商', 'https://via.placeholder.com/400x200/e6a23c/fff?text=广告图片3', 'popup', 'https://example.com/market', '2025-02-01 00:00:00', '2025-03-31 23:59:59', 3, 0, 0, NOW());

