import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../shared_widgets/glass_container.dart';
import '../../../theme.dart';
import '../models/notification_model.dart';
import '../providers/notification_provider.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // Notifications are already fetched by the provider's constructor
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (state.notifications.any((n) => n.isRead == false))
            TextButton(
              onPressed: () => ref.read(notificationProvider.notifier).markAllAsRead(),
              child: const Text('Đọc tất cả', style: TextStyle(color: AppColors.primary)),
            ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: state.isLoading && state.notifications.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : state.notifications.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
                    onRefresh: () => ref.read(notificationProvider.notifier).fetchNotifications(),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 100, bottom: 16),
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = state.notifications[index];
                        return _NotificationItem(notification: notification);
                      },
                    ),
                  ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_rounded, size: 80, color: Colors.grey.withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text(
            'Chưa có thông báo nào',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Hãy bắt đầu lướt để tìm kiếm tương hợp và nhận những cập nhật mới nhất từ LoveSense!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends ConsumerWidget {
  final NotificationModel notification;
  const _NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          if (notification.isRead == false) {
            ref.read(notificationProvider.notifier).markAsRead(notification.id);
          }
          // Navigate based on type if needed
        },
        child: GlassContainer(
          padding: const EdgeInsets.all(16),
          child: Opacity(
            opacity: notification.isRead == true ? 0.7 : 1.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIcon(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontWeight: notification.isRead == true ? FontWeight.normal : FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('HH:mm').format(notification.createdAt.toLocal()),
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.content,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                if (notification.isRead == false)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData iconData;
    Color color;

    switch (notification.type) {
      case NotificationType.match:
        iconData = Icons.favorite_rounded;
        color = Colors.redAccent;
        break;
      case NotificationType.xp:
        iconData = Icons.stars_rounded;
        color = Colors.amber;
        break;
      case NotificationType.title:
        iconData = Icons.emoji_events_rounded;
        color = Colors.blue;
        break;
      case NotificationType.message:
        iconData = Icons.chat_bubble_rounded;
        color = Colors.green;
        break;
      case NotificationType.ai_insight:
        iconData = Icons.auto_awesome_rounded;
        color = Colors.purple;
        break;
      default:
        iconData = Icons.notifications_rounded;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: color, size: 24),
    );
  }
}
