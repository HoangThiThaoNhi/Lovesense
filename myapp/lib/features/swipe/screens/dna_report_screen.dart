import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/api_service.dart';
import '../../../core/utils/toast_utils.dart';
import '../../../theme.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/swipe_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DNAReportScreen extends ConsumerStatefulWidget {
  const DNAReportScreen({super.key});

  @override
  ConsumerState<DNAReportScreen> createState() => _DNAReportScreenState();
}

class _DNAReportScreenState extends ConsumerState<DNAReportScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _report;

  @override
  void initState() {
    super.initState();
    _fetchReport();
  }

  Future<void> _fetchReport() async {
    try {
      final token = ref.read(authProvider).token;
      final response = await ApiService.get('/quiz/report', token: token);
      if (mounted) {
        setState(() {
          _report = response as Map<String, dynamic>;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showModernToast(context, 'Chưa có dữ liệu DNA. Hãy làm bài test trước nhé!', type: ToastType.info);
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 20),
              Text('Đang tải bản đồ DNA...', style: TextStyle(color: Colors.white.withOpacity(0.7))),
            ],
          ),
        ),
      );
    }

    final highlights = _report?['highlights'] as List? ?? [];
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'KẾT QUẢ AI DNA',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F172A), // Deep Night
              Color(0xFF1E1B4B), // Indigo Dark
              Color(0xFF312E81), // Indigo Mid
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Header Sparkle
                      const Icon(Icons.auto_awesome, color: Colors.amberAccent, size: 50)
                          .animate(onPlay: (c) => c.repeat())
                          .shimmer(duration: 2.seconds),
                      const SizedBox(height: 16),
                      
                      const Text(
                        'AI DNA ANALYSIS',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Glass Main Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _report?['summary'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                height: 1.7,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ).animate().slideY(begin: 0.1, duration: 600.ms).fadeIn(),
                      
                      const SizedBox(height: 24),
                      
                      // Highlight Chips
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: highlights.map((h) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigoAccent.withOpacity(0.6),
                                Colors.purpleAccent.withOpacity(0.6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.indigoAccent.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            h.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )).toList(),
                      ).animate(delay: 400.ms).fadeIn().moveY(begin: 20, end: 0),
                      
                      const SizedBox(height: 32),
                      
                      // Ideal Vibe Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.favorite, color: Colors.pinkAccent, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'Vibe người ấy lý tưởng:',
                                  style: TextStyle(
                                    color: Colors.pinkAccent.shade100,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _report?['ideal_vibe'] ?? '',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                height: 1.6,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ).animate(delay: 600.ms).fadeIn(),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              
              // Action Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      // 1. Auto-enable DNA Mode
                      final currentFilter = ref.read(swipeProvider).filter;
                      ref.read(swipeProvider.notifier).updateFilters(
                        currentFilter.copyWith(ignoreDNA: false),
                      );

                      // 2. Perform a refresh
                      await ref.read(swipeProvider.notifier).fetchDiscovery(silent: false);
                      
                      if (context.mounted) {
                        context.pop();
                        ToastUtils.showModernToast(context, '✨ DNA Soulmate đã được áp dụng!', type: ToastType.success);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1E1B4B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'TIẾP TỤC KHÁM PHÁ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ).animate(delay: 800.ms).fadeIn().slideY(begin: 0.5, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
