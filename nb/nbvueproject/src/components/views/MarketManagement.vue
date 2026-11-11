<template>
  <div class="market-management">
    <!-- 页面标题 -->
    <div class="page-header">
      <div class="header-left">
        <el-icon class="header-icon"><Shop /></el-icon>
        <span class="header-title">农贸市场管理</span>
      </div>
      <div class="header-right">
        <el-button type="primary" :icon="Plus" @click="handleAdd">新增市场</el-button>
        <el-button :icon="Download" @click="handleExport">批量导出</el-button>
      </div>
    </div>

    <!-- 搜索和筛选区域-->
    <div class="search-section">
      <div class="search-row">
        <el-input
          v-model="searchKeyword"
          placeholder="输入农贸市场名称搜索"
          clearable
          class="search-input"
          @keyup.enter="handleSearch"
        >
          <template #prefix>
            <el-icon><Search /></el-icon>
          </template>
        </el-input>
        
        <el-input
          v-model="searchRegion"
          placeholder="请输入所在地区"
          clearable
          class="filter-input"
          @keyup.enter="handleSearch"
        />

        <el-button type="primary" :icon="Search" @click="handleSearch">搜索</el-button>
        <el-button :icon="Refresh" @click="handleReset">重置</el-button>
      </div>

      <!-- 快捷筛选标题-->
      <div class="filter-tags">
        <span class="filter-label">快捷筛选：</span>
        <el-tag
          :type="regionFilter === 'all' ? 'primary' : 'info'"
          :effect="regionFilter === 'all' ? 'dark' : 'plain'"
          class="filter-tag"
          @click="filterByRegion('all')"
        >
          全部地区
        </el-tag>
        <el-tag
          :type="regionFilter === '城市' ? 'success' : 'info'"
          :effect="regionFilter === '城市' ? 'dark' : 'plain'"
          class="filter-tag"
          @click="filterByRegion('城市')"
        >
          城市市场
        </el-tag>
        <el-tag
          :type="regionFilter === '郊区' ? 'warning' : 'info'"
          :effect="regionFilter === '郊区' ? 'dark' : 'plain'"
          class="filter-tag"
          @click="filterByRegion('郊区')"
        >
          郊区市场
        </el-tag>
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
      <el-table-column type="index" label="序号" width="60" align="center" />
      <el-table-column prop="name" label="市场名称" width="200" show-overflow-tooltip />
      <el-table-column prop="regionId" label="所在地区" width="150" align="center" />
      <el-table-column prop="remark" label="市场简介" min-width="300" show-overflow-tooltip />
      <el-table-column prop="createTime" label="创建时间" width="180" align="center">
        <template #default="scope">
          {{ formatDate(scope.row.createTime) }}
        </template>
      </el-table-column>
      
      <el-table-column label="操作" width="180" align="center" fixed="right">
        <template #default="scope">
          <div class="action-btns">
            <el-button type="primary" size="small" @click="handleEdit(scope.row)" plain>编辑</el-button>
            <el-button type="danger" size="small" @click="handleDelete(scope.row)" plain>删除</el-button>
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
      :title="isEdit ? '修改农贸市场' : '新增农贸市场'" 
      width="500px"
    >
      <el-form :model="dialogForm" label-width="100px">
        <el-form-item label="市场名称" required>
          <el-input v-model="dialogForm.name" placeholder="请输入市场名称" />
        </el-form-item>
        <el-form-item label="所在地区">
          <el-input v-model="dialogForm.regionId" placeholder="请输入所在地区" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="dialogForm.remark" type="textarea" :rows="3" placeholder="请输入备注" />
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
import { Search, Shop, Plus, Download, Refresh } from '@element-plus/icons-vue'
import request from '../../utils/request'

const searchKeyword = ref('')
const searchRegion = ref('')
const loading = ref(false)
const tableData = ref<any[]>([])
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
const dialogVisible = ref(false)
const isEdit = ref(false)
const allData = ref<any[]>([])
const statusFilter = ref('all')
const regionFilter = ref('all')

