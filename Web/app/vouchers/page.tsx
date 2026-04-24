import { Sidebar } from '@/components/sidebar'
import { TopNav } from '@/components/top-nav'
import { VouchersContent } from '@/components/vouchers-content'
import { AuthGuard } from '@/components/auth-guard'

export const metadata = {
  title: 'Vouchers | LOVESENSE Admin',
}

export default function VouchersPage() {
  return <VouchersContent />
}
