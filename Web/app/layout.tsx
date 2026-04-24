import type { Metadata } from 'next'
// Use Google Fonts link (Google Sans Flex + Roboto + Poppins) via <link>
import { Analytics } from '@vercel/analytics/next'
import './globals.css'

// Note: font files will be loaded from Google Fonts using the link below

export const metadata: Metadata = {
  title: 'Hệ quản trị LOVESENSE Admin',
  description: 'Bảng quản trị cao cấp cho nền tảng hẹn hò LOVESENSE AI',
  generator: 'v0.app',
  icons: {
    icon: [
      {
        url: '/icon-light-32x32.png',
        media: '(prefers-color-scheme: light)',
      },
      {
        url: '/icon-dark-32x32.png',
        media: '(prefers-color-scheme: dark)',
      },
      {
        url: '/icon.svg',
        type: 'image/svg+xml',
      },
    ],
    apple: '/apple-icon.png',
  },
}

import { AuthProvider } from '@/context/AuthContext'
import { Toaster } from '@/components/ui/sonner'
import { Sidebar } from '../components/sidebar'
import { TopNav } from '../components/top-nav'
import { LayoutWrapper } from '../components/layout-wrapper'

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="vi" className="dark">
        <head>
          <link href="https://fonts.googleapis.com/css2?family=Google+Sans+Flex:opsz,wght@8..144,100..1000&family=Roboto:wght@300;400;500;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet" />
        </head>
        <body className="antialiased bg-[#0a0a0b]">
        <AuthProvider>
          <LayoutWrapper>
            {children}
          </LayoutWrapper>
          <Toaster />
        </AuthProvider>
        <Analytics />
      </body>
    </html>
  )
}
