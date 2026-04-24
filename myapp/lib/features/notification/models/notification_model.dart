enum NotificationType { match, message, xp, title, ai_insight, system, gift }

class NotificationModel {
  final int id;
  final int userId;
  final NotificationType type;
  final String title;
  final String content;
  final bool isRead;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.content,
    required this.isRead,
    this.metadata,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    // Boolean safety: Force explicit boolean conversion
    final bool readStatus = (json['is_read'] == 1 || json['is_read'] == true || json['is_read'] == 'true');
    
    return NotificationModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      userId: int.tryParse(json['user_id']?.toString() ?? '0') ?? 0,
      type: _parseType(json['type']?.toString()),
      title: (json['title'] ?? '').toString(),
      content: (json['content'] ?? '').toString(),
      isRead: readStatus,
      metadata: json['metadata'] is Map ? Map<String, dynamic>.from(json['metadata'] as Map) : null,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  static NotificationType _parseType(String? type) {
    switch (type) {
      case 'match': return NotificationType.match;
      case 'message': return NotificationType.message;
      case 'xp': return NotificationType.xp;
      case 'title': return NotificationType.title;
      case 'ai_insight': return NotificationType.ai_insight;
      case 'gift': return NotificationType.gift;
      default: return NotificationType.system;
    }
  }
}
