import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/user_model.dart';
import '../../../models/message_model.dart'; // Import ChatMatch
import '../../match/providers/match_provider.dart';
import '../../chat/providers/chat_provider.dart'; // Just to make sure it's available
import '../../../theme.dart';
import '../../../shared_widgets/glass_container.dart';
import 'package:lovesense/features/auth/providers/auth_provider.dart';
import '../../../core/utils/toast_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    // Refresh matches every time this screen is opened
    Future.microtask(() => ref.read(matchProvider.notifier).fetchMatches());
  }

  @override
  Widget build(BuildContext context) {
    final matchState = ref.watch(matchProvider);
    final authState = ref.watch(authProvider);
    final currentUserId = authState.currentUser?.id.toString();
    final allMatches = matchState.matches;
    
    // ── GROUP 1: "Đang chờ đối phương phản hồi" ──────────────────────────────
    // Gồm các lượt ghép đôi chưa có tin nhắn hoặc chỉ có tin nhắn từ phía tôi:
    // - lastMessage == null (chưa có tin nhắn nào)
    // - myMessageCount > 0 và otherMessageCount == 0 (tôi đã nhắn, họ chưa trả lời)
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

    // ── GROUP 2: "Tin nhắn chờ" ──────────────────────────────────────────────
    // Chỉ gồm các tin nhắn một chiều do đối phương gửi, đang chờ tôi phản hồi lại
    final pendingChats = allMatches
        .where((m) =>
            m.lastMessage != null &&
            m.myMessageCount == 0 &&
            m.otherMessageCount > 0)
        .toList();
    pendingChats.sort((a, b) {
      final aTime = a.lastMessage?.timestamp ?? a.matchedAt;
      final bTime = b.lastMessage?.timestamp ?? b.matchedAt;
      return bTime.compareTo(aTime);
    });

    // ── GROUP 3: "Tin nhắn" (Active) ─────────────────────────────────────────
    // Chỉ hiện chat đã có hội thoại 2 chiều (cả 2 đều đã nhắn)
    final activeChats = allMatches
        .where((m) => m.myMessageCount > 0 && m.otherMessageCount > 0)
        .toList();
    activeChats.sort((a, b) {
      final aTime = a.lastMessage?.timestamp ?? a.matchedAt;
      final bTime = b.lastMessage?.timestamp ?? b.matchedAt;
      return bTime.compareTo(aTime);
    });

    final hasActiveOrPendingChats = pendingChats.isNotEmpty || activeChats.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghép đôi & Tin nhắn'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: matchState.isLoading 
            ? const Center(child: CircularProgressIndicator())
            : matchState.error != null
                ? Center(child: Text(matchState.error!))
                : CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(child: SizedBox(height: 100)), // Space for AppBar
                      // AI Assistant Entry
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: GestureDetector(
                          onTap: () => context.pushNamed('ai_consultant'),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 10, spreadRadius: 2),
                                    ],
                                  ),
                                  child: Image.asset('assets/images/bot_3d.png'),
                                ).animate(onPlay: (c) {
                                  c.repeat(reverse: true);
                                })
                                 .moveY(begin: -5, end: 5, duration: 2.seconds, curve: Curves.easeInOutSine)
                                 .rotate(begin: -0.03, end: 0.03, duration: 2.5.seconds, curve: Curves.easeInOutSine),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Trợ lý hẹn hò AI',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      Text(
                                        'Tư vấn tình cảm & Gợi ý đối tượng phù hợp',
                                        style: TextStyle(color: Colors.white70, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ─── GROUP 1: Đang chờ kết nối (collapsed card) ─────────────
                    if (awaitingGroup.isNotEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      sliver: SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GestureDetector(
                            onTap: () {
                              context.pushNamed('awaiting_connections').then((_) {
                                ref.read(matchProvider.notifier).fetchMatches();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.92),
                                    AppColors.primary.withOpacity(0.18),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 1.5),
                                boxShadow: [
                                  BoxShadow(color: AppColors.primary.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4)),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Stacked avatars preview
                                  SizedBox(
                                    width: awaitingGroup.length >= 3 ? 72 : (awaitingGroup.length * 28.0 + 12),
                                    height: 56,
                                    child: Stack(
                                      children: [
                                        for (int i = 0; i < awaitingGroup.length.clamp(0, 3); i++)
                                          Positioned(
                                            left: i * 22.0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Colors.white, width: 2.5),
                                              ),
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundImage: awaitingGroup[i].imageUrl != null
                                                    ? NetworkImage(awaitingGroup[i].imageUrl!)
                                                    : null,
                                                backgroundColor: AppColors.primary.withOpacity(0.25),
                                                child: awaitingGroup[i].imageUrl == null
                                                    ? const Icon(Icons.person, color: Colors.white, size: 20)
                                                    : null,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Đang chờ đối phương phản hồi',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF1E88E5),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF1E88E5),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                '${awaitingGroup.length}',
                                                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(fontSize: 12.5),
                                            children: [
                                              if (iInitiated.isNotEmpty)
                                                TextSpan(
                                                  text: '${iInitiated.length} bạn đang chờ • ',
                                                  style: const TextStyle(color: Color(0xFF00ACC1), fontWeight: FontWeight.w500),
                                                ),
                                              if (theyInitiated.isNotEmpty)
                                                TextSpan(
                                                  text: '${theyInitiated.length} người chờ bạn',
                                                  style: const TextStyle(color: Color(0xFF1E88E5), fontWeight: FontWeight.w500),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right_rounded, color: Color(0xFF1E88E5), size: 22),
                                ],
                              ),
                            ),
                          ).animate().fade(duration: 300.ms).slideY(begin: 0.08, end: 0),
                        ),
                      ),
                    ),

                    // ═══════════════════════════════════════════════════════════
                    // SECTION: "Tin nhắn" header
                    // ═══════════════════════════════════════════════════════════
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Text(
                              'Tin nhắn', 
                              style: AppTextStyles.titleLarge.copyWith(fontSize: 20, color: AppColors.primary)
                            ),
                            if (pendingChats.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${pendingChats.length}',
                                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    // ─── Empty state ────────────────────────────────────────────
                    if (!hasActiveOrPendingChats)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            const Icon(Icons.chat_bubble_outline, color: Colors.white54, size: 56),
                            const SizedBox(height: 12),
                            const Text(
                              "Chưa có cuộc trò chuyện nào",
                              style: TextStyle(color: Colors.white70, fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Hãy swipe để tìm đối tượng phù hợp!",
                              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ─── GROUP 2: Tin nhắn chờ phản hồi (collapsed card) ────────
                    if (pendingChats.isNotEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildPendingChatsItem(pendingChats, currentUserId),
                        ),
                      ),
                    ),

                    // ─── GROUP 3: Tin nhắn đang hoạt động (active 2-way chats) ──
                    if (activeChats.isNotEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final match = activeChats[index];
                            final user = User(
                              id: match.userId,
                              name: match.name,
                              age: 20,
                              bio: '',
                              job: '',
                              imageUrls: match.imageUrl != null ? [match.imageUrl!] : ['https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500&auto=format&fit=crop&q=60'],
                              photos: [],
                              interests: [],
                              distanceKm: 0,
                            );
                            final timeStr = _getTimeStr(match.lastMessage?.timestamp ?? match.matchedAt);
                            final bool hasUnread = match.lastMessage != null &&
                                match.lastMessage!.isRead == false &&
                                match.lastMessage!.senderId != authState.currentUser?.id;

                            return Dismissible(
                              key: Key(match.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(Icons.delete, color: Colors.white),
                              ),
                              onDismissed: (_) {
                                ref.read(matchProvider.notifier).deleteMatch(match.id);
                                ToastUtils.showModernToast(context, 'Đã xóa cuộc trò chuyện với ${user.name}', type: ToastType.info);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    context.push('/chat/${match.id}', extra: user).then((_) {
                                      ref.read(matchProvider.notifier).fetchMatches();
                                    });
                                  },
                                  onLongPress: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Hủy ghép đôi?'),
                                        content: Text('Bạn có chắc chắn muốn hủy ghép đôi với ${user.name}?'),
                                        actions: [
                                          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hủy')),
                                          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hủy ghép đôi', style: TextStyle(color: Colors.red))),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      await ref.read(matchProvider.notifier).deleteMatch(match.id);
                                      if (mounted) ToastUtils.showModernToast(context, 'Đã hủy ghép đôi với ${user.name}');
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.white.withOpacity(0.92), Colors.white.withOpacity(0.45)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: [
                                        BoxShadow(
                                          color: hasUnread ? AppColors.primary.withOpacity(0.12) : Colors.black.withOpacity(0.04),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: hasUnread ? AppColors.primary.withOpacity(0.3) : Colors.white.withOpacity(0.5),
                                        width: hasUnread ? 1.5 : 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => context.pushNamed('user_detail', extra: user),
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 28,
                                                backgroundImage: NetworkImage(user.imageUrls.first),
                                              ),
                                              if (hasUnread)
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.primary,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: Colors.white, width: 2),
                                                    ),
                                                  ),
                                                ),
                                            ],
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
                                                  Text(
                                                    user.name,
                                                    style: AppTextStyles.titleLarge.copyWith(
                                                      fontSize: 15.5,
                                                      fontWeight: hasUnread ? FontWeight.bold : FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    timeStr,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: hasUnread ? AppColors.primary : Colors.grey[500],
                                                      fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                match.lastMessage?.type == MessageType.image
                                                    ? '📷 Ảnh'
                                                    : (match.lastMessage?.content ?? ''),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 13.5,
                                                  color: hasUnread ? Colors.black87 : Colors.grey[500],
                                                  fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: activeChats.length,
                        ),
                      ),
                    ),

                    // ─── Bottom Padding ──────────────────────────────────────────
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  ],
                ),
      ),
    );
  }

  String _getTimeStr(DateTime targetTime) {
    final diff = DateTime.now().difference(targetTime);
    if (diff.inSeconds < 60) {
      return 'vừa xong';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}p';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d';
    } else {
      return '${targetTime.day}/${targetTime.month}';
    }
  }

  Widget _buildPendingChatsItem(List<ChatMatch> pendingChats, String? currentUserId) {
    final count = pendingChats.length;
    final lastChat = pendingChats.first;
    final timeStr = _getTimeStr(lastChat.lastMessage?.timestamp ?? lastChat.matchedAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => _showPendingChatsBottomSheet(context, pendingChats, currentUserId),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.92),
                AppColors.primary.withOpacity(0.12),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00ACC1), Color(0xFF1E88E5)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1E88E5).withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.mark_chat_unread_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tin nhắn chờ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E88E5),
                          ),
                        ),
                        Text(
                          timeStr,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Bạn có $count cuộc trò chuyện đang chờ phản hồi',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Color(0xFF1E88E5), size: 16),
            ],
          ),
        ),
      ),
    ).animate().fade(duration: 300.ms).slideY(begin: 0.1, end: 0);
  }

  void _showPendingChatsBottomSheet(
    BuildContext context,
    List<ChatMatch> pendingChats,
    String? currentUserId,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.mark_chat_unread_rounded, color: Color(0xFF1E88E5)),
                        const SizedBox(width: 8),
                        Text(
                          'Tin nhắn chờ (${pendingChats.length})',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Text(
                  'Mở tin nhắn để xem người gửi. Họ sẽ không biết bạn đã đọc cho đến khi bạn đồng ý hoặc trả lời.',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: pendingChats.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final match = pendingChats[index];
                    final user = User(
                      id: match.userId,
                      name: match.name,
                      age: 20,
                      bio: '',
                      job: '',
                      imageUrls: match.imageUrl != null ? [match.imageUrl!] : ['https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500&auto=format&fit=crop&q=60'],
                      photos: [],
                      interests: [],
                      distanceKm: 0,
                    );

                    final targetTime = match.lastMessage?.timestamp ?? match.matchedAt;
                    final timeStr = _getTimeStr(targetTime);
                    
                    final bool isSentByMe = match.lastMessage?.senderId == currentUserId;
                    final String prefix = isSentByMe ? 'Bạn: ' : '';

                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        context.push('/chat/${match.id}', extra: user).then((_) {
                          ref.read(matchProvider.notifier).fetchMatches();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primary.withOpacity(0.35)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundImage: NetworkImage(user.imageUrls.first),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        user.name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
                                    match.lastMessage?.type == MessageType.image
                                        ? '📷 Ảnh'
                                        : '$prefix${match.lastMessage?.content ?? ""}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isSentByMe ? Colors.grey[600] : Colors.black87,
                                      fontWeight: isSentByMe ? FontWeight.normal : FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    isSentByMe 
                                      ? 'Chờ phản hồi từ đối phương'
                                      : 'Yêu cầu nhắn tin',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isSentByMe ? const Color(0xFF00ACC1) : const Color(0xFF1E88E5),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              isSentByMe ? Icons.hourglass_empty : Icons.mark_chat_unread_rounded,
                              size: 18,
                              color: isSentByMe ? const Color(0xFF00ACC1) : const Color(0xFF1E88E5),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  void _showQuickMatchDialog(BuildContext context, WidgetRef ref, dynamic like) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 320,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Photo Header
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                child: CachedNetworkImage(
                  imageUrl: like['main_photo'] ?? 'https://ui-avatars.com/api/?name=User',
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '${like['display_name']}, ${like['age']}',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      like['bio'] ?? 'Đã thích bạn! Hãy kết nối ngay.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // NOPE
                        IconButton(
                          onPressed: () {
                            ref.read(matchProvider.notifier).quickNope(like['user_id'].toString());
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close, color: Colors.red, size: 40),
                        ),
                        // LIKE (ACCEPT)
                        IconButton(
                          onPressed: () {
                            ref.read(matchProvider.notifier).quickLike(like['user_id'].toString());
                            Navigator.pop(context);
                            ToastUtils.showModernToast(context, '✨ Tuyệt vời! Bạn và ${like['display_name']} đã ghép đôi.', type: ToastType.success);
                          },
                          icon: const Icon(Icons.favorite, color: Colors.green, size: 40),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
