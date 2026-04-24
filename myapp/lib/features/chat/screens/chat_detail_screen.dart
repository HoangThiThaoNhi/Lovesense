import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import '../../../models/user_model.dart';
import '../../../models/message_model.dart';
import 'package:lovesense/features/auth/providers/auth_provider.dart';
import '../../chat/providers/chat_provider.dart';
import '../../match/providers/match_provider.dart';
import '../../../theme.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/utils/cloudinary_service.dart';
import '../../profile/screens/profile_setup_screen.dart';
import '../../../core/utils/toast_utils.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  final String matchId;
  final User user;

  const ChatDetailScreen({super.key, required this.matchId, required this.user});

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(chatProvider.notifier).fetchMessages(widget.matchId);
      ref.read(matchProvider.notifier).markAsRead(widget.matchId);
    });
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    
    ref.read(chatProvider.notifier).sendMessage(
      widget.matchId,
      _controller.text,
    );
    
    _controller.clear();
    _scrollToBottom();
  }

  Future<void> _sendImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      if (image == null) return;

      ref.read(chatProvider.notifier).sendMessage(
        widget.matchId,
        null,
        type: MessageType.image,
        localPath: image.path,
      );
      
      _scrollToBottom();
    } catch (e) {
      ToastUtils.showModernToast(context, 'Lỗi chọn ảnh: $e', type: ToastType.error);
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildImageMessage(Message message) {
    final imageUrl = message.imageUrl;
    if (imageUrl == null) return const SizedBox.shrink();

    final isLocal = !imageUrl.startsWith('http');

    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: isLocal
              ? Image.file(
                  File(imageUrl),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  imageUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
        ),
        if (message.isSending == true)
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  void _showDeleteMenu(Message message) {
    final isMe = message.senderId == ref.read(authProvider).currentUser?.id;
    if (!isMe) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Xóa tin nhắn'),
              onTap: () {
                ref.read(chatProvider.notifier).deleteMessage(widget.matchId, message.id);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final messages = chatState.messages[widget.matchId] ?? [];
    final currentUserId = ref.watch(authProvider).currentUser?.id;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        title: GestureDetector(
          onTap: () => context.pushNamed('user_detail', extra: widget.user),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: (widget.user.imageUrls.isNotEmpty && widget.user.imageUrls.first.startsWith('http'))
                  ? NetworkImage(widget.user.imageUrls.first)
                  : const AssetImage('assets/images/placeholder.png') as ImageProvider,
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(widget.user.name, overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'delete') {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Xóa lịch sử trò chuyện?'),
                    content: const Text('Tất cả tin nhắn sẽ bị xóa, nhưng bạn vẫn có thể tiếp tục trò chuyện sau này.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hủy')),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true), 
                        child: const Text('Xóa', style: TextStyle(color: Colors.red))
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await ref.read(chatProvider.notifier).deleteConversation(widget.matchId);
                  if (mounted) context.pop();
                }
              } else if (value == 'view') {
                context.pushNamed('user_detail', extra: widget.user);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'view', child: Text('Xem hồ sơ')),
              if (messages.isNotEmpty)
                const PopupMenuItem(value: 'delete', child: Text('Xóa cuộc trò chuyện')),
            ],
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: Column(
          children: [
            const SizedBox(height: 100), // Space for transparent AppBar
            if (chatState.isLoading) const LinearProgressIndicator(),
          if (chatState.error != null) 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(chatState.error!, style: const TextStyle(color: Colors.red)),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message.senderId == currentUserId;
                
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: GestureDetector(
                    onLongPress: () => _showDeleteMenu(message),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: message.type == MessageType.image 
                        ? EdgeInsets.zero 
                        : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: isMe 
                          ? AppColors.chatBubbleMeGradient 
                          : AppColors.chatBubbleAIGradient,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                          bottomLeft: Radius.circular(isMe ? 20 : 4),
                          bottomRight: Radius.circular(isMe ? 4 : 20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: message.type == MessageType.image
                        ? _buildImageMessage(message)
                        : Text(
                            message.content ?? '',
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Bottom section: Status bar + Input field
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Status bar: Pending approval (Only show if I sent a message and they haven't replied yet)
                if (messages.any((m) => m.senderId == currentUserId) && 
                    !messages.any((m) => m.senderId == widget.user.id))
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      border: Border(
                        bottom: BorderSide(color: Colors.black.withOpacity(0.05)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.info_outline, size: 14, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          "Tin nhắn của bạn đang chờ ${widget.user.name} phê duyệt",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12, 
                            color: Colors.black87, 
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // Input Area
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add_circle, color: AppColors.primary),
                          onPressed: _sendImage,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: 'Nhập tin nhắn...',
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onSubmitted: (_) => _sendMessage(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _sendMessage,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.primaryGradient,
                            ),
                            child: const Icon(Icons.send, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
