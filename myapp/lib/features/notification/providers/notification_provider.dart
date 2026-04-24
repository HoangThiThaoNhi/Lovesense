import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/api_service.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/notification_model.dart';

class NotificationState {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final String? error;

  NotificationState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
  });

  int get unreadCount => notifications.where((n) => n.isRead == false).length;

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    String? error,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  final Ref _ref;

  NotificationNotifier(this._ref) : super(NotificationState()) {
    fetchNotifications();
    
    // Auto-refresh every 10 seconds to keep UI fresh everywhere
    final timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_ref.read(authProvider).isAuthenticated) {
        fetchNotifications(silent: true);
      }
    });

    _ref.onDispose(() {
      timer.cancel();
    });
  }

  Future<void> fetchNotifications({bool silent = false}) async {
    if (state.isLoading) return;
    
    if (!silent) {
      state = state.copyWith(isLoading: true, error: null);
    }
    
    try {
      final token = _ref.read(authProvider).token;
      if (token == null) return;
      
      final response = await ApiService.get('/notifications', token: token);
      
      if (response is List) {
        final List<NotificationModel> fetched = response
            .map((n) => NotificationModel.fromJson(n))
            .toList();
        state = state.copyWith(notifications: fetched, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false, error: 'Dữ liệu không hợp lệ');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> markAsRead(int id) async {
    try {
      final token = _ref.read(authProvider).token;
      await ApiService.put('/notifications/$id/read', {}, token: token);
      
      state = state.copyWith(
        notifications: state.notifications.map((n) {
          if (n.id == id) {
            return NotificationModel(
              id: n.id, userId: n.userId, type: n.type,
              title: n.title, content: n.content, isRead: true,
              metadata: n.metadata, createdAt: n.createdAt
            );
          }
          return n;
        }).toList(),
      );
    } catch (e) {
      print('Mark as read error: $e');
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final token = _ref.read(authProvider).token;
      await ApiService.put('/notifications/mark-all-read', {}, token: token);
      
      state = state.copyWith(
        notifications: state.notifications.map((n) {
          return NotificationModel(
            id: n.id, userId: n.userId, type: n.type,
            title: n.title, content: n.content, isRead: true,
            metadata: n.metadata, createdAt: n.createdAt
          );
        }).toList(),
      );
    } catch (e) {
      print('Mark all as read error: $e');
    }
  }
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  return NotificationNotifier(ref);
});
