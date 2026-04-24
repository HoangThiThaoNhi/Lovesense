'use client'

import { useState } from 'react'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Heart, Mail, Lock, Loader2, ShieldCheck, Sparkles } from 'lucide-react'
import { api } from '@/lib/api'
import { toast } from 'sonner'

export function LoginView({ onLogin }: { onLogin: (token: string, user: any) => void }) {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState('')

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setIsLoading(true)
    setError('')

    try {
      const data = await api.login({ email, password })
      
      if (data.user.role !== 'admin') {
        throw new Error('Bạn không có quyền truy cập quản trị')
      }

      toast.success('Đăng nhập thành công! Chào mừng Quản trị viên.')
      onLogin(data.token, data.user)
    } catch (err: any) {
      const errorMessage = err.message || 'Đăng nhập thất bại. Vui lòng kiểm tra lại.'
      setError(errorMessage)
      toast.error(errorMessage)
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className="min-h-screen w-full flex items-center justify-center bg-[#0a0a0b] relative overflow-hidden font-outfit">
      {/* Mesh Gradients cho hiệu ứng vjp */}
      <div className="absolute top-[-10%] left-[-10%] w-[40%] h-[40%] bg-primary/20 rounded-full blur-[120px] animate-pulse" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[40%] h-[40%] bg-secondary/20 rounded-full blur-[120px] animate-pulse delay-700" />
      
      <div className="relative z-10 w-full max-w-md px-6">
        {/* Logo Section */}
        <div className="text-center mb-10">
          <div className="inline-flex items-center justify-center w-20 h-20 rounded-2xl bg-gradient-to-br from-primary to-secondary p-[2px] mb-6 shadow-2xl shadow-primary/20 group">
            <div className="w-full h-full bg-[#0a0a0b] rounded-[14px] flex items-center justify-center group-hover:scale-95 transition-transform duration-500">
              <Heart className="w-10 h-10 text-primary animate-pulse" fill="currentColor" />
            </div>
          </div>
          <h1 className="text-4xl font-black text-white tracking-tight mb-2 flex items-center justify-center gap-2">
            LOVESENSE <span className="text-sm font-medium px-2 py-1 bg-primary/10 text-primary rounded-lg border border-primary/20">ADMIN</span>
          </h1>
          <p className="text-muted-foreground font-medium">Bản điều khiển tối cao dành cho người quản trị</p>
        </div>

        <Card className="p-8 bg-card/40 border-border/50 backdrop-blur-2xl rounded-3xl shadow-2xl relative overflow-hidden group">
          <div className="absolute top-0 left-0 w-full h-[2px] bg-gradient-to-r from-transparent via-primary/50 to-transparent opacity-50" />
          
          <form onSubmit={handleSubmit} className="space-y-6">
            <div className="space-y-2">
              <label className="text-sm font-semibold text-foreground/80 ml-1">Email Quản Trị</label>
              <div className="relative group/input">
                <Mail className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground group-focus-within/input:text-primary transition-colors" />
                <Input
                  type="email"
                  placeholder="admin@lovesense.vn"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="pl-12 h-14 bg-secondary/10 border-border/50 focus:border-primary/50 focus:ring-primary/20 rounded-2xl transition-all"
                  required
                />
              </div>
            </div>

            <div className="space-y-2">
              <label className="text-sm font-semibold text-foreground/80 ml-1">Mật Mã</label>
              <div className="relative group/input">
                <Lock className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground group-focus-within/input:text-secondary transition-colors" />
                <Input
                  type="password"
                  placeholder="••••••••"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="pl-12 h-14 bg-secondary/10 border-border/50 focus:border-secondary/50 focus:ring-secondary/20 rounded-2xl transition-all"
                  required
                />
              </div>
            </div>

            <div className="flex items-center justify-between px-1">
              <div className="flex items-center gap-2">
                <input type="checkbox" className="w-4 h-4 rounded border-border/50 bg-secondary/10 accent-primary" id="remember" />
                <label htmlFor="remember" className="text-xs text-muted-foreground cursor-pointer hover:text-foreground transition-colors">Ghi nhớ tôi</label>
              </div>
              <a href="#" className="text-xs text-primary hover:underline font-semibold tracking-wide">Quên mật mã?</a>
            </div>

            <Button
              type="submit"
              disabled={isLoading}
              className="w-full h-14 bg-gradient-to-r from-primary to-secondary text-primary-foreground font-bold text-lg rounded-2xl shadow-xl shadow-primary/20 hover:shadow-primary/40 hover:scale-[1.02] active:scale-[0.98] transition-all disabled:opacity-70 group"
            >
              {isLoading ? (
                <div className="flex items-center gap-2">
                  <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                  Đang xác thực...
                </div>
              ) : (
                <div className="flex items-center gap-2">
                  Xác nhận Quản trị
                  <Sparkles className="w-5 h-5 group-hover:rotate-12 transition-transform" />
                </div>
              )}
            </Button>
          </form>
        </Card>

        {/* Footer info */}
        <div className="mt-8 flex items-center justify-center gap-6 text-muted-foreground/40 text-xs font-semibold uppercase tracking-widest">
          <div className="flex items-center gap-2">
            <ShieldCheck className="w-4 h-4" />
            Bảo mật 256-bit
          </div>
          <div className="flex items-center gap-2">
            <Sparkles className="w-4 h-4" />
            AI Powered
          </div>
        </div>
      </div>
    </div>
  )
}
