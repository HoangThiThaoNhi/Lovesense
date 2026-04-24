import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../theme.dart';
import '../../../shared_widgets/gradient_button.dart';
import '../../../core/utils/toast_utils.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/utils/api_service.dart';
import '../providers/swipe_provider.dart';
import '../../profile/providers/gamification_provider.dart';
import '../../../core/widgets/badge_upgrade_dialog.dart';
import '../../../models/gamification_model.dart';

class SurveyQuestion {
  final int id;
  final String question;
  final List<String> options;
  final String category;
  final String type;

  SurveyQuestion({
    required this.id, 
    required this.question, 
    required this.options, 
    required this.category,
    required this.type,
  });

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) {
    return SurveyQuestion(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options'] ?? []),
      category: json['category'],
      type: json['type'] ?? 'mcq',
    );
  }
}

class SurveyScreen extends ConsumerStatefulWidget {
  const SurveyScreen({super.key});

  @override
  ConsumerState<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends ConsumerState<SurveyScreen> {
  int _currentIndex = 0;
  bool _isLoading = true;
  String? _errorMessage;
  final Map<String, String> _answers = {};
  List<SurveyQuestion> _questions = [];
  final TextEditingController _openAnswerController = TextEditingController();

  @override
  void dispose() {
    _openAnswerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final token = ref.read(authProvider).token;
      if (token == null) throw Exception('Vui lòng đăng nhập lại');

      final List<dynamic> data = await ApiService.get('/ai/questions', token: token);
      setState(() {
        _questions = data.map((q) => SurveyQuestion.fromJson(q)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Không thể tải câu hỏi: $e';
      });
    }
  }

  void _onOptionSelected(String option) {
    setState(() {
      _answers[_questions[_currentIndex].id.toString()] = option;
      _openAnswerController.clear();
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
      } else {
        _submitSurvey();
      }
    });
  }

  Future<void> _submitSurvey() async {
    setState(() => _isLoading = true);
    
    // Format answers for backend - Use question_id as key to ensure all answers are captured
    final formattedAnswers = _questions.map((q) => {
      'question_id': q.id,
      'question_text': q.question,
      'category': q.category,
      'answer': _answers[q.id.toString()] ?? '',
    }).toList();

    // Save results and get AI analysis
    final result = await ref.read(swipeProvider.notifier).saveSurveyResults(formattedAnswers);
    
    // Refresh gamification
    await ref.read(gamificationProvider.notifier).loadStatus();

    setState(() => _isLoading = false);

    if (mounted) {
      // Show newly earned badges first
      final List<BadgeModel> newBadges = result['new_badges'] ?? [];
      for (final badge in newBadges) {
        if (mounted) {
          BadgeUpgradeDialog.show(context, badge);
        }
      }

      _showAIResultDialog(result['ai_analysis'], result['points']);
    }
  }

