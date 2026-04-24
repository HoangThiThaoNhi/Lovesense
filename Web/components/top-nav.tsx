'use client'

import { Bell, Search, User } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'

export function TopNav() {
  return (
    <nav className="h-16 bg-background/70 backdrop-blur-xl border-b border-white/5 flex items-center justify-between px-8 z-40 shadow-sm sticky top-0">
      {/* Search */}
      <div className="flex-1 max-w-md">
          <div className="relative group">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-primary transition-colors" />
            <input
              type="text"
              placeholder="Tìm kiếm..."
              className="pl-10 pr-4 py-2 w-64 md:w-80 bg-muted/50 border border-border rounded-full text-sm focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all duration-300"
            />
          </div>
      </div>

      {/* Right Actions */}
      <div className="flex items-center gap-4">
        <Button
          variant="ghost"
          size="icon"
          className="relative text-foreground hover:bg-secondary/20"
        >
          <Bell className="w-5 h-5" />
          <span className="absolute top-1 right-1 w-2 h-2 bg-primary rounded-full" />
        </Button>
        <Button
          variant="ghost"
          size="icon"
          className="w-10 h-10 rounded-full text-foreground hover:bg-secondary/20"
        >
          <User className="w-5 h-5" />
        </Button>
      </div>
    </nav>
  )
}
