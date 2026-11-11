USE nb_database;

CREATE TABLE IF NOT EXISTS `nb_graphic_course` (
  `id` VARCHAR(50) PRIMARY KEY,
  `title` VARCHAR(255) DEFAULT NULL,
  `teacher` VARCHAR(100) DEFAULT NULL,
  `resume` TEXT,
  `content` LONGTEXT,
  `image` VARCHAR(500) DEFAULT NULL,
  `category` VARCHAR(100) DEFAULT NULL,
  `browse_num` INT DEFAULT 0,
  `publish_status` INT DEFAULT 0,
  `publish_time` DATETIME DEFAULT NULL,
  `recommend` INT DEFAULT 0,
  `created_time` VARCHAR(50) DEFAULT NULL,
  `updated_time` VARCHAR(50) DEFAULT NULL,
  `create_by` VARCHAR(50) DEFAULT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_by` VARCHAR(50) DEFAULT NULL,
  `update_time` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `remark` VARCHAR(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `nb_video_course` (
  `id` VARCHAR(50) PRIMARY KEY,
  `title` VARCHAR(255) DEFAULT NULL,
  `teacher` VARCHAR(100) DEFAULT NULL,
  `resume` TEXT,
  `content` LONGTEXT,
  `image` VARCHAR(500) DEFAULT NULL,
  `video_url` VARCHAR(500) DEFAULT NULL,
  `duration` VARCHAR(50) DEFAULT NULL,
  `category` VARCHAR(100) DEFAULT NULL,
  `browse_num` INT DEFAULT 0,
  `publish_status` INT DEFAULT 0,
  `publish_time` DATETIME DEFAULT NULL,
  `recommend` INT DEFAULT 0,
  `created_time` VARCHAR(50) DEFAULT NULL,
  `updated_time` VARCHAR(50) DEFAULT NULL,
  `create_by` VARCHAR(50) DEFAULT NULL,
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_by` VARCHAR(50) DEFAULT NULL,
  `update_time` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `remark` VARCHAR(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


