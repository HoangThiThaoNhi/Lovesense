import { Sidebar } from '@/components/sidebar'
import { TopNav } from '@/components/top-nav'
import { AnalyticsContent } from '@/components/analytics-content'
import { AuthGuard } from '@/components/auth-guard'

export const metadata = {
  title: 'Analytics | LOVESENSE Admin',
}

export default function AnalyticsPage() {
  return <AnalyticsContent />
}
