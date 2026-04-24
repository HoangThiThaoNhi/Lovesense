'use client'

import { useState, useRef } from 'react'
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Progress } from '@/components/ui/progress'
import { Label } from '@/components/ui/label'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { Sparkles, Upload, Loader2, CheckCircle2, AlertCircle, X } from 'lucide-react'
import { api } from '@/lib/api'
import { toast } from 'sonner'

interface BulkUserModalProps {
  isOpen: boolean
  onClose: () => void
  onSuccess: () => void
}

export function BulkUserModal({ isOpen, onClose, onSuccess }: BulkUserModalProps) {
  const [loading, setLoading] = useState(false)
  const [files, setFiles] = useState<File[]>([])
  const [gender, setGender] = useState<'Nam' | 'Nữ' | 'Tất cả'>('Tất cả')
  const [lookingFor, setLookingFor] = useState<'Nam' | 'Nữ' | 'Tất cả'>('Tất cả')
  const [progress, setProgress] = useState(0)
  const [status, setStatus] = useState<'idle' | 'uploading' | 'generating' | 'success' | 'error'>('idle')
  const fileInputRef = useRef<HTMLInputElement>(null)

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files) {
      const newFiles = Array.from(e.target.files)
      if (files.length + newFiles.length > 50) {
        toast.error('Chỉ được phép tải lên tối đa 50 ảnh mỗi lần.')
        const remainingSlots = 50 - files.length
        setFiles(prev => [...prev, ...newFiles.slice(0, remainingSlots)])
      } else {
        setFiles(prev => [...prev, ...newFiles])
      }
    }
  }

  const removeFile = (index: number) => {
    setFiles(prev => prev.filter((_, i) => i !== index))
  }

  const handleSubmit = async () => {
    if (files.length === 0) {
      toast.error('Vui lòng chọn ít nhất một ảnh.')
      return
    }

    setLoading(true)
    setStatus('uploading')
    setProgress(20)

    try {
      const formData = new FormData()
      files.forEach(file => {
        formData.append('images', file)
      })
      formData.append('gender', gender)
      formData.append('looking_for', lookingFor)

      setStatus('generating')
      setProgress(50)

      const result = await api.bulkUserGenerate(formData)
      
      setProgress(100)
      setStatus('success')
      toast.success(result.message || `Đã tạo thành công ${files.length} người dùng AI!`)
      
      setTimeout(() => {
        onSuccess()
        onClose()
        // Reset state after closing
        setFiles([])
        setStatus('idle')
        setProgress(0)
      }, 2000)
    } catch (error) {
      setStatus('error')
      toast.error('Lỗi: ' + (error as any).message)
    } finally {
      setLoading(false)
    }
  }

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[600px] bg-[#0a0a0b] border-border/40 font-outfit rounded-[32px] text-white p-0 overflow-hidden shadow-2xl">
        <DialogHeader className="p-8 pb-0">
          <DialogTitle className="text-3xl font-black flex items-center gap-3">
            <Sparkles className="w-8 h-8 text-primary animate-pulse" />
            Tạo 500+ Người dùng AI
          </DialogTitle>
          <DialogDescription className="text-muted-foreground text-lg">
            Hệ thống sẽ tự động tạo hồ sơ, tiểu sử, sở thích dựa trên hình ảnh bạn cung cấp.
          </DialogDescription>
        </DialogHeader>

        <div className="p-8 space-y-6">
          <div className="grid grid-cols-2 gap-4 items-end">
            <div className="space-y-2">
              <Label className="text-xs font-black uppercase tracking-widest text-muted-foreground">Giới tính chung</Label>
              <Select 
                value={gender} 
                onValueChange={(val: any) => setGender(val)}
                disabled={loading}
              >
                <SelectTrigger className="bg-white/5 border-white/10 h-12 rounded-xl font-bold">
                  <SelectValue placeholder="Chọn giới tính" />
                </SelectTrigger>
                <SelectContent className="bg-[#121214] border-white/10">
                  <SelectItem value="Tất cả">Phân bổ ngẫu nhiên</SelectItem>
                  <SelectItem value="Nam" className="text-blue-400">Nam (Men)</SelectItem>
                  <SelectItem value="Nữ" className="text-pink-400">Nữ (Women)</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label className="text-xs font-black uppercase tracking-widest text-muted-foreground">Đối tượng tìm kiếm</Label>
              <Select 
                value={lookingFor} 
                onValueChange={(val: any) => setLookingFor(val)}
                disabled={loading}
              >
                <SelectTrigger className="bg-white/5 border-white/10 h-12 rounded-xl font-bold">
                  <SelectValue placeholder="Tìm kiếm..." />
                </SelectTrigger>
                <SelectContent className="bg-[#121214] border-white/10">
                  <SelectItem value="Tất cả">Ngẫu nhiên</SelectItem>
                  <SelectItem value="Nam">Tìm Nam</SelectItem>
                  <SelectItem value="Nữ">Tìm Nữ</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>

          {status === 'idle' || status === 'uploading' ? (
            <div 
              className={`border-2 border-dashed rounded-[24px] p-10 flex flex-col items-center justify-center transition-all cursor-pointer hover:bg-white/5 ${files.length > 0 ? 'border-primary/50 bg-primary/5' : 'border-white/10'}`}
              onClick={() => fileInputRef.current?.click()}
            >
              <Upload className={`w-12 h-12 mb-4 ${files.length > 0 ? 'text-primary' : 'text-muted-foreground'}`} />
              <p className="text-lg font-bold mb-1">
                {files.length > 0 ? `Đã chọn ${files.length} ảnh` : 'Click để chọn hoặc kéo thả nhiều ảnh'}
              </p>
              <p className="text-sm text-muted-foreground opacity-60 italic">AI sẽ tạo 1 người dùng cho mỗi ảnh bạn tải lên</p>
              <input 
                type="file" 
                multiple 
                ref={fileInputRef} 
                onChange={handleFileChange} 
                className="hidden" 
                accept="image/*"
              />
            </div>
          ) : null}

          {files.length > 0 && status === 'idle' && (
            <div className="max-h-[200px] overflow-y-auto grid grid-cols-4 gap-2 p-2 rounded-xl bg-white/5">
              {files.map((file, idx) => (
                <div key={idx} className="relative group aspect-square rounded-lg overflow-hidden bg-black/40 border border-white/10">
                  <img 
                    src={URL.createObjectURL(file)} 
                    className="w-full h-full object-cover opacity-80 group-hover:opacity-100 transition-opacity" 
                  />
                  <button 
                    onClick={(e) => { e.stopPropagation(); removeFile(idx); }}
                    className="absolute top-1 right-1 bg-red-500 rounded-full p-1 opacity-0 group-hover:opacity-100 transition-opacity shadow-lg"
                  >
                    <X className="w-3 h-3 text-white" />
                  </button>
                </div>
              ))}
            </div>
          )}

          {(status === 'uploading' || status === 'generating') && (
            <div className="py-10 space-y-6 animate-in fade-in zoom-in-95">
              <div className="flex flex-col items-center gap-4">
                <Loader2 className="w-16 h-16 text-primary animate-spin" />
                <div className="text-center">
                  <h4 className="text-xl font-black">
                    {status === 'uploading' ? 'Đang tải ảnh lên Cloudinary...' : 'AI đang "nặn" hồ sơ người dùng...'}
                  </h4>
                  <p className="text-muted-foreground italic">Vui lòng không đóng cửa sổ này</p>
                </div>
              </div>
              <div className="space-y-2">
                <div className="flex justify-between text-xs font-bold uppercase tracking-widest text-primary">
                  <span>Tiến độ</span>
                  <span>{progress}%</span>
                </div>
                <Progress value={progress} className="h-3 bg-white/5" />
              </div>
            </div>
          )}

          {status === 'success' && (
            <div className="py-10 flex flex-col items-center gap-4 animate-in zoom-in-95">
              <div className="w-20 h-20 bg-emerald-500/20 rounded-full flex items-center justify-center">
                <CheckCircle2 className="w-12 h-12 text-emerald-500" />
              </div>
              <div className="text-center">
                <h4 className="text-2xl font-black text-emerald-500">Thành công rực rỡ!</h4>
                <p className="text-muted-foreground italic">Kho người dùng của bạn đã được lấp đầy.</p>
              </div>
            </div>
          )}

          {status === 'error' && (
            <div className="py-10 flex flex-col items-center gap-4 animate-in shake">
              <div className="w-20 h-20 bg-red-500/20 rounded-full flex items-center justify-center">
                <AlertCircle className="w-12 h-12 text-red-500" />
              </div>
              <div className="text-center">
                <h4 className="text-2xl font-black text-red-500">Có lỗi xảy ra</h4>
                <p className="text-muted-foreground italic">Vui lòng kiểm tra lại kết nối mạng hoặc API Key.</p>
              </div>
              <Button variant="outline" onClick={() => setStatus('idle')} className="rounded-xl">Thử lại</Button>
            </div>
          )}
        </div>

        <DialogFooter className="p-8 pt-0 bg-transparent">
          <Button 
            variant="ghost" 
            onClick={onClose} 
            disabled={loading}
            className="rounded-2xl h-14 font-bold text-lg hover:bg-white/5"
          >
            Hủy bỏ
          </Button>
          <Button 
            onClick={handleSubmit} 
            disabled={loading || files.length === 0}
            className="bg-gradient-to-r from-primary to-secondary text-primary-foreground rounded-2xl h-14 px-10 font-black text-lg hover:scale-105 transition-all shadow-xl shadow-primary/30 border-t border-white/20"
          >
            {loading ? <Loader2 className="w-6 h-6 animate-spin" /> : 'Bắt đầu tạo (AI Generate)'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  )
}
