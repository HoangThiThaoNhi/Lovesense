import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lovesense/features/auth/providers/auth_provider.dart';
import '../../match/providers/match_provider.dart';
import '../../../models/user_model.dart';
import '../../../models/message_model.dart';
import '../../../theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AwaitingConnectionsScreen extends ConsumerWidget {
  const AwaitingConnectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchState = ref.watch(matchProvider);
    final authState = ref.watch(authProvider);
    final currentUserId = authState.currentUser?.id.toString();
    final allMatches = matchState.matches;

    // Filter "Đang chờ đối phương phản hồi"
    final awaitingGroup = allMatches
        .where((m) =>
            (m.status == 'pending' && m.lastMessage == null) ||
            (m.myMessageCount > 0 && m.otherMessageCount == 0))
        .toList();
    awaitingGroup.sort((a, b) {
      final aTime = a.lastMessage?.timestamp ?? a.matchedAt;
      final bTime = b.lastMessage?.timestamp ?? b.matchedAt;
      return bTime.compareTo(aTime);
    });

    // Sub-split for display
    final iInitiated = awaitingGroup.where((m) =>
        (m.user1Id == currentUserId && m.lastMessage == null) ||
        (m.myMessageCount > 0 && m.otherMessageCount == 0)
    ).toList();
    final theyInitiated = awaitingGroup.where((m) =>
        m.user2Id == currentUserId && m.lastMessage == null
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đang chờ đối phương phản hồi'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: SafeArea(
          child: matchState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : awaitingGroup.isEmpty
                  ? _buildEmptyState()
                  : ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      children: [
                        if (theyInitiated.isNotEmpty) ...[
                          _buildSectionHeader(
                            context,
                            title: 'Đang chờ mình (${theyInitiated.length})',
                            icon: Icons.waving_hand_rounded,
                            accentColor: const Color(0xFF1E88E5), // Deep primary blue
                          ),
                          const SizedBox(height: 10),
                          ...theyInitiated.map((match) => _buildAwaitingItem(
                                context,
                                ref,
                                match,
                                currentUserId,
                                accentColor: const Color(0xFF1E88E5),
                                subtitle: 'Đang chờ bạn chào hỏi 👋',
                                actionText: 'Trò chuyện ngay',
                                icon: Icons.chat_bubble_outline_rounded,
                              )),
                          const SizedBox(height: 24),
                        ],
                        if (iInitiated.isNotEmpty) ...[
                          _buildSectionHeader(
                            context,
                            title: 'Mình đang chờ họ (${iInitiated.length})',
                            icon: Icons.schedule_send_rounded,
                            accentColor: const Color(0xFF00ACC1), // Cyan/Teal blue
                          ),
                          const SizedBox(height: 10),
                          ...iInitiated.map((match) => _buildAwaitingItem(
                                context,
                                ref,
                                match,
                                currentUserId,
                                accentColor: const Color(0xFF00ACC1),
                                subtitle: match.lastMessage != null
                                    ? (match.lastMessage!.type == MessageType.image ? 'Bạn: 📷 Ảnh' : 'Bạn: ${match.lastMessage!.content}')
                                    : 'Bạn đã thích đối phương, chờ bắt đầu chat!',
                                actionText: match.lastMessage != null ? 'Nhắn thêm' : 'Gửi tin nhắn',
                                icon: Icons.send_rounded,
                              )),
                        ],
                      ],
                    ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color accentColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accentColor.withOpacity(0.3), width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: accentColor, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fade(duration: 200.ms).slideX(begin: -0.05, end: 0);
  }

  Widget _buildAwaitingItem(
    BuildContext context,
    WidgetRef ref,
    ChatMatch match,
    String? currentUserId, {
    required Color accentColor,
    required String subtitle,
    required String actionText,
    required IconData icon,
  }) {
    final user = User(
      id: match.userId,
      name: match.name,
      age: 20,
      bio: '',
      job: '',
      imageUrls: match.imageUrl != null
          ? [match.imageUrl!]
          : ['https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500&auto=format&fit=crop&q=60'],
      photos: [],
      interests: [],
      distanceKm: 0,
    );

    // Format match time
    final targetTime = match.matchedAt;
    final diff = DateTime.now().difference(targetTime);
    String timeStr;
    if (diff.inSeconds < 60) {
      timeStr = 'vừa xong';
    } else if (diff.inMinutes < 60) {
      timeStr = '${diff.inMinutes} phút trước';
    } else if (diff.inHours < 24) {
      timeStr = '${diff.inHours} giờ trước';
    } else {
      timeStr = '${diff.inDays} ngày trước';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          context.push('/chat/${match.id}', extra: user).then((_) {
            ref.read(matchProvider.notifier).fetchMatches();
          });
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: accentColor.withOpacity(0.25), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(user.imageUrls.first),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            user.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.5,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          timeStr,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          actionText,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 12,
                          color: accentColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: accentColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(duration: 250.ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.people_outline_rounded,
              color: AppColors.primary,
              size: 64,
            ),
          ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
          const SizedBox(height: 20),
          const Text(
            'Không có cuộc trò chuyện chờ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Không có cuộc trò chuyện nào đang chờ đối phương phản hồi.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
