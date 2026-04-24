import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../../chat/providers/ai_provider.dart';
import '../../swipe/providers/swipe_provider.dart';
import '../../../theme.dart';
import '../../../shared_widgets/profile_card.dart';
import '../../../models/user_model.dart';
import '../../../core/widgets/badge_upgrade_dialog.dart';

class AIOnboardingScreen extends ConsumerStatefulWidget {
  const AIOnboardingScreen({super.key});

  @override
  ConsumerState<AIOnboardingScreen> createState() => _AIOnboardingScreenState();
}

class _AIOnboardingScreenState extends ConsumerState<AIOnboardingScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(aiProvider.notifier).startInterview());
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text;
    _controller.clear();
    _scrollToBottom();
    
    final response = await ref.read(aiProvider.notifier).sendInterviewResponse(text);
    
    if (response != null && response['gamification'] != null) {
      final gamification = response['gamification'];
      if (gamification['newlyEarnedBadges'] != null && (gamification['newlyEarnedBadges'] as List).isNotEmpty) {
        final newBadges = gamification['newlyEarnedBadges'] as List;
        for (var badge in newBadges) {
          if (mounted) {
            BadgeUpgradeDialog.show(context, badge);
          }
        }
      }
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final aiState = ref.watch(aiProvider);
    final recommendations = aiState.recommendations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Dating Assistant'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: Column(
          children: [
            const SizedBox(height: 100), // AppBar space
            Expanded(
              child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: aiState.messages.length,
              itemBuilder: (context, index) {
                final msg = aiState.messages[index];
                final isMe = msg.senderId == 'user';
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: isMe 
                        ? AppColors.chatBubbleMeGradient 
                        : AppColors.chatBubbleAIGradient,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: Radius.circular(isMe ? 20 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      msg.content ?? '',
                      style: TextStyle(color: isMe ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          if (aiState.isLoading) const LinearProgressIndicator(),
          
          // Show recommendations if complete
          if (aiState.isComplete && recommendations.isNotEmpty)
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Dành riêng cho bạn:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: recommendations.length,
                      itemBuilder: (context, index) {
                        final userJson = recommendations[index];
                        final user = User.fromJson(userJson);
                        final String? imageUrl = user.imageUrls.isNotEmpty ? user.imageUrls.first : null;

                        return GestureDetector(
                          onTap: () {
                            context.pushNamed('user_detail', extra: user);
                          },
                          child: Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                  child: imageUrl != null 
                                    ? Image.network(imageUrl, height: 120, width: 150, fit: BoxFit.cover)
                                    : Container(height: 120, color: Colors.grey[300], child: const Icon(Icons.person)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${user.name}, ${user.age}',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        user.job.isNotEmpty ? user.job : 'Cư dân LoveSense',
                                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary, 
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          final users = recommendations.map((u) => User.fromJson(u)).toList();
                          ref.read(swipeProvider.notifier).loadAIRecommendations(users);
                          context.go('/home');
                        },
                        child: const Text('Xem tất cả trên thẻ Swipe! →', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          if (!aiState.isComplete)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Nhập câu trả lời...',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send, color: AppColors.primary),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
}
