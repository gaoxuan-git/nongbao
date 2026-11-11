-- 创建服务表
CREATE TABLE IF NOT EXISTS `nb_service` (
  `id` varchar(50) NOT NULL COMMENT '主键ID',
  `title` varchar(200) DEFAULT NULL COMMENT '服务标题',
  `image` longtext COMMENT '服务图片',
  `resume` varchar(500) DEFAULT NULL COMMENT '服务摘要',
  `content` text COMMENT '服务内容',
  `category` varchar(50) DEFAULT NULL COMMENT '服务类别',
  `provider` varchar(200) DEFAULT NULL COMMENT '服务商名称',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `price` decimal(10,2) DEFAULT NULL COMMENT '服务价格',
  `status` int DEFAULT 1 COMMENT '状态(0下架 1上架)',
  `address` varchar(500) DEFAULT NULL COMMENT '服务地址',
  `order_count` int DEFAULT 0 COMMENT '订单数量',
  `rating` decimal(3,1) DEFAULT NULL COMMENT '评分',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='服务表';

-- 创建专家表
CREATE TABLE IF NOT EXISTS `nb_expert` (
  `id` varchar(50) NOT NULL COMMENT '主键ID',
  `name` varchar(100) DEFAULT NULL COMMENT '专家姓名',
  `avatar` longtext COMMENT '专家头像',
  `specialty` varchar(200) DEFAULT NULL COMMENT '专业领域',
  `title` varchar(100) DEFAULT NULL COMMENT '职称',
  `organization` varchar(200) DEFAULT NULL COMMENT '所属机构',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `introduction` text COMMENT '个人简介',
  `service_count` int DEFAULT 0 COMMENT '服务次数',
  `rating` varchar(10) DEFAULT NULL COMMENT '评分',
  `status` int DEFAULT 1 COMMENT '状态(0不可用 1可用)',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_specialty` (`specialty`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='专家表';

-- 插入服务测试数据
INSERT INTO `nb_service` (`id`, `title`, `image`, `resume`, `content`, `category`, `provider`, `phone`, `price`, `status`, `address`, `order_count`, `rating`, `create_time`) VALUES
('1', '有机肥料配送服务', 'https://via.placeholder.com/400x240/67c23a/fff?text=有机肥料', '提供优质有机肥料，全程冷链配送，确保肥料新鲜度', '我们提供最优质的有机肥料，来源可追溯，质量有保障。专业团队提供施肥指导，确保农作物健康成长。', 'supply', '绿色农资公司', '400-888-8888', 120.00, 1, '浙江省杭州市余杭区', 358, 4.8, NOW()),
('2', '农机租赁与维修服务', 'https://via.placeholder.com/400x240/409eff/fff?text=农机服务', '提供各类农机租赁服务，包括拖拉机、收割机、播种机等', '专业农机租赁服务，设备齐全，价格优惠。提供上门维修保养服务，确保农机正常运转。', 'machinery', '农机服务中心', '400-777-7777', 200.00, 1, '山东省济南市历城区', 245, 4.5, NOW()),
('3', '病虫害防治指导', 'https://via.placeholder.com/400x240/e6a23c/fff?text=技术指导', '专业农技师提供病虫害识别与防治方案', '资深农技师团队，提供上门诊断服务，制定科学防治方案，确保农作物健康生长。', 'tech', '农技服务站', '400-666-6666', 150.00, 1, '江苏省南京市江宁区', 189, 4.7, NOW());

-- 插入专家测试数据
INSERT INTO `nb_expert` (`id`, `name`, `avatar`, `specialty`, `title`, `organization`, `phone`, `email`, `introduction`, `service_count`, `rating`, `status`, `create_time`) VALUES
('1', '张教授', 'https://via.placeholder.com/150/409eff/fff?text=张教授', '水稻种植技术', '教授/博士生导师', '中国农业大学', '138-0000-0001', 'zhang@example.com', '从事水稻种植研究30年，主持国家级科研项目10余项，发表SCI论文50余篇。', 156, '4.9', 1, NOW()),
('2', '李专家', 'https://via.placeholder.com/150/67c23a/fff?text=李专家', '蔬菜病虫害防治', '研究员', '农业科学院', '138-0000-0002', 'li@example.com', '蔬菜病虫害防治专家，擅长绿色防控技术，服务农户超过1000家。', 203, '4.8', 1, NOW()),
('3', '王老师', 'https://via.placeholder.com/150/e6a23c/fff?text=王老师', '果树栽培管理', '高级农艺师', '农业技术推广中心', '138-0000-0003', 'wang@example.com', '果树栽培专家，指导建立现代化果园50余个，培训果农3000余人次。', 178, '4.7', 1, NOW());

