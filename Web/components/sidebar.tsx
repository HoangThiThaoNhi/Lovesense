'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import {
  BarChart3,
  Users,
  MessageSquare,
  Sparkles,
  TrendingUp,
  Trophy,
  Settings,
  Heart,
  History as LucideHistory,
  Ticket,
} from 'lucide-react'
import { cn } from '@/lib/utils'
import { useAuth } from '@/context/AuthContext'

const menuItems = [
  {
    label: 'Bảng điều khiển',
    href: '/dashboard',
    icon: BarChart3,
  },
  {
    label: 'Người dùng',
    href: '/users',
    icon: Users,
  },
  {
    label: 'Câu hỏi AI',
    href: '/questions',
    icon: Sparkles,
  },
  {
    label: 'Thống kê',
    href: '/analytics',
    icon: TrendingUp,
  },
// {
//   label: 'Thử thách',
//   href: '/gamification',
//   icon: Trophy,
// },
  {
    label: 'Huy hiệu',
    href: '/badges',
    icon: Sparkles, // Or any appropriate icon like Award if imported
  },
  {
    label: 'Kho Voucher',
    href: '/vouchers',
    icon: Ticket,
  },
  {
    label: 'Lịch sử hệ thống',
    href: '/logs',
    icon: LucideHistory,
  },
];

export function Sidebar() {
  const pathname = usePathname()
  const { logout } = useAuth()

  return (
    <aside className="fixed left-0 top-0 h-screen w-72 bg-[#0a0a0b] border-r border-white/5 flex flex-col z-50 transition-all font-outfit shadow-2xl">
      {/* Logo Section */}
      <div className="px-8 py-10 flex items-center gap-4 group cursor-pointer">
        <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-primary via-secondary to-primary p-[2px] shadow-xl shadow-primary/20 group-hover:scale-110 transition-transform duration-500">
          <div className="w-full h-full bg-[#0a0a0b] rounded-[14px] flex items-center justify-center">
            <Heart className="w-6 h-6 text-primary animate-pulse" fill="currentColor" />
          </div>
        </div>
        <div>
          <h1 className="text-2xl font-black text-white tracking-tighter leading-none">LOVESENSE</h1>
          <p className="text-[10px] font-black text-muted-foreground uppercase tracking-widest mt-1 opacity-60">Admin CMS</p>
        </div>
      </div>

      {/* Navigation */}
      <nav className="flex-1 px-6 space-y-2 overflow-y-auto mt-4 custom-scrollbar">
        {menuItems.map((item) => {
          const Icon = item.icon
          const isActive = pathname === item.href || pathname.startsWith(item.href + '/')
          return (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                'group flex items-center gap-4 px-5 py-4 rounded-2xl transition-all duration-300 relative overflow-hidden',
                isActive
                  ? 'bg-gradient-to-r from-primary/20 to-secondary/10 text-white shadow-lg border border-primary/20'
                  : 'text-muted-foreground hover:text-white hover:bg-white/5'
              )}
            >
              {isActive && (
                <div className="absolute left-0 top-0 w-1 h-full bg-primary shadow-[0_0_20px_rgba(235,94,117,1)]" />
              )}
              <Icon className={cn('w-5 h-5 transition-transform group-hover:scale-110', isActive ? 'text-primary' : 'text-muted-foreground')} />
              <span className="font-bold tracking-tight text-[15px]">{item.label}</span>
              {!isActive && (
                <div className="ml-auto w-1.5 h-1.5 rounded-full bg-white/10 group-hover:bg-primary/50 transition-colors" />
              )}
            </Link>
          )
        })}
      </nav>

      {/* Upgrade/Stats Widget */}
      <div className="px-6 mb-6">
        <div className="bg-gradient-to-br from-primary/10 via-transparent to-secondary/10 border border-white/5 rounded-[24px] p-6 relative overflow-hidden group">
          <Sparkles className="absolute top-4 right-4 w-5 h-5 text-primary opacity-20 animate-spin-slow" />
          <p className="text-xs font-black text-muted-foreground uppercase tracking-widest mb-3">Hệ thống AI</p>
          <div className="flex items-center gap-3 mb-4">
             <div className="flex -space-x-2">
                {[1,2,3].map(i => (
                  <div key={i} className="w-8 h-8 rounded-full border-2 border-[#0a0a0b] bg-secondary/20 flex items-center justify-center text-[10px] font-black">AI</div>
                ))}
             </div>
             <p className="text-[10px] font-bold text-white tracking-tight">3 Mô hình đang chạy</p>
          </div>
          <div className="h-1.5 w-full bg-white/5 rounded-full overflow-hidden">
             <div className="h-full w-[85%] bg-gradient-to-r from-primary to-secondary rounded-full" />
          </div>
        </div>
      </div>

      {/* Footer / Account */}
      <div className="px-6 py-8 mt-auto border-t border-white/5 bg-white/2 backdrop-blur-md">
        <button 
          onClick={logout}
          className="w-full group flex items-center gap-4 p-4 rounded-2xl bg-white/5 hover:bg-red-500/10 border border-white/5 hover:border-red-500/20 transition-all duration-300"
        >
          <div className="w-10 h-10 rounded-xl bg-secondary/10 flex items-center justify-center group-hover:bg-red-500/20 transition-colors">
            <Settings className="w-5 h-5 text-secondary group-hover:text-red-500 transition-colors" />
          </div>
          <div className="text-left">
            <p className="text-sm font-black text-white px-1">Đăng xuất</p>
            <p className="text-[10px] font-bold text-muted-foreground px-1 uppercase tracking-wider">Thoát hệ thống</p>
          </div>
        </button>
      </div>
    </aside>
  )
}
