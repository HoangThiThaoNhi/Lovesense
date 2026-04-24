import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ai_provider.dart';
import '../../../theme.dart';
import '../../../models/user_model.dart';
import '../../../models/message_model.dart';
import '../../../core/utils/api_service.dart';
import '../../../core/widgets/badge_upgrade_dialog.dart';

class AIConsultantScreen extends ConsumerStatefulWidget {
  const AIConsultantScreen({super.key});

  @override
  ConsumerState<AIConsultantScreen> createState() => _AIConsultantScreenState();
}

class _AIConsultantScreenState extends ConsumerState<AIConsultantScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadHistory();
      ref.read(aiProvider.notifier).fetchSessions('consult');
    });
  }

  Future<void> _loadHistory() async {
    await ref.read(aiProvider.notifier).fetchHistory('consult');
    _scrollToBottom();
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text;
    _controller.clear();
    _scrollToBottom();
    
    final response = await ref.read(aiProvider.notifier).consult(text);
    
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
    // Filter messages for consult context if needed, but for now assuming state is fresh or shared
    final consultMessages = aiState.messages.where((m) => m.matchId == 'ai_consult').toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('AI Tư Vấn Tình Cảm'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'Lịch sử',
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Làm mới đoạn chat',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Làm mới đoạn chat?'),
                  content: const Text('Cuộc trò chuyện hiện tại sẽ được lưu vào lịch sử và bắt đầu một cuộc trò chuyện mới.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ref.read(aiProvider.notifier).createNewSession('consult');
                      }, 
                      child: const Text('Đồng ý')
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(gradient: AppColors.mainGradient),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.history, color: Colors.white, size: 40),
                    const SizedBox(height: 10),
                    const Text('Lịch sử tư vấn', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: aiState.sessions.isEmpty 
                ? const Center(child: Text('Chưa có lịch sử'))
                : ListView.builder(
                    itemCount: aiState.sessions.length,
                    itemBuilder: (context, index) {
                      final session = aiState.sessions[index];
                      final isSelected = session['id'] == aiState.currentSessionId;
                      return ListTile(
                        leading: Icon(Icons.chat_bubble_outline, color: isSelected ? AppColors.primary : null),
                        title: Text(
                          session['title'] ?? 'Cuộc trò chuyện ${session['id']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: isSelected ? FontWeight.bold : null),
                        ),
                        subtitle: Text(
                          session['created_at'] != null 
                            ? session['created_at'].toString().split('T')[0] 
                            : '',
                          style: const TextStyle(fontSize: 10),
                        ),
                        selected: isSelected,
                        onTap: () {
                          ref.read(aiProvider.notifier).fetchHistory('consult', sessionId: session['id']);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
            ),
          ],
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome, size: 18, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'AI giúp bạn tư vấn cách bắt chuyện, hiểu đối phương và tìm người phù hợp nhất.',
                      style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
              itemCount: consultMessages.length,
              itemBuilder: (context, index) {
                final msg = consultMessages[index];
                final isMe = msg.senderId == 'user';
                final hasRecs = !isMe && msg.recommendations != null && msg.recommendations!.isNotEmpty;

                return Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
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
                              color: isMe 
                                ? const Color(0xFF2196F3).withOpacity(0.2)
                                : Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: isMe 
                            ? Border.all(color: Colors.white.withOpacity(0.1))
                            : Border.all(color: Colors.white.withOpacity(0.8)),
                        ),
                        child: Text(
                          msg.content ?? '',
                          style: TextStyle(color: isMe ? Colors.white : Colors.black87),
                        ),
                      ),
                    ),
                    if (hasRecs)
                      Container(
                        height: 200,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: msg.recommendations!.length,
                          itemBuilder: (context, rIndex) {
                            final userData = msg.recommendations![rIndex];
                            final List<dynamic> photos = userData['photos'] ?? [];
                            final String? imageUrl = photos.isNotEmpty ? photos[0]['image_url'] : null;

                            return GestureDetector(
                              onTap: () {
                                // Merge nested profile data into root for User.fromJson
                                final Map<String, dynamic> userMap = {
                                  ...userData,
                                  ...(userData['profile'] as Map<String, dynamic>? ?? {}),
                                };
                                final user = User.fromJson(userMap);
                                context.pushNamed(
                                  'user_detail',
                                  extra: user,
                                );
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
                                        ? Image.network(ApiService.formatImageUrl(imageUrl), height: 120, width: 150, fit: BoxFit.cover)
                                        : Container(height: 120, color: Colors.grey[300], child: const Icon(Icons.person)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${userData['profile']?['display_name'] ?? 'Ẩn danh'}, ${userData['profile']?['age'] ?? ''}',
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            userData['profile']?['occupation'] ?? 'Người dùng LoveSense',
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
                  ],
                );
              },
            ),
          ),
          if (aiState.isLoading) const LinearProgressIndicator(),
          
          // Suggested Questions
          if (!aiState.isLoading && consultMessages.isEmpty)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                   _SuggestionChip(
                    label: 'Làm sao để bắt đầu câu chuyện?',
                    onTap: () {
                      _controller.text = 'Làm sao để bắt đầu câu chuyện với một người mới quen?';
                      _sendMessage();
                    }
                  ),
                  _SuggestionChip(
                    label: 'Tìm người ở gần',
                    onTap: () {
                      _controller.text = 'Tìm cho tôi 1 người ở gần đi';
                      _sendMessage();
                    }
                  ),
                  _SuggestionChip(
                    label: 'Gợi ý đối tượng phù hợp',
                    onTap: () {
                      _controller.text = 'Hãy gợi ý cho tôi những người phù hợp với sở thích của tôi.';
                      _sendMessage();
                    }
                  ),
                  _SuggestionChip(
                    label: 'Tư vấn cách nhắn tin',
                    onTap: () {
                      _controller.text = 'Bạn có thể tư vấn cho tôi cách nhắn tin để gây ấn tượng không?';
                      _sendMessage();
                    }
                  ),
                ],
              ),
            ),

          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 4),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Hỏi AI bất cứ điều gì...',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.white, size: 18),
                    ),
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

class _SuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SuggestionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label, style: const TextStyle(fontSize: 12)),
        onPressed: onTap,
        backgroundColor: Colors.white,
        side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
      ),
    );
  }
}
