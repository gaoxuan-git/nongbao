-- =====================================================
-- 农宝系统性能优化 SQL 脚本
-- 功能：为常用查询字段添加索引，提升查询性能
-- 创建时间：2025-10-24
-- =====================================================

-- 使用数据库
USE nbdb;

-- =====================================================
-- 1. 农产品表 (nb_farm_produce) 索引优化
-- =====================================================

-- 检查现有索引
SHOW INDEX FROM nb_farm_produce;

-- 为创建时间添加索引（用于排序）
ALTER TABLE nb_farm_produce 
ADD INDEX idx_create_time (create_time DESC) 
COMMENT '创建时间索引，用于列表排序';

-- 为上架状态添加索引
ALTER TABLE nb_farm_produce 
ADD INDEX idx_push_status (push_status) 
COMMENT '上架状态索引';

-- 为推荐状态添加索引
ALTER TABLE nb_farm_produce 
ADD INDEX idx_recommend (recommend) 
COMMENT '推荐状态索引';

-- 为标题添加前缀索引（用于模糊搜索）
ALTER TABLE nb_farm_produce 
ADD INDEX idx_title (title(100)) 
COMMENT '标题前缀索引，用于搜索';

-- 为分类添加索引
ALTER TABLE nb_farm_produce 
ADD INDEX idx_catgory (catgory) 
COMMENT '分类索引';

-- 为供应商名称添加索引
ALTER TABLE nb_farm_produce 
ADD INDEX idx_provider_name (provider_name(50)) 
COMMENT '供应商名称索引';

-- 复合索引：状态+推荐+创建时间（用于组合查询）
ALTER TABLE nb_farm_produce 
ADD INDEX idx_status_recommend_time (push_status, recommend, create_time DESC) 
COMMENT '状态推荐时间复合索引';


-- =====================================================
-- 2. 补贴政策表 (nb_allowance_policy) 索引优化
-- =====================================================

ALTER TABLE nb_allowance_policy 
ADD INDEX idx_create_time (create_time DESC) 
COMMENT '创建时间索引';

ALTER TABLE nb_allowance_policy 
ADD INDEX idx_push_status (push_status) 
COMMENT '发布状态索引';

ALTER TABLE nb_allowance_policy 
ADD INDEX idx_recommend (recommend) 
COMMENT '推荐状态索引';

ALTER TABLE nb_allowance_policy 
ADD INDEX idx_title (title(100)) 
COMMENT '标题前缀索引';


-- =====================================================
-- 3. 信贷产品表 (nb_credit_loan) 索引优化
-- =====================================================

ALTER TABLE nb_credit_loan 
ADD INDEX idx_create_time (create_time DESC) 
COMMENT '创建时间索引';

ALTER TABLE nb_credit_loan 
ADD INDEX idx_push_status (push_status) 
COMMENT '发布状态索引';

ALTER TABLE nb_credit_loan 
ADD INDEX idx_title (title(100)) 
COMMENT '标题前缀索引';


-- =====================================================
-- 4. 农贸市场表 (nb_farm_market) 索引优化
-- =====================================================

ALTER TABLE nb_farm_market 
ADD INDEX idx_create_time (create_time DESC) 
COMMENT '创建时间索引';

ALTER TABLE nb_farm_market 
ADD INDEX idx_push_status (push_status) 
COMMENT '发布状态索引';

ALTER TABLE nb_farm_market 
ADD INDEX idx_title (title(100)) 
COMMENT '标题前缀索引';


-- =====================================================
-- 5. 图文课程表 (nb_graphic_course) 索引优化
-- =====================================================

ALTER TABLE nb_graphic_course 
ADD INDEX idx_create_time (create_time DESC) 
COMMENT '创建时间索引';

ALTER TABLE nb_graphic_course 
ADD INDEX idx_push_status (push_status) 
COMMENT '发布状态索引';

ALTER TABLE nb_graphic_course 
ADD INDEX idx_recommend (recommend) 
COMMENT '推荐状态索引';

ALTER TABLE nb_graphic_course 
ADD INDEX idx_title (title(100)) 
COMMENT '标题前缀索引';


-- =====================================================
-- 6. 视频课程表 (nb_video_course) 索引优化
-- =====================================================

ALTER TABLE nb_video_course 
ADD INDEX idx_create_time (create_time DESC) 
COMMENT '创建时间索引';

ALTER TABLE nb_video_course 
ADD INDEX idx_push_status (push_status) 
COMMENT '发布状态索引';

ALTER TABLE nb_video_course 
ADD INDEX idx_recommend (recommend) 
COMMENT '推荐状态索引';

ALTER TABLE nb_video_course 
ADD INDEX idx_title (title(100)) 
COMMENT '标题前缀索引';


-- =====================================================
-- 7. 验证索引创建结果
-- =====================================================

-- 查看农产品表的所有索引
SHOW INDEX FROM nb_farm_produce;

-- 查看表的统计信息
ANALYZE TABLE nb_farm_produce;
ANALYZE TABLE nb_allowance_policy;
ANALYZE TABLE nb_credit_loan;
ANALYZE TABLE nb_farm_market;
ANALYZE TABLE nb_graphic_course;
ANALYZE TABLE nb_video_course;


-- =====================================================
-- 8. 性能测试查询
-- =====================================================

-- 测试1：按创建时间排序查询（应使用 idx_create_time）
EXPLAIN SELECT * FROM nb_farm_produce ORDER BY create_time DESC LIMIT 10;

-- 测试2：按状态筛选（应使用 idx_push_status）
EXPLAIN SELECT * FROM nb_farm_produce WHERE push_status = 1;

-- 测试3：组合查询（应使用 idx_status_recommend_time）
EXPLAIN SELECT * FROM nb_farm_produce 
WHERE push_status = 1 AND recommend = 1 
ORDER BY create_time DESC;

-- 测试4：标题搜索（应使用 idx_title）
EXPLAIN SELECT * FROM nb_farm_produce WHERE title LIKE '有机%';


-- =====================================================
-- 9. 慢查询日志配置（可选）
-- =====================================================

-- 查看当前慢查询配置
SHOW VARIABLES LIKE 'slow_query%';
SHOW VARIABLES LIKE 'long_query_time';

-- 启用慢查询日志（需要 root 权限）
-- SET GLOBAL slow_query_log = 'ON';
-- SET GLOBAL long_query_time = 1; -- 超过1秒的查询记录为慢查询
-- SET GLOBAL slow_query_log_file = '/var/log/mysql/slow-query.log';


-- =====================================================
-- 10. 索引使用情况监控
-- =====================================================

-- 查看索引使用统计
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    SEQ_IN_INDEX,
    COLUMN_NAME,
    CARDINALITY
FROM 
    information_schema.STATISTICS
WHERE 
    TABLE_SCHEMA = 'nbdb'
    AND TABLE_NAME IN (
        'nb_farm_produce', 
        'nb_allowance_policy', 
        'nb_credit_loan',
        'nb_farm_market',
        'nb_graphic_course',
        'nb_video_course'
    )
ORDER BY 
    TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;


-- =====================================================
-- 注意事项：
-- 1. 索引会占用额外的存储空间
-- 2. 索引会略微降低 INSERT/UPDATE/DELETE 的性能
-- 3. 对于小表（<1000行），索引效果不明显
-- 4. 定期使用 ANALYZE TABLE 更新统计信息
-- 5. 监控慢查询日志，持续优化
-- =====================================================

-- 完成提示
SELECT '✅ 索引创建完成！请运行 EXPLAIN 查看查询计划验证索引是否生效。' AS message;

