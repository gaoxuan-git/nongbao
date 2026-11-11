<template>
  <div class="produce-management">
    <!-- 页面标题 -->
    <div class="page-header">
      <div class="header-left">
        <el-icon class="header-icon"><ShoppingBag /></el-icon>
        <span class="header-title">农产品管理</span>
      </div>
      <div class="header-right">
        <el-button type="primary" :icon="Plus" @click="handleAdd">新增农产品</el-button>
        <el-button :icon="Download" @click="handleExport">批量导出</el-button>
      </div>
    </div>

    <!-- 搜索和筛选区域-->
    <div class="search-section">
      <div class="search-row">
        <el-input
          v-model="queryParams.title"
          placeholder="搜索农产品名称或卖点摘要"
          clearable
          class="search-input"
          @keyup.enter="handleQuery"
        >
          <template #prefix>
            <el-icon><Search /></el-icon>
          </template>
        </el-input>

        <el-input
          v-model="queryParams.resume"
          placeholder="配送摘要"
          clearable
          class="filter-input"
          @keyup.enter="handleQuery"
        />

        <el-select 
          v-model="queryParams.pushStatus" 
          placeholder="上架状态 "
          clearable
          class="filter-select"
          @change="handleQuery"
        >
          <el-option label="已上架" :value="1" />
          <el-option label="未上架" :value="0" />
        </el-select>

        <el-select 
          v-model="queryParams.recommend" 
          placeholder="推荐状态 "
          clearable
          class="filter-select"
          @change="handleQuery"
        >
          <el-option label="已推荐" :value="1" />
          <el-option label="未推荐" :value="0" />
        </el-select>

        <el-input-number
          v-model="queryParams.salesMin"
          placeholder="最小销题"
          :min="0"
          controls-position="right"
          class="filter-number"
          @change="handleQuery"
        />

        <el-input-number
          v-model="queryParams.browseMin"
          placeholder="最小浏览量"
          :min="0"
          controls-position="right"
          class="filter-number"
          @change="handleQuery"
        />

        <el-button type="primary" :icon="Search" @click="handleQuery">搜索</el-button>
        <el-button :icon="Refresh" @click="handleReset">重置</el-button>
      </div>

      <!-- 快捷筛选按题-->
      <div class="filter-buttons">
        <span class="filter-label">快捷筛选：</span>
        <el-button 
          :type="statusFilter === 'all' ? 'primary' : 'default'"
          size="small"
          @click="filterByStatus('all')"
        >
          全部
        </el-button>
        <el-button 
          :type="statusFilter === 'unpushed' ? 'primary' : 'default'"
          size="small"
          @click="filterByStatus('unpushed')"
        >
          未上架        </el-button>
        <el-button 
          :type="statusFilter === 'recommend' ? 'primary' : 'default'"
          size="small"
          @click="filterByStatus('recommend')"
        >
          推荐商品
        </el-button>
      </div>
    </div>

    <!-- 数据表格 -->
    <el-table
      :data="tableData"
      style="width: 100%; margin-top: 20px;"
      border
      stripe
      v-loading="loading"
    >
      <el-table-column type="index" label="序号" width="70" align="center" />
      <el-table-column prop="title" label="农产品名称" width="160" show-overflow-tooltip />
      
      <el-table-column label="图片" width="90" align="center">
        <template #default="scope">
          <el-image
            v-if="scope.row.image"
            :src="scope.row.image"
            fit="cover"
            style="width: 60px; height: 60px; border-radius: 4px; cursor: pointer;"
            :preview-src-list="[scope.row.image]"
          >
            <template #error>
              <div class="image-slot">
                <el-icon><Picture /></el-icon>
              </div>
            </template>
          </el-image>
          <span v-else style="color: #ccc; font-size: 12px;">暂无</span>
        </template>
      </el-table-column>

      <el-table-column prop="providerName" label="商户名称" width="140" align="center" />
      <el-table-column prop="resume" label="产品摘要" min-width="180" show-overflow-tooltip />
      
      <el-table-column label="上架状态" width="100" align="center">
        <template #default="scope">
          <el-tag :type="scope.row.pushStatus === 1 ? 'success' : 'info'" size="small">
            {{ scope.row.pushStatus === 1 ? '已上架' : '未上架' }}
          </el-tag>
        </template>
      </el-table-column>

      <el-table-column prop="pushTime" label="上架时间" width="110" align="center">
        <template #default="scope">
          {{ formatDate(scope.row.pushTime) }}
        </template>
      </el-table-column>
      
      <el-table-column prop="browseNum" label="浏览数" width="90" align="center" />
      
      <el-table-column label="操作" width="240" align="center" fixed="right">
        <template #default="scope">
          <div class="action-btns">
            <el-button type="primary" size="small" @click="handleEdit(scope.row)" plain>编辑</el-button>
            <el-button type="danger" size="small" @click="handleDelete(scope.row)" plain>删除</el-button>
            <el-button 
              :type="scope.row.recommend === 1 ? 'warning' : 'success'" 
              size="small" 
              @click="toggleRecommend(scope.row)"
              plain
            >
              {{ scope.row.recommend === 1 ? '取消推荐' : '推荐' }}
            </el-button>
          </div>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <el-pagination
      v-model:current-page="currentPage"
      v-model:page-size="pageSize"
      :total="total"
      :page-sizes="[10, 20, 50, 100, 160]"
      layout="total, sizes, prev, pager, next, jumper"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      style="margin-top: 20px; justify-content: flex-end;"
    />

    <!-- 新增/编辑对话框-->
    <el-dialog 
      v-model="dialogVisible" 
      :title="isEdit ? '修改农产品' : '新增农产品'" 
      width="600px"
    >
      <el-form :model="dialogForm" label-width="120px" :rules="rules" ref="formRef">
        <el-form-item label="产品名称" prop="title">
          <el-input v-model="dialogForm.title" placeholder="请输入产品名称" />
        </el-form-item>
        <el-form-item label="产品图片">
          <div class="image-upload-container">
            <el-upload
              class="image-uploader"
              :show-file-list="false"
              :auto-upload="false"
              accept="image/*"
              @change="handleImageChange"
            >
              <img v-if="dialogForm.image" :src="dialogForm.image" class="preview-image" />
              <el-icon v-else class="uploader-icon"><Plus /></el-icon>
            </el-upload>
            <div class="upload-tips">
              <p>点击上传图片或输入图片URL</p>
              <el-input 
                v-model="dialogForm.image" 
                placeholder="或直接输入图片URL" 
                clearable
                size="small"
                style="margin-top: 8px;"
              />
            </div>
          </div>
        </el-form-item>
        <el-form-item label="配送摘要" prop="resume">
          <el-input v-model="dialogForm.resume" type="textarea" :rows="2" placeholder="请输入配送摘要" />
        </el-form-item>
        <el-form-item label="产品详情">
          <el-input v-model="dialogForm.description" type="textarea" :rows="3" placeholder="请输入产品详细描题" />
        </el-form-item>
        <el-form-item label="产品品类">
          <el-select v-model="dialogForm.catgory" placeholder="请选择产品品类" style="width: 100%;">
            <el-option label="粮食" value="粮食" />
            <el-option label="蔬菜" value="蔬菜" />
            <el-option label="水果" value="水果" />
            <el-option label="禽蛋" value="禽蛋" />
            <el-option label="茶叶" value="茶叶" />
            <el-option label="其他" value="其他" />
          </el-select>
        </el-form-item>
        <el-form-item label="商户名称">
          <el-input v-model="dialogForm.providerName" placeholder="请输入商户名称" />
        </el-form-item>
        <el-form-item label="产品价格" prop="price">
          <el-input-number v-model="dialogForm.price" :min="0" :precision="2" :step="0.1" style="width: 100%;" />
        </el-form-item>
        <el-form-item label="上架状态">
          <el-radio-group v-model="dialogForm.pushStatus">
            <el-radio :label="1">已上架</el-radio>
            <el-radio :label="0">未上架</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="推荐状态">
          <el-radio-group v-model="dialogForm.recommend">
            <el-radio :label="1">已推荐</el-radio>
            <el-radio :label="0">未推荐</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitForm">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Search, Picture, Plus, Download, Refresh, ShoppingBag } from '@element-plus/icons-vue'
