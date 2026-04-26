import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/utils/api_service.dart';

class BadgeModel {
  final int id;
  final String name;
  final String description;
  final int pointsRequired;
  final String? iconUrl;
  final DateTime? earnedAt;

  BadgeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pointsRequired,
    this.iconUrl,
    this.earnedAt,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    DateTime? earned;
    
    final users = json['users'] as List?;
    dynamic earnedRaw = json['UserBadge']?['earned_at'] ?? json['earned_at'];
    
    if (earnedRaw == null && users != null && users.isNotEmpty) {
      final firstUser = users[0] as Map<String, dynamic>?;
      earnedRaw = firstUser?['UserBadge']?['earned_at'];
    }

    if (earnedRaw != null) {
      earned = DateTime.tryParse(earnedRaw.toString());
    }
    
    return BadgeModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      pointsRequired: int.tryParse(json['points_required']?.toString() ?? '0') ?? 0,
      iconUrl: json['icon_url'] as String?,
      earnedAt: earned,
    );
  }


  /// Check if the icon is an image (network or relative path)
  bool get isImage => iconUrl != null && (iconUrl!.startsWith('http') || iconUrl!.startsWith('/uploads'));

  /// Check if the icon is a network image
  bool get isNetworkImage => isImage;

  /// Icon emoji based on icon_url if it's not an image, otherwise fallback mapping
  String get emoji {
    if (iconUrl != null && !isImage) return iconUrl!;
    
    final n = name.toLowerCase();
    if (n.contains('platinum')) return '💎';
    if (n.contains('gold')) return '🥇';
    if (n.contains('silver')) return '🥈';
    if (n.contains('bronze')) return '🥉';
    return '🏅';
  }

  /// Color based on badge tier
  int get color {
    final n = name.toLowerCase();
    if (n.contains('platinum') || n.contains('bạch kim')) return 0xFF64B5F6;
    if (n.contains('gold') || n.contains('vàng')) return 0xFFFFD700;
    if (n.contains('silver') || n.contains('bạc')) return 0xFFB0BEC5;
    if (n.contains('bronze') || n.contains('đồng')) return 0xFFCD7F32;
    return 0xFFE91E63;
  }

  /// Build the badge icon widget with correct priority:
  /// 1. Network Image (Uploaded in CMS)
  /// 2. Custom Emoji (Set in CMS)
  /// 3. Hardcoded 3D Assets (Fallback based on name)
  /// 4. Default Emoji
  Widget buildIcon({double size = 24, bool useDefault3D = true}) {
    // 1. Check for Network Image / Uploaded Path
    if (isNetworkImage) {
      return CachedNetworkImage(
        imageUrl: ApiService.formatImageUrl(iconUrl),
        width: size,
        height: size,
        fit: BoxFit.contain,
        placeholder: (context, url) => SizedBox(width: size, height: size, child: const CircularProgressIndicator(strokeWidth: 2)),
        errorWidget: (context, url, error) => _fallbackIcon(size, useDefault3D),
      );
    }

    // 2. Check if iconUrl is a simple Emoji (not a path)
    if (iconUrl != null && iconUrl!.isNotEmpty && !iconUrl!.startsWith('/') && !iconUrl!.startsWith('http')) {
      return Text(iconUrl!, style: TextStyle(fontSize: size * 0.8));
    }

    // 3. Fallback
    return _fallbackIcon(size, useDefault3D);
  }

  Widget _fallbackIcon(double size, bool useDefault3D) {
    if (useDefault3D) {
      final n = name.toLowerCase();
      if (n.contains('bronze') || n.contains('đồng')) {
        return Image.asset('assets/images/bronze_badge_3d.png', width: size * 1.2, height: size * 1.2, fit: BoxFit.contain);
      }
      if (n.contains('silver') || n.contains('bạc')) {
        return Image.asset('assets/images/silver_badge_3d.png', width: size * 1.2, height: size * 1.2, fit: BoxFit.contain);
      }
      if (n.contains('gold') || n.contains('vàng') || n.contains('platinum') || n.contains('bạch kim')) {
        return Image.asset('assets/images/gold_badge_3d.png', width: size * 1.2, height: size * 1.2, fit: BoxFit.contain);
      }
    }
    return Text(emoji, style: TextStyle(fontSize: size * 0.8));
  }
}


