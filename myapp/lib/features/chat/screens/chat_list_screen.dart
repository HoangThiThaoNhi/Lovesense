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
    
    final pendingRequests = allMatches.where((m) => m.status == 'pending' && m.user2Id == currentUserId).toList();
    pendingRequests.sort((a, b) => b.matchedAt.compareTo(a.matchedAt));
    
    final matches = allMatches.where((m) => m.status == 'accepted' || (m.status == 'pending' && m.user1Id == currentUserId)).toList();
    // Sort by last message timestamp, fallback to matchedAt
    matches.sort((a, b) {
      final aTime = a.lastMessage?.timestamp ?? a.matchedAt;
      final bTime = b.lastMessage?.timestamp ?? b.matchedAt;
      return bTime.compareTo(aTime);
    });

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

                    // New Matches (Horizontal)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lượt ghép đôi mới', 
                              style: AppTextStyles.titleLarge.copyWith(fontSize: 18, color: AppColors.primary)
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 100,
                              child: matches.isEmpty 
                                ? const Center(child: Text("Chưa có lượt ghép đôi nào"))
                                : ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: matches.length,
                                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                                    itemBuilder: (context, index) {
                                      final match = matches[index];
                                      // Create a temporary User object for navigation
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
                                      
                                      return GestureDetector(
                                        onTap: () {
                                          context.push('/chat/${match.id}', extra: user);
                                        },
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                context.pushNamed('user_detail', extra: user);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient: AppColors.primaryGradient,
                                                ),
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(user.imageUrls.first),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              user.name,
                                              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Pending Likes (Who Liked You) - Horizontal Carousel
                    if (matchState.pendingLikes.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Đang chờ bạn chấp nhận', 
                                  style: AppTextStyles.titleLarge.copyWith(fontSize: 16, color: Colors.orangeAccent)
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${matchState.pendingLikes.length}',
                                    style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 110,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: matchState.pendingLikes.length,
                                separatorBuilder: (_, __) => const SizedBox(width: 16),
                                itemBuilder: (context, index) {
                                  final like = matchState.pendingLikes[index];
                                  final String imageUrl = like['main_photo'] ?? 'https://ui-avatars.com/api/?name=User';
                                  final String name = like['display_name'] ?? 'User';
                                  final String userId = like['user_id'].toString();

                                  return GestureDetector(
                                    onTap: () {
                                      _showQuickMatchDialog(context, ref, like);
                                    },
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(2.5),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(colors: [Colors.orange, Colors.redAccent]),
                                              ),
                                              child: CircleAvatar(
                                                radius: 32,
                                                backgroundImage: CachedNetworkImageProvider(imageUrl),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                                                ),
                                                child: const Icon(Icons.favorite, color: Colors.red, size: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        SizedBox(
                                          width: 70,
                                          child: Text(
                                            name,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Divider(height: 32, thickness: 0.5),
                          ],
                        ),
                      ),
                    ),

                    SliverPadding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          'Tin nhắn', 
                          style: AppTextStyles.titleLarge.copyWith(fontSize: 18, color: AppColors.primary)
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                             final match = matches[index];
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
                             final diff = DateTime.now().difference(targetTime);
                             String timeStr;
                             if (diff.inSeconds < 60) {
                               timeStr = 'vừa xong';
                             } else if (diff.inMinutes < 60) {
                               timeStr = '${diff.inMinutes}p';
                             } else if (diff.inHours < 24) {
                               timeStr = '${diff.inHours}h';
                             } else if (diff.inDays < 7) {
                               timeStr = '${diff.inDays}d';
                             } else {
                               timeStr = '${targetTime.day}/${targetTime.month}';
                             }

                             return Dismissible(
                               key: Key(match.id),
                               direction: DismissDirection.endToStart,
                               background: Container(
                                 alignment: Alignment.centerRight,
                                 padding: const EdgeInsets.symmetric(horizontal: 20),
                                 margin: const EdgeInsets.only(bottom: 16),
                                 decoration: BoxDecoration(
                                   color: Colors.red,
                                   borderRadius: BorderRadius.circular(20),
                                 ),
                                 child: const Icon(Icons.delete, color: Colors.white),
                               ),
                               onDismissed: (direction) {
                                 ref.read(matchProvider.notifier).deleteMatch(match.id);
                                 ToastUtils.showModernToast(context, 'Đã xóa cuộc trò chuyện với ${user.name}', type: ToastType.info);
                               },
                               child: Padding(
                                 padding: const EdgeInsets.only(bottom: 16),
                                 child: GestureDetector(
                                   onTap: () {
                                     context.push('/chat/${match.id}', extra: user).then((_) {
                                       // Refresh when coming back
                                       ref.read(matchProvider.notifier).fetchMatches();
                                     });
                                   },
                                   onLongPress: () async {
                                     final confirm = await showDialog<bool>(
                                       context: context,
                                       builder: (context) => AlertDialog(
                                         title: const Text('Hủy ghép đôi?'),
                                         content: Text('Bạn có chắc chắn muốn hủy ghép đôi với ${user.name}? Tất cả tin nhắn và sự tương hợp sẽ bị xóa hoàn toàn.'),
                                         actions: [
                                           TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hủy')),
                                           TextButton(
                                             onPressed: () => Navigator.pop(context, true), 
                                             child: const Text('Hủy ghép đôi', style: TextStyle(color: Colors.red))
                                           ),
                                         ],
                                       ),
                                     );
                                     if (confirm == true) {
                                       await ref.read(matchProvider.notifier).deleteMatch(match.id);
                                       if (mounted) {
                                         ToastUtils.showModernToast(context, 'Đã hủy ghép đôi với ${user.name}');
                                       }
                                     }
                                   },
                                   child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.white.withOpacity(0.9), Colors.white.withOpacity(0.4)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                                        ],
                                        border: Border.all(color: Colors.white.withOpacity(0.5)),
                                      ),
                                      child: Row(
                                         children: [
                                           GestureDetector(
                                             onTap: () {
                                               context.pushNamed('user_detail', extra: user);
                                             },
                                             child: CircleAvatar(
                                               radius: 28,
                                               backgroundImage: NetworkImage(user.imageUrls.first),
                                             ),
                                           ),
                                           const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      user.name,
                                                      style: AppTextStyles.titleLarge.copyWith(fontSize: 16),
                                                    ),
                                                    Text(
                                                      timeStr,
                                                      style: AppTextStyles.bodyMedium.copyWith(
                                                        fontSize: 12,
                                                        color: (match.lastMessage != null && match.lastMessage!.isRead == false && match.lastMessage!.senderId != authState.currentUser?.id)
                                                            ? AppColors.primary
                                                            : Colors.grey[600],
                                                        fontWeight: (match.lastMessage != null && match.lastMessage!.isRead == false && match.lastMessage!.senderId != authState.currentUser?.id)
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        match.lastMessage?.type == MessageType.image ? '📷 Ảnh' : (match.lastMessage?.content ?? 'Chưa có tin nhắn'),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: (match.lastMessage != null && match.lastMessage!.isRead == false && match.lastMessage!.senderId != authState.currentUser?.id)
                                                              ? Colors.black87
                                                              : Colors.grey[600],
                                                          fontWeight: (match.lastMessage != null && match.lastMessage!.isRead == false && match.lastMessage!.senderId != authState.currentUser?.id)
                                                              ? FontWeight.w600
                                                              : FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
                          childCount: matches.length,
                        ),
                      ),
                    ),
                  ],
                ),
      ),
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