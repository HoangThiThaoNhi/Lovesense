'use client'

import { useTheme } from 'next-themes'
import { Toaster as Sonner, ToasterProps } from 'sonner'

const Toaster = ({ ...props }: ToasterProps) => {
  const { theme = 'system' } = useTheme()

  return (
    <Sonner
      theme={theme as ToasterProps['theme']}
      className="toaster group"
      richColors
      expand={true}
      position="top-right"
      toastOptions={{
        classNames: {
          toast: "group toast group-[.toaster]:bg-background/80 group-[.toaster]:backdrop-blur-xl group-[.toaster]:text-foreground group-[.toaster]:border-border/50 group-[.toaster]:shadow-2xl group-[.toaster]:rounded-[20px] font-outfit px-5 py-4",
          description: "group-[.toast]:text-muted-foreground font-medium",
          actionButton: "group-[.toast]:bg-primary group-[.toast]:text-primary-foreground font-bold rounded-xl",
          cancelButton: "group-[.toast]:bg-muted group-[.toast]:text-muted-foreground font-bold rounded-xl",
          success: "group-[.toaster]:border-emerald-500/20 group-[.toaster]:bg-emerald-500/5",
          error: "group-[.toaster]:border-red-500/20 group-[.toaster]:bg-red-500/5",
          warning: "group-[.toaster]:border-amber-500/20 group-[.toaster]:bg-amber-500/5",
          info: "group-[.toaster]:border-blue-500/20 group-[.toaster]:bg-blue-500/5",
        },
      }}
      {...props}
    />
  )
}

export { Toaster }
