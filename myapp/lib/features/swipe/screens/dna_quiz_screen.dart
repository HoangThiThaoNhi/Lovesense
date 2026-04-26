import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/api_service.dart';
import '../../../core/utils/toast_utils.dart';
import '../../../theme.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/swipe_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/widgets/badge_upgrade_dialog.dart';

class DNAQuizScreen extends ConsumerStatefulWidget {
  const DNAQuizScreen({super.key});

  @override
  ConsumerState<DNAQuizScreen> createState() => _DNAQuizScreenState();
}

class _DNAQuizScreenState extends ConsumerState<DNAQuizScreen> {
  List<dynamic> _questions = [];
  int _currentIndex = 0;
  bool _isLoading = true;
  bool _isAnalyzing = false;
  Map<String, dynamic>? _report;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      final token = ref.read(authProvider).token;
      final response = await ApiService.get('/quiz', token: token);
      if (mounted) {
        setState(() {
          _questions = response as List;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showModernToast(context, 'Lỗi tải câu hỏi: $e', type: ToastType.error);
        context.pop();
      }
    }
  }

  Future<void> _submitAnswer(String optionId) async {
    try {
      final token = ref.read(authProvider).token;
      final response = await ApiService.post('/quiz/submit', {'optionId': optionId}, token: token);
      
      ToastUtils.showModernToast(context, '✨ +5 XP DNA', type: ToastType.success);

      // Kiểm tra xem có huy hiệu mới không
      if (response != null && response['gamification'] != null) {
        final gamification = response['gamification'];
        if (gamification['newlyEarnedBadges'] != null && (gamification['newlyEarnedBadges'] as List).isNotEmpty) {
          final newBadges = gamification['newlyEarnedBadges'] as List;
          for (var badge in newBadges) {
            if (mounted) {
              BadgeUpgradeDialog.show(context, badge as Map<String, dynamic>);
            }
          }
        }
      }

      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
        });
      } else {
        _generateReport();
      }
    } catch (e) {
      ToastUtils.showModernToast(context, 'Lỗi gửi đáp án: $e', type: ToastType.error);
    }
  }

  Future<void> _generateReport() async {
    setState(() {
      _isAnalyzing = true;
    });

    try {
      final token = ref.read(authProvider).token;
      final response = await ApiService.get('/quiz/report', token: token);
      if (mounted) {
        setState(() {
          _report = response as Map<String, dynamic>;
          _isAnalyzing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        if (e.toString().contains('không còn tương thích')) {
          setState(() {
            _currentIndex = 0;
            _report = null;
            _isAnalyzing = false;
          });
          ToastUtils.showModernToast(context, 'Hệ thống đã dọn dẹp dữ liệu cũ. Mời bạn làm lại bài Quiz mới nhé!', type: ToastType.info);
        } else {
          ToastUtils.showModernToast(context, 'Lỗi phân tích DNA: $e', type: ToastType.error);
          setState(() => _isAnalyzing = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_isAnalyzing) {
      return _buildAnalyzingScreen();
    }

    if (_report != null) {
      return _buildReportScreen();
    }

    final question = _questions[_currentIndex];
    final options = question['options'] as List;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6366F1), // Indigo 500
              Color(0xFFA855F7), // Purple 500
              Color(0xFFEC4899), // Pink 500
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Bar
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: (_currentIndex + 1) / _questions.length,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DNA Analysis',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '${_currentIndex + 1} / ${_questions.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn().slideY(begin: -0.2),

                const Spacer(),
                
                // Question Card (Glassmorphism)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // AI Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.auto_awesome, color: Colors.white, size: 14),
                            SizedBox(width: 6),
                            Text(
                              'AI DNA INSIGHT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        question['content'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 36),
                      ...options.map((opt) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _buildOptionButton(opt),
                      )),
                    ],
                  ),
                ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack).fadeIn(),
                
                const Spacer(flex: 2),
                
                // Hint
                Center(
                  child: Text(
                    'Hãy trả lời thành thật để AI tìm được người phù hợp nhất với bạn ✨',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ).animate(delay: 1.seconds).fadeIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(dynamic opt) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _submitAnswer(opt['id']),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF6366F1),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: Text(
          opt['label'],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.2,
          ),
        ),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
     .shimmer(delay: 2.seconds, duration: 2.seconds, color: Colors.white.withOpacity(0.2));
  }

  Widget _buildAnalyzingScreen() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/bot_3d.png', width: 150)
                .animate(onPlay: (c) {
                  c.repeat(reverse: true);
                })
                .moveY(begin: -10, end: 10, duration: 1.seconds),
            const SizedBox(height: 32),
            const Text(
              'Lovesense AI đang giải mã DNA Soulmate của bạn...',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ).animate().fadeIn(delay: 500.ms),
            const SizedBox(height: 16),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildReportScreen() {
    final highlights = _report?['highlights'] as List? ?? [];
    
    return Scaffold(
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
              const SizedBox(height: 20),
              const Text(
                'BẢN ĐỒ AI DNA SOULMATE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
              ).animate().fadeIn().scale(),
              
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
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
                            const Icon(Icons.auto_awesome, color: Colors.amberAccent, size: 48),
                            const SizedBox(height: 20),
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
                      
                      const SizedBox(height: 24),
                      
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
                      // 1. Auto-enable DNA Mode (set ignoreDNA to false)
                      final currentFilter = ref.read(swipeProvider).filter;
                      ref.read(swipeProvider.notifier).updateFilters(
                        currentFilter.copyWith(ignoreDNA: false),
                      );

                      // 2. Perform a hard refresh to show new DNA-based results
                      await ref.read(swipeProvider.notifier).fetchDiscovery(silent: false);
                      
                      if (context.mounted) {
                        context.pop();
                        ToastUtils.showModernToast(context, '✨ Soulmate đang chờ bạn ở trang chủ!', type: ToastType.success);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1E1B4B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'KHÁM PHÁ SOULMATE NGAY',
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
