"use client";

import { useEffect, useState, useCallback } from 'react'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import {
  Search,
  MoreVertical,
  Mail, 
  Filter,
  Trash2,
  Edit,
  LayoutGrid,
  List as ListIcon,
  Activity,
  History,
  CheckCircle,
  Ban,
  AlertTriangle,
  Eye,
  Key,
  UserPlus,
  Loader2,
  Lock as LockIcon,
  Search as SearchIcon,
  Sparkles
} from 'lucide-react'
import { toast } from 'sonner'
import { 
  Dialog, 
  DialogContent, 
  DialogHeader, 
  DialogTitle, 
  DialogFooter,
  DialogDescription
} from '@/components/ui/dialog'
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from '@/components/ui/tabs'
import { UserDetailModal } from './user-detail-modal'
import { UserCreateModal } from './user-create-modal'
import { BulkUserModal } from './bulk-user-modal'
import { api } from '@/lib/api'

export function UsersContent() {
  const [users, setUsers] = useState<any[]>([])
  const [loading, setLoading] = useState(true)
  const [searchQuery, setSearchQuery] = useState('')
  const [statusFilter, setStatusFilter] = useState('all')
  const [page, setPage] = useState(1)
  const [totalPages, setTotalPages] = useState(1)
  const [totalUsers, setTotalUsers] = useState(0)
  const [selectedUser, setSelectedUser] = useState<any | null>(null)
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false)
  const [isResetModalOpen, setIsResetModalOpen] = useState(false)
  const [resetUserId, setResetUserId] = useState<string | null>(null)
  const [newPassword, setNewPassword] = useState('')
  const [isResetting, setIsResetting] = useState(false)
  const [stats, setStats] = useState<any>({ totalUsers: 0, activeUsers: 0, inactiveUsers: 0 })
  const [viewMode, setViewMode] = useState<'table' | 'card'>('table')
  const [isPointsModalOpen, setIsPointsModalOpen] = useState(false)
  const [isBulkModalOpen, setIsBulkModalOpen] = useState(false)
  const [pointsUserId, setPointsUserId] = useState<string | null>(null)
  const [newPoints, setNewPoints] = useState<number>(0)
  const [isUpdatingPoints, setIsUpdatingPoints] = useState(false)

  const fetchStats = useCallback(async () => {
    try {
      const data = await api.getStats()
      setStats(data)
    } catch (error) {
      console.error('Failed to fetch stats:', error)
    }
  }, [])

  const fetchUsers = useCallback(async () => {
    setLoading(true)
    try {
      const data = await api.getUsers({ 
        search: searchQuery, 
        status: statusFilter,
        page,
        limit: 10
      })
      setUsers(data.users)
      setTotalPages(data.totalPages)
      setTotalUsers(data.total)
    } catch (error) {
      console.error('Failed to fetch users:', error)
    } finally {
      setLoading(false)
    }
  }, [searchQuery, statusFilter, page])

  useEffect(() => {
    fetchStats()
  }, [fetchStats])

  useEffect(() => {
    // Reset page when filter/search changes
    setPage(1)
  }, [searchQuery, statusFilter])

  useEffect(() => {
    const timer = setTimeout(() => {
      fetchUsers()
    }, 500) // Debounce search
    return () => clearTimeout(timer)
  }, [fetchUsers])

  const handleUpdateStatus = async (id: string, status: string) => {
    try {
      await api.updateUserStatus(id, status)
      fetchUsers()
      fetchStats()
      toast.success('Cập nhật trạng thái thành công')
    } catch (error) {
      toast.error('Không thể cập nhật trạng thái: ' + (error as any).message)
    }
  }

  const handleResetPassword = async () => {
    if (!resetUserId || !newPassword) return
    
    setIsResetting(true)
    try {
      await api.resetPassword(resetUserId, newPassword)
      toast.success('Đã đổi mật khẩu thành công!')
      setIsResetModalOpen(false)
      setNewPassword('')
      setResetUserId(null)
    } catch (error) {
      toast.error('Lỗi: ' + (error as any).message)
    } finally {
      setIsResetting(false)
    }
  }

  const openResetPasswordModal = (id: string) => {
    setResetUserId(id)
    setNewPassword('')
    setIsResetModalOpen(true)
  }

  const openPointsModal = (user: any) => {
    setPointsUserId(user.id)
    setNewPoints(user.profile?.points || 0)
    setIsPointsModalOpen(true)
  }

  const handleUpdatePoints = async () => {
    if (!pointsUserId) return
    
    setIsUpdatingPoints(true)
    try {
      await api.updateUserPoints(pointsUserId, newPoints)
      toast.success('Đã cập nhật điểm thành công!')
      setIsPointsModalOpen(false)
      fetchUsers()
    } catch (error) {
      toast.error('Lỗi: ' + (error as any).message)
    } finally {
      setIsUpdatingPoints(false)
    }
  }

  const openUserDetail = (user: any) => {
    setSelectedUser(user)
    setIsModalOpen(true)
  }

  return (
    <div className="p-8 w-full font-outfit">
      {/* Tiêu đề */}
      <div className="mb-10 flex items-end justify-between">
        <div>
          <h1 className="text-4xl font-extrabold text-white mb-3 tracking-tight">Quản lý người dùng</h1>
          <p className="text-muted-foreground font-medium text-lg italic opacity-80 decoration-primary/30 underline-offset-4">
            Giám sát và điều hành toàn bộ người dùng trên hệ thống LOVESENSE
          </p>
        </div>
        <Button 
          onClick={() => setIsCreateModalOpen(true)}
          className="bg-gradient-to-r from-primary to-secondary text-primary-foreground hover:scale-105 transition-all shadow-xl shadow-primary/20 rounded-2xl h-12 px-6 font-bold"
        >
          <UserPlus className="w-5 h-5 mr-3" />
          Tạo tài khoản mới
        </Button>
        <Button 
          onClick={() => setIsBulkModalOpen(true)}
          className="bg-white/5 border border-white/10 text-white hover:bg-white/10 rounded-2xl h-12 px-6 font-bold shadow-xl transition-all ml-4"
        >
          <Sparkles className="w-5 h-5 mr-3 text-primary" />
          Bulk AI Create
        </Button>
      </div>

      <div className="w-full">

      {/* Stats Hero Section */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
        <Card className="p-6 bg-gradient-to-br from-primary/20 to-transparent border-primary/20 rounded-[32px] shadow-lg backdrop-blur-xl relative overflow-hidden group">
          <div className="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
            <UserPlus className="w-20 h-20 text-primary" />
          </div>
          <div className="relative z-10">
            <p className="text-sm font-bold text-muted-foreground uppercase tracking-wider mb-2">Tổng người dùng</p>
            <h3 className="text-4xl font-black text-white">{stats.totalUsers}</h3>
            <p className="text-xs font-semibold text-primary mt-2">↑ 12% so với tháng trước</p>
          </div>
        </Card>
        
        <Card className="p-6 bg-gradient-to-br from-emerald-500/20 to-transparent border-emerald-500/20 rounded-[32px] shadow-lg backdrop-blur-xl relative overflow-hidden group">
          <div className="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
            <CheckCircle className="w-20 h-20 text-emerald-500" />
          </div>
          <div className="relative z-10">
            <p className="text-sm font-bold text-muted-foreground uppercase tracking-wider mb-2">Đang hoạt động</p>
            <h3 className="text-4xl font-black text-emerald-500">{stats.activeUsers}</h3>
            <p className="text-xs font-semibold text-emerald-500 mt-2">Đang sử dụng hệ thống</p>
          </div>
        </Card>

        <Card className="p-6 bg-gradient-to-br from-red-500/20 to-transparent border-red-500/20 rounded-[32px] shadow-lg backdrop-blur-xl relative overflow-hidden group">
          <div className="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
            <Ban className="w-20 h-20 text-red-500" />
          </div>
          <div className="relative z-10">
            <p className="text-sm font-bold text-muted-foreground uppercase tracking-wider mb-2">Không hoạt động/Bị chặn</p>
            <h3 className="text-4xl font-black text-red-500">{stats.inactiveUsers}</h3>
            <p className="text-xs font-semibold text-red-500 mt-2">Tài khoản bị hạn chế</p>
          </div>
        </Card>
      </div>

      {/* Thanh công cụ vjp */}
      <Card className="p-4 bg-card/50 border-border/40 backdrop-blur-xl mb-8 rounded-[24px] shadow-sm flex flex-wrap gap-4 items-center">
        <div className="flex-1 min-w-[300px] relative group">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground group-focus-within:text-primary transition-colors" />
          <Input
            placeholder="Tìm theo tên, email hoặc User ID..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="pl-12 h-12 bg-secondary/10 border-border/40 focus:ring-primary/20 rounded-xl transition-all font-medium"
          />
        </div>
        
        <div className="flex items-center gap-3">
          <div className="flex items-center gap-2 text-sm font-bold text-muted-foreground bg-secondary/10 px-4 h-12 rounded-xl border border-border/40">
            <Filter className="w-4 h-4" />
            Lọc theo:
          </div>
          <Select value={statusFilter} onValueChange={setStatusFilter}>
            <SelectTrigger className="w-[180px] h-12 bg-secondary/10 border-border/40 rounded-xl font-bold">
              <SelectValue placeholder="Trạng thái" />
            </SelectTrigger>
            <SelectContent className="bg-card border-border rounded-xl">
              <SelectItem value="all" className="font-medium">Tất cả trạng thái</SelectItem>
              <SelectItem value="active" className="font-medium text-emerald-500">Đang hoạt động</SelectItem>
              <SelectItem value="inactive" className="font-medium text-gray-500">Không hoạt động</SelectItem>
              <SelectItem value="flagged" className="font-medium text-amber-500">Cảnh báo</SelectItem>
              <SelectItem value="banned" className="font-medium text-red-500">Bị chặn</SelectItem>
            </SelectContent>
          </Select>
        </div>

        <div className="flex bg-secondary/10 p-1 rounded-xl border border-border/40 ml-auto">
          <Button
            variant={viewMode === 'table' ? 'secondary' : 'ghost'}
            size="icon"
            onClick={() => setViewMode('table')}
            className={`h-10 w-10 rounded-lg ${viewMode === 'table' ? 'bg-background shadow-sm' : ''}`}
          >
            <ListIcon className="w-5 h-5" />
          </Button>
          <Button
            variant={viewMode === 'card' ? 'secondary' : 'ghost'}
            size="icon"
            onClick={() => setViewMode('card')}
            className={`h-10 w-10 rounded-lg ${viewMode === 'card' ? 'bg-background shadow-sm' : ''}`}
          >
            <LayoutGrid className="w-5 h-5" />
          </Button>
        </div>
      </Card>

      {/* Bảng dữ liệu vjp */}
      {viewMode === 'table' ? (
      <Card className="bg-card/30 border-border/40 overflow-hidden rounded-[32px] shadow-2xl backdrop-blur-md relative">
        {loading && (
          <div className="absolute inset-0 bg-background/50 backdrop-blur-sm z-10 flex items-center justify-center">
            <Loader2 className="w-12 h-12 text-primary animate-spin" />
          </div>
        )}
        <Table>
          <TableHeader>
            <TableRow className="border-border/40 hover:bg-transparent h-16">
              <TableHead className="text-muted-foreground/80 font-bold uppercase tracking-wider pl-8">User ID</TableHead>
              <TableHead className="text-muted-foreground/80 font-bold uppercase tracking-wider">Người dùng</TableHead>
              <TableHead className="text-muted-foreground/80 font-bold uppercase tracking-wider">Trạng thái</TableHead>
              <TableHead className="text-muted-foreground/80 font-bold uppercase tracking-wider">Ngày tham gia</TableHead>
              <TableHead className="text-right text-muted-foreground/80 font-bold uppercase tracking-wider pr-8">Hành động</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {users.length === 0 && !loading ? (
              <TableRow>
                <TableCell colSpan={5} className="h-40 text-center">
                  <div className="flex flex-col items-center gap-2 opacity-50">
                    <AlertTriangle className="w-10 h-10" />
                    <p className="font-bold">Không tìm thấy người dùng nào</p>
                  </div>
                </TableCell>
              </TableRow>
            ) : (
              users.map((user: any) => (
                <tr
                  key={user.id}
                  className="border-b border-border/40 hover:bg-primary/5 transition-all h-20 group"
                >
                  <td className="pl-8 font-bold text-primary/80 tracking-tight">{user.id}</td>
                  <td>
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 rounded-2xl bg-secondary/20 flex items-center justify-center font-black text-xl text-secondary overflow-hidden border border-border/20 group-hover:scale-110 transition-transform shadow-lg">
                        {user.profile?.display_name?.charAt(0).toUpperCase() || 'U'}
                      </div>
                      <div>
                        <p 
                          className="font-bold text-foreground cursor-pointer hover:text-primary transition-colors text-lg"
                          onClick={() => openUserDetail(user)}
                        >
                          {user.profile?.display_name || 'Chưa đặt tên'}
                        </p>
                        <p className="text-xs font-medium text-muted-foreground opacity-70">{user.email || user.phone}</p>
                      </div>
                    </div>
                  </td>
                  <td className="px-4 py-6">
                    <span
                      className={`inline-flex items-center px-4 py-1.5 rounded-full text-[10px] font-black uppercase tracking-widest border ${
                        user.status === 'active'
                           ? 'bg-emerald-500/10 text-emerald-500 border-emerald-500/20'
                           : user.status === 'inactive'
                             ? 'bg-gray-500/10 text-gray-500 border-gray-500/20'
                             : user.status === 'flagged'
                               ? 'bg-amber-500/10 text-amber-500 border-amber-500/20'
                               : 'bg-red-500/10 text-red-500 border-red-500/20'
                      }`}
                    >
                      {user.status === 'active' ? 'Hoạt động' : user.status === 'inactive' ? 'Không hoạt động' : user.status === 'flagged' ? 'Cảnh báo' : 'Bị chặn'}
                    </span>
                  </td>
                  <td className="text-muted-foreground font-semibold text-sm">
                    {new Date(user.created_at).toLocaleDateString('vi-VN')}
                  </td>
                  <td className="text-right pr-8">
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="icon" className="h-10 w-10 hover:bg-primary/10 rounded-xl group/btn">
                          <MoreVertical className="w-5 h-5 group-hover/btn:text-primary" />
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent align="end" className="bg-card/95 border-border backdrop-blur-xl rounded-2xl p-2 w-56 shadow-2xl">
                        <DropdownMenuItem className="cursor-pointer hover:bg-secondary/10 rounded-xl h-11 px-4 font-bold flex items-center gap-3 transition-all" onClick={() => openUserDetail(user)}>
                          <Eye className="w-4 h-4 text-purple-500" />
                          Xem chi tiết
                        </DropdownMenuItem>
                        
                        {user.status !== 'active' && (
                          <DropdownMenuItem 
                            className="cursor-pointer hover:bg-emerald-500/10 text-emerald-500 rounded-xl h-11 px-4 font-bold flex items-center gap-3 transition-all"
                            onClick={() => handleUpdateStatus(user.id, 'active')}
                          >
                            <CheckCircle className="w-4 h-4" />
                            Hoạt động (Active)
                          </DropdownMenuItem>
                        )}
                        
                        {user.status !== 'flagged' && (
                          <DropdownMenuItem 
                            className="cursor-pointer hover:bg-amber-500/10 text-amber-500 rounded-xl h-11 px-4 font-bold flex items-center gap-3 transition-all"
                            onClick={() => handleUpdateStatus(user.id, 'flagged')}
                          >
                            <AlertTriangle className="w-4 h-4" />
                            Cảnh báo (Flagged)
                          </DropdownMenuItem>
                        )}
                        
                        {user.status !== 'inactive' && (
                          <DropdownMenuItem 
                            className="cursor-pointer hover:bg-gray-500/10 text-gray-500 rounded-xl h-11 px-4 font-bold flex items-center gap-3 transition-all"
                            onClick={() => handleUpdateStatus(user.id, 'inactive')}
                          >
                            <History className="w-4 h-4" />
                            Không hoạt động (Inactive)
                          </DropdownMenuItem>
                        )}
                        
                        {user.status !== 'banned' && (
                          <DropdownMenuItem 
                            className="cursor-pointer hover:bg-red-500/10 text-red-500 rounded-xl h-11 px-4 font-bold flex items-center gap-3 transition-all"
                            onClick={() => handleUpdateStatus(user.id, 'banned')}
                          >
                            <Ban className="w-4 h-4" />
                            Chặn (Banned)
                          </DropdownMenuItem>
                        )}
                        <DropdownMenuItem 
                          className="cursor-pointer hover:bg-primary/10 text-primary rounded-xl h-11 px-4 font-bold flex items-center gap-3 transition-all"
                          onClick={() => openResetPasswordModal(user.id)}
                        >
                          <Key className="w-4 h-4 text-primary" />
                          Đổi mật khẩu
                        </DropdownMenuItem>

                        <DropdownMenuItem 
                          className="cursor-pointer hover:bg-amber-500/10 text-amber-500 rounded-xl h-11 px-4 font-bold flex items-center gap-3 transition-all"
                          onClick={() => openPointsModal(user)}
                        >
                          <Sparkles className="w-4 h-4 text-amber-500" />
                          Chỉnh sửa điểm (XP)
                        </DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                   </td>
                </tr>
              ))
            )}
          </TableBody>
        </Table>
      </Card>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {users.map((user: any) => (
            <Card key={user.id} className="p-6 bg-card/30 border-border/40 backdrop-blur-md rounded-[28px] shadow-xl hover:shadow-primary/5 transition-all group border-b-4 border-b-transparent hover:border-b-primary">
              <div className="flex justify-between items-start mb-6">
                <div className="flex items-center gap-4">
                  <div className="w-16 h-16 rounded-2xl bg-primary/20 flex items-center justify-center font-black text-2xl text-primary overflow-hidden border border-white/10 group-hover:scale-105 transition-transform">
                    {user.profile?.avatar ? (
                      <img src={user.profile.avatar} className="w-full h-full object-cover" />
                    ) : (
                      user.profile?.display_name?.charAt(0).toUpperCase() || 'U'
                    )}
                  </div>
                  <div>
                    <h3 className="text-xl font-black text-white line-clamp-1 group-hover:text-primary transition-colors hover:cursor-pointer" onClick={() => openUserDetail(user)}>
                      {user.profile?.display_name || 'N/A'}
                    </h3>
                    <p className="text-xs font-bold text-muted-foreground italic opacity-60">ID: {user.id}</p>
                  </div>
                </div>
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" size="icon" className="h-10 w-10 hover:bg-white/5 rounded-xl">
                      <MoreVertical className="w-5 h-5" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent align="end" className="bg-card/95 border-border backdrop-blur-xl rounded-xl">
                    <DropdownMenuItem onClick={() => openUserDetail(user)} className="cursor-pointer gap-2"><Eye className="w-4 h-4" /> Xem</DropdownMenuItem>
                    <DropdownMenuItem onClick={() => handleUpdateStatus(user.id, user.status === 'active' ? 'banned' : 'active')} className="cursor-pointer gap-2">
                       {user.status === 'active' ? <Ban className="w-4 h-4 text-red-500" /> : <CheckCircle className="w-4 h-4 text-emerald-500" />}
                       {user.status === 'active' ? 'Chặn' : 'Mở khóa'}
                    </DropdownMenuItem>
                    <DropdownMenuItem onClick={() => openResetPasswordModal(user.id)} className="cursor-pointer gap-2"><Key className="w-4 h-4" /> Đổi MK</DropdownMenuItem>
                    <DropdownMenuItem onClick={() => openPointsModal(user)} className="cursor-pointer gap-2"><Sparkles className="w-4 h-4 text-amber-500" /> Chỉnh điểm (XP)</DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              </div>

              <div className="space-y-4">
                <div className="flex items-center gap-3 text-sm text-muted-foreground font-medium bg-white/5 p-3 rounded-2xl">
                  <Mail className="w-4 h-4 text-secondary" />
                  <span className="truncate">{user.email || user.phone || 'N/A'}</span>
                </div>
                
                <div className="flex items-center justify-between">
                   <span
                    className={`inline-flex items-center px-4 py-1.5 rounded-full text-[10px] font-black uppercase tracking-widest border ${
                      user.status === 'active'
                        ? 'bg-emerald-500/10 text-emerald-500 border-emerald-500/20'
                        : user.status === 'inactive'
                          ? 'bg-gray-500/10 text-gray-500 border-gray-500/20'
                          : user.status === 'flagged'
                            ? 'bg-amber-500/10 text-amber-500 border-amber-500/20'
                            : 'bg-red-500/10 text-red-500 border-red-500/20'
                    }`}
                  >
                    {user.status === 'active' ? 'Hoạt động' : user.status === 'inactive' ? 'Không hoạt động' : user.status === 'flagged' ? 'Cảnh báo' : 'Bị chặn'}
                  </span>
                  <p className="text-[10px] font-black text-muted-foreground uppercase tracking-widest">
                    Gia nhập: {new Date(user.created_at).toLocaleDateString('vi-VN')}
                  </p>
                </div>
              </div>
            </Card>
          ))}
        </div>
      )}

      {/* Phân trang */}
      <div className="mt-10 flex items-center justify-between px-4">
        <p className="text-md font-bold text-muted-foreground italic">
          Đang hiển thị <span className="text-foreground not-italic">{users.length}</span> / {totalUsers} người dùng hệ thống
        </p>
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
              className="rounded-2xl h-12 px-6 font-bold border-border/40 shadow-sm hover:bg-secondary/10 hover:border-primary/50 transition-all disabled:opacity-30"
            >
              Trang trước
            </Button>
            <Button 
              variant="outline" 
              onClick={() => setPage(p => Math.min(totalPages, p + 1))}
              disabled={page === totalPages || loading}
              className="rounded-2xl h-12 px-6 font-bold border-border/40 shadow-sm hover:bg-secondary/10 hover:border-primary/50 transition-all disabled:opacity-30"
            >
              Trang sau
            </Button>
          </div>
        </div>
      </div>
      </div>

      {/* Modal chi tiết */}
      <UserDetailModal 
        user={selectedUser} 
        isOpen={isModalOpen} 
        onClose={() => setIsModalOpen(false)} 
      />

      {/* Modal tạo mới */}
      <UserCreateModal
        isOpen={isCreateModalOpen}
        onClose={() => setIsCreateModalOpen(false)}
        onSuccess={() => {
          fetchUsers()
          fetchStats()
        }}
      />

      <BulkUserModal
        isOpen={isBulkModalOpen}
        onClose={() => setIsBulkModalOpen(false)}
        onSuccess={() => {
          fetchUsers()
          fetchStats()
        }}
      />
      {/* Modal đổi mật khẩu */}
      <Dialog open={isResetModalOpen} onOpenChange={setIsResetModalOpen}>
        <DialogContent className="sm:max-w-[425px] bg-[#0a0a0b] border-border/40 font-outfit rounded-[32px] text-white">
          <DialogHeader>
            <DialogTitle className="text-2xl font-black flex items-center gap-2">
              <LockIcon className="w-6 h-6 text-primary" />
              Đổi mật khẩu
            </DialogTitle>
            <DialogDescription className="text-muted-foreground font-medium">
              Nhập mật khẩu mới cho người dùng này. Hãy đảm bảo mật khẩu đủ mạnh.
            </DialogDescription>
          </DialogHeader>
          <div className="py-6 space-y-4">
            <div className="space-y-2">
              <label className="text-xs font-bold text-muted-foreground uppercase tracking-widest pl-1">
                Mật khẩu mới
              </label>
              <Input
                type="password"
                placeholder="••••••••"
                className="bg-white/5 border-white/10 rounded-2xl h-12 focus:ring-primary/20 transition-all font-medium"
                value={newPassword}
                onChange={(e) => setNewPassword(e.target.value)}
                autoFocus
              />
            </div>
          </div>
          <DialogFooter className="gap-3 sm:gap-0">
            <Button
              variant="ghost"
              onClick={() => setIsResetModalOpen(false)}
              className="rounded-2xl h-12 font-bold hover:bg-white/5"
            >
              Hủy
            </Button>
            <Button
              onClick={handleResetPassword}
              disabled={isResetting || !newPassword}
              className="bg-primary hover:bg-primary/90 text-white rounded-2xl h-12 px-8 font-bold shadow-xl shadow-primary/20"
            >
              {isResetting ? (
                <>
                  <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                  Đang xử lý...
                </>
              ) : (
                'Cập nhật mật khẩu'
              )}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Modal chỉnh sửa điểm */}
      <Dialog open={isPointsModalOpen} onOpenChange={setIsPointsModalOpen}>
        <DialogContent className="sm:max-w-[425px] bg-[#0a0a0b] border-border/40 font-outfit rounded-[32px] text-white">
          <DialogHeader>
            <DialogTitle className="text-2xl font-black flex items-center gap-2">
              <Sparkles className="w-6 h-6 text-amber-500" />
              Chỉnh sửa điểm thưởng
            </DialogTitle>
            <DialogDescription className="text-muted-foreground font-medium">
              Bạn đang điều chỉnh tổng số điểm (XP) của người dùng này.
            </DialogDescription>
          </DialogHeader>
          <div className="py-6 space-y-4">
            <div className="space-y-2">
              <label className="text-xs font-bold text-muted-foreground uppercase tracking-widest pl-1">
                Số điểm hiện tại
              </label>
              <Input
                type="number"
                placeholder="Nhập số điểm..."
                className="bg-white/5 border-white/10 rounded-2xl h-12 focus:ring-amber-500/20 transition-all font-black text-xl text-amber-500"
                value={newPoints}
                onChange={(e) => setNewPoints(parseInt(e.target.value) || 0)}
                autoFocus
              />
            </div>
            <div className="flex gap-2">
              {[+10, +50, +100, -10, -50].map(val => (
                <Button 
                  key={val}
                  type="button"
                  variant="outline"
                  size="sm"
                  className="rounded-lg h-8 px-2 text-[10px] font-black border-white/10"
                  onClick={() => setNewPoints(prev => Math.max(0, prev + val))}
                >
                  {val > 0 ? `+${val}` : val}
                </Button>
              ))}
            </div>
          </div>
          <DialogFooter className="gap-3 sm:gap-0">
            <Button
              variant="ghost"
              onClick={() => setIsPointsModalOpen(false)}
              className="rounded-2xl h-12 font-bold hover:bg-white/5"
            >
              Hủy
            </Button>
            <Button
              onClick={handleUpdatePoints}
              disabled={isUpdatingPoints}
              className="bg-amber-500 hover:bg-amber-600 text-white rounded-2xl h-12 px-8 font-bold shadow-xl shadow-amber-500/20"
            >
              {isUpdatingPoints ? (
                <>
                  <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                  Đang cập nhật...
                </>
              ) : (
                'Lưu thay đổi'
              )}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}
