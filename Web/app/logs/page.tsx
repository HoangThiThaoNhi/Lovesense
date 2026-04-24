import { LogsContent } from '@/components/logs-content'
import { Sidebar } from '@/components/sidebar'
import { TopNav } from '@/components/top-nav'
import { AuthGuard } from '@/components/auth-guard'

export default function LogsPage() {
  return (
    <AuthGuard>
      <main className="min-h-screen bg-[#0a0a0b] flex">
        <Sidebar />
        <div className="flex-1 flex flex-col ml-72">
          <TopNav />
          <div className="flex-1 overflow-y-auto custom-scrollbar">
            <LogsContent />
          </div>
        </div>
      </main>
    </AuthGuard>
  )
}
