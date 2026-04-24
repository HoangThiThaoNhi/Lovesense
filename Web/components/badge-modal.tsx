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
import { Award, Loader2, Upload } from 'lucide-react'
import { api } from '@/lib/api'

interface BadgeModalProps {
  badge: any | null
  isOpen: boolean
  onClose: () => void
  onSuccess: () => void
}

export function BadgeModal({ badge, isOpen, onClose, onSuccess }: BadgeModalProps) {
  const [loading, setLoading] = useState(false)
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    points_required: 0,
    icon_url: ''
  })
  const [selectedFile, setSelectedFile] = useState<File | null>(null)
  const [previewUrl, setPreviewUrl] = useState<string | null>(null)

  useEffect(() => {
    if (badge) {
      setFormData({
        name: badge.name || '',
        description: badge.description || '',
        points_required: badge.points_required || 0,
        icon_url: badge.icon_url || ''
      })
      setPreviewUrl(badge.icon_url ? (badge.icon_url.startsWith('http') ? badge.icon_url : `${process.env.NEXT_PUBLIC_API_URL?.replace('/api', '')}${badge.icon_url}`) : null)
    } else {
      setFormData({
        name: '',
        description: '',
        points_required: 0,
        icon_url: ''
      })
      setPreviewUrl(null)
    }
    setSelectedFile(null)
  }, [badge, isOpen])

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (file) {
      setSelectedFile(file)
      setPreviewUrl(URL.createObjectURL(file))
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    try {
      const data = new FormData()
      data.append('name', formData.name)
      data.append('description', formData.description)
      data.append('points_required', formData.points_required.toString())
      if (selectedFile) {
        data.append('icon', selectedFile)
      } else {
        data.append('icon_url', formData.icon_url)
      }

      if (badge?.id) {
        await api.updateBadge(badge.id, data)
      } else {
        await api.createBadge(data)
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
            <Award className="w-6 h-6 text-secondary" />
            {badge?.id ? 'Chỉnh sửa huy hiệu' : 'Tạo huy hiệu mới'}
          </DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-6 py-4">
          <div className="space-y-2">
            <Label htmlFor="name" className="font-bold text-muted-foreground">Tên huy hiệu</Label>
            <Input
              id="name"
              placeholder="Ví dụ: Trái Tim Vàng"
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-secondary/20"
              required
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="desc" className="font-bold text-muted-foreground">Mô tả</Label>
            <Textarea
              id="desc"
              placeholder="Ý nghĩa của huy hiệu này..."
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              className="bg-white/5 border-white/10 min-h-[80px] rounded-xl focus:ring-secondary/20 resize-none"
              required
            />
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="pts" className="font-bold text-muted-foreground">Điểm yêu cầu</Label>
              <Input
                id="pts"
                type="number"
                value={formData.points_required}
                onChange={(e) => setFormData({ ...formData, points_required: parseInt(e.target.value) })}
                className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-secondary/20"
                required
              />
            </div>
            <div className="space-y-2">
               <Label className="font-bold text-muted-foreground">Icon (Emoji / 3D Image)</Label>
               <div className="flex gap-2">
                  <Input
                    placeholder="🏆"
                    value={formData.icon_url}
                    onChange={(e) => setFormData({ ...formData, icon_url: e.target.value })}
                    className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-secondary/20"
                  />
                  <Label htmlFor="icon-upload" className="flex items-center justify-center px-4 bg-white/5 border border-white/10 rounded-xl cursor-pointer hover:bg-white/10 transition-colors">
                    <Upload className="w-5 h-5" />
                    <input id="icon-upload" type="file" className="hidden" accept="image/*" onChange={handleFileChange} />
                  </Label>
               </div>
            </div>
          </div>

          {previewUrl && (
            <div className="flex items-center justify-center p-4 bg-white/5 rounded-2xl border border-white/10">
               <div className="text-center">
                  <p className="text-[10px] font-black text-muted-foreground uppercase mb-2">Xem trước</p>
                  {previewUrl.length < 10 ? <span className="text-4xl">{previewUrl}</span> : <img src={previewUrl} className="w-20 h-20 object-contain" alt="Preview" />}
               </div>
            </div>
          )}

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
              className="bg-gradient-to-r from-secondary to-purple-600 text-white rounded-xl h-12 px-8 font-bold hover:scale-105 transition-all shadow-xl shadow-secondary/20"
            >
              {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : (badge?.id ? 'Cập nhật' : 'Tạo huy hiệu')}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
