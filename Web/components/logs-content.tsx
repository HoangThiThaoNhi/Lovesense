"use client";

import { useEffect, useState, useCallback } from 'react'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import {
  History as LucideHistory,
  Loader2,
  Calendar,
  User,
  Shield,
  Activity,
  AlertCircle
} from 'lucide-react'
import { api } from '@/lib/api'

export function LogsContent() {
  const [logs, setLogs] = useState<any[]>([])
  const [loading, setLoading] = useState(true)
  const [page, setPage] = useState(1)
  const [totalPages, setTotalPages] = useState(1)
  const [totalLogs, setTotalLogs] = useState(0)

  const fetchLogs = useCallback(async () => {
    setLoading(true)
    try {
      const data = await api.getLogs(page)
      setLogs(data.logs || [])
      setTotalPages(data.totalPages || 1)
      setTotalLogs(data.total || 0)
    } catch (error) {
      console.error('Failed to fetch logs:', error)
    } finally {
      setLoading(false)
    }
  }, [page])

  useEffect(() => {
    fetchLogs()
  }, [fetchLogs])

  return (
    <div className="p-8 max-w-7xl font-outfit">
      {/* Tiêu đề */}
      <div className="mb-10 flex items-end justify-between">
        <div>
          <h1 className="text-4xl font-extrabold text-white mb-3 tracking-tight flex items-center gap-4">
            <LucideHistory className="w-10 h-10 text-primary" />
            Lịch sử hoạt động hệ thống
          </h1>
          <p className="text-muted-foreground font-medium text-lg italic opacity-80 decoration-primary/30 underline-offset-4">
            Theo dõi mọi tác động hành chính và thay đổi cấu hình trên LOVESENSE
          </p>
        </div>
      </div>

      {/* Stats Summary */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
        <Card className="p-6 bg-gradient-to-br from-primary/10 to-transparent border-white/5 rounded-[32px] shadow-lg backdrop-blur-xl group">
          <p className="text-xs font-black text-muted-foreground uppercase mb-2 tracking-widest">Tổng số thao tác</p>
          <div className="flex items-baseline gap-2">
            <p className="text-4xl font-black text-white">{totalLogs || 0}</p>
            <span className="text-sm font-bold text-muted-foreground opacity-50 italic underline decoration-primary/30 underline-offset-4">kể từ khi khởi tạo</span>
          </div>
        </Card>
        
        <Card className="p-6 bg-gradient-to-br from-emerald-500/10 to-transparent border-white/5 rounded-[32px] shadow-lg backdrop-blur-xl group">
          <p className="text-xs font-black text-muted-foreground uppercase mb-2 tracking-widest">Lần cuối ghi nhận</p>
          <div className="flex items-baseline gap-2">
             <p className="text-lg font-black text-emerald-500">
               {logs && logs.length > 0 ? new Date(logs[0].created_at).toLocaleDateString('vi-VN') : 'N/A'}
             </p>
             <span className="text-xs font-medium text-muted-foreground opacity-50">Gần nhất</span>
          </div>
        </Card>

        <Card className="p-6 bg-gradient-to-br from-secondary/10 to-transparent border-white/5 rounded-[32px] shadow-lg backdrop-blur-xl group">
          <p className="text-xs font-black text-muted-foreground uppercase mb-2 tracking-widest">Trạng thái hệ thống</p>
          <div className="flex items-center gap-2">
             <div className="w-3 h-3 rounded-full bg-emerald-500 animate-pulse shadow-[0_0_10px_rgba(16,185,129,0.5)]" />
             <p className="text-lg font-black text-white">Đang giám sát</p>
          </div>
        </Card>
      </div>

      {/* Main Logs Table */}
      <Card className="bg-card/30 border-border/40 overflow-hidden rounded-[32px] shadow-2xl backdrop-blur-md relative">
        {loading && (
          <div className="absolute inset-0 bg-background/50 backdrop-blur-sm z-10 flex items-center justify-center">
            <Loader2 className="w-12 h-12 text-primary animate-spin" />
          </div>
        )}
        <Table>
          <TableHeader>
            <TableRow className="border-border/40 hover:bg-transparent h-20">
              <TableHead className="text-muted-foreground/80 font-bold uppercase tracking-wider pl-8 w-[220px]">Thời gian</TableHead>
              <TableHead className="text-muted-foreground/80 font-bold uppercase tracking-wider w-[240px]">Quản trị viên</TableHead>
              <TableHead className="text-muted-foreground/80 font-bold uppercase tracking-wider w-[220px]">Hành động</TableHead>
              <TableHead className="text-muted-foreground/80 font-bold uppercase tracking-wider w-[180px]">Đối tượng tác động</TableHead>
              <TableHead className="text-muted-foreground/80 font-bold uppercase tracking-wider pr-8">Chi tiết thao tác</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {(!logs || logs.length === 0) && !loading ? (
              <TableRow>
                <TableCell colSpan={5} className="h-40 text-center">
                  <div className="flex flex-col items-center gap-2 opacity-40">
                    <AlertCircle className="w-10 h-10" />
                    <p className="font-bold">Chưa ghi nhận lịch sử hoạt động</p>
                  </div>
                </TableCell>
              </TableRow>
            ) : (
              logs?.map((log) => (
                <TableRow key={log.id} className="border-b border-border/40 h-24 hover:bg-white/5 transition-colors group">
                  <td className="pl-8">
                    <div className="flex items-center gap-3 text-muted-foreground font-semibold text-sm">
                      <Calendar className="w-4 h-4 opacity-50" />
                      {new Date(log.created_at).toLocaleString('vi-VN')}
                    </div>
                  </td>
                  <td>
                    <div className="flex items-center gap-4 py-2">
                      <div className="w-10 h-10 rounded-xl bg-primary/10 flex items-center justify-center text-primary font-black text-sm border border-primary/20">
                        <Shield className="w-5 h-5" />
                      </div>
                      <div>
                        <p className="font-bold text-foreground line-clamp-1">{log.admin?.profile?.display_name || 'Admin'}</p>
                        <p className="text-[11px] text-muted-foreground opacity-60 uppercase tracking-widest font-medium">{log.admin?.email || 'System'}</p>
                      </div>
                    </div>
                  </td>
                  <td>
                    <span className="inline-flex px-4 py-1.5 bg-white/5 border border-white/10 rounded-xl text-[10px] font-black uppercase tracking-widest text-primary group-hover:bg-primary group-hover:text-white transition-all whitespace-nowrap">
                      {log.action}
                    </span>
                  </td>
                  <td>
                    <div className="font-black text-secondary text-[13px] tracking-tight bg-secondary/5 px-3 py-1 rounded-lg border border-secondary/10 w-fit">
                      {log.target || 'Hệ thống'}
                    </div>
                  </td>
                  <td className="pr-8">
                    <p className="text-xs text-muted-foreground font-medium leading-relaxed italic opacity-75 group-hover:opacity-100 transition-opacity max-w-[300px] line-clamp-2">
                      {log.details || 'Không có chi tiết bổ sung'}
                    </p>
                  </td>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </Card>

      {/* Pagination logs */}
      <div className="mt-10 flex items-center justify-between px-4">
        <div className="flex items-center gap-2 text-muted-foreground font-bold italic">
          <Activity className="w-4 h-4 text-emerald-500" />
          <span>Hệ thống đang hoạt động ổn định</span>
        </div>
        
        <div className="flex items-center gap-6">
          <div className="flex items-center gap-2">
            <span className="text-sm font-bold text-muted-foreground uppercase tracking-widest">Trang</span>
            <div className="w-10 h-10 rounded-xl bg-primary/20 border border-primary/20 flex items-center justify-center font-black text-primary">
              {page}
            </div>
            <span className="text-sm font-bold text-muted-foreground uppercase tracking-widest">/ {totalPages}</span>
          </div>
          <div className="flex gap-3">
            <Button 
              variant="outline" 
              onClick={() => setPage(p => Math.max(1, p - 1))}
              disabled={page === 1 || loading} 
              className="rounded-2xl h-12 px-6 font-bold border-border/40 shadow-sm hover:bg-white/5 transition-all disabled:opacity-30"
            >
              Trước
            </Button>
            <Button 
              variant="outline" 
              onClick={() => setPage(p => Math.min(totalPages, p + 1))}
              disabled={page === totalPages || loading}
              className="rounded-2xl h-12 px-6 font-bold border-border/40 shadow-sm hover:bg-white/5 transition-all disabled:opacity-30"
            >
              Sau
            </Button>
          </div>
        </div>
      </div>
    </div>
  )
}
