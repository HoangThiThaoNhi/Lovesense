import { Sidebar } from '@/components/sidebar'
import { TopNav } from '@/components/top-nav'
import { SettingsContent } from '@/components/settings-content'
import { AuthGuard } from '@/components/auth-guard'

export const metadata = {
  title: 'Settings | LOVESENSE Admin',
}

export default function SettingsPage() {
  return <SettingsContent />
}
