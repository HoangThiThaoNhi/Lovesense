"use client"

import { Sidebar } from './sidebar'
import { TopNav } from './top-nav'
import { LoginView } from './login-view'
import { useAuth } from '@/context/AuthContext'
import { Loader2 } from 'lucide-react'
import { usePathname } from 'next/navigation'

export function LayoutWrapper({ children }: { children: React.ReactNode }) {
  const { isAuthenticated, isLoading, login } = useAuth()
  const pathname = usePathname()

  if (isLoading) {
    return (
      <div className="min-h-screen w-full flex items-center justify-center bg-[#0a0a0b]">
        <Loader2 className="w-12 h-12 text-primary animate-spin" />
      </div>
    )
  }

  if (!isAuthenticated) {
    return <LoginView onLogin={(token, user) => login(token, user)} />
  }

  return (
    <div className="min-h-screen">
      <Sidebar />
      <div className="ml-72 flex-1 flex flex-col">
        <TopNav />
        <main className="pt-8 px-8 pb-10">
          {children}
        </main>
      </div>
    </div>
  )
}