import request from '../../utils/request'

const queryParams = reactive({
  title: '',
  resume: '',
  pushStatus: undefined,
  recommend: undefined,
  salesMin: undefined,
  browseMin: undefined,
})

const loading = ref(false)
const tableData = ref<any[]>([])
const allData = ref<any[]>([])
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
const dialogVisible = ref(false)
const isEdit = ref(false)
const statusFilter = ref('all')
const formRef = ref()
let fetchingData = false // 防止重复请求

const dialogForm = reactive({
  id: undefined,
  title: '',
  image: '',
  resume: '',
  description: '',
  catgory: '',
  providerName: '',
  price: 0,
  pushStatus: 0,
  recommend: 0,
})

const rules = {
  title: [{ required: true, message: '产品名称不能为空', trigger: 'blur' }],
  resume: [{ required: true, message: '配送摘要不能为题', trigger: 'blur' }],
  price: [{ required: true, message: '产品价格不能为空', trigger: 'blur' }],
}

const fetchList = async () => {
  // 防止重复请求
  if (fetchingData) {
    console.log('⚠️ 请求正在进行中，跳过重复请求')
    return
  }
  
  fetchingData = true
  loading.value = true
  try {
    console.log('🔄 开始获取农产品列表...')
    const res: any = await request.get('/dev-api/yjnb/produce/list')
    if (res.code === 200) {
      console.log('📦 农产品列表原始数据', res.rows)
      allData.value = (res.rows || []).map((item: any) => {
        console.log('🌾 农产品', item.title, 'image长度:', item.image?.length, 'image前缀:', item.image?.substring(0, 30))
        return item
      })
      applyFilters()
      console.log('✅ 获取成功，共', res.rows?.length || 0, '条数据')
    }
  } catch (error) {
    console.error('获取列表失败:', error)
    ElMessage.error('获取数据失败')
  } finally {
    loading.value = false
    fetchingData = false
  }
}

