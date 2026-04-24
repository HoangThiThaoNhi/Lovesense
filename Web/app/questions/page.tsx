import { Sidebar } from '@/components/sidebar'
import { TopNav } from '@/components/top-nav'
import { QuestionsContent } from '@/components/questions-content'
import { AuthGuard } from '@/components/auth-guard'

export const metadata = {
  title: 'AI Questions | LOVESENSE Admin',
}

export default function QuestionsPage() {
  return <QuestionsContent />
}
