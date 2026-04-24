import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/leaderboard_provider.dart';
import '../../../theme.dart';
import 'dart:ui';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardAsync = ref.watch(leaderboardProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Bảng xếp hạng XP', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: leaderboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (data) {
          final topUsers = data['top_users'] as List;
          final userRank = data['user_rank'];
          final userPoints = data['user_points'];

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => ref.read(leaderboardProvider.notifier).loadLeaderboard(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: topUsers.length,
                    itemBuilder: (context, index) {
                      final profile = topUsers[index];
                      final user = profile['user'];
                      final isCurrentUser = profile['user_id'] == data['current_user_id']; // This depends on if we return current_user_id
                      
                      return _buildLeaderboardItem(
                        context, 
                        index + 1, 
                        user['full_name'], 
                        user['avatar_url'], 
                        profile['points'], 
                        profile['current_title'],
                        isCurrentUser
                      );
                    },
                  ),
                ),
              ),
              
              // Sticky User Rank Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, -5)),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            '#$userRank',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'Vị trí của bạn',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Text(
                        '$userPoints XP',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLeaderboardItem(BuildContext context, int rank, String name, String? avatar, int points, String? title, bool isMe) {
    Color rankColor = Colors.grey[600]!;
    if (rank == 1) rankColor = Colors.amber[700]!;
    if (rank == 2) rankColor = Colors.grey[400]!;
    if (rank == 3) rankColor = Colors.brown[400]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isMe ? AppColors.primary.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isMe ? AppColors.primary.withOpacity(0.2) : Colors.grey[100]!),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              '$rank',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: rankColor),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 24,
            backgroundImage: avatar != null && avatar.isNotEmpty 
                ? NetworkImage(avatar) 
                : null,
            child: avatar == null || avatar.isEmpty ? const Icon(Icons.person) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (title != null)
                  Text(
                    title,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.w600),
                  ),
              ],
            ),
          ),
          Text(
            '$points',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.primary),
          ),
          const SizedBox(width: 4),
          const Text('XP', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
        ],
      ),
    );
  }
}
