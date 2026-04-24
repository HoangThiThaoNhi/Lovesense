"use client";

import { useEffect, useState } from 'react'
import { Card } from '@/components/ui/card'
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  AreaChart,
  Area,
} from 'recharts'
import { 
  Users, 
  Heart, 
  Zap, 
  TrendingUp, 
  Activity, 
  ShieldCheck, 
  History, 
  ArrowUpRight, 
  Briefcase,
  Sparkles,
  Loader2
} from 'lucide-react'
import { api } from '@/lib/api'
import { analyticsData } from '@/lib/mock-data' // Giữ lại biểu đồ mock cho đẹp mắt vì data BE chưa đủ chuỗi thời gian

import { Button } from '@/components/ui/button'

export function DashboardContent() {
  const [mounted, setMounted] = useState(false)
  const [stats, setStats] = useState<any>(null)
  const [logs, setLogs] = useState<any[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    setMounted(true)
    const fetchData = async () => {
      try {
        const [statsData, logsData] = await Promise.all([
          api.getStats(),
          api.getLogs()
        ])
        setStats(statsData)
        setLogs(logsData.logs || [])
      } catch (error) {
        console.error('Failed to fetch dashboard data:', error)
      } finally {
        setLoading(false)
      }
    }
    fetchData()
  }, [])

  if (!mounted || loading) return (
    <div className="flex items-center justify-center min-h-screen">
      <Loader2 className="w-12 h-12 text-primary animate-spin" />
    </div>
  )

  return (
    <div className="p-8 w-full font-outfit">
      {/* Tiêu đề Chào mừng vjp */}
      <div className="mb-12 flex items-center justify-between">
        <div className="space-y-2">
          <h1 className="text-5xl font-black text-white tracking-tighter leading-none mb-1">
            Chào mừng, <span className="text-transparent bg-clip-text bg-gradient-to-r from-primary to-secondary">Quản trị viên!</span>
          </h1>
          <p className="text-muted-foreground text-lg font-medium opacity-80 italic flex items-center gap-2">
            Hệ thống đang vận hành tối ưu với <span className="text-emerald-500 font-bold not-italic">99.9% uptime</span>
            <Activity className="w-5 h-5 text-emerald-500 animate-pulse" />
          </p>
        </div>
        <div className="px-6 py-3 rounded-2xl bg-white/5 border border-white/10 flex items-center gap-4 shadow-2xl backdrop-blur-xl">
           <div className="w-10 h-10 rounded-xl bg-primary/20 flex items-center justify-center text-primary">
              <ShieldCheck className="w-6 h-6" />
           </div>
           <div>
              <p className="text-[10px] font-black text-muted-foreground uppercase opacity-70">Phiên làm việc</p>
              <p className="text-sm font-bold text-white">Xác thực: Admin Toàn Cầu</p>
           </div>
        </div>
      </div>

      {/* Chỉ số tổng quan vjp */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
        <StatCard
          label="Tổng người dùng"
          value={stats?.totalUsers?.toLocaleString('vi-VN') || '0'}
          change={stats?.userGrowthRate || 0}
          icon={Users}
          color="from-primary to-secondary"
        />
        <StatCard
          label="Lượt ghép đôi"
          value={stats?.newMatches?.toLocaleString('vi-VN') || '0'}
          change={stats?.matchGrowthRate || 0}
          icon={Heart}
          color="from-rose-500 to-pink-500"
        />
        <StatCard
          label="Tỷ lệ tương tác"
          value={`${stats?.engagementRate || 0}%`}
          change={stats?.engagementGrowthRate || 0}
          icon={Zap}
          color="from-yellow-500 to-orange-500"
        />
        <StatCard
          label="Người dùng đang hoạt động"
          value={stats?.activeUsers?.toLocaleString('vi-VN') || '0'}
          change={stats?.activeRate || 0}
          icon={TrendingUp}
          color="from-emerald-500 to-teal-500"
        />
      </div>

      <div className="grid grid-cols-12 gap-8 mb-12">
        {/* Biểu đồ tăng trưởng vjp */}
        <Card className="col-span-12 lg:col-span-8 p-8 bg-card/30 border-border/40 backdrop-blur-md rounded-[32px] shadow-2xl">
          <div className="flex items-center justify-between mb-10">
             <h3 className="text-2xl font-black text-white flex items-center gap-3">
               <Activity className="w-7 h-7 text-primary" />
               Hiệu quả hệ thống qua AI
             </h3>
             <div className="flex gap-4">
                <div className="flex items-center gap-2 text-xs font-bold text-muted-foreground">
                  <div className="w-3 h-3 bg-primary rounded-full shadow-lg shadow-primary/40" /> Người dùng
                </div>
                <div className="flex items-center gap-2 text-xs font-bold text-muted-foreground">
                  <div className="w-3 h-3 bg-secondary rounded-full shadow-lg shadow-secondary/40" /> Ghép đôi
                </div>
             </div>
          </div>
          <div className="h-[400px]">
             <ResponsiveContainer width="100%" height="100%">
               <AreaChart data={analyticsData}>
                 <defs>
                   <linearGradient id="colorUsers" x1="0" y1="0" x2="0" y2="1">
                     <stop offset="5%" stopColor="#eb5e75" stopOpacity={0.8} />
                     <stop offset="95%" stopColor="#eb5e75" stopOpacity={0} />
                   </linearGradient>
                 </defs>
                 <CartesianGrid strokeDasharray="3 3" stroke="rgba(255,255,255,0.05)" />
                 <XAxis dataKey="date" stroke="#9ca3af" axisLine={false} tickLine={false} />
                 <YAxis stroke="#9ca3af" axisLine={false} tickLine={false} />
                 <Tooltip 
                    contentStyle={{ 
                      backgroundColor: 'rgba(10,10,11,0.95)', 
                      border: '1px solid rgba(255,255,255,0.1)', 
                      borderRadius: '20px',
                      backdropFilter: 'blur(10px)',
                      fontWeight: 'bold',
                      boxShadow: '0 25px 50px -12px rgba(0,0,0,0.5)'
                    }} 
                 />
                 <Area 
                    type="monotone" 
                    dataKey="users" 
                    stroke="#eb5e75" 
                    fillOpacity={1} 
                    fill="url(#colorUsers)" 
                    strokeWidth={4}
                    animationDuration={2000}
                 />
                 <Line type="monotone" dataKey="matches" stroke="#8b4fb5" strokeWidth={4} dot={{ r: 6, fill: '#8b4fb5' }} />
               </AreaChart>
             </ResponsiveContainer>
          </div>
        </Card>

        {/* Trạng thái AI vjp */}
        <Card className="col-span-12 lg:col-span-4 p-8 bg-gradient-to-br from-primary/10 to-transparent border-white/10 backdrop-blur-md rounded-[32px] shadow-2xl relative overflow-hidden group">
          <Sparkles className="absolute top-6 right-6 w-10 h-10 text-primary opacity-20 group-hover:opacity-100 transition-opacity animate-pulse" />
          <h3 className="text-2xl font-black text-white mb-8 flex items-center gap-3">
             <Briefcase className="w-7 h-7 text-primary" />
             Sức khỏe AI
          </h3>
          <div className="space-y-6">
            <AIStatItem label="Độ chính xác Matching" value="94.8%" color="text-emerald-500" progress={94.8} />
            <AIStatItem label="Tỷ lệ phản hồi AI" value="82.4%" color="text-primary" progress={82.4} />
            <AIStatItem label="Phân tích tâm lý" value="76.2%" color="text-secondary" progress={76.2} />
            <AIStatItem label="Gợi ý Thử thách" value="88.9%" color="text-yellow-500" progress={88.9} />
          </div>
          <div className="mt-12 p-6 rounded-3xl bg-black/40 border border-white/5">
             <p className="text-xs font-bold text-muted-foreground uppercase mb-2">Thông điệp hệ thống</p>
             <p className="text-sm font-medium text-foreground italic leading-relaxed">
               "Mô hình AI mới đang đạt hiệu suất vượt mong đợi trong việc ghép đôi dựa trên sở thích âm nhạc."
             </p>
          </div>
        </Card>
      </div>

      {/* Lịch sử thao tác Admin vjp */}
      <Card className="bg-card/30 border-border/40 backdrop-blur-md overflow-hidden rounded-[32px] shadow-2xl">
        <div className="p-8 border-b border-white/10 flex items-center justify-between">
          <h3 className="text-2xl font-black text-white flex items-center gap-3">
            <History className="w-7 h-7 text-secondary" />
            Lịch sử thao tác Quản trị viên
          </h3>
          <Button variant="ghost" className="text-xs font-bold text-primary hover:bg-primary/10 rounded-xl">
             Xem tất cả báo cáo
          </Button>
        </div>
        <div className="overflow-x-auto px-4 pb-4">
          <table className="w-full">
            <thead className="bg-white/5 border-b border-white/5">
              <tr>
                <th className="px-8 py-6 text-left text-xs font-black text-muted-foreground uppercase tracking-widest">Thời gian</th>
                <th className="px-8 py-6 text-left text-xs font-black text-muted-foreground uppercase tracking-widest">Người thực hiện</th>
                <th className="px-8 py-6 text-left text-xs font-black text-muted-foreground uppercase tracking-widest">Hành động</th>
                <th className="px-8 py-6 text-left text-xs font-black text-muted-foreground uppercase tracking-widest">Đối tượng mục tiêu</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-white/5">
              {(!logs || logs.length === 0) ? (
                <tr>
                  <td colSpan={4} className="px-8 py-20 text-center">
                    <div className="flex flex-col items-center gap-3 opacity-40">
                      <History className="w-12 h-12 text-muted-foreground" />
                      <p className="text-sm font-bold text-muted-foreground italic uppercase tracking-widest">
                        Chưa ghi nhận hoạt động nào gần đây
                      </p>
                    </div>
                  </td>
                </tr>
              ) : (
                logs.map((log: any) => (
                  <tr key={log.id} className="hover:bg-white/5 transition-all group">
                    <td className="px-8 py-6 text-sm font-bold text-muted-foreground italic opacity-70 group-hover:opacity-100 transition-opacity whitespace-nowrap">
                      {new Date(log.created_at).toLocaleString('vi-VN')}
                    </td>
                    <td className="px-8 py-6">
                      <div className="flex items-center gap-4">
                        <div className="w-10 h-10 rounded-xl bg-secondary/10 flex items-center justify-center text-secondary font-black text-sm border border-secondary/10 group-hover:bg-secondary group-hover:text-white transition-all duration-300">
                          {log.admin?.email?.charAt(0).toUpperCase() || 'A'}
                        </div>
                        <div className="flex flex-col">
                          <span className="text-sm font-black text-white">{log.admin?.profile?.display_name || 'Hệ thống'}</span>
                          <span className="text-[10px] font-bold text-muted-foreground opacity-50 uppercase tracking-tighter">{log.admin?.email || 'System'}</span>
                        </div>
                      </div>
                    </td>
                    <td className="px-8 py-6">
                      <span className="px-3 py-1.5 rounded-xl bg-primary/10 text-primary text-[10px] font-black uppercase tracking-widest border border-primary/20 group-hover:bg-primary group-hover:text-white transition-all duration-300 shadow-sm shadow-primary/10">
                        {log.action}
                      </span>
                    </td>
                    <td className="px-8 py-6">
                       <span className="text-sm font-black text-foreground opacity-90 group-hover:text-secondary transition-colors duration-300 line-clamp-1">
                         {log.target}
                       </span>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </Card>
    </div>
  )
}

function StatCard({ label, value, change, icon: Icon, color }: any) {
  return (
    <Card className="p-8 bg-card/30 border-border/40 backdrop-blur-md overflow-hidden relative group rounded-[32px] shadow-xl hover:shadow-primary/10 transition-all hover:scale-[1.02]">
      <div className={`absolute -right-20 -top-20 w-48 h-48 bg-gradient-to-br ${color} opacity-10 rounded-full blur-3xl group-hover:opacity-20 transition-opacity`} />
      <div className="relative z-10">
        <div className="flex items-start justify-between mb-8">
          <div className={`w-14 h-14 rounded-2xl bg-gradient-to-br ${color} flex items-center justify-center shadow-lg`}>
            <Icon className="w-7 h-7 text-white" />
          </div>
          <div className={`flex items-center gap-1 text-sm font-black ${change >= 0 ? 'text-emerald-500' : 'text-red-500'}`}>
            <ArrowUpRight className={`w-4 h-4 ${change < 0 ? 'rotate-90' : ''}`} />
            {change}%
          </div>
        </div>
        <p className="text-sm font-bold text-muted-foreground uppercase tracking-widest mb-2">{label}</p>
        <p className="text-4xl font-black text-white tracking-tighter">{value}</p>
      </div>
    </Card>
  )
}

function AIStatItem({ label, value, color, progress }: any) {
  return (
    <div className="space-y-2">
      <div className="flex justify-between items-end">
        <span className="text-xs font-bold text-muted-foreground uppercase">{label}</span>
        <span className={`text-sm font-black ${color}`}>{value}</span>
      </div>
      <div className="h-2 w-full bg-white/5 rounded-full overflow-hidden">
        <div 
          className={`h-full bg-gradient-to-r from-primary to-secondary transition-all duration-1000 ease-out`} 
          style={{ width: `${progress}%` }}
        />
      </div>
    </div>
  )
}
