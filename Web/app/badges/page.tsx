import { Sidebar } from '@/components/sidebar'
import { TopNav } from '@/components/top-nav'
import { BadgesContent } from '@/components/badges-content'
import { AuthGuard } from '@/components/auth-guard'

export const metadata = {
  title: 'Badges | LOVESENSE Admin',
}

export default function BadgesPage() {
  return <BadgesContent />
}
