import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/api_service.dart';
import '../../../models/message_model.dart';
import '../../auth/providers/auth_provider.dart';

class AIState {
  final List<Message> messages;
  final bool isLoading;
  final bool isComplete;
  final Map<String, dynamic>? parsedProfile;
  final List<dynamic> recommendations;
  final List<dynamic> sessions;
  final int? currentSessionId;

  AIState({
    this.messages = const [],
    this.isLoading = false,
    this.isComplete = false,
    this.parsedProfile,
    this.recommendations = const [],
    this.sessions = const [],
    this.currentSessionId,
  });

  AIState copyWith({
    List<Message>? messages,
    bool? isLoading,
    bool? isComplete,
    Map<String, dynamic>? parsedProfile,
    List<dynamic>? recommendations,
    List<dynamic>? sessions,
    int? currentSessionId,
  }) {
    return AIState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isComplete: isComplete ?? this.isComplete,
      parsedProfile: parsedProfile ?? this.parsedProfile,
      recommendations: recommendations ?? this.recommendations,
      sessions: sessions ?? this.sessions,
      currentSessionId: currentSessionId ?? this.currentSessionId,
    );
  }
}

class AINotifier extends StateNotifier<AIState> {
  final Ref _ref;

  AINotifier(this._ref) : super(AIState());

  void reset() {
    state = state.copyWith(
      messages: [],
      isLoading: false,
      isComplete: false,
      recommendations: [],
      currentSessionId: null,
    );
  }

  Future<void> fetchSessions(String type) async {
    state = state.copyWith(isLoading: true);
    try {
      final token = _ref.read(authProvider).token;
      final response = await ApiService.get('/ai/sessions/$type', token: token);
      if (response is List) {
        state = state.copyWith(isLoading: false, sessions: response);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> createNewSession(String type) async {
    state = state.copyWith(isLoading: true, messages: []);
    try {
      final token = _ref.read(authProvider).token;
      final response = await ApiService.post('/ai/sessions', {'type': type}, token: token);
      state = state.copyWith(
        isLoading: false,
        currentSessionId: response['id'],
        messages: [],
      );
      // Refresh session list
      fetchSessions(type);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchHistory(String type, {int? sessionId}) async {
    state = state.copyWith(isLoading: true);
    try {
      final token = _ref.read(authProvider).token;
      final sid = sessionId ?? state.currentSessionId ?? 'latest';
      final response = await ApiService.get('/ai/history/$type/$sid', token: token);
      
      if (response is List) {
        final historyMessages = response.map((m) {
          return Message(
            id: DateTime.now().toString() + m['content'].hashCode.toString(),
            matchId: type == 'interview' ? 'ai' : 'ai_consult',
            senderId: m['role'] == 'user' ? 'user' : 'ai',
            content: m['content'],
            timestamp: DateTime.now(),
            recommendations: m['recommendations'],
          );
        }).toList();

        state = state.copyWith(
          isLoading: false,
          messages: historyMessages,
          currentSessionId: sessionId ?? state.currentSessionId,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> startInterview() async {
    state = state.copyWith(isLoading: true, messages: []);
    try {
      final token = _ref.read(authProvider).token;
      final response = await ApiService.post('/ai/interview', {'history': []}, token: token);
      
      final aiMsg = Message(
        id: 'ai_0',
        matchId: 'ai',
        senderId: 'ai',
        content: response['message'],
        timestamp: DateTime.now(),
      );
      
      state = state.copyWith(
        isLoading: false,
        messages: [aiMsg],
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<Map<String, dynamic>?> sendInterviewResponse(String response) async {
    final userMsg = Message(
      id: DateTime.now().toString(),
      matchId: 'ai',
      senderId: 'user',
      content: response,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      isLoading: true,
      messages: [...state.messages, userMsg],
    );

    try {
      final token = _ref.read(authProvider).token;
      final history = state.messages.map((m) => {
        'role': m.senderId == 'user' ? 'user' : 'model',
        'content': m.content,
      }).toList();

      final res = await ApiService.post('/ai/interview', {
        'history': history,
        'lastResponse': response,
        'session_id': state.currentSessionId,
      }, token: token);

      final aiMsg = Message(
        id: DateTime.now().toString(),
        matchId: 'ai',
        senderId: 'ai',
        content: res['message'],
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        isLoading: false,
        messages: [...state.messages, aiMsg],
        isComplete: res['isComplete'] ?? false,
        parsedProfile: res['parsedProfile'],
        currentSessionId: res['session_id'],
      );

      if (state.isComplete) {
        getRecommendations();
      }
      return res;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return null;
    }
  }

  Future<void> getRecommendations() async {
    if (state.parsedProfile == null) return;
    state = state.copyWith(isLoading: true);
    try {
      final token = _ref.read(authProvider).token;
      final res = await ApiService.post('/ai/recommendations', {
        'userProfile': state.parsedProfile,
      }, token: token);
      
      state = state.copyWith(
        isLoading: false,
        recommendations: res['recommendations'] ?? [],
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<Map<String, dynamic>?> consult(String message) async {
    // If messages are from a different context (e.g. interview), clear them
    if (state.messages.any((m) => m.matchId == 'ai')) {
      reset();
    }

    final userMsg = Message(
      id: DateTime.now().toString(),
      matchId: 'ai_consult',
      senderId: 'user',
      content: message,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      isLoading: true,
      messages: [...state.messages, userMsg],
    );

    try {
      final token = _ref.read(authProvider).token;
      final history = state.messages.map((m) => {
        'role': m.senderId == 'user' ? 'user' : 'model',
        'content': m.content,
      }).toList();

      final res = await ApiService.post('/ai/consult', {
        'history': history,
        'message': message,
        'session_id': state.currentSessionId,
      }, token: token);

      final aiMsg = Message(
        id: DateTime.now().toString(),
        matchId: 'ai_consult',
        senderId: 'ai',
        content: res['message'],
        timestamp: DateTime.now(),
        recommendations: res['recommendations'],
      );

      state = state.copyWith(
        isLoading: false,
        messages: [...state.messages, aiMsg],
        currentSessionId: res['session_id'],
      );
      return res;
    } catch (e) {
      print('DEBUG: AI Consult Error: $e');
      state = state.copyWith(isLoading: false);
      return null;
    }
  }
}

final aiProvider = StateNotifierProvider<AINotifier, AIState>((ref) {
  return AINotifier(ref);
});
