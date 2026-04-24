"use client"

import { Sidebar } from '@/components/sidebar'
import { TopNav } from '@/components/top-nav'
import { DashboardContent } from '@/components/dashboard-content'
import { LoginView } from '@/components/login-view'
import { useAuth } from '@/context/AuthContext'
import { Loader2 } from 'lucide-react'

export default function Home() {
  return <DashboardContent />
}
