import { Sidebar } from '@/components/sidebar'
import { TopNav } from '@/components/top-nav'
import { UsersContent } from '@/components/users-content'

export const metadata = {
  title: 'Users | LOVESENSE Admin',
}

import { AuthGuard } from '@/components/auth-guard'

export default function UsersPage() {
  return <UsersContent />
}
