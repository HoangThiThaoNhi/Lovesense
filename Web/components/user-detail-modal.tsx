'use client'

import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from '@/components/ui/dialog'
import { Badge } from '@/components/ui/badge'
import { Card } from '@/components/ui/card'
import { 
  User, 
  Briefcase, 
  Calendar, 
  Heart, 
  Activity, 
  Shield, 
  Mail, 
  Sparkles,
  Info
} from 'lucide-react'

export function UserDetailModal({ user, isOpen, onClose }: { user: any; isOpen: boolean; onClose: () => void }) {
  if (!user) return null

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'active': return 'bg-emerald-500/10 text-emerald-500 border-emerald-500/20'
      case 'banned': return 'bg-red-500/10 text-red-500 border-red-500/20'
      case 'flagged': return 'bg-amber-500/10 text-amber-500 border-amber-500/20'
      default: return 'bg-gray-500/10 text-gray-500 border-gray-500/20'
    }
  }

  const getStatusLabel = (status: string) => {
    switch (status) {
      case 'active': return 'Hoạt động'
      case 'banned': return 'Bị chặn'
      case 'flagged': return 'Cảnh báo'
      default: return status
    }
  }

  // Parse interests carefully
  let interests: string[] = []
  try {
    const rawInterests = user.profile?.interests
    if (Array.isArray(rawInterests)) {
      interests = rawInterests
    } else if (typeof rawInterests === 'string') {
      interests = JSON.parse(rawInterests)
    }
  } catch (e) {
    interests = []
  }

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-3xl p-0 bg-[#0f1115] border-white/10 overflow-hidden rounded-3xl shadow-2xl text-white">
        <DialogHeader className="sr-only">
          <DialogTitle>Hồ sơ: {user.profile?.display_name}</DialogTitle>
          <DialogDescription>
            Xem chi tiết thông tin cá nhân và lịch sử hoạt động của người dùng.
          </DialogDescription>
        </DialogHeader>

        <div className="max-h-[85vh] overflow-y-auto custom-scrollbar">
          {/* Header Section */}
          <div className="p-8 bg-gradient-to-b from-primary/20 to-transparent border-b border-white/5">
            <div className="flex flex-col md:flex-row gap-8 items-center md:items-start text-center md:text-left">
              {/* Avatar */}
              <div className="w-28 h-28 rounded-3xl bg-secondary/20 flex-shrink-0 flex items-center justify-center text-3xl font-bold border-2 border-white/10 overflow-hidden">
                {user.profile?.avatar ? (
                  <img src={user.profile.avatar} className="w-full h-full object-cover" />
                ) : (
                  user.profile?.display_name?.charAt(0).toUpperCase() || 'U'
                )}
              </div>

              {/* Basic Info */}
              <div className="flex-1 space-y-4">
                <div>
                  <h2 className="text-3xl font-bold text-white mb-2">
                    {user.profile?.display_name || 'Người dùng'}
                  </h2>
                  <div className="flex flex-wrap justify-center md:justify-start gap-3">
                    <Badge className={`px-3 py-0.5 text-[10px] uppercase font-bold tracking-widest ${getStatusColor(user.status)}`}>
                      {getStatusLabel(user.status)}
                    </Badge>
                    <span className="text-sm font-medium text-muted-foreground flex items-center gap-1.5">
                      <Mail className="w-4 h-4" /> {user.email || 'N/A'}
                    </span>
                    <span className="text-sm font-medium text-muted-foreground flex items-center gap-1.5">
                      <Shield className="w-4 h-4" /> ID: {user.id}
                    </span>
                  </div>
                </div>

                {/* Quick Stats */}
                <div className="flex justify-center md:justify-start gap-4">
                  <div className="bg-white/5 px-4 py-2 rounded-xl border border-white/5">
                    <p className="text-[10px] text-muted-foreground uppercase font-bold tracking-wider">Ghép đôi</p>
                    <p className="text-xl font-bold text-primary">{user.matchCount || 0}</p>
                  </div>
                  <div className="bg-white/5 px-4 py-2 rounded-xl border border-white/5">
                    <p className="text-[10px] text-muted-foreground uppercase font-bold tracking-wider">Điểm thưởng</p>
                    <p className="text-xl font-bold text-secondary">{user.profile?.points || 0}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div className="p-8 space-y-10">
            {/* Bio Section */}
            <section>
              <h3 className="text-xs font-bold text-muted-foreground uppercase tracking-widest mb-4 flex items-center gap-2">
                <Info className="w-4 h-4" /> Tiểu sử
              </h3>
              <div className="p-6 bg-white/5 rounded-2xl border border-white/10 text-white/80 leading-relaxed font-medium italic">
                "{user.profile?.bio || 'Người dùng chưa cập nhật thông tin giới thiệu.'}"
              </div>
            </section>

            {/* Core Info Cards */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="p-5 bg-white/5 rounded-2xl border border-white/10 flex items-center gap-4">
                <div className="w-12 h-12 rounded-xl bg-primary/20 flex items-center justify-center text-primary">
                  <User className="w-6 h-6" />
                </div>
                <div>
                  <p className="text-[10px] text-muted-foreground uppercase font-bold tracking-wider">Tuổi / Giới tính</p>
                  <p className="text-lg font-bold text-white">{user.profile?.age || '?' } • {user.profile?.gender || '?'}</p>
                </div>
              </div>
              <div className="p-5 bg-white/5 rounded-2xl border border-white/10 flex items-center gap-4">
                <div className="w-12 h-12 rounded-xl bg-secondary/20 flex items-center justify-center text-secondary">
                  <Briefcase className="w-6 h-6" />
                </div>
                <div>
                  <p className="text-[10px] text-muted-foreground uppercase font-bold tracking-wider">Nghề nghiệp</p>
                  <p className="text-lg font-bold text-white truncate max-w-[150px]">{user.profile?.occupation || 'Chưa cập nhật'}</p>
                </div>
              </div>
            </div>

            {/* Specialties & Interests Row */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
              {/* Characteristics */}
              <section className="bg-white/5 p-6 rounded-2xl border border-white/10">
                <h3 className="text-xs font-bold text-muted-foreground uppercase tracking-widest mb-4 flex items-center gap-2">
                  <Sparkles className="w-4 h-4 text-secondary" /> Đặc điểm nổi bật
                </h3>
                <div className="flex flex-wrap gap-2">
                  {(user.personalityTags || ['Thân thiện', 'Năng động', 'Chân thành']).map((tag: any) => (
                    <div key={tag} className="px-3 py-1.5 bg-black/40 rounded-lg border border-white/10 text-xs font-bold text-white/70">
                      {tag}
                    </div>
                  ))}
                </div>
              </section>

              {/* Interests */}
              <section className="bg-white/5 p-6 rounded-2xl border border-white/10">
                <h3 className="text-xs font-bold text-muted-foreground uppercase tracking-widest mb-4 flex items-center gap-2">
                  <Heart className="w-4 h-4 text-red-400" /> Sở thích
                </h3>
                <div className="flex flex-wrap gap-2">
                  {interests.length > 0 ? (
                    interests.map((tag) => (
                      <Badge key={tag} className="bg-secondary/20 text-secondary border-none px-3 py-1 text-xs font-bold">
                        {tag}
                      </Badge>
                    ))
                  ) : (
                    <p className="text-xs italic text-muted-foreground">Chưa có sở thích</p>
                  )}
                </div>
              </section>
            </div>

            {/* System Info */}
            <section className="bg-white/5 p-6 rounded-2xl border border-white/10">
              <h3 className="text-xs font-bold text-muted-foreground uppercase tracking-widest mb-6">Thông tin hệ thống</h3>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-y-4 gap-x-12">
                <div className="flex items-center justify-between border-b border-white/5 pb-2">
                  <span className="text-sm text-muted-foreground">Ngày tham gia</span>
                  <span className="text-sm font-bold text-white">{user.created_at ? new Date(user.created_at).toLocaleDateString('vi-VN') : 'N/A'}</span>
                </div>
                <div className="flex items-center justify-between border-b border-white/5 pb-2">
                  <span className="text-sm text-muted-foreground">Vai trò</span>
                  <span className="text-sm font-bold text-primary uppercase">{user.role}</span>
                </div>
                <div className="flex items-center justify-between border-b border-white/5 pb-2">
                  <span className="text-sm text-muted-foreground">Tài khoản</span>
                  <span className={`text-sm font-bold ${user.status === 'active' ? 'text-emerald-400' : 'text-red-400'}`}>
                    {user.status === 'active' ? 'Đang hoạt động' : 'Đã khóa'}
                  </span>
                </div>
              </div>
            </section>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  )
}