// 模拟数据
const mockData = [
  {
    id: 1,
    name: '绿色农贸批发市场',
    regionId: '城市-朝阳区',
    remark: '北京市朝阳区大型综合性农贸批发市场，成立于2019年，主营蔬菜、水果、粮油等农产品批发业务。市场占地面积8000平方米，设有100个固定摊位，配备现代化冷链仓储设施。日均客流量3000+人次，月交易额达2000万元。市场严格执行食品安全检测制度，所有产品均经过农残快检，确保食品安全。提供免费停车位200个，配套餐饮、金融等便民服务。',
    createTime: '2019-01-15 09:30:00'
  },
  {
    id: 2,
    name: '鲜果集市',
    regionId: '城市-海淀区',
    remark: '海淀区知名专业水果批发市场，创建于2020年2月，是北京市重点农产品批发市场之一。市场专注于提供国内外优质水果，建有5000平米标准化冷库，配备全程冷链物流配送系统。经营品种涵盖苹果、香蕉、橙子、葡萄等50余种，日吞吐量达50吨。与全国20多个果品生产基地建立长期合作关系，保证货源充足、价格稳定。提供线上订购、批发配送一站式服务。',
    createTime: '2020-02-20 14:20:00'
  },
  {
    id: 3,
    name: '田园综合市场',
    regionId: '郊区-顺义区',
    remark: '顺义区现代化农产品综合交易市场，2018年3月建成投入使用。集农产品交易、仓储、初加工、配送于一体，是北京市农业产业化重点龙头企业。市场总占地面积20000平方米，建筑面积12000平方米，设有交易区、仓储区、加工区、冷链配送中心等功能分区。年交易农产品10万吨，交易额超5亿元。市场通过ISO9001质量管理体系认证，建有完善的农产品质量安全追溯系统，所有产品可实现源头追溯。',
    createTime: '2018-03-10 08:00:00'
  },
  {
    id: 4,
    name: '有机蔬菜交易中心',
    regionId: '郊区-大兴区',
    remark: '大兴区首家专业有机蔬菜交易中心，成立于2021年4月，专注于绿色有机蔬菜的批发与配送。市场与周边30余家有机蔬菜种植基地签订直采协议，所有产品均通过国家有机产品认证，经过严格的农残检测和重金属检测。经营有机白菜、有机西红柿、有机黄瓜等60余个品种，日供应量达15吨。服务范围覆盖大兴、丰台、朝阳、海淀、石景山5个区域，为300余家餐饮企业、机关食堂、学校提供配送服务。市场建有可追溯系统，消费者可通过扫描二维码查询产品来源、检测报告等信息。',
    createTime: '2021-04-05 10:15:00'
  },
  {
    id: 5,
    name: '畜禽产品批发市场',
    regionId: '城市-丰台区',
    remark: '丰台区规模最大的肉类、禽蛋专业批发市场，创办于2017年5月。市场占地6000平方米，设有猪肉区、牛羊肉区、禽类区、蛋类区等专业交易区域。配备大型冷库3座，总容量5000吨，冷藏车20余辆，确保产品全程冷链运输。日交易额达500万元，年交易量超过2万吨。市场所有肉品均来自定点屠宰场，具备完整的检疫证明和合格证，严格执行肉品进场查验制度。与北京市100余家连锁超市、200余家餐饮企业建立长期供货关系。提供24小时营业服务，满足不同客户需求。',
    createTime: '2017-05-18 07:45:00'
  },
  {
    id: 6,
    name: '水产海鲜大市场',
    regionId: '城市-石景山区',
    remark: '石景山区最大的水产品、海鲜批发零售市场，2019年6月正式开业。市场建筑面积5000平方米，设有活鱼交易区、冰鲜海产品区、干货区等。拥有大型活鱼池10余个，总蓄水量达300立方米，可同时养殖鲤鱼、草鱼、鲢鱼、鲫鱼等20余种淡水鱼。建有专业海鲜暂养池，经营东海、南海、黄渤海等海域的鲜活海产品。日供应新鲜水产10吨以上，品种涵盖淡水鱼、海水鱼、虾类、蟹类、贝类等100余种。与山东、福建、广东等沿海地区建立稳定货源渠道，保证产品新鲜度。提供免费宰杀、真空包装等增值服务。',
    createTime: '2019-06-12 11:30:00'
  },
  {
    id: 7,
    name: '粮油调味品批发中心',
    regionId: '郊区-通州区',
    remark: '通州区专业粮油调味品批发中心，2016年7月成立，是京津冀地区重要的粮油集散地。市场总占地面积25000平方米，其中仓储面积15000平方米，配备现代化粮食存储设施，可储存各类粮油产品5000吨。经营品类包括：大米、面粉、食用油、调味品、干货、南北货等1000余种商品。与中粮集团、益海嘉里、鲁花集团等知名企业建立战略合作关系，货源充足、品质保证。年交易额超8亿元，服务范围辐射北京、天津、河北三地，为超市、餐饮、食品加工企业提供一站式采购服务。市场通过SC食品经营许可认证，建有完善的进销存管理系统。',
    createTime: '2016-07-22 09:00:00'
  },
  {
    id: 8,
    name: '农副产品综合市场',
    regionId: '城市-东城区',
    remark: '东城区老牌综合性农副产品批发市场，始建于2015年8月，地理位置优越，交通便利。市场经营面积10000平方米，设有蔬菜区、水果区、粮油区、副食品区、调味品区等多个功能区域。经营品类齐全，涵盖蔬菜、水果、肉蛋禽、水产、粮油、调味品等2000余种商品。价格实惠，品质保证，深受周边居民和餐饮企业信赖。日均客流量5000人次，日均交易额100万元，节假日交易额可达200万元。市场实行统一管理、统一收费、统一检测，配备专业食品安全检测室，每日对入场产品进行快速检测。提供免费送货上门服务，满足客户多样化需求。',
    createTime: '2015-08-30 13:20:00'
  },
  {
    id: 9,
    name: '特色农产品展销中心',
    regionId: '郊区-昌平区',
    remark: '昌平区特色农产品展示展销中心，2020年9月建成开放，是北京市农业农村局重点扶持项目。中心占地面积15000平方米，展厅面积8000平方米，集展示、销售、体验、培训于一体。汇集全国28个省份的特色农产品，涵盖有机蔬菜、精品水果、特色粮油、山珍干货、地方特产等10大类3000余种商品。定期举办全国农产品展销会、地方特色农产品推介会、农业技术培训等活动，年均举办各类活动50余场。年交易额达5000万元，带动当地就业200余人。中心建有电商平台，实现线上线下融合发展，产品可配送至全北京。与100余个贫困县建立产销对接关系，助力乡村振兴。',
    createTime: '2020-09-14 15:10:00'
  },
  {
    id: 10,
    name: '社区便民菜市场',
    regionId: '城市-西城区',
    remark: '西城区标准化社区便民菜市场，2022年10月新建，按照"便民、利民、惠民"原则打造的民生工程。市场面积2000平方米，设有蔬菜、水果、肉类、水产、粮油、熟食等经营区域，摊位整洁有序，环境干净卫生。服务周边月坛、金融街、西便门等10个社区约5万居民，提供新鲜蔬菜水果、优质肉类、粮油副食等生活必需品。所有商品明码标价，实行农超对接、产地直采，减少中间环节，让利于民。市场建有检测室，每日对蔬菜、水果等进行农药残留快速检测，检测结果在公示栏公布。营业时间早6:00至晚21:00,节假日不休息。提供免费WiFi、手机充电、便民饮水等贴心服务，深受居民好评。',
    createTime: '2022-10-08 08:30:00'
  }
]