const applyFilters = () => {
  let filteredData = [...allData.value]
  
  // 状态筛选
  if (statusFilter.value === 'unpushed') {
    filteredData = filteredData.filter(item => item.pushStatus === 0)
  } else if (statusFilter.value === 'recommend') {
    filteredData = filteredData.filter(item => item.recommend === 1)
  }
  
  // 搜索筛选
  if (queryParams.title.trim()) {
    const keyword = queryParams.title.trim().toLowerCase()
    filteredData = filteredData.filter(item => 
      (item.title && item.title.toLowerCase().includes(keyword)) ||
      (item.resume && item.resume.toLowerCase().includes(keyword))
    )
  }
  
  if (queryParams.resume.trim()) {
    const resume = queryParams.resume.trim().toLowerCase()
    filteredData = filteredData.filter(item => 
      (item.resume && item.resume.toLowerCase().includes(resume))
    )
  }
  
  if (queryParams.pushStatus !== undefined) {
    filteredData = filteredData.filter(item => item.pushStatus === queryParams.pushStatus)
  }
  
  if (queryParams.recommend !== undefined) {
    filteredData = filteredData.filter(item => item.recommend === queryParams.recommend)
  }
  
  // 销量筛选
  if (queryParams.salesMin !== undefined && queryParams.salesMin !== null) {
    filteredData = filteredData.filter(item => (item.salesNum || 0) >= queryParams.salesMin)
  }
  
  // 浏览量筛选
  if (queryParams.browseMin !== undefined && queryParams.browseMin !== null) {
    filteredData = filteredData.filter(item => (item.browseNum || 0) >= queryParams.browseMin)
  }
  
  total.value = filteredData.length
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  tableData.value = filteredData.slice(start, end)
}

const handleQuery = () => {
  currentPage.value = 1
  applyFilters()
}

const handleReset = () => {
  queryParams.title = ''
  queryParams.resume = ''
  queryParams.pushStatus = undefined
  queryParams.recommend = undefined
  queryParams.salesMin = undefined
  queryParams.browseMin = undefined
  statusFilter.value = 'all'
  currentPage.value = 1
  applyFilters()
}

const filterByStatus = (status: string) => {
  statusFilter.value = status
  currentPage.value = 1
  applyFilters()
}

const handleAdd = () => {
  isEdit.value = false
  Object.assign(dialogForm, {
    id: undefined,
    title: '',
    image: '',
    resume: '',
    description: '',
    catgory: '',
    providerName: '',
    price: 0,
    pushStatus: 0,
    recommend: 0,
  })
  dialogVisible.value = true
}

const handleEdit = (row: any) => {
  console.log('=== 点击编辑 ===')
  console.log('原始行数据', {
    id: row.id,
    title: row.title,
    hasImage: !!row.image,
    imagePreview: row.image?.substring(0, 50)
  })
  
  isEdit.value = true
  Object.assign(dialogForm, row)
  
  console.log('赋值后dialogForm:', {
    id: dialogForm.id,
    title: dialogForm.title,
    hasImage: !!dialogForm.image,
    imagePreview: dialogForm.image?.substring(0, 50)
  })
  
  dialogVisible.value = true
}

