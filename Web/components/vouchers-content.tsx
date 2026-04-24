'use client'

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
  Ticket,
  Calendar,
  ShieldCheck
} from 'lucide-react'
import { api } from '@/lib/api'
import { VoucherModal } from './voucher-modal'

export function VouchersContent() {
  const [vouchers, setVouchers] = useState<any[]>([])
  const [badges, setBadges] = useState<any[]>([])
  const [loading, setLoading] = useState(true)
  const [selectedVoucher, setSelectedVoucher] = useState<any | null>(null)
  const [isVoucherModalOpen, setIsVoucherModalOpen] = useState(false)

  const fetchData = useCallback(async () => {
    setLoading(true)
    try {
      const [vouchersData, badgesData] = await Promise.all([
        api.getVouchers(),
        api.getBadges()
      ])
      setVouchers(vouchersData)
      setBadges(badgesData)
    } catch (error) {
      console.error('Failed to fetch vouchers data:', error)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    fetchData()
  }, [fetchData])

  const handleDeleteVoucher = async (id: string) => {
    if (!confirm('Bạn có chắc muốn xóa voucher này?')) return
    try {
      await api.deleteVoucher(id)
      fetchData()
    } catch (error: any) {
      alert('Lỗi: ' + error.message)
    }
  }

  const openCreateVoucherDialog = () => {
    setSelectedVoucher(null)
    setIsVoucherModalOpen(true)
  }

  const openEditVoucherDialog = (v: any) => {
    setSelectedVoucher(v)
    setIsVoucherModalOpen(true)
  }

  const handleExpireVoucher = async (id: string) => {
    if (!confirm('Bạn có chắc muốn cho voucher này hết hạn ngay lập tức?')) return
    try {
      // Set end_date to 1 second ago to ensure it's definitely in the past
      const pastDate = new Date(Date.now() - 1000).toISOString()
      await api.updateVoucher(id, { end_date: pastDate })
      fetchData()
    } catch (error: any) {
      alert('Lỗi: ' + error.message)
    }
  }

  return (
    <div className="p-8 max-w-7xl font-outfit relative">
      {loading && (
        <div className="absolute inset-0 bg-background/50 backdrop-blur-sm z-50 flex items-center justify-center">
          <Loader2 className="w-16 h-16 text-indigo-500 animate-spin" />
        </div>
      )}
      
      {/* Tiêu đề */}
      <div className="mb-10 flex items-end justify-between">
        <div>
          <h1 className="text-4xl font-extrabold text-white mb-3 tracking-tight flex items-center gap-4">
            <Ticket className="w-10 h-10 text-indigo-500" />
            Kho Voucher & Quà tặng
          </h1>
          <p className="text-muted-foreground font-medium text-lg italic opacity-80">
            Quản lý mã quà tặng được trao tự động khi người dùng đạt Huy hiệu
          </p>
        </div>
      </div>

      <div className="flex items-center justify-between mb-8">
        <h2 className="text-2xl font-black text-white flex items-center gap-3">
          Danh sách Voucher
        </h2>
        <Button 
          onClick={openCreateVoucherDialog}
          className="bg-gradient-to-r from-indigo-500 to-purple-600 text-white hover:scale-105 transition-all shadow-xl shadow-indigo-500/20 rounded-2xl h-12 px-6 font-bold"
        >
          <Plus className="w-5 h-5 mr-3" />
          Tạo Voucher mới
        </Button>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {vouchers.map((voucher) => (
          <Card key={voucher.id} className="p-6 bg-card/30 border-border/40 backdrop-blur-md hover:bg-card/50 transition-all rounded-3xl group border-2 hover:border-indigo-500/30 overflow-hidden relative">
            <div className="absolute -right-4 -top-4 w-24 h-24 bg-indigo-500/5 rounded-full blur-2xl group-hover:bg-indigo-500/10 transition-colors pointer-events-none" />
            
            <div className="flex justify-between items-start mb-6">
              <div className="w-14 h-14 rounded-2xl bg-indigo-500/10 flex items-center justify-center shadow-inner group-hover:scale-110 transition-transform">
                <Ticket className="w-7 h-7 text-indigo-500" />
              </div>
              <div className="relative z-10">
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" size="icon" className="rounded-xl hover:bg-white/10">
                      <MoreVertical className="w-4 h-4" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent align="end" className="bg-card/95 border-border backdrop-blur-xl rounded-xl p-2 min-w-[160px]">
                  <DropdownMenuItem onClick={() => openEditVoucherDialog(voucher)} className="cursor-pointer gap-3 py-3 rounded-lg hover:bg-white/5 transition-colors">
                    <div className="w-8 h-8 rounded-lg bg-indigo-500/10 flex items-center justify-center">
                      <Edit className="w-4 h-4 text-indigo-500" />
                    </div>
                    <span className="font-bold text-sm">Sửa voucher</span>
                  </DropdownMenuItem>

                  {new Date(voucher.end_date) > new Date() ? (
                    <DropdownMenuItem onClick={() => handleExpireVoucher(voucher.id)} className="cursor-pointer gap-3 py-3 rounded-lg hover:bg-white/5 transition-colors">
                      <div className="w-8 h-8 rounded-lg bg-amber-500/10 flex items-center justify-center">
                        <Calendar className="w-4 h-4 text-amber-500" />
                      </div>
                      <span className="font-bold text-sm text-amber-500">Hết hạn</span>
                    </DropdownMenuItem>
                  ) : (
                    <DropdownMenuItem disabled className="opacity-50 gap-3 py-3 rounded-lg">
                      <div className="w-8 h-8 rounded-lg bg-red-500/10 flex items-center justify-center">
                        <Calendar className="w-4 h-4 text-red-500" />
                      </div>
                      <span className="font-bold text-sm text-red-500">Đã hết hạn</span>
                    </DropdownMenuItem>
                  )}

                  <DropdownMenuItem onClick={() => handleDeleteVoucher(voucher.id)} className="cursor-pointer gap-3 py-3 rounded-lg hover:bg-red-500/10 transition-colors">
                    <div className="w-8 h-8 rounded-lg bg-red-500/10 flex items-center justify-center">
                      <Trash2 className="w-4 h-4 text-red-500" />
                    </div>
                    <span className="font-bold text-sm text-red-500">Xóa voucher</span>
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            </div>
          </div>
            
            <div className="mb-4 flex items-center gap-3">
               <span className="px-3 py-1 bg-white/5 border border-white/10 rounded-full text-[10px] font-bold text-indigo-400 uppercase tracking-wider">
                  Code: {voucher.code}
               </span>
               {(() => {
                  const now = new Date();
                  const start = new Date(voucher.start_date);
                  const end = new Date(voucher.end_date);
                  if (now < start) return <span className="px-2 py-0.5 bg-amber-500/10 border border-amber-500/20 rounded-full text-[9px] font-bold text-amber-500 uppercase">Sắp diễn ra</span>;
                  if (now > end) return <span className="px-2 py-0.5 bg-red-500/10 border border-red-500/20 rounded-full text-[9px] font-bold text-red-500 uppercase">Hết hạn</span>;
                  return <span className="px-2 py-0.5 bg-emerald-500/10 border border-emerald-500/20 rounded-full text-[9px] font-bold text-emerald-500 uppercase">Đang hiệu lực</span>;
               })()}
            </div>

            <h3 className="text-xl font-black text-white mb-1">{voucher.name}</h3>
            <p className="text-sm text-muted-foreground line-clamp-2 mb-4 h-10 overflow-hidden leading-relaxed">{voucher.description}</p>
            
            <div className="space-y-3 pt-4 border-t border-white/5">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2 text-muted-foreground">
                   <ShieldCheck className="w-4 h-4" />
                   <span className="text-[11px] font-bold uppercase tracking-tight">Huy hiệu yêu cầu</span>
                </div>
                <div className="text-[13px] font-black text-secondary">{voucher.badge?.name || 'Unknown'}</div>
              </div>
              
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2 text-muted-foreground">
                   <Calendar className="w-4 h-4" />
                   <span className="text-[11px] font-bold uppercase tracking-tight">Thời hạn</span>
                </div>
                <div className="text-[12px] font-medium text-white/80">
                  {new Date(voucher.start_date).toLocaleDateString('vi-VN')} - {new Date(voucher.end_date).toLocaleDateString('vi-VN')}
                </div>
              </div>
            </div>
          </Card>
        ))}
      </div>

      {vouchers.length === 0 && !loading && (
        <div className="flex flex-col items-center justify-center py-20 bg-white/5 rounded-[40px] border border-dashed border-white/10">
           <Ticket className="w-20 h-20 text-muted-foreground/20 mb-4" />
           <p className="text-muted-foreground font-medium">Chưa có voucher nào được tạo.</p>
           <Button onClick={openCreateVoucherDialog} variant="link" className="text-indigo-500 mt-2">Tạo ngay</Button>
        </div>
      )}

      <VoucherModal
        voucher={selectedVoucher}
        badges={badges}
        isOpen={isVoucherModalOpen}
        onClose={() => setIsVoucherModalOpen(false)}
        onSuccess={fetchData}
      />
    </div>
  )
}
