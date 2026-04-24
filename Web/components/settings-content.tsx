"use client";

import { useState } from 'react'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import {
  Settings as SettingsIcon,
  Bell,
  Lock,
  Globe,
  Save,
  Loader2,
  CheckCircle2,
  XCircle,
} from 'lucide-react'
import { api } from '@/lib/api'

export function SettingsContent() {
  const [settings, setSettings] = useState({
    platformName: 'LOVESENSE',
    adminEmail: 'admin@lovesense.vn',
    supportEmail: 'support@lovesense.vn',
    maxUsersDaily: '1000',
    maintenanceMode: false,
  })

  // State cho đổi mật khẩu
  const [passwords, setPasswords] = useState({
    currentPassword: '',
    newPassword: '',
    confirmPassword: '',
  })
  const [passwordLoading, setPasswordLoading] = useState(false)
  const [passwordStatus, setPasswordStatus] = useState<null | 'success' | 'error'>(null)
  const [errorMessage, setErrorMessage] = useState('')

  const handleChange = (field: string, value: string | boolean) => {
    setSettings((prev) => ({ ...prev, [field]: value }))
  }

  const handlePasswordSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (passwords.newPassword !== passwords.confirmPassword) {
      setPasswordStatus('error')
      setErrorMessage('Mật khẩu xác nhận không khớp')
      return
    }

    setPasswordLoading(true)
    setPasswordStatus(null)
    setErrorMessage('')

    try {
      await api.changeAdminPassword({
        currentPassword: passwords.currentPassword,
        newPassword: passwords.newPassword
      })
      setPasswordStatus('success')
      setPasswords({ currentPassword: '', newPassword: '', confirmPassword: '' })
    } catch (error: any) {
      setPasswordStatus('error')
      setErrorMessage(error.message || 'Lỗi khi đổi mật khẩu')
    } finally {
      setPasswordLoading(false)
    }
  }

  return (
    <div className="p-8 max-w-4xl font-outfit">
      {/* Tiêu đề */}
      <div className="mb-10">
        <h1 className="text-4xl font-black text-white tracking-tight mb-2">Cài đặt hệ thống</h1>
        <p className="text-muted-foreground text-lg italic opacity-80">Cấu hình nền tảng và bảo mật tài khoản quản trị</p>
      </div>

      <div className="grid gap-8">
        {/* Cài đặt chung */}
        <Card className="p-8 bg-card/30 border-border/40 backdrop-blur-md rounded-[32px] shadow-2xl">
          <div className="flex items-center gap-4 mb-8">
            <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-primary to-secondary flex items-center justify-center shadow-lg">
              <SettingsIcon className="w-6 h-6 text-white" />
            </div>
            <h2 className="text-2xl font-black text-white">Cấu hình chung</h2>
          </div>

          <div className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="space-y-2">
                <label className="text-sm font-bold text-muted-foreground uppercase tracking-wider ml-1">Tên nền tảng</label>
                <Input
                  value={settings.platformName}
                  onChange={(e) => handleChange('platformName', e.target.value)}
                  className="h-12 bg-secondary/10 border-border/40 rounded-xl font-bold"
                />
              </div>
              <div className="space-y-2">
                <label className="text-sm font-bold text-muted-foreground uppercase tracking-wider ml-1">Giới hạn User/Ngày</label>
                <Input
                  type="number"
                  value={settings.maxUsersDaily}
                  onChange={(e) => handleChange('maxUsersDaily', e.target.value)}
                  className="h-12 bg-secondary/10 border-border/40 rounded-xl font-bold"
                />
              </div>
            </div>
            <div className="space-y-2">
              <label className="text-sm font-bold text-muted-foreground uppercase tracking-wider ml-1">Email quản trị</label>
              <Input
                type="email"
                value={settings.adminEmail}
                onChange={(e) => handleChange('adminEmail', e.target.value)}
                className="h-12 bg-secondary/10 border-border/40 rounded-xl font-bold"
              />
            </div>
          </div>
        </Card>

        {/* Đổi mật khẩu - Yêu cầu cụ thể của User */}
        <Card className="p-8 bg-card/30 border-border/40 backdrop-blur-md rounded-[32px] shadow-2xl">
          <div className="flex items-center gap-4 mb-8">
            <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-red-500 to-rose-600 flex items-center justify-center shadow-lg">
              <Lock className="w-6 h-6 text-white" />
            </div>
            <h2 className="text-2xl font-black text-white">Đổi mật khẩu quản trị</h2>
          </div>

          <form onSubmit={handlePasswordSubmit} className="space-y-6">
            <div className="space-y-4">
              <div className="space-y-2">
                <Input
                  type="password"
                  placeholder="Mật khẩu hiện tại"
                  value={passwords.currentPassword}
                  onChange={(e) => setPasswords({ ...passwords, currentPassword: e.target.value })}
                  className="h-12 bg-secondary/10 border-border/40 rounded-xl font-bold"
                  required
                />
              </div>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <Input
                  type="password"
                  placeholder="Mật khẩu mới"
                  value={passwords.newPassword}
                  onChange={(e) => setPasswords({ ...passwords, newPassword: e.target.value })}
                  className="h-12 bg-secondary/10 border-border/40 rounded-xl font-bold"
                  required
                />
                <Input
                  type="password"
                  placeholder="Xác nhận mật khẩu mới"
                  value={passwords.confirmPassword}
                  onChange={(e) => setPasswords({ ...passwords, confirmPassword: e.target.value })}
                  className="h-12 bg-secondary/10 border-border/40 rounded-xl font-bold"
                  required
                />
              </div>
            </div>

            {passwordStatus === 'success' && (
              <div className="flex items-center gap-2 p-4 bg-emerald-500/10 text-emerald-500 rounded-xl border border-emerald-500/20 font-bold italic">
                <CheckCircle2 className="w-5 h-5" />
                Đã đổi mật khẩu thành công!
              </div>
            )}

            {passwordStatus === 'error' && (
              <div className="flex items-center gap-2 p-4 bg-red-500/10 text-red-500 rounded-xl border border-red-500/20 font-bold italic">
                <XCircle className="w-5 h-5" />
                {errorMessage}
              </div>
            )}

            <Button 
              type="submit" 
              disabled={passwordLoading}
              className="w-full h-12 bg-gradient-to-r from-red-500 to-rose-600 text-white font-black uppercase tracking-widest rounded-xl hover:scale-[1.01] transition-all shadow-lg shadow-red-500/20"
            >
              {passwordLoading ? <Loader2 className="w-5 h-5 animate-spin" /> : 'Cập nhật mật khẩu'}
            </Button>
          </form>
        </Card>

        {/* Chế độ bảo trì */}
        <Card className="p-8 bg-card/30 border-border/40 backdrop-blur-md rounded-[32px] shadow-2xl">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-amber-500 to-orange-600 flex items-center justify-center shadow-lg">
                <Globe className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-black text-white">Chế độ bảo trì</h2>
                <p className="text-sm text-muted-foreground font-medium italic opacity-70">Tạm ngắt truy cập ứng dụng cho người dùng</p>
              </div>
            </div>
            <button
              onClick={() => handleChange('maintenanceMode', !settings.maintenanceMode)}
              className={`relative inline-flex h-10 w-20 items-center rounded-full transition-all duration-500 ${
                settings.maintenanceMode ? 'bg-primary shadow-[0_0_15px_rgba(235,94,117,0.5)]' : 'bg-white/10'
              }`}
            >
              <div
                className={`absolute left-1 h-8 w-8 rounded-full bg-white shadow-lg transition-all duration-500 ${
                  settings.maintenanceMode ? 'translate-x-10' : 'translate-x-0'
                }`}
              />
            </button>
          </div>
        </Card>
      </div>

      <div className="mt-12 flex justify-end gap-4">
        <Button variant="ghost" className="h-12 px-8 font-bold text-muted-foreground hover:text-white rounded-xl">Hủy bỏ</Button>
        <Button className="h-12 px-10 bg-white text-black hover:bg-white/90 font-black uppercase tracking-widest rounded-xl shadow-xl transition-all hover:scale-105">
          <Save className="w-5 h-5 mr-3" />
          Lưu tất cả cấu hình
        </Button>
      </div>
    </div>
  )
}