const submitForm = async () => {
  if (!formRef.value) return
  
  await formRef.value.validate(async (valid: boolean) => {
    if (!valid) return
    
    try {
      // 检查图片字段
      console.log('=== 提交数据前检查 ===')
      console.log('是否为编辑', isEdit.value)
      console.log('产品ID:', dialogForm.id)
      console.log('产品标题:', dialogForm.title)
      console.log('图片字段存在:', !!dialogForm.image)
      console.log('图片类型:', dialogForm.image?.substring(0, 30))
      
      // 检查图片大小
      if (dialogForm.image && dialogForm.image.startsWith('data:image')) {
        const imageSize = dialogForm.image.length
        console.log('图片大小:', Math.round(imageSize / 1024), 'KB')
        if (imageSize > 10 * 1024 * 1024) { // 超过10MB
          ElMessage.warning('图片过大，建议压缩后上传')
        }
      }
      
      // 复制dialogForm以避免修改原对象
      const submitData = { ...dialogForm }
      console.log('提交的数据', {
        id: submitData.id,
        title: submitData.title,
        hasImage: !!submitData.image,
        imagePreview: submitData.image?.substring(0, 50)
      })
      
      let res: any
      if (isEdit.value) {
        res = await request.put('/dev-api/yjnb/produce', submitData)
      } else {
        res = await request.post('/dev-api/yjnb/produce', submitData)
      }
      
      console.log('后端响应:', res)
      
      if (res.code === 200) {
        ElMessage.success(isEdit.value ? '修改成功' : '新增成功')
        dialogVisible.value = false
        fetchList()
      } else {
        ElMessage.error(res.msg || '操作失败')
        console.error('后端返回错误:', res)
      }
    } catch (error: any) {
      console.error('提交失败:', error)
      const errorMsg = error?.response?.data?.msg || error?.message || '操作失败'
      ElMessage.error('操作失败: ' + errorMsg)
    }
  })
}

const handleDelete = (row: any) => {
  ElMessageBox.confirm('确定要删除该农产品吗？', '系统提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(async () => {
    try {
      const res: any = await request.delete(`/dev-api/yjnb/produce/${row.id}`)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        fetchList()
      } else {
        ElMessage.error(res.msg || '删除失败')
      }
    } catch (error) {
      console.error('删除失败:', error)
      ElMessage.error('删除失败')
    }
  }).catch(() => {})
}

const toggleRecommend = (row: any) => {
  const action = row.recommend === 1 ? '取消推荐' : '推荐'
  ElMessageBox.confirm(`是否${action}所选商题`, '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'info',
  }).then(async () => {
    try {
      let res: any
      if (row.recommend === 1) {
        res = await request.post(`/dev-api/yjnb/produce/unrecommendFarmProduce`, [row.id])
      } else {
        res = await request.post(`/dev-api/yjnb/produce/recommendFarmProduce`, [row.id])
      }
      if (res.code === 200) {
        ElMessage.success(`${action}成功`)
        // 本地更新数据，避免重新请题        row.recommend = row.recommend === 1 ? 0 : 1
        applyFilters()
      } else {
        ElMessage.error(res.msg || `${action}失败`)
      }
    } catch (error) {
      console.error(`${action}失败:`, error)
      ElMessage.error(`${action}失败`)
    }
  }).catch(() => {})
}

const handleExport = () => {
  ElMessage.info('批量导出功能待实现')
}

const handleImageChange = (file: any) => {
  // 这里可以实现图片上传到服务器的逻辑
  // 暂时使用本地预览
  const reader = new FileReader()
  reader.onload = (e: any) => {
    dialogForm.image = e.target.result
  }
  reader.readAsDataURL(file.raw)
}

const handleSizeChange = (val: number) => {
  pageSize.value = val
  applyFilters()
}

const handleCurrentChange = (val: number) => {
  currentPage.value = val
  applyFilters()
}

