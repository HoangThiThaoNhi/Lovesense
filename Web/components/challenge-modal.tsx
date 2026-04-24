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
import { Trophy, Loader2, Target, Award } from 'lucide-react'
import { api } from '@/lib/api'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'

interface ChallengeModalProps {
  challenge: any | null
  isOpen: boolean
  onClose: () => void
  onSuccess: () => void
}

export function ChallengeModal({ challenge, isOpen, onClose, onSuccess }: ChallengeModalProps) {
  const [loading, setLoading] = useState(false)
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    reward_xp: 0,
    trigger_condition: '',
    reward_badge_id: '',
    status: 'active'
  })
  const [badges, setBadges] = useState<any[]>([])

  useEffect(() => {
    const fetchBadges = async () => {
      try {
        const data = await api.getBadges()
        setBadges(data)
      } catch (err) {
        console.error('Failed to fetch badges:', err)
      }
    }
    if (isOpen) fetchBadges()
  }, [isOpen])

  useEffect(() => {
    if (challenge) {
      setFormData({
        title: challenge.title || '',
        description: challenge.description || '',
        reward_xp: challenge.reward_xp || 0,
        trigger_condition: challenge.trigger_condition || '',
        reward_badge_id: challenge.reward_badge_id?.toString() || '',
        status: challenge.status || 'active'
      })
    } else {
      setFormData({
        title: '',
        description: '',
        reward_xp: 0,
        trigger_condition: '',
        reward_badge_id: '',
        status: 'active'
      })
    }
  }, [challenge, isOpen])

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    try {
      if (challenge?.id) {
        await api.updateChallenge(challenge.id, formData)
      } else {
        await api.createChallenge(formData)
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
      <DialogContent className="sm:max-w-[550px] bg-[#0a0a0b] border-border/40 font-outfit rounded-[32px] text-white overflow-hidden">
        <DialogHeader>
          <DialogTitle className="text-2xl font-black flex items-center gap-3">
            <Trophy className="w-6 h-6 text-secondary" />
            {challenge?.id ? 'Chỉnh sửa thử thách' : 'Tạo thử thách mới'}
          </DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-5 py-4 max-h-[70vh] overflow-y-auto px-1 custom-scrollbar">
          <div className="space-y-2">
            <Label htmlFor="title" className="font-bold text-muted-foreground flex items-center gap-2">
              <Target className="w-4 h-4" /> Tên thử thách
            </Label>
            <Input
              id="title"
              placeholder="Ví dụ: Thêm ảnh cá nhân"
              value={formData.title}
              onChange={(e) => setFormData({ ...formData, title: e.target.value })}
              className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-secondary/20"
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="desc" className="font-bold text-muted-foreground">Mô tả chi tiết</Label>
            <Textarea
              id="desc"
              placeholder="Giải thích cách hoàn thành thử thách này..."
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              className="bg-white/5 border-white/10 min-h-[80px] rounded-xl focus:ring-secondary/20 resize-none"
              required
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="xp" className="font-bold text-muted-foreground">Phần thưởng (XP)</Label>
              <Input
                id="xp"
                type="number"
                value={formData.reward_xp}
                onChange={(e) => setFormData({ ...formData, reward_xp: parseInt(e.target.value) })}
                className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-secondary/20"
                required
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="trigger" className="font-bold text-muted-foreground">Mã hành động (Trigger)</Label>
              <Input
                id="trigger"
                placeholder="ADD_PHOTO, COMPLETE_PROFILE..."
                value={formData.trigger_condition}
                onChange={(e) => setFormData({ ...formData, trigger_condition: e.target.value })}
                className="bg-white/5 border-white/10 h-12 rounded-xl focus:ring-secondary/20"
                required
              />
            </div>
          </div>

          <div className="space-y-2">
            <Label className="font-bold text-muted-foreground flex items-center gap-2">
               <Award className="w-4 h-4" /> Huy hiệu tặng kèm (Tùy chọn)
            </Label>
            <Select 
              value={formData.reward_badge_id} 
              onValueChange={(val) => setFormData({ ...formData, reward_badge_id: val })}
            >
              <SelectTrigger className="bg-white/5 border-white/10 h-12 rounded-xl">
                <SelectValue placeholder="Chọn huy hiệu thưởng..." />
              </SelectTrigger>
              <SelectContent className="bg-[#0a0a0b] border-white/10 rounded-xl text-white">
                <SelectItem value="none">Không tặng huy hiệu</SelectItem>
                {badges.map(b => (
                  <SelectItem key={b.id} value={b.id.toString()}>{b.name}</SelectItem>
                ))}
              </SelectContent>
            </Select>
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
              className="bg-gradient-to-r from-secondary to-purple-600 text-white rounded-xl h-12 px-8 font-bold hover:scale-105 transition-all shadow-xl shadow-secondary/20"
            >
              {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : (challenge?.id ? 'Cập nhật' : 'Tạo thử thách')}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
