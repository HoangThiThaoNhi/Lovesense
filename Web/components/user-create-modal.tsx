'use client'

import { useState } from 'react'
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { UserPlus, Loader2 } from 'lucide-react'
import { api } from '@/lib/api'

interface UserCreateProps {
  isOpen: boolean
  onClose: () => void
  onSuccess: () => void
}

export function UserCreateModal({ isOpen, onClose, onSuccess }: UserCreateProps) {
  const [loading, setLoading] = useState(false)
  const [formData, setFormData] = useState({
    email: '',
    password: '',
    role: 'user',
    status: 'active'
  })

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    try {
      await api.createUser(formData)
      onSuccess()
      onClose()
      setFormData({ email: '', password: '', role: 'user', status: 'active' })
    } catch (error) {
      alert('Lỗi khi tạo tài khoản: ' + (error as any).message)
    } finally {
      setLoading(false)
    }
  }

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[425px] bg-[#0a0a0b] border-border/40 font-outfit rounded-[32px] text-white">
        <DialogHeader>
          <DialogTitle className="text-2xl font-black flex items-center gap-3">
            <UserPlus className="w-6 h-6 text-primary" />
            Tạo tài khoản mới
          </DialogTitle>
          <DialogDescription className="text-muted-foreground text-xs">
            Điền thông tin bên dưới để khởi tạo tài khoản quản trị hoặc người dùng mới.
          </DialogDescription>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-6 py-4">
          <div className="space-y-2">
            <Label htmlFor="email" className="font-bold text-muted-foreground">Email / Số điện thoại</Label>
            <Input
              id="email"
              placeholder="name@example.com"
              value={formData.email}
              onChange={(e) => setFormData({ ...formData, email: e.target.value })}
              className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-primary/20"
              required
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="pass" className="font-bold text-muted-foreground">Mật khẩu</Label>
            <Input
              id="pass"
              type="password"
              placeholder="••••••••"
              value={formData.password}
              onChange={(e) => setFormData({ ...formData, password: e.target.value })}
              className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-primary/20"
              required
            />
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label className="font-bold text-muted-foreground">Vai trò</Label>
              <Select 
                value={formData.role} 
                onValueChange={(val) => setFormData({ ...formData, role: val })}
              >
                <SelectTrigger className="bg-white/5 border-white/10 h-12 rounded-xl">
                  <SelectValue placeholder="Vai trò" />
                </SelectTrigger>
                <SelectContent className="bg-[#0a0a0b] border-white/10">
                  <SelectItem value="user">Người dùng</SelectItem>
                  <SelectItem value="admin">Quản trị viên</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label className="font-bold text-muted-foreground">Trạng thái</Label>
              <Select 
                value={formData.status} 
                onValueChange={(val) => setFormData({ ...formData, status: val })}
              >
                <SelectTrigger className="bg-white/5 border-white/10 h-12 rounded-xl">
                  <SelectValue placeholder="Trạng thái" />
                </SelectTrigger>
                <SelectContent className="bg-[#0a0a0b] border-white/10">
                  <SelectItem value="active">Hoạt động</SelectItem>
                  <SelectItem value="flagged">Cảnh báo</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
          <DialogFooter className="pt-4">
            <Button 
              type="button" 
              variant="ghost" 
              onClick={onClose}
              className="rounded-xl h-12 font-bold hover:bg-white/5"
            >
              Hủy
            </Button>
            <Button 
              type="submit" 
              disabled={loading}
              className="bg-gradient-to-r from-primary to-secondary text-primary-foreground rounded-xl h-12 px-8 font-bold hover:scale-105 transition-all shadow-xl shadow-primary/20"
            >
              {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : 'Tạo tài khoản'}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
