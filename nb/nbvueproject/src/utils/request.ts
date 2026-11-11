import axios from 'axios'

// 后端接口配置
// Spring Boot 版本后端（推荐）
const baseURL = 'http://localhost:80'
const isSpringBoot = true  // Spring Boot 版本

// SSM 版本后端
//const baseURL = 'http://localhost:8080/springproduct'
//const isSpringBoot = false  // SSM 版本


// 创建axios实例
const request = axios.create({
  baseURL: baseURL,
  timeout: 10000
})
// 请求拦截器
request.interceptors.request.use(
  config => {
    console.log('🔧 请求拦截器 - 原始URL:', config.url)
    console.log('🔧 baseURL:', config.baseURL)
    console.log('🔧 isSpringBoot:', isSpringBoot)
    
    // 1. 添加 token 到请求头
    const token = localStorage.getItem('token')
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`
      console.log('🔐 已添加 token 到请求头')
    }
    
    // 2. 路径适配: Spring Boot vs SSM
    if (isSpringBoot) {
      // Spring Boot 版本：保持 /dev-api 前缀
      // 前端请求 /dev-api/yjnb/xxx → 直接发送到 Spring Boot
    } else {
      // SSM 版本：将 /dev-api 替换为 /api
      if (config.url && config.url.startsWith('/dev-api/')) {
        config.url = config.url.replace('/dev-api/', '/api/')
        console.log('🔄 SSM路径转换后:', config.url)
      }
    }
    
    console.log('🚀 最终请求URL:', config.baseURL + config.url)
    return config
  },
  error => {
    return Promise.reject(error)
  }
)
// 响应拦截器
request.interceptors.response.use(
  response => {
    return response.data
  },
  error => {
    console.error('请求错误:', error)
    return Promise.reject(error)
  }
)

export default request

