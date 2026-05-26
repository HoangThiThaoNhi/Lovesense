enum MessageType { text, image }

class Message {
  final String id;
  final String matchId;
  final String senderId;
  final String? content;
  final MessageType type;
  final String? imageUrl;
  final DateTime timestamp;
  final bool isRead;
  final bool isSending;
  final List<dynamic>? recommendations;

  Message({
    required this.id,
    required this.matchId,
    required this.senderId,
    this.content,
    this.type = MessageType.text,
    this.imageUrl,
    required this.timestamp,
    this.isRead = false,
    this.isSending = false,
    this.recommendations,
  });

  Message copyWith({
    String? id,
    String? matchId,
    String? senderId,
    String? content,
    MessageType? type,
    String? imageUrl,
    DateTime? timestamp,
    bool? isRead,
    bool? isSending,
    List<dynamic>? recommendations,
  }) {
    return Message(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      isSending: isSending ?? this.isSending,
      recommendations: recommendations ?? this.recommendations,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'].toString(),
      matchId: json['match_id'].toString(),
      senderId: json['sender_id'].toString(),
      content: json['content'],
      type: json['message_type'] == 'image' ? MessageType.image : MessageType.text,
      imageUrl: json['image_url'],
      timestamp: DateTime.parse(json['created_at']),
      isRead: (json['is_read'] == 1 || json['is_read'] == true) == true,
      isSending: false,
    );
  }
}

class ChatMatch {
  final String id;
  final String userId; 
  final String name;
  final String? imageUrl;
  final DateTime matchedAt;
  final Message? lastMessage;
  final String status;
  final String user1Id;
  final String user2Id;
  final int myMessageCount;
  final int otherMessageCount;

  ChatMatch({
    required this.id,
    required this.userId,
    required this.name,
    this.imageUrl,
    required this.matchedAt,
    this.lastMessage,
    this.status = 'accepted',
    this.user1Id = '',
    this.user2Id = '',
    this.myMessageCount = 0,
    this.otherMessageCount = 0,
  });

  ChatMatch copyWith({
    String? id,
    String? userId,
    String? name,
    String? imageUrl,
    DateTime? matchedAt,
    Message? lastMessage,
    String? status,
    String? user1Id,
    String? user2Id,
    int? myMessageCount,
    int? otherMessageCount,
  }) {
    return ChatMatch(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      matchedAt: matchedAt ?? this.matchedAt,
      lastMessage: lastMessage ?? this.lastMessage,
      status: status ?? this.status,
      user1Id: user1Id ?? this.user1Id,
      user2Id: user2Id ?? this.user2Id,
      myMessageCount: myMessageCount ?? this.myMessageCount,
      otherMessageCount: otherMessageCount ?? this.otherMessageCount,
    );
  }
}
