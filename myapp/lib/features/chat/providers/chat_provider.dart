import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/message_model.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/utils/api_service.dart';
import '../../../core/utils/cloudinary_service.dart';

class ChatState {
  final Map<String, List<Message>> messages; // matchId -> messages
  final bool isLoading;
  final String? error;

  ChatState({
    this.messages = const {},
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    Map<String, List<Message>>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final Ref _ref;
  ChatNotifier(this._ref) : super(ChatState());

  Future<void> fetchMessages(String matchId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final token = _ref.read(authProvider).token;
      final responseBody = await ApiService.get('/messages/$matchId', token: token);
      
      if (responseBody is List) {
        final List<Message> fetchedMessages = (responseBody as List).map((m) => Message.fromJson(m)).toList();

        state = state.copyWith(
          messages: {
            ...state.messages,
            matchId: fetchedMessages,
          },
          isLoading: false,
          error: null,
        );
      } else {
        state = state.copyWith(isLoading: false, error: 'Lỗi tải tin nhắn');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> sendMessage(String matchId, String? content, {MessageType type = MessageType.text, String? imageUrl, String? localPath}) async {
    final senderId = _ref.read(authProvider).currentUser?.id;
    if (senderId == null) return;

    final tempId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
    final tempMsg = Message(
      id: tempId,
      matchId: matchId,
      senderId: senderId,
      content: content,
      type: type,
      imageUrl: localPath ?? imageUrl,
      timestamp: DateTime.now(),
      isRead: true,
      isSending: true,
    );

    final currentMessages = state.messages[matchId] ?? [];
    state = state.copyWith(
      messages: {
        ...state.messages,
        matchId: [...currentMessages, tempMsg],
      },
    );

    try {
      final token = _ref.read(authProvider).token;
      String? finalImageUrl = imageUrl;

      // 1. If we have a local path, upload it first
      if (type == MessageType.image && localPath != null) {
        try {
          final uploadedUrl = await CloudinaryService.uploadImage(localPath, token!);
          if (uploadedUrl == null) {
            throw Exception('Lỗi: Cloudinary trả về null');
          }
          finalImageUrl = uploadedUrl;
        } catch (uploadError) {
          throw Exception('Lỗi tải ảnh: $uploadError');
        }
        
        // Update the temp message with the real URL but still marked as sending
        final updatedMessages = state.messages[matchId]!.map((m) {
          if (m.id == tempId) return m.copyWith(imageUrl: finalImageUrl);
          return m;
        }).toList();
        
        state = state.copyWith(messages: {...state.messages, matchId: updatedMessages});
      }

      // 2. Send to backend
      await ApiService.post('/messages', {
        'matchId': matchId,
        'content': content,
        'messageType': type == MessageType.image ? 'image' : 'text',
        'imageUrl': finalImageUrl,
      }, token: token);
      
      // Refresh to get real IDs and clear any previous errors
      state = state.copyWith(error: null);
      fetchMessages(matchId);
    } catch (e) {
      // Mark the message as failed or remove it? For now, just show error
      state = state.copyWith(error: '$e');
      
      // Remove failed temp message if it stayed as "sending" indefinitely
      final filteredMessages = state.messages[matchId]?.where((m) => m.id != tempId).toList();
      if (filteredMessages != null) {
        state = state.copyWith(messages: {...state.messages, matchId: filteredMessages});
      }
    }
  }

  Future<void> deleteMessage(String matchId, String messageId) async {
    try {
      final token = _ref.read(authProvider).token;
      await ApiService.delete('/messages/$messageId', token: token);
      
      final currentMessages = state.messages[matchId] ?? [];
      state = state.copyWith(
        messages: {
          ...state.messages,
          matchId: currentMessages.where((m) => m.id != messageId).toList(),
        },
      );
    } catch (e) {
      state = state.copyWith(error: 'Lỗi xóa tin nhắn: $e');
    }
  }

  Future<void> deleteMatch(String matchId) async {
    try {
      final token = _ref.read(authProvider).token;
      await ApiService.delete('/matches/$matchId', token: token);
      
      final newMessages = Map<String, List<Message>>.from(state.messages);
      newMessages.remove(matchId);
      state = state.copyWith(messages: newMessages);
    } catch (e) {
      state = state.copyWith(error: 'Lỗi xóa cuộc trò chuyện: $e');
    }
  }

  Future<void> deleteConversation(String matchId) async {
    try {
      final token = _ref.read(authProvider).token;
      await ApiService.delete('/messages/conversation/$matchId', token: token);
      
      state = state.copyWith(
        messages: {
          ...state.messages,
          matchId: [],
        },
      );
    } catch (e) {
      state = state.copyWith(error: 'Lỗi xóa tin nhắn cuộc trò chuyện: $e');
    }
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier(ref);
});