class GamificationStatus {
  final int points;
  final String currentTitle;
  final List<BadgeModel> badges;
  final List<PointHistoryEntry> history;
  final List<ChallengeModel> challenges;
  final int unusedVouchersCount;

  GamificationStatus({
    required this.points,
    required this.currentTitle,
    required this.badges,
    required this.history,
    required this.challenges,
    required this.unusedVouchersCount,
  });

  factory GamificationStatus.fromJson(Map<String, dynamic> json) {
    try {
      final profileMap = json['profile'];
      final Map<String, dynamic> profile = (profileMap is Map) ? Map<String, dynamic>.from(profileMap) : {};
      
      // Defensively parse lists
      final List<BadgeModel> badgeList = [];
      if (json['badges'] is List) {
        for (var item in json['badges']) {
          if (item is Map) {
            badgeList.add(BadgeModel.fromJson(Map<String, dynamic>.from(item)));
          }
        }
      }
          
      final List<PointHistoryEntry> historyList = [];
      if (json['history'] is List) {
        for (var item in json['history']) {
          if (item is Map) {
            historyList.add(PointHistoryEntry.fromJson(Map<String, dynamic>.from(item)));
          }
        }
      }
          
      final List<ChallengeModel> challengeList = [];
      if (json['challenges'] is List) {
        for (var item in json['challenges']) {
          if (item is Map) {
            challengeList.add(ChallengeModel.fromJson(Map<String, dynamic>.from(item)));
          }
        }
      }
  
      return GamificationStatus(
        points: int.tryParse(profile['points']?.toString() ?? '0') ?? 0,
        currentTitle: profile['current_title']?.toString() ?? 'Newbie',
        badges: badgeList,
        history: historyList,
        challenges: challengeList,
        unusedVouchersCount: int.tryParse(json['unusedVouchersCount']?.toString() ?? '0') ?? 0,
      );
    } catch (e, stack) {
      print('DEBUG ERROR: GamificationStatus.fromJson failed: $e');
      print(stack);
      return GamificationStatus.empty();
    }
  }

  static GamificationStatus empty() => GamificationStatus(
    points: 0,
    currentTitle: 'Newbie',
    badges: <BadgeModel>[],
    history: <PointHistoryEntry>[],
    challenges: <ChallengeModel>[],
    unusedVouchersCount: 0,
  );
}

class ChallengeModel {
  final int id;
  final String title;
  final String description;
  final String triggerCondition;
  final int rewardXp;
  final int? rewardBadgeId;
  final String status;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.triggerCondition,
    required this.rewardXp,
    this.rewardBadgeId,
    required this.status,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: (json['title'] ?? json['name'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      triggerCondition: (json['trigger_condition'] ?? '') as String,
      rewardXp: int.tryParse((json['reward_xp'] ?? json['points_required'] ?? '0').toString()) ?? 0,
      rewardBadgeId: json['reward_badge_id'] != null ? int.tryParse(json['reward_badge_id'].toString()) : null,
      status: (json['status'] ?? 'active') as String,
    );
  }

  String get emoji {
    final t = title.toLowerCase();
    if (t.contains('ảnh') || t.contains('photo')) return '📸';
    if (t.contains('hồ sơ') || t.contains('profile')) return '✏️';
    if (t.contains('ai') || t.contains('bot')) return '🤖';
    if (t.contains('match')) return '💖';
    if (t.contains('chat')) return '💬';
    return '🎯';
  }
}

class PointHistoryEntry {
  final int id;
  final String action;
  final int points;
  final DateTime createdAt;

  PointHistoryEntry({
    required this.id,
    required this.action,
    required this.points,
    required this.createdAt,
  });

  factory PointHistoryEntry.fromJson(Map<String, dynamic> json) {
    return PointHistoryEntry(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      action: json['action'] as String? ?? '',
      points: int.tryParse(json['points']?.toString() ?? '0') ?? 0,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }
}
