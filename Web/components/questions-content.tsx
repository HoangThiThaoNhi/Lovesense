"use client";

import { useEffect, useState, useCallback } from 'react'
import { Card } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'
import {
  Search,
  MoreVertical,
  Trash2,
  Edit,
  Eye,
  Plus,
  Target,
  Copy,
  Sparkles,
  Loader2,
  AlertCircle,
} from 'lucide-react'
import { Badge } from '@/components/ui/badge'
import { QuestionModal } from './question-modal'
import { api } from '@/lib/api'

export function QuestionsContent() {
  const [questions, setQuestions] = useState<any[]>([])
  const [loading, setLoading] = useState(true)
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedQuestion, setSelectedQuestion] = useState<any | null>(null)
  const [isModalOpen, setIsModalOpen] = useState(false)

  const fetchQuestions = useCallback(async () => {
    setLoading(true)
    try {
      const data = await api.getQuestions()
      setQuestions(data)
    } catch (error) {
      console.error('Failed to fetch questions:', error)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    fetchQuestions()
  }, [fetchQuestions])

  const openCreateDialog = () => {
    setSelectedQuestion(null)
    setIsModalOpen(true)
  }

  const openEditDialog = (q: any) => {
    setSelectedQuestion(q)
    setIsModalOpen(true)
  }

  const handleDuplicate = (q: any) => {
    setSelectedQuestion({ ...q, id: null, isDuplicate: true })
    setIsModalOpen(true)
  }

  const handleDelete = async (id: string) => {
    if (!confirm('Bạn có chắc muốn xóa (lưu trữ) câu hỏi này?')) return
    try {
      await api.deleteQuestion(id)
      fetchQuestions()
    } catch (error: any) {
      alert('Lỗi: ' + error.message)
    }
  }

  const filteredQuestions = questions.filter(
    (q) =>
      q.text.toLowerCase().includes(searchQuery.toLowerCase()) ||
      q.category.toLowerCase().includes(searchQuery.toLowerCase()) ||
      (q.sub_category && q.sub_category.toLowerCase().includes(searchQuery.toLowerCase()))
  )

  const getCategoryLabel = (category: string) => {
    switch (category?.toUpperCase()) {
      case 'G1_PERSONALITY': return 'G1 - Tính cách'
      case 'G2_CORE_VALUES': return 'G2 - Giá trị cốt lõi'
      case 'G3_FINANCIAL_LIFESTYLE': return 'G3 - Tài chính & Lối sống'
      case 'G4_INTIMACY_ROMANCE': return 'G4 - Sự lãng mạn & Thân mật'
      case 'G5_CAREER_AMBITION': return 'G5 - Sự nghiệp & Tham vọng'
      case 'G6_CONFLICT_RESOLUTION': return 'G6 - Giải quyết xung đột'
      case 'G7_INTERESTS_GROWTH': return 'G7 - Sở thích & Phát triển'
      default: return category
    }
  }

  const getWeightBadge = (weight: number) => {
    if (weight >= 5) return 'bg-red-500 text-white shadow-lg shadow-red-500/20'
    if (weight >= 4) return 'bg-orange-500 text-white shadow-lg shadow-orange-500/20'
    if (weight >= 3) return 'bg-amber-500 text-white'
    return 'bg-blue-500/10 text-blue-500 border-blue-500/20'
  }

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty?.toLowerCase()) {
      case 'easy': return 'bg-emerald-500/10 text-emerald-500'
      case 'medium': return 'bg-amber-500/10 text-amber-500'
      case 'hard': return 'bg-red-500/10 text-red-500'
      default: return 'bg-gray-500/10 text-gray-500'
    }
  }

  const getDifficultyLabel = (difficulty: string) => {
    switch (difficulty?.toLowerCase()) {
      case 'easy': return 'Dễ'
      case 'medium': return 'Trung bình'
      case 'hard': return 'Khó'
      default: return difficulty
    }
  }

  return (
    <div className="p-8 w-full font-outfit">
      {/* Tiêu đề */}
      <div className="mb-10 flex items-end justify-between">
        <div>
          <h1 className="text-4xl font-extrabold text-white mb-3 tracking-tight flex items-center gap-4 text-shadow-lg shadow-primary/20">
            <Sparkles className="w-10 h-10 text-primary animate-pulse" />
            Cấu hình AI Interview
          </h1>
          <p className="text-muted-foreground font-medium text-lg italic opacity-80">
            Thiết kế ngân hàng câu hỏi để AI thấu hiểu người dùng sâu sắc hơn
          </p>
        </div>
        <Button 
          className="bg-gradient-to-r from-primary to-secondary text-primary-foreground hover:scale-105 transition-all shadow-xl shadow-primary/40 rounded-2xl h-14 px-8 font-black text-lg border-t border-white/20"
          onClick={openCreateDialog}
        >
          <Plus className="w-6 h-6 mr-3" />
          Tạo câu hỏi mới
        </Button>
      </div>

      {/* Thanh công cụ */}
      <div className="flex gap-4 mb-8">
        <div className="flex-1 relative group">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground group-focus-within:text-primary transition-colors" />
          <Input
            placeholder="Tìm kiếm theo nội dung, phân loại hoặc tiêu chí phụ..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="pl-12 h-14 bg-secondary/10 border-border/40 focus:ring-primary/20 rounded-2xl transition-all font-medium text-lg placeholder:text-muted-foreground/50"
          />
        </div>
      </div>

      {/* Bảng dữ liệu */}
      <Card className="bg-card/30 border-border/40 overflow-hidden rounded-[32px] shadow-2xl backdrop-blur-md relative">
        {loading && (
          <div className="absolute inset-0 bg-background/50 backdrop-blur-sm z-10 flex items-center justify-center">
            <Loader2 className="w-12 h-12 text-primary animate-spin" />
          </div>
        )}
        <Table>
          <TableHeader>
            <TableRow className="border-border/40 hover:bg-transparent h-20 bg-white/5">
              <TableHead className="text-muted-foreground font-bold uppercase tracking-wider pl-8 w-[400px]">Câu hỏi & Tiêu chí</TableHead>
              <TableHead className="text-muted-foreground font-bold uppercase tracking-wider text-center">Trọng số</TableHead>
              <TableHead className="text-muted-foreground font-bold uppercase tracking-wider">Phân loại</TableHead>
              <TableHead className="text-muted-foreground font-bold uppercase tracking-wider">Độ khó</TableHead>
              <TableHead className="text-muted-foreground font-bold uppercase tracking-wider">Trạng thái</TableHead>
              <TableHead className="text-right text-muted-foreground font-bold uppercase tracking-wider pr-8">Hành động</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {filteredQuestions.length === 0 && !loading ? (
              <TableRow>
                <TableCell colSpan={6} className="h-40 text-center">
                  <div className="flex flex-col items-center gap-2 opacity-50 text-muted-foreground">
                    <AlertCircle className="w-10 h-10" />
                    <p className="font-bold">Không có câu hỏi nào</p>
                  </div>
                </TableCell>
              </TableRow>
            ) : (
              filteredQuestions.map((q) => (
                <TableRow
                  key={q.id}
                  className="border-border/40 hover:bg-white/5 transition-all h-28 group"
                >
                  <TableCell className="pl-8">
                    <div className="flex items-start gap-4">
                      <div className="mt-1">
                        <div className={`w-2 h-2 rounded-full ${q.status === 'active' ? 'bg-emerald-500 shadow-[0_0_8px_rgba(16,185,129,0.5)]' : 'bg-muted'}`} />
                      </div>
                      <div>
                        <p className="font-bold text-foreground text-lg mb-1 group-hover:text-primary transition-colors line-clamp-2">
                          {q.text}
                        </p>
                        <div className="flex items-center gap-3">
                          <span className={`inline-flex px-2 py-0.5 rounded-md text-[9px] font-black uppercase tracking-widest ${
                            q.type === 'mcq' ? 'bg-blue-500/20 text-blue-400' : 'bg-purple-500/20 text-purple-400'
                          }`}>
                            {q.type === 'mcq' ? 'Trắc nghiệm' : 'Mở'}
                          </span>
                          {q.sub_category && (
                            <span className="text-[10px] font-bold text-primary italic">
                              #{q.sub_category}
                            </span>
                          )}
                        </div>
                      </div>
                    </div>
                  </TableCell>
                  <TableCell className="text-center">
                    <div className={`inline-flex items-center justify-center w-8 h-8 rounded-full font-black text-xs border border-white/10 ${getWeightBadge(q.weight || 1)}`}>
                      {q.weight || 1}
                    </div>
                  </TableCell>
                  <TableCell>
                    <Badge variant="outline" className="bg-secondary/10 text-secondary border-secondary/20 font-black text-[10px] h-7 rounded-lg uppercase tracking-wider px-3">
                      {getCategoryLabel(q.category)}
                    </Badge>
                  </TableCell>
                  <TableCell>
                     <span className={`inline-flex px-3 py-1 rounded-full text-[10px] font-black uppercase tracking-widest ${getDifficultyColor(q.difficulty)}`}>
                      {getDifficultyLabel(q.difficulty)}
                    </span>
                  </TableCell>
                  <TableCell>
                    <span
                      className={`inline-flex items-center px-3 py-1 rounded-full text-[10px] font-black uppercase tracking-widest border ${
                        q.status === 'active'
                          ? 'bg-emerald-500/10 text-emerald-500 border-emerald-500/20'
                          : q.status === 'draft'
                            ? 'bg-amber-500/10 text-amber-500 border-amber-500/20'
                            : 'bg-red-500/10 text-red-500 border-red-500/10'
                      }`}
                    >
                      {q.status === 'active' ? 'Hoạt động' : q.status === 'draft' ? 'Bản nháp' : 'Lưu trữ'}
                    </span>
                  </TableCell>
                  <TableCell className="text-right pr-8">
                    <div className="flex items-center justify-end gap-2">
                      <Button 
                        variant="ghost" 
                        size="icon" 
                        className="h-10 w-10 hover:bg-emerald-500/10 hover:text-emerald-500 rounded-xl transition-colors"
                        onClick={() => openEditDialog(q)}
                      >
                        <Edit className="w-5 h-5" />
                      </Button>
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" size="icon" className="h-10 w-10 hover:bg-primary/10 rounded-xl group/btn">
                            <MoreVertical className="w-5 h-5 group-hover/btn:text-primary" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end" className="bg-card/95 border-border backdrop-blur-xl rounded-2xl p-2 w-56 shadow-2xl">
                          <DropdownMenuItem 
                            className="cursor-pointer hover:bg-secondary/10 rounded-xl h-11 px-4 font-bold flex items-center gap-3 transition-all"
                            onClick={() => handleDuplicate(q)}
                          >
                            <Copy className="w-4 h-4 text-blue-500" />
                            Nhân bản câu hỏi
                          </DropdownMenuItem>
                          <DropdownMenuItem 
                            className="cursor-pointer text-destructive hover:bg-destructive/10 rounded-xl h-11 px-4 font-bold flex items-center gap-3 transition-all"
                            onClick={() => handleDelete(q.id)}
                          >
                            <Trash2 className="w-4 h-4" />
                            Xóa (Lưu trữ)
                          </DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </div>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </Card>

      <QuestionModal
        question={selectedQuestion}
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        onSuccess={fetchQuestions}
      />

      {/* Thống kê nhanh */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-6 mt-10">
        <Card className="p-8 bg-gradient-to-br from-primary/10 to-transparent border-white/10 rounded-[28px] shadow-lg flex flex-col justify-between group hover:bg-primary/5 transition-all">
          <p className="text-xs font-black text-muted-foreground mb-4 uppercase tracking-[0.2em] group-hover:text-primary transition-colors">Tổng số câu hỏi</p>
          <div className="flex items-baseline gap-2">
            <p className="text-5xl font-black text-foreground">{questions.length}</p>
            <span className="text-sm font-bold text-muted-foreground opacity-50 italic">câu hỏi trong kho</span>
          </div>
        </Card>
        <Card className="p-8 bg-gradient-to-br from-emerald-500/10 to-transparent border-white/10 rounded-[28px] shadow-lg flex flex-col justify-between group hover:bg-emerald-500/5 transition-all">
          <p className="text-xs font-black text-muted-foreground mb-4 uppercase tracking-[0.2em] group-hover:text-emerald-500 transition-colors">Câu hỏi đang hoạt động</p>
          <div className="flex items-baseline gap-2">
            <p className="text-5xl font-black text-emerald-500">
              {questions.filter((q) => q.status === 'active').length}
            </p>
            <span className="text-sm font-bold text-muted-foreground opacity-50 italic">đã sẵn sàng cho AI</span>
          </div>
        </Card>
      </div>
    </div>
  )
}
