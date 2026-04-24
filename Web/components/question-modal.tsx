'use client'

import { useState, useEffect } from 'react'
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { Sparkles, Loader2 } from 'lucide-react'
import { api } from '@/lib/api'

interface QuestionModalProps {
  question: any | null
  isOpen: boolean
  onClose: () => void
  onSuccess: () => void
}

export function QuestionModal({ question, isOpen, onClose, onSuccess }: QuestionModalProps) {
  const [loading, setLoading] = useState(false)
  const [showGuide, setShowGuide] = useState(false)
  const [formData, setFormData] = useState({
    text: '',
    category: 'personality',
    difficulty: 'medium',
    status: 'active',
    type: 'mcq',
    options: '',
    weight: 1,
    sub_category: ''
  })

  useEffect(() => {
    if (question) {
      setFormData({
        text: question.text || '',
        category: question.category || 'personality',
        difficulty: question.difficulty || 'medium',
        status: question.status || 'active',
        type: question.type || 'mcq',
        options: question.options || '',
        weight: question.weight || 1,
        sub_category: question.sub_category || ''
      })
    } else {
      setFormData({
        text: '',
        category: 'personality',
        difficulty: 'medium',
        status: 'active',
        type: 'mcq',
        options: '',
        weight: 1,
        sub_category: ''
      })
    }
  }, [question, isOpen])

  const handleAISuggest = async () => {
    if (!formData.text) {
      alert('Vui lòng nhập nội dung câu hỏi trước');
      return;
    }
    setLoading(true);
    try {
      const suggestion = await api.suggestQuizLogic({
        question: formData.text,
        category_id: formData.category
      });
      
      if (suggestion && suggestion.options) {
        // suggestion.options might be an array or string depending on AI output
        const optionsStr = Array.isArray(suggestion.options) 
          ? suggestion.options.join('; ') 
          : suggestion.options;
        setFormData({ ...formData, options: optionsStr });
      }
    } catch (error) {
      console.error('AI Suggest failed:', error);
      alert('AI không thể đưa ra gợi ý lúc này');
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    try {
      if (question?.id && !question.isDuplicate) {
        await api.updateQuestion(question.id, formData)
      } else {
        await api.createQuestion(formData)
      }
      onSuccess()
      onClose()
    } catch (error) {
      alert('Lỗi: ' + (error as any).message)
    } finally {
      setLoading(false)
    }
  }

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[550px] bg-[#0a0a0b] border-border/40 font-outfit rounded-[32px] text-white p-0 overflow-hidden shadow-2xl">
        <DialogHeader className="p-6 pb-0">
          <div className="flex justify-between items-center mb-2">
            <DialogTitle className="text-2xl font-black flex items-center gap-3">
              <Sparkles className="w-6 h-6 text-primary" />
              {question?.id && !question.isDuplicate ? 'Chỉnh sửa câu hỏi' : 'Tạo câu hỏi AI mới'}
            </DialogTitle>
            <Button 
              variant="outline" 
              size="sm" 
              onClick={() => setShowGuide(!showGuide)}
              className={`rounded-full transition-all text-xs gap-2 ${showGuide ? 'bg-primary text-primary-foreground border-primary' : 'bg-white/5 border-white/10 text-white'}`}
            >
              <Sparkles className="w-4 h-4" />
              {showGuide ? 'Đóng hướng dẫn' : 'Hướng dẫn'}
            </Button>
            <DialogDescription className="text-muted-foreground text-xs mt-1">
              Thiết lập các tham số cho câu hỏi để AI phân tích DNA người dùng chính xác hơn.
            </DialogDescription>
          </div>
        </DialogHeader>

        <div className="max-h-[70vh] overflow-y-auto custom-scrollbar px-6 py-4">
          {showGuide && (
            <div className="bg-primary/10 border border-primary/20 p-4 rounded-2xl mb-6 animate-in fade-in slide-in-from-top-2 duration-300">
              <h4 className="font-bold text-primary mb-2 text-sm flex items-center gap-2">
                <Sparkles className="w-4 h-4" /> Logic Matchmaking:
              </h4>
              <div className="grid grid-cols-1 gap-3">
                <div className="bg-black/20 p-2 rounded-lg border border-white/5">
                  <p className="text-[11px] leading-relaxed text-white/80">
                    <span className="text-primary font-bold">Trọng số (1-5):</span> Mức <span className="text-white font-bold">5</span> là điều kiện bắt buộc để Match. Mức <span className="text-white font-bold">1</span> là sở thích bổ trợ.
                  </p>
                </div>
                <div className="bg-black/20 p-2 rounded-lg border border-white/5">
                  <p className="text-[11px] leading-relaxed text-white/80">
                    <span className="text-primary font-bold">Tiêu chí phụ:</span> Nhập từ khóa (vd: Tài chính, Con cái) để Gemini phân tích chân dung sâu hơn.
                  </p>
                </div>
              </div>
            </div>
          )}

          <form id="question-form" onSubmit={handleSubmit} className="space-y-6">
            <div className="space-y-2">
              <Label htmlFor="text" className="font-bold text-muted-foreground text-sm">Nội dung câu hỏi</Label>
              <Textarea
                id="text"
                placeholder="Ví dụ: Bạn thích dành ngày nghỉ cuối tuần như thế nào?"
                value={formData.text}
                onChange={(e) => setFormData({ ...formData, text: e.target.value })}
                className="bg-white/5 border-white/10 min-h-[80px] rounded-xl focus:ring-primary/20 resize-none text-sm"
                required
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label className="font-bold text-muted-foreground text-sm">Loại hình</Label>
                <Select 
                  value={formData.type} 
                  onValueChange={(val) => setFormData({ ...formData, type: val })}
                >
                  <SelectTrigger className="bg-white/5 border-white/10 h-11 rounded-xl text-sm">
                    <SelectValue placeholder="Chọn hình thức" />
                  </SelectTrigger>
                  <SelectContent className="bg-[#121214] border-white/10">
                    <SelectItem value="mcq">Trắc nghiệm (MCQ)</SelectItem>
                    <SelectItem value="open">Câu hỏi mở</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              
              <div className="space-y-2">
                <Label className="font-bold text-muted-foreground text-sm">Phân loại</Label>
                <Select 
                  value={formData.category} 
                  onValueChange={(val) => setFormData({ ...formData, category: val })}
                >
                  <SelectTrigger className="bg-white/5 border-white/10 h-11 rounded-xl text-sm">
                    <SelectValue placeholder="Chọn loại" />
                  </SelectTrigger>
                  <SelectContent className="bg-[#121214] border-white/10">
                    <SelectItem value="G1_PERSONALITY">G1 - Tính cách</SelectItem>
                    <SelectItem value="G2_CORE_VALUES">G2 - Giá trị cốt lõi</SelectItem>
                    <SelectItem value="G3_FINANCIAL_LIFESTYLE">G3 - Tài chính & Lối sống</SelectItem>
                    <SelectItem value="G4_INTIMACY_ROMANCE">G4 - Sự lãng mạn & Thân mật</SelectItem>
                    <SelectItem value="G5_CAREER_AMBITION">G5 - Sự nghiệp & Tham vọng</SelectItem>
                    <SelectItem value="G6_CONFLICT_RESOLUTION">G6 - Giải quyết xung đột</SelectItem>
                    <SelectItem value="G7_INTERESTS_GROWTH">G7 - Sở thích & Phát triển</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label className="font-bold text-muted-foreground text-sm">Trọng số (Ưu tiên 1-5)</Label>
                <Select 
                  value={formData.weight.toString()} 
                  onValueChange={(val) => setFormData({ ...formData, weight: parseInt(val) })}
                >
                  <SelectTrigger className="bg-white/5 border-white/10 h-11 rounded-xl text-sm">
                    <SelectValue placeholder="Chọn trọng số" />
                  </SelectTrigger>
                  <SelectContent className="bg-[#121214] border-white/10">
                    <SelectItem value="1">1 - Thấp</SelectItem>
                    <SelectItem value="2">2 - Trung bình</SelectItem>
                    <SelectItem value="3">3 - Khá</SelectItem>
                    <SelectItem value="4">4 - Cao</SelectItem>
                    <SelectItem value="5">5 - Rất cao</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="sub_category" className="font-bold text-muted-foreground text-sm">Tiêu chí phụ</Label>
                <Input
                  id="sub_category"
                  placeholder="Vd: Tài chính..."
                  value={formData.sub_category}
                  onChange={(e) => setFormData({ ...formData, sub_category: e.target.value })}
                  className="bg-white/5 border-white/10 h-11 rounded-xl focus:ring-primary/20 text-sm"
                />
              </div>
            </div>

            {formData.type === 'mcq' && (
              <div className="space-y-2 animate-in fade-in slide-in-from-top-2">
                <div className="flex justify-between items-center">
                  <Label htmlFor="options" className="font-bold text-amber-500 text-sm">Các lựa chọn (ngăn cách bởi dấu ;)</Label>
                  <Button 
                    type="button" 
                    variant="ghost" 
                    size="sm" 
                    onClick={handleAISuggest}
                    className="text-primary hover:text-primary/80 h-7 px-2 font-bold text-[10px] uppercase gap-1"
                  >
                    <Sparkles className="w-3 h-3" />
                    AI Gợi ý
                  </Button>
                </div>
                <Input
                  id="options"
                  placeholder="Vd: Đi du lịch; Ở nhà xem phim; Đi cà phê"
                  value={formData.options}
                  onChange={(e) => setFormData({ ...formData, options: e.target.value })}
                  className="bg-white/5 border-white/10 h-11 rounded-xl focus:ring-amber-500/20 text-sm"
                  required={formData.type === 'mcq'}
                />
              </div>
            )}
            
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label className="font-bold text-muted-foreground text-sm">Độ khó</Label>
                <Select 
                  value={formData.difficulty} 
                  onValueChange={(val) => setFormData({ ...formData, difficulty: val })}
                >
                  <SelectTrigger className="bg-white/5 border-white/10 h-11 rounded-xl text-sm">
                    <SelectValue placeholder="Chọn độ khó" />
                  </SelectTrigger>
                  <SelectContent className="bg-[#121214] border-white/10">
                    <SelectItem value="easy">Dễ</SelectItem>
                    <SelectItem value="medium">Trung bình</SelectItem>
                    <SelectItem value="hard">Khó</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <Label className="font-bold text-muted-foreground text-sm">Trạng thái</Label>
                <Select 
                  value={formData.status} 
                  onValueChange={(val) => setFormData({ ...formData, status: val })}
                >
                  <SelectTrigger className="bg-white/5 border-white/10 h-11 rounded-xl text-sm">
                    <SelectValue placeholder="Trạng thái" />
                  </SelectTrigger>
                  <SelectContent className="bg-[#121214] border-white/10">
                    <SelectItem value="active">Hoạt động</SelectItem>
                    <SelectItem value="draft">Bản nháp</SelectItem>
                    <SelectItem value="archived">Lưu trữ</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </form>
        </div>

        <DialogFooter className="p-6 pt-2 bg-[#0a0a0b] border-t border-white/5">
          <Button 
            type="button" 
            variant="ghost" 
            onClick={onClose}
            className="rounded-xl h-11 font-bold hover:bg-white/5"
          >
            Hủy
          </Button>
          <Button 
            form="question-form"
            type="submit" 
            disabled={loading}
            className="bg-gradient-to-r from-primary to-secondary text-primary-foreground rounded-xl h-11 px-8 font-bold hover:scale-105 transition-all shadow-xl shadow-primary/20"
          >
            {loading ? <Loader2 className="w-5 h-5 animate-spin" /> : (question?.id && !question.isDuplicate ? 'Cập nhật' : 'Tạo câu hỏi')}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  )
}
