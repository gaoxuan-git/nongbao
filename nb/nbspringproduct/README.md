# 农宝后台管理系统

## 项目介绍
农宝后台管理系统，基于Spring Boot + MyBatis-Plus开发的后端项目，提供补贴政策、信贷信息、农贸市场、农产品等模块的管理功能。

## 技术栈
- Spring Boot 2.6.13
- MyBatis-Plus 3.4.3
- MySQL 8.0
- Lombok
- FastJSON

## 项目结构
```
nbspringproduct
├── src/main/java/com/movie/nbspringproduct
│   ├── common              # 通用类
│   │   ├── BaseEntity.java        # 基础实体类
│   │   ├── Result.java            # 统一响应结果
│   │   └── PageQuery.java         # 分页查询参数
│   ├── config              # 配置类
│   │   ├── CorsConfig.java        # 跨域配置
│   │   └── MyBatisPlusConfig.java # MyBatis-Plus配置
│   ├── controller          # 控制器层
│   │   ├── NbAllowancePolicyController.java  # 补贴政策
│   │   ├── NbCreditLoanController.java       # 信贷信息
│   │   ├── NbFarmMarketController.java       # 农贸市场
│   │   ├── NbFarmProduceController.java      # 农产品
│   │   └── TestUserController.java           # 测试用户
│   ├── entity              # 实体类
│   │   ├── NbAllowancePolicy.java  # 补贴政策实体
│   │   ├── NbCreditLoan.java       # 信贷信息实体
│   │   ├── NbFarmMarket.java       # 农贸市场实体
│   │   ├── NbFarmProduce.java      # 农产品实体
│   │   └── TestUser.java           # 测试用户实体
│   ├── mapper              # 数据访问层
│   │   ├── NbAllowancePolicyMapper.java
│   │   ├── NbCreditLoanMapper.java
│   │   ├── NbFarmMarketMapper.java
│   │   ├── NbFarmProduceMapper.java
│   │   └── TestUserMapper.java
│   ├── service             # 服务层接口
│   │   ├── INbAllowancePolicyService.java
│   │   ├── INbCreditLoanService.java
│   │   ├── INbFarmMarketService.java
│   │   ├── INbFarmProduceService.java
│   │   └── ITestUserService.java
│   └── service/impl        # 服务层实现
│       ├── NbAllowancePolicyServiceImpl.java
│       ├── NbCreditLoanServiceImpl.java
│       ├── NbFarmMarketServiceImpl.java
│       ├── NbFarmProduceServiceImpl.java
│       └── TestUserServiceImpl.java
└── src/main/resources
    ├── application.yml     # 应用配置文件
    └── sql
        └── schema.sql      # 数据库初始化脚本
```

## 快速开始

### 1. 环境要求
- JDK 1.8+
- Maven 3.6+
- MySQL 8.0+

### 2. 数据库配置
1. 创建数据库：
```sql
CREATE DATABASE nb_database DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. 执行初始化脚本：
- 执行 `src/main/resources/sql/schema.sql` 文件

3. 修改数据库连接配置：
- 编辑 `src/main/resources/application.yml`
- 修改数据库地址、用户名、密码

### 3. 启动项目
```bash
# 编译项目
mvn clean install

# 运行项目
mvn spring-boot:run
```

项目启动后，访问地址：http://localhost:80

## API接口文档

### 1. 补贴政策模块 (/dev-api/yjnb/policy)
- GET /list - 查询补贴政策列表
- GET /{id} - 获取补贴政策详细信息
- POST - 新增补贴政策
- PUT - 修改补贴政策
- DELETE /{ids} - 删除补贴政策
- POST /export - 导出补贴政策列表
- POST /recommendAllowancePolicy - 推荐补贴政策
- POST /unrecommendAllowancePolicy - 取消推荐补贴政策
- POST /releaseAllowancePolicy - 发布补贴政策
- POST /unreleaseAllowancePolicy - 取消发布补贴政策

### 2. 信贷信息模块 (/dev-api/yjnb/loan)
- GET /list - 查询信贷信息列表
- GET /{id} - 获取信贷信息详细信息
- POST - 新增信贷信息
- PUT - 修改信贷信息
- DELETE /{ids} - 删除信贷信息
- POST /export - 导出信贷信息列表
- POST /recommandCreditLoan - 推荐信贷信息
- POST /unRecommandCreditLoan - 取消推荐信贷信息
- POST /publishCreditLoan - 发布信贷信息
- POST /unPublishCreditLoan - 取消发布信贷信息

### 3. 农贸市场模块 (/dev-api/yjnb/market)
- GET /list - 查询农贸市场列表
- GET /{id} - 获取农贸市场详细信息
- POST - 新增农贸市场
- PUT - 修改农贸市场
- DELETE /{ids} - 删除农贸市场
- POST /export - 导出农贸市场列表

### 4. 农产品模块 (/dev-api/yjnb/produce)
- GET /list - 查询农产品列表
- GET /{id} - 获取农产品详细信息
- POST - 新增农产品
- PUT - 修改农产品
- DELETE /{ids} - 删除农产品
- POST /export - 导出农产品列表
- POST /recommendFarmProduce - 推荐农产品
- POST /unrecommendFarmProduce - 取消推荐农产品
- POST /pushFarmProduce - 发布农产品
- POST /unpushFarmProduce - 取消发布农产品

### 5. 测试用户模块 (/dev-api/test/user)
- GET /list - 获取用户列表
- GET /{userId} - 获取用户详细
- POST /save - 新增用户
- PUT /update - 更新用户
- DELETE /{userId} - 删除用户信息

## 配置说明

### application.yml 配置项
```yaml
server:
  port: 80  # 服务端口

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/nb_database  # 数据库地址
    username: root  # 数据库用户名
    password: root  # 数据库密码
```

## 注意事项
1. 请确保MySQL数据库已启动并正确配置
2. 首次运行需要执行数据库初始化脚本
3. 默认端口为80，如需修改请在application.yml中配置
4. 项目已配置跨域支持，可直接被前端调用

## 开发说明
- 所有实体类继承BaseEntity，包含通用字段（创建人、创建时间、更新人、更新时间、备注）
- 使用MyBatis-Plus简化数据访问层开发
- 统一使用Result类封装接口返回结果
- 已配置CORS跨域支持

## 联系方式
如有问题，请联系开发团队。

