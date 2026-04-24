import { Sidebar } from '@/components/sidebar'
import { TopNav } from '@/components/top-nav'
import { GamificationContent } from '@/components/gamification-content'
import { AuthGuard } from '@/components/auth-guard'

export const metadata = {
  title: 'Gamification | LOVESENSE Admin',
}

export default function GamificationPage() {
  return <GamificationContent />
}