const dialogForm = reactive({
  id: null,
  name: '',
  regionId: '',
  remark: ''
})

const fetchList = async () => {
  loading.value = true
  try {
    console.log('🔄 开始获取市场列表...')
    const res = await request.get('/dev-api/yjnb/market/list')
    console.log('📦 后端原始响应:', res)
    
    if (res && res.code === 200 && res.rows && res.rows.length > 0) {
      console.log('✅ 使用后端数据库数据:', res.rows.length, '条')
      
      // ✅ 完全使用数据库数据,不再依赖 mockData
      allData.value = res.rows.map((item: any) => ({
        ...item,
        // 统一字段名: 后端可能返回 createdTime 或 createTime
        createTime: item.createTime || item.createdTime || '-',
        remark: item.remark || '暂无简介'
      }))
      
      console.log('✅ 数据库数据加载成功,第一条数据:', allData.value[0])
    } else {
      console.log('⚠️ 后端无数据或响应异常,使用本地mockData')
      allData.value = mockData
    }
    applyFilters()
    
  } catch (error) {
    console.error('❌ API请求失败,使用mockData:', error)
    allData.value = mockData
    applyFilters()
    
  } finally {
    loading.value = false
    console.log('✅ fetchList完成,当前tableData条数:', tableData.value.length)
  }
}