const formatDate = (dateStr: string) => {
  if (!dateStr) return '-'
  const date = new Date(dateStr)
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`
}

onMounted(() => {
  fetchList()
})
</script>

<style scoped>
.produce-management {
  width: 100%;
  padding: 0;
  background: #f0f2f5;
  min-height: calc(100vh - 60px);
  box-sizing: border-box;
}

/* 页面标题 */
.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: white;
  padding: 20px 40px;
  border-bottom: 1px solid #e8e8e8;
  position: relative;
  overflow: hidden;
}





.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
  z-index: 1;
}

.header-icon {
  font-size: 24px;
  color: #1890ff;
}

.header-title {
  font-size: 22px;
  font-weight: 600;
  color: #5a4a3a;
  letter-spacing: 0.5px;
}

.header-right {
  display: flex;
  gap: 12px;
  z-index: 1;
}

.header-right .el-button {
  border: none;
  font-weight: 500;
}

/* 搜索筛选区域*/
.search-section {
  background: white;
  padding: 20px;
  margin: 20px 40px;
  border-radius: 0;
  border: 1px solid #e8e8e8;
}

.search-row {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
}

.search-input {
  width: 320px;
}

.filter-input {
  width: 200px;
}

.filter-select {
  width: 150px;
}

.filter-number {
  width: 140px;
}

/* 快捷筛选标题*/
.filter-tags {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-top: 16px;
  padding-top: 16px;
  border-top: 1px solid #e8dcc8;
}

.filter-label {
  font-size: 14px;
  color: #8b7355;
  font-weight: 500;
}

.filter-tag {
  cursor: pointer;
  user-select: none;
  transition: all 0.3s;
  font-size: 13px;
  padding: 6px 16px;
  border-color: #e8e8e8;
}

.filter-tag:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(133, 185, 70, 0.2);
}

.image-slot {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  background: #f5f7fa;
  color: #909399;
  font-size: 30px;
}

/* 表格样式优化 */
:deep(.el-table) {
  font-size: 14px;
  border-radius: 0;
  overflow: hidden;
  box-shadow: none;
  margin: 0 40px 20px 40px;
  border: 1px solid #e8e8e8;
  width: calc(100% - 80px) !important;
}

:deep(.el-table th) {
  background: #1890ff !important;
  color: #fff;
  font-weight: 500;
  font-size: 14px;
  padding: 12px 0;
}

:deep(.el-table th .cell) {
  color: #fff;
}

:deep(.el-table td) {
  padding: 10px 0;
  border-color: #e8dcc8;
}

:deep(.el-table__row:hover > td) {
  background-color: #f5f5f5 !important;
}

:deep(.el-table--striped .el-table__body tr.el-table__row--striped) {
  background-color: #fafaf8;
}

:deep(.el-table td), :deep(.el-table th) {
  border-color: #e8dcc8;
}

:deep(.el-table::before) {
  background-color: #e8dcc8;
}

:deep(.el-table--border .el-table__inner-wrapper::after) {
  background-color: #e8dcc8;
}

.image-upload-container {
  display: flex;
  gap: 20px;
  align-items: flex-start;
}

.image-uploader {
  border: 2px dashed #d9d9d9;
  border-radius: 8px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: all 0.3s;
  width: 148px;
  height: 148px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #fafafa;
}

.image-uploader:hover {
  border-color: #409eff;
  background: #e6f7ff;
}

.preview-image {
  width: 148px;
  height: 148px;
  object-fit: cover;
  display: block;
}

.uploader-icon {
  font-size: 32px;
  color: #8c939d;
}

.upload-tips {
  flex: 1;
}

.upload-tips p {
  margin: 0 0 8px;
  color: #606266;
  font-size: 14px;
}

/* 按钮样式覆盖 */
:deep(.el-button--primary) {
  background: #1890ff;
  border-color: #1890ff;
}

:deep(.el-button--primary:hover) {
  background: #40a9ff;
  border-color: #40a9ff;
}

:deep(.el-button--success) {
  background: #1890ff;
  border-color: #1890ff;
}

:deep(.el-button--success:hover) {
  background: #40a9ff;
  border-color: #40a9ff;
}

:deep(.el-input__wrapper:hover) {
  box-shadow: 0 0 0 1px #1890ff inset;
}

:deep(.el-input__wrapper.is-focus) {
  box-shadow: 0 0 0 1px #1890ff inset !important;
}

:deep(.el-select .el-input.is-focus .el-input__wrapper) {
  box-shadow: 0 0 0 1px #1890ff inset !important;
}

/* 分页样式 */
:deep(.el-pagination) {
  justify-content: center;
  padding: 20px 0;
}

:deep(.el-pagination.is-background .el-pager li:not(.is-disabled).is-active) {
  background-color: #1890ff;
  border-color: #1890ff;
}

:deep(.el-pagination.is-background .el-pager li:hover) {
  color: #1890ff;
}

/* 操作按钮样式 */
.action-btns {
  display: flex;
  gap: 6px;
  justify-content: center;
  flex-wrap: nowrap;
}

.action-btns .el-button {
  margin: 0 !important;
  padding: 5px 12px;
  font-size: 13px;
  font-weight: 500;
  min-width: 70px;
  flex-shrink: 0;
}
</style>
