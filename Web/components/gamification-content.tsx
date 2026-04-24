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
  Trophy,
  Zap,
  Users,
  Plus,
  Edit,
  Trash2,
  Sparkles,
  Target,
  Activity,
  Loader2,
} from 'lucide-react'
import { Badge as UIBadge } from '@/components/ui/badge'
import { api } from '@/lib/api'
import { ChallengeModal } from './challenge-modal'
import { Tabs, TabsList, TabsTrigger, TabsContent } from '@/components/ui/tabs'
import { BadgeModal } from './badge-modal'

export function GamificationContent() {
  const [activeTab, setActiveTab] = useState('challenges')
  const [challenges, setChallenges] = useState<any[]>([])
  const [badges, setBadges] = useState<any[]>([])
  const [loading, setLoading] = useState(true)
  
  const [selectedItem, setSelectedItem] = useState<any | null>(null)
  const [isChallengeModalOpen, setIsChallengeModalOpen] = useState(false)
  const [isBadgeModalOpen, setIsBadgeModalOpen] = useState(false)
  
  const [stats, setStats] = useState<any>(null)
  const [leaderboard, setLeaderboard] = useState<any[]>([])

  const fetchData = useCallback(async () => {
    setLoading(true)
    try {
      const [challengesData, badgesData, statsData, leaderboardData] = await Promise.all([
        api.getChallenges(),
        api.getBadges(),
        api.getGamificationStats(),
        api.getLeaderboard()
      ])
      setChallenges(challengesData)
      setBadges(badgesData)
      setStats(statsData)
      setLeaderboard(leaderboardData)
    } catch (error) {
      console.error('Failed to fetch gamification data:', error)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    fetchData()
  }, [fetchData])

  const openCreateDialog = () => {
    setSelectedItem(null)
    if (activeTab === 'challenges') setIsChallengeModalOpen(true)
    else setIsBadgeModalOpen(true)
  }

  const openEditDialog = (item: any) => {
    setSelectedItem(item)
    if (activeTab === 'challenges') setIsChallengeModalOpen(true)
    else setIsBadgeModalOpen(true)
  }

  const handleDelete = async (id: string) => {
    const type = activeTab === 'challenges' ? 'thử thách' : 'huy hiệu';
    if (!confirm(`Bạn có chắc muốn xóa vĩnh viễn ${type} này?`)) return
    try {
      if (activeTab === 'challenges') await api.deleteChallenge(id)
      else await api.deleteBadge(id)
      fetchData()
    } catch (error: any) {
      alert('Lỗi: ' + error.message)
    }
  }

  const getRarity = (val: number) => {
    if (val >= 1000) return 'Sử thi'
    if (val >= 400) return 'Hiếm'
    return 'Phổ biến'
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
            <Trophy className="w-10 h-10 text-secondary" />
            Hệ thống Gamification
          </h1>
          <p className="text-muted-foreground font-medium text-lg italic opacity-80 decoration-secondary/30 underline-offset-4">
            Quản lý thử thách và huy hiệu để tăng tương tác người dùng
          </p>
        </div>
        <Button 
          variant="outline" 
          onClick={fetchData} 
          className="border-white/10 bg-white/5 hover:bg-white/10 rounded-2xl h-12 px-6 font-bold flex items-center gap-2"
        >
          <Activity className="w-5 h-5" />
          Làm mới dữ liệu
        </Button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
        <StatsCard 
          icon={Trophy} 
          label="Tổng thành tích" 
          value={stats?.totalChallenges || 0} 
          color="from-primary to-secondary" 
        />
        <StatsCard 
          icon={Zap} 
          label="Tổng lượt mở khóa" 
          value={stats?.totalCompletions?.toLocaleString('vi-VN') || 0} 
          color="from-blue-500 to-cyan-500" 
        />
        <StatsCard 
          icon={Sparkles} 
          label="Thành tích Sử thi" 
          value={stats?.epicChallenges || 0} 
          color="from-purple-500 to-pink-500" 
        />
        <StatsCard 
          icon={Target} 
          label="Tỷ lệ hoàn thành TB" 
          value={stats?.avgCompletionRate || '0%'} 
          color="from-yellow-500 to-orange-500" 
        />
      </div>

      <Tabs defaultValue="challenges" className="mb-12" onValueChange={setActiveTab}>
        <div className="flex items-center justify-between mb-8">
          <TabsList className="bg-white/5 p-1 rounded-2xl border border-white/10 h-14">
            <TabsTrigger value="challenges" className="rounded-xl px-8 font-black data-[state=active]:bg-secondary data-[state=active]:text-white transition-all h-full">
              THỬ THÁCH
            </TabsTrigger>
            <TabsTrigger value="badges" className="rounded-xl px-8 font-black data-[state=active]:bg-secondary data-[state=active]:text-white transition-all h-full">
              HUY HIỆU
            </TabsTrigger>
          </TabsList>
          
          <Button 
            onClick={openCreateDialog}
            className="bg-gradient-to-r from-secondary to-purple-600 text-white hover:scale-105 transition-all shadow-xl shadow-secondary/20 rounded-2xl h-12 px-6 font-bold"
          >
            <Plus className="w-5 h-5 mr-3" />
            Tạo {activeTab === 'challenges' ? 'thử thách' : 'huy hiệu'} mới
          </Button>
        </div>

        <TabsContent value="challenges" className="mt-0">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {challenges.map((achievement) => (
              <ItemCard 
                key={achievement.id} 
                item={achievement} 
                onEdit={openEditDialog} 
                onDelete={handleDelete}
                rarity={getRarity(achievement.reward_xp)}
                valueLabel="Thưởng"
                valueUnit="XP"
                valueKey="reward_xp"
              />
            ))}
          </div>
        </TabsContent>

        <TabsContent value="badges" className="mt-0">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {badges.map((badge) => (
              <ItemCard 
                key={badge.id} 
                item={badge} 
                onEdit={openEditDialog} 
                onDelete={handleDelete}
                rarity={getRarity(badge.points_required)}
                valueLabel="Yêu cầu"
                valueUnit="XP"
                valueKey="points_required"
              />
            ))}
          </div>
        </TabsContent>
      </Tabs>

      <ChallengeModal
        challenge={selectedItem}
        isOpen={isChallengeModalOpen}
        onClose={() => setIsChallengeModalOpen(false)}
        onSuccess={fetchData}
      />

      <BadgeModal
        badge={selectedItem}
        isOpen={isBadgeModalOpen}
        onClose={() => setIsBadgeModalOpen(false)}
        onSuccess={fetchData}
      />

      <Card className="p-8 bg-card/30 border-border/40 backdrop-blur-md rounded-[32px] shadow-2xl relative overflow-hidden">
        <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-primary via-secondary to-primary opacity-50" />
        <h2 className="text-2xl font-black text-white mb-8 flex items-center gap-3">
          <Zap className="w-6 h-6 text-yellow-500" />
          Người dùng tích cực nhất (Bảng vàng)
        </h2>
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {leaderboard.map((user) => (
            <div
              key={user.rank}
              className="flex items-center justify-between p-6 bg-white/5 rounded-3xl hover:bg-white/10 border border-white/5 transition-all group scale-100 hover:scale-[1.02]"
            >
              <div className="flex items-center gap-5">
                <div className={`w-12 h-12 rounded-2xl flex items-center justify-center font-black text-xl shadow-2xl ${
                  user.rank === 1 ? 'bg-yellow-500 text-black' : 
                  user.rank === 2 ? 'bg-gray-300 text-black' : 
                  user.rank === 3 ? 'bg-orange-600 text-white' : 
                  'bg-white/10 text-white'
                }`}>
                  {user.rank}
                </div>
                <img src={user.avatar} className="w-14 h-14 rounded-2xl border-2 border-white/10 object-cover" alt="" />
                <div>
                  <p className="text-lg font-black text-white group-hover:text-secondary transition-colors">{user.name}</p>
                  <p className="text-xs font-bold text-muted-foreground truncate max-w-[150px] opacity-70 italic">{user.email}</p>
                </div>
              </div>
              <div className="text-right text-white">
                <p className="text-2xl font-black text-secondary">{user.points.toLocaleString('vi-VN')}</p>
                <p className="text-[10px] font-black text-muted-foreground uppercase tracking-widest">Điểm XP</p>
              </div>
            </div>
          ))}
          {leaderboard.length === 0 && (
            <div className="col-span-2 py-20 text-center opacity-50 font-bold italic">
               Chưa có dữ liệu xếp hạng người dùng...
            </div>
          )}
        </div>
      </Card>
    </div>
  )
}

function ItemCard({ item, onEdit, onDelete, rarity, valueLabel, valueUnit, valueKey }: any) {
  return (
    <Card className="p-8 bg-card/30 border-border/40 backdrop-blur-md hover:shadow-2xl hover:shadow-primary/10 transition-all duration-500 rounded-[32px] group cursor-pointer relative overflow-hidden">
      <div className="absolute top-0 right-0 w-32 h-32 bg-gradient-to-br from-primary/10 to-transparent rounded-bl-full opacity-50 group-hover:scale-150 transition-transform" />
      
      <div className="flex items-start justify-between mb-8">
        <div className="text-6xl group-hover:scale-110 group-hover:rotate-6 transition-transform duration-500 drop-shadow-2xl">
           {item.icon_url?.length > 4 ? <img src={item.icon_url.startsWith('http') ? item.icon_url : `${process.env.NEXT_PUBLIC_API_URL?.replace('/api', '')}${item.icon_url}`} className="w-16 h-16 object-contain" alt="" /> : (item.icon_url || '🏆')}
        </div>
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="ghost" size="icon" className="h-10 w-10 hover:bg-white/10 rounded-xl group/btn">
              <MoreVertical className="w-5 h-5 group-hover/btn:text-white" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end" className="bg-card/95 border-border backdrop-blur-xl rounded-2xl p-2 w-56 shadow-2xl">
            <DropdownMenuItem 
              className="cursor-pointer hover:bg-secondary/10 rounded-xl h-11 px-4 font-bold flex items-center gap-3 transition-all"
              onClick={() => onEdit(item)}
            >
              <Edit className="w-4 h-4 text-emerald-500" />
              Sửa thông tin
            </DropdownMenuItem>
            <DropdownMenuItem 
              className="cursor-pointer text-destructive hover:bg-destructive/10 rounded-xl h-11 px-4 font-bold flex items-center gap-3 transition-all"
              onClick={() => onDelete(item.id)}
            >
              <Trash2 className="w-4 h-4" />
              Xóa vĩnh viễn
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>

      <h3 className="text-2xl font-black text-white mb-3 group-hover:text-primary transition-colors line-clamp-1">{item.name || item.title}</h3>
      <p className="text-muted-foreground font-medium text-sm leading-relaxed mb-8 line-clamp-2">{item.description}</p>

      <div className="space-y-6">
        <div className="flex items-center justify-between p-4 rounded-2xl bg-white/5 border border-white/5 group-hover:border-primary/30 transition-colors">
          <span className="text-xs font-bold text-muted-foreground uppercase flex items-center gap-2">
            <Users className="w-3.5 h-3.5" /> {valueLabel}
          </span>
          <span className="font-black text-foreground">{item[valueKey]} {valueUnit}</span>
        </div>

        <div className="flex items-center justify-between">
          <UIBadge
            className={`text-[10px] font-black px-4 py-1.5 rounded-full border shadow-lg ${
              rarity === 'Phổ biến'
                ? 'bg-gray-500/10 text-gray-500 border-gray-500/20'
                : rarity === 'Hiếm'
                  ? 'bg-blue-500/10 text-blue-500 border-blue-500/20'
                  : 'bg-purple-500/10 text-purple-500 border-purple-500/20'
            }`}
          >
            {rarity}
          </UIBadge>
          <div className="flex flex-col items-end">
            <span className="text-[10px] font-black text-muted-foreground uppercase tracking-widest leading-none">ID</span>
            <span className="text-lg font-black text-secondary">#{item.id}</span>
          </div>
        </div>
      </div>
    </Card>
  )
}

function StatsCard({ icon: Icon, label, value, color }: { icon: any, label: string, value: any, color: string }) {
  return (
    <Card className="p-8 bg-card/30 border-border/40 backdrop-blur-md overflow-hidden relative group rounded-3xl shadow-xl hover:shadow-secondary/10 transition-all">
       <div className={`absolute -right-16 -top-16 w-40 h-40 bg-gradient-to-br ${color} opacity-10 rounded-full blur-3xl group-hover:opacity-20 transition-opacity`} />
       <div className="relative z-10 flex items-center gap-6">
          <div className={`w-16 h-16 rounded-2xl bg-gradient-to-br ${color} flex items-center justify-center shadow-2xl`}>
            <Icon className="w-8 h-8 text-white" />
          </div>
          <div>
            <p className="text-xs font-bold text-muted-foreground uppercase tracking-wider mb-2">{label}</p>
            <p className="text-3xl font-black text-white tracking-tight">{value}</p>
          </div>
       </div>
    </Card>
  )
}
