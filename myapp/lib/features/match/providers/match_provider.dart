import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/message_model.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/utils/api_service.dart';

class MatchState {
  final List<ChatMatch> matches;
  final List<dynamic> pendingLikes;
  final bool isLoading;
  final String? error;

  MatchState({
    this.matches = const [],
    this.pendingLikes = const [],
    this.isLoading = false,
    this.error,
  });

  MatchState copyWith({
    List<ChatMatch>? matches,
    List<dynamic>? pendingLikes,
    bool? isLoading,
    String? error,
  }) {
    return MatchState(
      matches: matches ?? this.matches,
      pendingLikes: pendingLikes ?? this.pendingLikes,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class MatchNotifier extends StateNotifier<MatchState> {
  final Ref _ref;
  MatchNotifier(this._ref) : super(MatchState()) {
    fetchMatches();
  }

  Future<void> fetchMatches() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = _ref.read(authProvider).token;
      if (token == null) {
        state = state.copyWith(isLoading: false);
        return;
      }
      
      // Fetch matches
      dynamic matchesData;
      try {
        matchesData = await ApiService.get('/matches', token: token);
      } catch (e) {
        print('DEBUG: Error fetching matches: $e');
        matchesData = [];
      }
      
      // Fetch pending likes
      dynamic pendingData;
      try {
        pendingData = await ApiService.get('/swipes/pending', token: token);
      } catch (e) {
        print('DEBUG: Error fetching pending likes: $e');
        pendingData = [];
      }
      
      final List<dynamic> responseBody = (matchesData is List) ? matchesData : [];
      final List<dynamic> pendingLikesBody = (pendingData is List) ? pendingData : [];
      
      final List<ChatMatch> fetchedMatches = responseBody.map((m) {
        if (m == null || m is! Map) return null;
        final map = m as Map<String, dynamic>;
        
        DateTime matchedAt;
        try {
          matchedAt = DateTime.parse(map['match_date']?.toString() ?? '').toLocal();
        } catch (_) {
          matchedAt = DateTime.now();
        }

        Message? lastMessage;
        if (map['last_message'] != null || map['last_message_type'] == 'image') {
          lastMessage = Message(
            id: 'last',
            matchId: map['match_id']?.toString() ?? '',
            senderId: map['last_sender_id']?.toString() ?? '',
            content: map['last_message']?.toString(),
            type: map['last_message_type'] == 'image' ? MessageType.image : MessageType.text,
            timestamp: map['last_message_date'] != null 
                ? DateTime.parse(map['last_message_date'].toString()).toLocal() 
                : matchedAt,
            isRead: (map['is_read'] == 1 || map['is_read'] == true),
          );
        }

        return ChatMatch(
          id: map['match_id']?.toString() ?? '',
          userId: map['profile_userid']?.toString() ?? '',
          name: map['display_name']?.toString() ?? 'User',
          imageUrl: map['main_photo']?.toString(),
          matchedAt: matchedAt,
          lastMessage: lastMessage,
          status: map['status']?.toString() ?? 'accepted',
          user1Id: map['user1_id']?.toString() ?? '',
          user2Id: map['user2_id']?.toString() ?? '',
        );
      }).whereType<ChatMatch>().toList();

      state = state.copyWith(
        matches: fetchedMatches, 
        pendingLikes: pendingLikesBody,
        isLoading: false
      );
    } catch (e) {
      print('DEBUG: Global error in fetchMatches: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> quickLike(String userId) async {
    try {
      final token = _ref.read(authProvider).token;
      await ApiService.post('/swipes', {
        'swiped_id': userId,
        'type': 'like'
      }, token: token);
      
      // Refresh both to see the new match
      await fetchMatches();
    } catch (e) {
      print('Quick Like Error: $e');
    }
  }

  Future<void> quickNope(String userId) async {
    try {
      final token = _ref.read(authProvider).token;
      await ApiService.post('/swipes', {
        'swiped_id': userId,
        'type': 'nope'
      }, token: token);
      
      // Just refresh local state by filtering out
      state = state.copyWith(
        pendingLikes: state.pendingLikes.where((l) => l['user_id'].toString() != userId).toList()
      );
    } catch (e) {
      print('Quick Nope Error: $e');
    }
  }

  Future<void> markAsRead(String matchId) async {
    // ... same as before ...
    final token = _ref.read(authProvider).token;
    final updatedMatches = state.matches.map((m) {
      if (m.id == matchId && m.lastMessage != null) {
        return ChatMatch(
          id: m.id,
          userId: m.userId,
          name: m.name,
          imageUrl: m.imageUrl,
          matchedAt: m.matchedAt,
          lastMessage: Message(
            id: m.lastMessage!.id,
            matchId: m.lastMessage!.matchId,
            senderId: m.lastMessage!.senderId,
            content: m.lastMessage!.content,
            type: m.lastMessage!.type,
            timestamp: m.lastMessage!.timestamp,
            isRead: true,
          ),
          status: m.status,
          user1Id: m.user1Id,
          user2Id: m.user2Id,
        );
      }
      return m;
    }).toList();

    state = state.copyWith(matches: updatedMatches);
    try {
      await ApiService.post('/matches/$matchId/read', {}, token: token);
    } catch (e) {
      print('Mark As Read Error: $e');
    }
  }

  Future<void> deleteMatch(String matchId) async {
    final token = _ref.read(authProvider).token;
    final originalMatches = state.matches;
    state = state.copyWith(
      matches: state.matches.where((m) => m.id != matchId).toList(),
    );
    try {
      await ApiService.delete('/matches/$matchId', token: token);
    } catch (e) {
      state = state.copyWith(matches: originalMatches);
    }
  }

  Future<void> acceptMatch(String matchId) async {
    final token = _ref.read(authProvider).token;
    final updatedMatches = state.matches.map((m) {
      if (m.id == matchId) {
        return ChatMatch(
          id: m.id,
          userId: m.userId,
          name: m.name,
          imageUrl: m.imageUrl,
          matchedAt: m.matchedAt,
          lastMessage: m.lastMessage,
          status: 'accepted',
          user1Id: m.user1Id,
          user2Id: m.user2Id,
        );
      }
      return m;
    }).toList();
    state = state.copyWith(matches: updatedMatches);
    try {
      await ApiService.put('/matches/$matchId/accept', {}, token: token);
    } catch (e) {
      fetchMatches();
    }
  }

  Future<void> rejectMatch(String matchId) async {
    final token = _ref.read(authProvider).token;
    final originalMatches = state.matches;
    state = state.copyWith(
      matches: state.matches.where((m) => m.id != matchId).toList(),
    );
    try {
      await ApiService.put('/matches/$matchId/reject', {}, token: token);
    } catch (e) {
      state = state.copyWith(matches: originalMatches);
    }
  }
}

final matchProvider = StateNotifierProvider<MatchNotifier, MatchState>((ref) {
  return MatchNotifier(ref);
});