  void _showAIResultDialog(Map<String, dynamic>? aiAnalysis, int points) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Icon(Icons.auto_awesome, color: AppColors.primary, size: 60)
                        .animate(onPlay: (c) {
                          c.repeat();
                        })
                        .shimmer(duration: 2.seconds),
                    const SizedBox(height: 16),
                    Text(
                      "Kết quả phân tích AI",
                      style: AppTextStyles.headlineSmall.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                      child: Text("+$points điểm kinh nghiệm 📝", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    const SizedBox(height: 32),
                    
                    // AI Analysis Summary
                    if (aiAnalysis?['analysis_summary'] != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          aiAnalysis!['analysis_summary'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ).animate().fadeIn().scale()
                    else
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "AI đang phân tích dữ liệu của bạn...",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                        ),
                      ),

                    // Choice Commentary Card - YOUR PERSONA
                    if (aiAnalysis?['choice_commentary'] != null) ...[
                      _buildResultSection(
                        title: "Về bản thân bạn",
                        icon: Icons.psychology_rounded,
                        color: Colors.orange,
                        content: aiAnalysis!['choice_commentary'],
                      ),
                      const SizedBox(height: 20),
                    ],
                    
                    // AI Description Card - IDEAL PARTNER
                    if (aiAnalysis?['description'] != null) ...[
                      _buildResultSection(
                        title: "Đối tượng lý tưởng",
                        icon: Icons.favorite_rounded,
                        color: Colors.pink,
                        content: aiAnalysis!['description'],
                      ),
                      const SizedBox(height: 24),
                    ],
                    
                    // AI Keywords / Target Tags
                    if (aiAnalysis?['target_tags'] != null || aiAnalysis?['suggested_interests'] != null) ...[
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4, bottom: 12),
                          child: Text(
                            "AI SẼ TÌM KIẾM CÁC ĐẶC ĐIỂM:",
                            style: TextStyle(
                              fontWeight: FontWeight.w900, 
                              fontSize: 11, 
                              color: Colors.grey,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: ((aiAnalysis?['target_tags'] ?? aiAnalysis?['suggested_interests'] ?? []) as List).map((kw) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                          ),
                          child: Text(
                            "#$kw",
                            style: const TextStyle(
                              color: AppColors.primary, 
                              fontSize: 13, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )).toList(),
                      ).animate().fadeIn(delay: 400.ms),
                    ],
                    
                    const SizedBox(height: 48),
                    GradientButton(
                      text: "KHÁM PHÁ NGAY",
                      onPressed: () {
                        // Ensure we use the AI results by enabling interest filter
                        ref.read(swipeProvider.notifier).updateFilters(
                          ref.read(swipeProvider).filter.copyWith(useInterests: true)
                        );
                        
                        context.pop(); // Pop dialog
                        context.pop(); // Pop survey screen
                        
                        // Show success message with points
                        ToastUtils.showModernToast(
                          context, 
                          '🎉 Chúc mừng! Đã cập nhật danh sách gợi ý dựa trên gu của bạn!',
                          type: ToastType.success
                        );
                      },
                      width: double.infinity,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection({
    required String title,
    required IconData icon,
    required Color color,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  color: color,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1, end: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phỏng vấn tìm bạn đời"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: Column(
          children: [
            const SizedBox(height: 100), // AppBar space
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Đang chuẩn bị câu hỏi...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              Text(_errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              GradientButton(text: "Thử lại", onPressed: _loadQuestions),
            ],
          ),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.info_outline, color: Colors.grey, size: 60),
            const SizedBox(height: 16),
            const Text("Hiện chưa có câu hói nào từ hệ thống."),
            const SizedBox(height: 24),
            TextButton(onPressed: () => context.pop(), child: const Text("Quay lại")),
          ],
        ),
      );
    }

    final q = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          color: AppColors.primary,
          minHeight: 6,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Câu hỏi ${_currentIndex + 1}/${_questions.length}",
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  q.question,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headlineSmall.copyWith(fontWeight: FontWeight.bold),
                ).animate().fadeIn().slideY(begin: 0.2, end: 0),
                const SizedBox(height: 48),
                if (q.type.toLowerCase() == 'mcq' && q.options.isNotEmpty)
                  ...q.options.map((opt) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _onOptionSelected(opt),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                        ),
                        child: Text(
                          opt,
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                    ),
                  )).toList()
                else
                  Column(
                    children: [
                      TextField(
                        controller: _openAnswerController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: q.type.toLowerCase() == 'mcq' 
                            ? "Hãy nhập câu trả lời của bạn (do câu hỏi thiếu lựa chọn)..." 
                            : "Nhập câu trả lời của bạn...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: AppColors.primary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      GradientButton(
                        text: "CÂU TIẾP THEO",
                        onPressed: () {
                          if (_openAnswerController.text.trim().isEmpty) {
                            ToastUtils.showModernToast(context, 'Vui lòng nhập câu trả lời', type: ToastType.warning);
                            return;
                          }
                          _onOptionSelected(_openAnswerController.text.trim());
                        },
                        width: double.infinity,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
