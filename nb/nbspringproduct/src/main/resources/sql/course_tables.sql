-- 图文课程表
CREATE TABLE IF NOT EXISTS `nb_graphic_course` (
  `id` VARCHAR(50) PRIMARY KEY COMMENT '主键ID',
  `title` VARCHAR(255) DEFAULT NULL COMMENT '课程标题',
  `teacher` VARCHAR(100) DEFAULT NULL COMMENT '讲师姓名',
  `resume` TEXT COMMENT '课程简介',
  `content` LONGTEXT COMMENT '课程内容',
  `image` VARCHAR(500) DEFAULT NULL COMMENT '封面图片',
  `category` VARCHAR(100) DEFAULT NULL COMMENT '课程分类',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图文课程表';

-- 视频课程表
CREATE TABLE IF NOT EXISTS `nb_video_course` (
  `id` VARCHAR(50) PRIMARY KEY COMMENT '主键ID',
  `title` VARCHAR(255) DEFAULT NULL COMMENT '课程标题',
  `teacher` VARCHAR(100) DEFAULT NULL COMMENT '讲师姓名',
  `resume` TEXT COMMENT '课程简介',
  `content` LONGTEXT COMMENT '课程介绍',
  `image` VARCHAR(500) DEFAULT NULL COMMENT '封面图片',
  `video_url` VARCHAR(500) DEFAULT NULL COMMENT '视频链接',
  `duration` VARCHAR(50) DEFAULT NULL COMMENT '时长',
  `category` VARCHAR(100) DEFAULT NULL COMMENT '课程分类',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='视频课程表';

-- 插入图文课程测试数据
INSERT INTO `nb_graphic_course` (`id`, `title`, `teacher`, `resume`, `content`, `image`, `category`, `browse_num`, `publish_status`, `recommend`, `created_time`) VALUES 
(UUID(), '水稻种植技术指南', '李教授', '详细介绍水稻从育秧到收获的全过程种植技术', '本课程系统讲解水稻种植的关键技术要点，包括品种选择、育秧管理、田间管理、病虫害防治等内容。', '/images/course/rice.jpg', '种植技术', 156, 1, 1, '2024-01-10 08:00:00'),
(UUID(), '有机蔬菜栽培技术', '王老师', '从零开始学习有机蔬菜种植的实用技术', '课程涵盖有机蔬菜的土壤准备、种子处理、田间管理、病虫害生物防治等核心内容。', '/images/course/vegetables.jpg', '种植技术', 203, 1, 1, '2024-01-15 09:30:00'),
(UUID(), '果树修剪与管理', '张专家', '掌握果树修剪的方法和技巧，提高果实品质', '详细讲解苹果、梨、桃等常见果树的修剪时期、修剪方法和注意事项。', '/images/course/fruit-tree.jpg', '果树管理', 178, 1, 0, '2024-02-01 10:15:00'),
(UUID(), '农业病虫害识别与防治', '陈老师', '学会识别常见农业病虫害，掌握科学防治方法', '课程包含水稻、小麦、玉米等作物的主要病虫害识别特征及综合防治策略。', '/images/course/pest-control.jpg', '病虫害防治', 245, 1, 1, '2024-02-10 14:20:00'),
(UUID(), '智慧农业技术应用', '刘博士', '了解现代农业技术在生产中的应用', '介绍物联网、大数据、人工智能等技术在农业生产中的具体应用案例。', '/images/course/smart-farm.jpg', '智慧农业', 189, 1, 0, '2024-02-20 11:00:00');

-- 插入视频课程测试数据
INSERT INTO `nb_video_course` (`id`, `title`, `teacher`, `resume`, `content`, `image`, `video_url`, `duration`, `category`, `browse_num`, `publish_status`, `recommend`, `created_time`) VALUES 
(UUID(), '小麦高产栽培技术', '赵教授', '视频讲解小麦高产栽培的关键技术措施', '本视频课程从品种选择、播种技术、肥水管理、病虫害防治等方面全面介绍小麦高产栽培技术。', '/images/course/wheat.jpg', '/videos/wheat-cultivation.mp4', '45分钟', '种植技术', 312, 1, 1, '2024-01-20 08:30:00'),
(UUID(), '温室大棚建设与管理', '孙工程师', '手把手教你建设和管理温室大棚', '详细演示温室大棚的选址、建设流程、设备安装、日常管理等实操内容。', '/images/course/greenhouse.jpg', '/videos/greenhouse-setup.mp4', '52分钟', '设施农业', 267, 1, 1, '2024-01-25 09:00:00'),
(UUID(), '畜禽养殖技术', '吴专家', '科学养殖技术，提高养殖效益', '涵盖猪、鸡、牛等常见畜禽的品种选择、饲养管理、疾病防控等实用技术。', '/images/course/livestock.jpg', '/videos/livestock-farming.mp4', '38分钟', '养殖技术', 198, 1, 0, '2024-02-05 10:45:00'),
(UUID(), '农产品电商营销', '周老师', '学习农产品线上销售的方法和技巧', '从平台选择、店铺运营、产品包装、物流配送等角度讲解农产品电商营销策略。', '/images/course/ecommerce.jpg', '/videos/ecommerce-marketing.mp4', '41分钟', '经营管理', 234, 1, 1, '2024-02-15 13:20:00'),
(UUID(), '农业机械使用与维护', '郑技师', '掌握常用农业机械的操作和维护技能', '视频演示拖拉机、收割机、植保机等农业机械的正确使用方法和日常维护保养。', '/images/course/machinery.jpg', '/videos/machinery-maintenance.mp4', '36分钟', '农机技术', 176, 1, 0, '2024-02-28 15:00:00');