const applyFilters = () => {
  let filteredData = [...allData.value]
  
  // 地区筛选
  if (regionFilter.value !== 'all') {
    filteredData = filteredData.filter(item => 
      item.regionId && item.regionId.includes(regionFilter.value)
    )
  }
  
  // 搜索筛选
  if (searchKeyword.value.trim()) {
    const keyword = searchKeyword.value.trim().toLowerCase()
    filteredData = filteredData.filter(item => 
      (item.name && item.name.toLowerCase().includes(keyword)) ||
      (item.remark && item.remark.toLowerCase().includes(keyword))
    )
  }
  
  if (searchRegion.value.trim()) {
    const region = searchRegion.value.trim().toLowerCase()
    filteredData = filteredData.filter(item => 
      (item.regionId && item.regionId.toLowerCase().includes(region))
    )
  }
  
  total.value = filteredData.length
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  tableData.value = filteredData.slice(start, end)
}

const handleSearch = () => {
  currentPage.value = 1
  applyFilters()
}

const handleReset = () => {
  searchKeyword.value = ''
  searchRegion.value = ''
  regionFilter.value = 'all'
  currentPage.value = 1
  applyFilters()
}

const filterByStatus = (status: string) => {
  statusFilter.value = status
  currentPage.value = 1
  applyFilters()
}

const filterByRegion = (region: string) => {
  regionFilter.value = region
  currentPage.value = 1
  applyFilters()
}

const resetForm = () => {
  dialogForm.id = null
  dialogForm.name = ''
  dialogForm.regionId = ''
  dialogForm.remark = ''
}

const handleAdd = () => {
  isEdit.value = false
  resetForm()
  dialogVisible.value = true
}

const handleEdit = (row: any) => {
  isEdit.value = true
  Object.assign(dialogForm, row)
  dialogVisible.value = true
}

const submitForm = async () => {
  if (!dialogForm.name) {
    ElMessage.warning('请输入市场名称')
    return
  }

  try {
    let res
    if (isEdit.value) {
      res = await request.put('/dev-api/yjnb/market', dialogForm)
    } else {
      res = await request.post('/dev-api/yjnb/market', dialogForm)
    }
    
    if (res.code === 200) {
      ElMessage.success(isEdit.value ? '修改成功' : '新增成功')
      dialogVisible.value = false
      fetchList()
    } else {
      ElMessage.error(res.msg || '操作失败')
    }
  } catch (error) {
    console.error('提交失败:', error)
    ElMessage.error('操作失败')
  }
}

const handleDelete = (row: any) => {
  ElMessageBox.confirm('确定要删除该农贸市场吗？', '系统提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(async () => {
    try {
      const res = await request.delete(`/dev-api/yjnb/market/${row.id}`)
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

const handleExport = () => {
  ElMessage.info('批量导出功能待实现')
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
  if (!dateStr || dateStr === 'null' || dateStr === 'undefined') return '-'
  
  // 如果已经是正确的格式,直接返回(YYYY-MM-DD HH:mm:ss)
  if (/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/.test(dateStr)) {
    return dateStr.substring(0, 16) // 返回 YYYY-MM-DD HH:mm
  }
  
  // 尝试解析日期
  const date = new Date(dateStr)
  
  // 检查日期是否有效
  if (isNaN(date.getTime())) {
    console.error('❌ 无效的日期格式:', dateStr)
    return '-'
  }
  
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')} ${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`
}

onMounted(() => {
  // ✅ 直接从数据库获取数据
  fetchList()
})
</script>

<style scoped>
.market-management {
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
  flex-wrap: wrap;
}

.action-btns .el-button {
  margin: 0 !important;
  padding: 5px 12px;
  font-size: 13px;
  font-weight: 500;
  min-width: 70px;
}

:deep(.el-button--primary.is-plain) {
  color: #1890ff;
  background: #e6f7ff;
  border-color: #1890ff;
}

:deep(.el-button--primary.is-plain:hover) {
  background: #1890ff;
  border-color: #1890ff;
  color: white;
}

:deep(.el-button--danger.is-plain) {
  color: #f56c6c;
  background: #fef0f0;
  border-color: #f56c6c;
}

:deep(.el-button--danger.is-plain:hover) {
  background: #f56c6c;
  border-color: #f56c6c;
  color: white;
}
</style>
