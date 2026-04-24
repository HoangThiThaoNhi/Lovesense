'use client'

import { useEffect, useState } from 'react'
import { Card } from '@/components/ui/card'
import {
  LineChart,
  Line,
  BarChart,
  Bar,
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from 'recharts'
import {
  MessageSquare,
  Clock,
  Activity,
  Percent,
  TrendingUp,
  Zap,
  Target,
  Users,
  Heart,
  FileText,
  Loader2,
} from 'lucide-react'
import { api } from '@/lib/api'
import { Button } from '@/components/ui/button'

export function AnalyticsContent() {
  const [loading, setLoading] = useState(true)
  const [data, setData] = useState<any>(null)

  useEffect(() => {
    const fetchData = async () => {
      try {
        const result = await api.getAIStats()
        setData(result)
      } catch (error) {
        console.error('Failed to fetch AI stats:', error)
      } finally {
        setLoading(false)
      }
    }
    fetchData()
  }, [])

  if (loading) {
    return (
      <div className="h-[80vh] flex items-center justify-center">
        <Loader2 className="w-12 h-12 text-primary animate-spin" />
      </div>
    )
  }

  const stats = data || {
    completionRate: 0,
    totalSurveys: 0,
    effectiveness: 0,
    chatRate: 0,
    timeSeries: []
  }

  return (
    <div className="p-8 w-full font-outfit">
      {/* Tiêu đề */}
      <div className="mb-10 flex items-end justify-between">
        <div>
          <h1 className="text-4xl font-extrabold text-white mb-3 tracking-tight">Thống kê & Phân tích AI</h1>
          <p className="text-muted-foreground font-medium text-lg italic opacity-80 decoration-primary/30 underline-offset-4">
            Đo lường hiệu quả ghép đôi và hành vi người dùng thông qua xử lý AI
          </p>
        </div>
        <Button className="bg-white/5 border border-white/10 text-foreground hover:bg-white/10 transition-all rounded-2xl h-12 px-6 font-bold flex items-center gap-2">
          <FileText className="w-5 h-5 text-primary" />
          Xuất báo cáo PDF
        </Button>
      </div>

      {/* Chỉ số Matching Metrics */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
        <MetricCard
          icon={Users}
          label="Tỷ lệ làm khảo sát"
          value={`${stats.completionRate}%`}
          change={2.4}
          color="from-primary to-secondary"
        />
        <MetricCard
          icon={MessageSquare}
          label="Match → Chat Rate"
          value={`${stats.chatRate}%`}
          change={8.5}
          color="from-blue-500 to-cyan-500"
        />
        <MetricCard
          icon={Clock}
          label="Số khảo sát hoàn thành"
          value={stats.totalSurveys.toString()}
          change={15.2}
          color="from-emerald-500 to-teal-500"
        />
        <MetricCard
          icon={Zap}
          label="Hiệu quả AI Match"
          value={`${stats.effectiveness}%`}
          change={3.2}
          color="from-purple-500 to-pink-500"
        />
      </div>

      {/* Biểu đồ so sánh */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-10">
        <Card className="p-8 bg-card/30 border-border/40 backdrop-blur-md rounded-[32px] shadow-2xl">
          <div className="flex items-center justify-between mb-8">
            <h3 className="text-xl font-bold text-white flex items-center gap-3">
              <Zap className="w-6 h-6 text-primary" />
              Tăng trưởng Ghép đôi AI
            </h3>
          </div>
          <ResponsiveContainer width="100%" height={350}>
            <AreaChart data={stats.timeSeries}>
              <defs>
                <linearGradient id="colorMatch" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="5%" stopColor="#eb5e75" stopOpacity={0.8} />
                  <stop offset="95%" stopColor="#eb5e75" stopOpacity={0} />
                </linearGradient>
              </defs>
              <CartesianGrid strokeDasharray="3 3" stroke="rgba(255,255,255,0.05)" />
              <XAxis dataKey="date" stroke="#9ca3af" axisLine={false} tickLine={false} />
              <YAxis stroke="#9ca3af" axisLine={false} tickLine={false} />
              <Tooltip 
                contentStyle={{ 
                  backgroundColor: 'rgba(10,10,11,0.9)', 
                  border: '1px solid rgba(255,255,255,0.1)', 
                  borderRadius: '16px',
                  backdropFilter: 'blur(10px)',
                  fontWeight: 'bold'
                }} 
              />
              <Area type="monotone" dataKey="count" stroke="#eb5e75" fillOpacity={1} fill="url(#colorMatch)" strokeWidth={3} />
            </AreaChart>
          </ResponsiveContainer>
        </Card>

        <Card className="p-8 bg-card/30 border-border/40 backdrop-blur-md rounded-[32px] shadow-2xl">
          <div className="flex items-center justify-between mb-8">
            <h3 className="text-xl font-bold text-white flex items-center gap-3">
              <Activity className="w-6 h-6 text-secondary" />
              Hiệu suất theo ngày
            </h3>
          </div>
          <ResponsiveContainer width="100%" height={350}>
            <BarChart data={stats.timeSeries}>
              <CartesianGrid strokeDasharray="3 3" stroke="rgba(255,255,255,0.05)" />
              <XAxis dataKey="date" stroke="#9ca3af" axisLine={false} tickLine={false} />
              <YAxis stroke="#9ca3af" axisLine={false} tickLine={false} />
              <Tooltip 
                 contentStyle={{ 
                  backgroundColor: 'rgba(10,10,11,0.9)', 
                  border: '1px solid rgba(255,255,255,0.1)', 
                  borderRadius: '16px',
                  backdropFilter: 'blur(10px)',
                  fontWeight: 'bold'
                }} 
              />
              <Bar dataKey="count" fill="#8b4fb5" radius={[8, 8, 0, 0]} barSize={40} />
            </BarChart>
          </ResponsiveContainer>
        </Card>
      </div>

      {/* Chỉ số Chat chi tiết */}
      <Card className="bg-card/30 border-border/40 backdrop-blur-md overflow-hidden rounded-[32px] shadow-2xl">
        <div className="p-8 border-b border-white/10 flex items-center gap-3">
          <Target className="w-6 h-6 text-primary" />
          <h3 className="text-xl font-bold text-white">Chỉ số tối ưu hiệu quả AI</h3>
        </div>
        <div className="overflow-x-auto px-4 pb-4">
          <table className="w-full">
            <thead className="bg-white/5 border-b border-white/5">
              <tr>
                <th className="px-8 py-6 text-left text-xs font-black text-muted-foreground uppercase tracking-widest">Loại hành vi</th>
                <th className="px-8 py-6 text-left text-xs font-black text-muted-foreground uppercase tracking-widest">Tỷ lệ</th>
                <th className="px-8 py-6 text-left text-xs font-black text-muted-foreground uppercase tracking-widest">Đánh giá AI</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-white/5 text-white">
              <tr className="hover:bg-primary/5">
                <td className="px-8 py-6 font-bold">Survey Completion</td>
                <td className="px-8 py-6 font-black text-xl">{stats.completionRate}%</td>
                <td className="px-8 py-6">
                  <span className="px-3 py-1 rounded-full bg-emerald-500/10 text-emerald-500 text-[10px] font-black uppercase">Tốt</span>
                </td>
              </tr>
              <tr className="hover:bg-primary/5">
                <td className="px-8 py-6 font-bold">AI Matching Effectiveness</td>
                <td className="px-8 py-6 font-black text-xl">{stats.effectiveness}%</td>
                <td className="px-8 py-6">
                  <span className="px-3 py-1 rounded-full bg-emerald-500/10 text-emerald-500 text-[10px] font-black uppercase">Tối ưu</span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </Card>
    </div>
  )
}


interface MetricCardProps {
  icon: React.ComponentType<{ className?: string }>
  label: string
  value: string
  change: number
  color: string
}

function MetricCard({ icon: Icon, label, value, change, color }: MetricCardProps) {
  return (
    <Card className="p-8 bg-card/30 border-border/40 backdrop-blur-md overflow-hidden relative group rounded-3xl shadow-xl hover:shadow-primary/10 transition-all hover:scale-[1.02]">
      <div className={`absolute -right-16 -top-16 w-40 h-40 bg-gradient-to-br ${color} opacity-10 rounded-full blur-3xl group-hover:opacity-20 transition-opacity`} />
      <div className="relative z-10 flex flex-col justify-between h-full">
        <div className="flex items-start justify-between mb-8">
          <div className={`w-14 h-14 rounded-2xl bg-gradient-to-br ${color} flex items-center justify-center shadow-lg`}>
            <Icon className="w-7 h-7 text-white" />
          </div>
          <span
            className={`text-sm font-black px-3 py-1 rounded-xl bg-white/5 border border-white/10 ${
              change >= 0 ? 'text-emerald-500' : 'text-red-500'
            }`}
          >
            {change >= 0 ? '+' : ''}{change}%
          </span>
        </div>
        <div>
          <p className="text-sm font-bold text-muted-foreground uppercase tracking-wider mb-2">{label}</p>
          <p className="text-3xl font-black text-white tracking-tight">{value}</p>
        </div>
      </div>
    </Card>
  )
}
