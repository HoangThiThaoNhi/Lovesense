'use client'

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000/api'

async function fetcher(endpoint: string, options: RequestInit = {}) {
  const token = typeof window !== 'undefined' ? localStorage.getItem('admin_token') : null
  
  const isFormData = options.body instanceof FormData;
  
  const headers = {
    ...(isFormData ? {} : { 'Content-Type': 'application/json' }),
    ...(token ? { Authorization: `Bearer ${token}` } : {}),
    ...options.headers,
  }

  const response = await fetch(`${API_BASE_URL}${endpoint}`, {
    ...options,
    headers,
  })

  // Global 401 handling
  if (response.status === 401) {
    if ((api as any).onUnauthorized) {
      (api as any).onUnauthorized()
    }
  }

  const data = await response.json()

  if (!response.ok) {
    throw new Error(data.error || 'Đã có lỗi xảy ra. Vui lòng thử lại.')
  }

  return data
}

export const api = {
  // Auth
  login: (credentials: any) => fetcher('/auth/login', {
    method: 'POST',
    body: JSON.stringify(credentials),
  }),

  // Admin Stats & Logs
  getStats: () => fetcher('/admin/stats'),
  getLogs: (page = 1) => fetcher(`/admin/logs?page=${page}`),

  // User Management
  getUsers: (params: { search?: string; status?: string; page?: number; limit?: number } = {}) => {
    const query = new URLSearchParams()
    if (params.search) query.append('search', params.search)
    if (params.status) query.append('status', params.status)
    if (params.page) query.append('page', params.page.toString())
    if (params.limit) query.append('limit', params.limit.toString())
    return fetcher(`/admin/users?${query.toString()}`)
  },
  createUser: (userData: any) => fetcher('/admin/users', {
    method: 'POST',
    body: JSON.stringify(userData),
  }),
  updateUserStatus: (id: string, status: string) => fetcher(`/admin/users/${id}/status`, {
    method: 'PUT',
    body: JSON.stringify({ status }),
  }),
  resetPassword: (id: string, newPassword: string) => fetcher(`/admin/users/${id}/reset-password`, {
    method: 'PUT',
    body: JSON.stringify({ newPassword }),
  }),
  updateUserPoints: (id: string, points: number) => fetcher(`/admin/users/${id}/points`, {
    method: 'PUT',
    body: JSON.stringify({ points }),
  }),
  bulkUserGenerate: (formData: FormData) => fetcher('/admin/users/bulk-generate', {
    method: 'POST',
    body: formData,
  }),
  changeAdminPassword: (passwords: any) => fetcher('/admin/change-password', {
    method: 'POST',
    body: JSON.stringify(passwords),
  }),

  // AI & Gamification
  getQuestions: () => fetcher('/admin/questions'),
  createQuestion: (data: any) => fetcher('/admin/questions', {
    method: 'POST',
    body: JSON.stringify(data),
  }),
  updateQuestion: (id: string, data: any) => fetcher(`/admin/questions/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  }),
  deleteQuestion: (id: string) => fetcher(`/admin/questions/${id}`, {
    method: 'DELETE',
  }),
  suggestQuizLogic: (data: any) => fetcher('/admin/questions/suggest-logic', {
    method: 'POST',
    body: JSON.stringify(data),
  }),
  getAIStats: () => fetcher('/admin/ai-stats'),
  getChallenges: () => fetcher('/admin/challenges'),
  createChallenge: (data: any) => fetcher('/admin/challenges', {
    method: 'POST',
    body: JSON.stringify(data),
  }),
  updateChallenge: (id: string, data: any) => fetcher(`/admin/challenges/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  }),
  deleteChallenge: (id: string) => fetcher(`/admin/challenges/${id}`, {
    method: 'DELETE',
  }),
  getGamificationStats: () => fetcher('/admin/gamification-stats'),
  getLeaderboard: () => fetcher('/admin/leaderboard'),

  // Badge Management
  getBadges: () => fetcher('/admin/badges'),
  createBadge: (data: any) => {
    // If it's a FormData object (when uploading an image), don't stringify it
    if (data instanceof FormData) {
      return fetcher('/admin/badges', {
        method: 'POST',
        body: data,
      });

    }
    return fetcher('/admin/badges', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  },
  updateBadge: (id: string, data: any) => {
    if (data instanceof FormData) {
      return fetcher(`/admin/badges/${id}`, {
        method: 'PUT',
        body: data,
      });

    }
    return fetcher(`/admin/badges/${id}`, {
      method: 'PUT',
      body: JSON.stringify(data),
    });
  },
  deleteBadge: (id: string) => fetcher(`/admin/badges/${id}`, {
    method: 'DELETE',
  }),

  // Voucher Management
  getVouchers: () => fetcher('/admin/vouchers'),
  createVoucher: (data: any) => fetcher('/admin/vouchers', {
    method: 'POST',
    body: JSON.stringify(data),
  }),
  updateVoucher: (id: string, data: any) => fetcher(`/admin/vouchers/${id}`, {
    method: 'PUT',
    body: JSON.stringify(data),
  }),
  deleteVoucher: (id: string) => fetcher(`/admin/vouchers/${id}`, {
    method: 'DELETE',
  }),
}


