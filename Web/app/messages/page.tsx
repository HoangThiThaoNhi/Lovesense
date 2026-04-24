import { Sidebar } from '@/components/sidebar'
import { TopNav } from '@/components/top-nav'
import { MessageSquare, ArrowRight } from 'lucide-react'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'

export const metadata = {
  title: 'Messages | LOVESENSE Admin',
}

import { AuthGuard } from '@/components/auth-guard'

export default function MessagesPage() {
  return (
    <div className="p-8 w-full">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-foreground mb-2">Messaging Hub</h1>
        <p className="text-muted-foreground">Monitor and manage user conversations</p>
      </div>

      <Card className="p-12 bg-card border-border text-center">
        <div className="w-16 h-16 rounded-lg bg-gradient-to-br from-primary to-secondary flex items-center justify-center mx-auto mb-6">
          <MessageSquare className="w-8 h-8 text-white" />
        </div>
        <h2 className="text-2xl font-bold text-foreground mb-2">Coming Soon</h2>
        <p className="text-muted-foreground mb-6 max-w-md mx-auto">
          The messaging hub is currently in development. Real-time conversation monitoring and moderation tools will be available soon.
        </p>
        <Button className="bg-primary text-primary-foreground hover:bg-primary/90">
          Check Back Later
          <ArrowRight className="w-4 h-4 ml-2" />
        </Button>
      </Card>
    </div>
  )
}
