import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/message_model.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/utils/api_service.dart';

class MatchState {
  final List<ChatMatch> matches;
  final bool isLoading;
  final String? error;

  MatchState({
    this.matches = const [],
    this.isLoading = false,
    this.error,
  });

  MatchState copyWith({
    List<ChatMatch>? matches,
    bool? isLoading,
    String? error,
  }) {
    return MatchState(
      matches: matches ?? this.matches,
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
      final responseBody = await ApiService.get('/matches', token: token);
      
      if (responseBody is List) {
        final List<ChatMatch> fetchedMatches = (responseBody as List).map((m) {
          DateTime matchedAt;
          try {
            matchedAt = DateTime.parse(m['match_date'].toString()).toLocal();
          } catch (_) {
            matchedAt = DateTime.now();
          }

          Message? lastMessage;
          if (m['last_message'] != null || m['last_message_type'] == 'image') {
            lastMessage = Message(
              id: 'last',
              matchId: m['match_id'].toString(),
              senderId: m['last_sender_id'].toString(),
              content: m['last_message'],
              type: m['last_message_type'] == 'image' ? MessageType.image : MessageType.text,
              timestamp: m['last_message_date'] != null ? DateTime.parse(m['last_message_date']).toLocal() : matchedAt,
              isRead: (m['is_read'] == 1 || m['is_read'] == true) == true,
            );
          }

          return ChatMatch(
            id: m['match_id'].toString(),
            userId: m['profile_userid'].toString(),
            name: m['display_name'] ?? 'User',
            imageUrl: m['main_photo'],
            matchedAt: matchedAt,
            lastMessage: lastMessage,
            status: m['status'] ?? 'accepted',
            user1Id: m['user1_id']?.toString() ?? '',
            user2Id: m['user2_id']?.toString() ?? '',
          );
        }).toList();
        state = state.copyWith(matches: fetchedMatches, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false, error: 'Lỗi tải dữ liệu');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> markAsRead(String matchId) async {
    final token = _ref.read(authProvider).token;
    
    // Optimistic local update
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
            isRead: true, // Optimistically mark as read
          ),
        );
      }
      return m;
    }).toList();

    state = state.copyWith(matches: updatedMatches);

    try {
      await ApiService.post('/matches/$matchId/read', {}, token: token);
    } catch (e) {
      print('Mark As Read Error: $e');
      // We don't necessarily need to rollback for read status as it's not critical
    }
  }

  Future<void> deleteMatch(String matchId) async {
    final token = _ref.read(authProvider).token;
    
    // Optimistic update
    final originalMatches = state.matches;
    state = state.copyWith(
      matches: state.matches.where((m) => m.id != matchId).toList(),
    );

    try {
      await ApiService.delete('/matches/$matchId', token: token);
    } catch (e) {
      print('Delete Match Error: $e');
      // Rollback on error
      state = state.copyWith(matches: originalMatches);
    }
  }

  Future<void> acceptMatch(String matchId) async {
    final token = _ref.read(authProvider).token;
    
    // Optimistic update
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
      print('Accept Match Error: $e');
      fetchMatches(); // Rollback by refetching
    }
  }

  Future<void> rejectMatch(String matchId) async {
    final token = _ref.read(authProvider).token;
    
    // Optimistic update (remove from list)
    final originalMatches = state.matches;
    state = state.copyWith(
      matches: state.matches.where((m) => m.id != matchId).toList(),
    );

    try {
      await ApiService.put('/matches/$matchId/reject', {}, token: token);
    } catch (e) {
      print('Reject Match Error: $e');
      state = state.copyWith(matches: originalMatches); // Rollback
    }
  }
}

final matchProvider = StateNotifierProvider<MatchNotifier, MatchState>((ref) {
  return MatchNotifier(ref);
});
