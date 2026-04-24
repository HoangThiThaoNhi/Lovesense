"use client";

import { useEffect, useState, useCallback } from 'react'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'
import {
  MoreVertical,
  Plus,
  Edit,
  Trash2,
  Loader2,
  Award,
} from 'lucide-react'
import { api } from '@/lib/api'
import { BadgeModal } from './badge-modal'

export function BadgesContent() {
  const [badges, setBadges] = useState<any[]>([])
  const [loading, setLoading] = useState(true)
  const [selectedBadge, setSelectedBadge] = useState<any | null>(null)
  const [isBadgeModalOpen, setIsBadgeModalOpen] = useState(false)

  const fetchData = useCallback(async () => {
    setLoading(true)
    try {
      const badgesData = await api.getBadges()
      setBadges(badgesData)
    } catch (error) {
      console.error('Failed to fetch badges data:', error)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    fetchData()
  }, [fetchData])

  const handleDeleteBadge = async (id: string) => {
    if (!confirm('Bạn có chắc muốn xóa huy hiệu này?')) return
    try {
      await api.deleteBadge(id)
      fetchData()
    } catch (error: any) {
      alert('Lỗi: ' + error.message)
    }
  }

  const openCreateBadgeDialog = () => {
    setSelectedBadge(null)
    setIsBadgeModalOpen(true)
  }

  const openEditBadgeDialog = (b: any) => {
    setSelectedBadge(b)
    setIsBadgeModalOpen(true)
  }

  return (
    <div className="p-8 max-w-7xl font-outfit relative">
      {loading && (
        <div className="absolute inset-0 bg-background/50 backdrop-blur-sm z-50 flex items-center justify-center">
          <Loader2 className="w-16 h-16 text-secondary animate-spin" />
        </div>
      )}
      
      {/* Tiêu đề */}
      <div className="mb-10 flex items-end justify-between">
        <div>
          <h1 className="text-4xl font-extrabold text-white mb-3 tracking-tight flex items-center gap-4">
            <Award className="w-10 h-10 text-emerald-500" />
            Hệ thống Huy hiệu
          </h1>
          <p className="text-muted-foreground font-medium text-lg italic opacity-80 decoration-secondary/30 underline-offset-4">
            Quản lý cấp độ và huy hiệu để tôn vinh người dùng tương tác xuất sắc
          </p>
        </div>
      </div>

      <div className="flex items-center justify-between mb-8">
        <h2 className="text-2xl font-black text-white flex items-center gap-3">
          Danh sách huy hiệu
        </h2>
        <Button 
          onClick={openCreateBadgeDialog}
          className="bg-gradient-to-r from-emerald-500 to-teal-600 text-white hover:scale-105 transition-all shadow-xl shadow-emerald-500/20 rounded-2xl h-12 px-6 font-bold"
        >
          <Plus className="w-5 h-5 mr-3" />
          Tạo huy hiệu mới
        </Button>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        {badges.map((badge) => (
          <Card key={badge.id} className="p-6 bg-card/30 border-border/40 backdrop-blur-md hover:bg-card/50 transition-all rounded-3xl group border-2 hover:border-secondary/30">
            <div className="flex justify-between items-start mb-6">
              <div className="w-16 h-16 rounded-2xl bg-white/5 flex items-center justify-center text-3xl shadow-inner group-hover:scale-110 transition-transform">
                {badge.icon_url?.startsWith('http') ? (
                  <img src={badge.icon_url} className="w-10 h-10 object-contain" alt="" />
                ) : (
                  badge.icon_url || '🏅'
                )}
              </div>
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="ghost" size="icon" className="rounded-xl hover:bg-white/10">
                    <MoreVertical className="w-4 h-4" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end" className="bg-card/95 border-border backdrop-blur-xl rounded-xl">
                  <DropdownMenuItem onClick={() => openEditBadgeDialog(badge)} className="cursor-pointer gap-2"><Edit className="w-4 h-4 text-emerald-500" /> Sửa</DropdownMenuItem>
                  <DropdownMenuItem onClick={() => handleDeleteBadge(badge.id)} className="cursor-pointer gap-2 text-destructive"><Trash2 className="w-4 h-4" /> Xóa</DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            </div>
            
            <h3 className="text-lg font-black text-white mb-1">{badge.name}</h3>
            <p className="text-xs text-muted-foreground line-clamp-2 mb-4 h-8 overflow-hidden">{badge.description}</p>
            
            <div className="pt-4 border-t border-white/5 flex items-center justify-between">
              <div className="text-[10px] font-black text-muted-foreground uppercase tracking-widest">Yêu cầu</div>
              <div className="font-black text-secondary">{badge.points_required} XP</div>
            </div>
          </Card>
        ))}
      </div>

      <BadgeModal
        badge={selectedBadge}
        isOpen={isBadgeModalOpen}
        onClose={() => setIsBadgeModalOpen(false)}
        onSuccess={fetchData}
      />
    </div>
  )
}
