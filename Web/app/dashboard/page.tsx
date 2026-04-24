import { Sidebar } from '@/components/sidebar'
import { TopNav } from '@/components/top-nav'
import { DashboardContent } from '@/components/dashboard-content'

export const metadata = {
  title: 'Dashboard | LOVESENSE Admin',
}

import { AuthGuard } from '@/components/auth-guard'

export default function DashboardPage() {
  return <DashboardContent />
}
