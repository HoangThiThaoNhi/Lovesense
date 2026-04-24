'use client'

import { useState, useEffect } from 'react'
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import { 
  Select, 
  SelectContent, 
  SelectItem, 
  SelectTrigger, 
  SelectValue 
} from '@/components/ui/select'
import { Ticket, Loader2 } from 'lucide-react'
import { api } from '@/lib/api'

interface VoucherModalProps {
  voucher: any | null
  badges: any[]
  isOpen: boolean
  onClose: () => void
  onSuccess: () => void
}

export function VoucherModal({ voucher, badges, isOpen, onClose, onSuccess }: VoucherModalProps) {
  const [loading, setLoading] = useState(false)
  const [formData, setFormData] = useState({
    code: '',
    name: '',
    description: '',
    badge_id: '',
    start_date: '',
    end_date: ''
  })

  useEffect(() => {
    if (voucher) {
      setFormData({
        code: voucher.code || '',
        name: voucher.name || '',
        description: voucher.description || '',
        badge_id: voucher.badge_id?.toString() || '',
        start_date: voucher.start_date ? new Date(voucher.start_date).toISOString().split('T')[0] : '',
        end_date: voucher.end_date ? new Date(voucher.end_date).toISOString().split('T')[0] : ''
      })
    } else {
      setFormData({
        code: '',
        name: '',
        description: '',
        badge_id: '',
        start_date: '',
        end_date: ''
      })
    }
  }, [voucher, isOpen])

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!formData.badge_id) {
      alert('Vui lòng chọn một huy hiệu để gán voucher này.')
      return
    }

    setLoading(true)
    try {
      if (voucher?.id) {
        await api.updateVoucher(voucher.id, formData)
      } else {
        await api.createVoucher(formData)
      }
      onSuccess()
      onClose()
    } catch (error) {
      alert('Lỗi: ' + (error as any).message)
    } finally {
      setLoading(false)
    }
  }

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[500px] bg-[#0a0a0b] border-border/40 font-outfit rounded-[32px] text-white">
        <DialogHeader>
          <DialogTitle className="text-2xl font-black flex items-center gap-3">
            <Ticket className="w-6 h-6 text-indigo-500" />
            {voucher?.id ? 'Chỉnh sửa Voucher' : 'Tạo Voucher mới'}
          </DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-6 py-4">
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="code" className="font-bold text-muted-foreground">Mã Voucher</Label>
              <Input
                id="code"
                placeholder="LOVE30"
                value={formData.code}
                onChange={(e) => setFormData({ ...formData, code: e.target.value.toUpperCase() })}
                className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-indigo-500/20"
                required
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="name" className="font-bold text-muted-foreground">Tên Voucher</Label>
              <Input
                id="name"
                placeholder="Giảm 30% VIP"
                value={formData.name}
                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-indigo-500/20"
                required
              />
            </div>
          </div>

          <div className="space-y-2">
            <Label htmlFor="badge" className="font-bold text-muted-foreground">Gán cho Huy hiệu</Label>
            <Select 
              value={formData.badge_id} 
              onValueChange={(val) => setFormData({ ...formData, badge_id: val })}
            >
              <SelectTrigger className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-indigo-500/20">
                <SelectValue placeholder="Chọn huy hiệu yêu cầu..." />
              </SelectTrigger>
              <SelectContent className="bg-[#0a0a0b] border-border">
                {badges.map((b) => (
                  <SelectItem key={b.id} value={b.id.toString()}>
                    {b.name} ({b.points_required} XP)
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-2">
            <Label htmlFor="desc" className="font-bold text-muted-foreground">Quy định & Thể lệ</Label>
            <Textarea
              id="desc"
              placeholder="Nhập chi tiết về cách sử dụng và quy định..."
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              className="bg-white/5 border-white/10 min-h-[100px] rounded-xl focus:ring-indigo-500/20 resize-none"
              required
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="start_date" className="font-bold text-muted-foreground">Ngày bắt đầu</Label>
              <div className="relative">
                <Input
                  id="start_date"
                  type="date"
                  min={new Date().toISOString().split('T')[0]}
                  value={formData.start_date}
                  onChange={(e) => setFormData({ ...formData, start_date: e.target.value })}
                  className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-indigo-500/20 text-white [color-scheme:dark]"
                  required
                />
              </div>
            </div>
            <div className="space-y-2">
              <Label htmlFor="end_date" className="font-bold text-muted-foreground">Ngày kết thúc</Label>
              <div className="relative">
                <Input
                  id="end_date"
                  type="date"
                  min={formData.start_date || new Date().toISOString().split('T')[0]}
                  value={formData.end_date}
                  onChange={(e) => setFormData({ ...formData, end_date: e.target.value })}
                  className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-indigo-500/20 text-white [color-scheme:dark]"
                  required
                />
              </div>
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
              className="bg-gradient-to-r from-indigo-500 to-purple-600 text-white rounded-xl h-12 px-8 font-bold hover:scale-105 transition-all shadow-xl shadow-indigo-500/20"
            >
              {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : (voucher?.id ? 'Cập nhật' : 'Tạo Voucher')}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
