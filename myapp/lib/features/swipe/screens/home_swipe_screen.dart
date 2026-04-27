import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import '../../../shared_widgets/profile_card.dart';
import '../../../shared_widgets/glass_container.dart';
import '../../swipe/providers/swipe_provider.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../../match/screens/match_dialog.dart';
import '../../../theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/toast_utils.dart';
import '../../notification/providers/notification_provider.dart';
import '../../auth/providers/auth_provider.dart';

class HomeSwipeScreen extends ConsumerStatefulWidget {
  const HomeSwipeScreen({super.key});

  @override
  ConsumerState<HomeSwipeScreen> createState() => _HomeSwipeScreenState();
}

class _HomeSwipeScreenState extends ConsumerState<HomeSwipeScreen> {
  final CardSwiperController _controller = CardSwiperController();
  Timer? _hideTimer;
  int _currentIndex = 0;
  double? _botX;
  double? _botY;
  bool _botDragging = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listenManual(swipeProvider.select((s) => s.users), (prev, next) {
        if (mounted) setState(() => _currentIndex = 0);
      });
      ref.listenManual(swipeProvider.select((s) => s.showAISuggestion), (prev, next) {
        if (next == true) _startAutoHide();
      });
      
      // Auto-fetch if users are empty on startup
      if (ref.read(swipeProvider).users.isEmpty) {
        ref.read(swipeProvider.notifier).fetchDiscovery(silent: true);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_botX == null) {
      final size = MediaQuery.of(context).size;
      _botX = size.width - 146;
      _botY = size.height - 230;
    }
  }

  void _startAutoHide() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) ref.read(swipeProvider.notifier).hideAISuggestion();
    });
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    final swipeState = ref.read(swipeProvider);
    final users = swipeState.users;
    if (previousIndex >= users.length) return true;
    final user = users[previousIndex];

    // Handle async logic in background
    if (direction == CardSwiperDirection.right) {
      ref.read(swipeProvider.notifier).likeUser(user).then((isMatch) {
        if (isMatch && mounted) {
          showDialog(
            context: context,
            builder: (context) => MatchDialog(matchedUser: user),
          );
        }
      });
    } else if (direction == CardSwiperDirection.left) {
      ref.read(swipeProvider.notifier).nopeUser(user);
    } else if (direction == CardSwiperDirection.top) {
      ref.read(swipeProvider.notifier).superLikeUser(user).then((isMatch) {
        if (isMatch && mounted) {
          showDialog(
            context: context,
            builder: (context) => MatchDialog(matchedUser: user),
          );
        }
      });
    }

    if (mounted) {
      setState(() => _currentIndex = currentIndex ?? _currentIndex + 1);
    }
    return true;
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final swipeState = ref.watch(swipeProvider);
    final users = swipeState.users;
    final isProfileComplete = ref.watch(authProvider).isProfileComplete;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.mainGradient,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/new_double_heart_3d.png',
                        width: 44,
                        height: 44,
                        fit: BoxFit.contain,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) => const DiscoveryFilterBottomSheet(),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.tune, color: AppColors.primary, size: 20),
                            const SizedBox(width: 8),
                            Builder(
                              builder: (context) {
                                final filter = ref.watch(swipeProvider).filter;
                                final hasFilter = filter.minAge != 18 ||
                                    filter.maxAge != 100 ||
                                    filter.maxDistance != 20000 ||
                                    filter.useInterests != false;
                                return Text(
                                  hasFilter ? 'Đang áp dụng bộ lọc' : 'Bộ lọc',
                                  style: AppTextStyles.titleLarge.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 18,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push('/notifications'),
                        child: GlassContainer(
                          padding: const EdgeInsets.all(8),
                          child: Badge(
                            label: Text(
                              ref.watch(notificationProvider).unreadCount.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            isLabelVisible: ref.watch(notificationProvider).unreadCount > 0,
                            backgroundColor: AppColors.primary,
                            child: const Icon(Icons.notifications, color: AppColors.secondary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // DNA Mode Selection is now inside Filter Bottom Sheet
                const SizedBox(height: 12),

                // Card Swiper
                Expanded(
                  child: !isProfileComplete 
                    ? _buildIncompleteProfilePrompt()
                    : RefreshIndicator(
                    onRefresh: () => ref.read(swipeProvider.notifier).fetchDiscovery(),
                    child: swipeState.isLoading && users.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : users.isEmpty
                            ? _buildEmptyDiscoveryState(
                                swipeState.filter.minAge != 18 || swipeState.filter.maxAge != 100 || swipeState.filter.maxDistance != 20000 || swipeState.filter.useInterests != false
                              )
                            : CardSwiper(
                          key: ValueKey(users.map((u) => u.id).join(',')),
                          controller: _controller,
                          cardsCount: users.length,
                          onSwipe: _onSwipe,
                          numberOfCardsDisplayed: users.length < 3 ? users.length : 3,
                          backCardOffset: const Offset(0, 40),
                          padding: const EdgeInsets.all(24.0),
                          cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                            if (index >= users.length) return const SizedBox.shrink();
                            return GestureDetector(
                              onTap: () => context.pushNamed('user_detail', extra: users[index]),
                              child: ProfileCard(user: users[index]),
                            );
                          },
                        ),
                  ),
                ),

                // Action Buttons
                if (users.isNotEmpty && isProfileComplete)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ActionButton(
                          icon: Icons.close,
                          color: AppColors.error,
                          onTap: () => _controller.swipe(CardSwiperDirection.left),
                        ),
                        const SizedBox(width: 20),
                        _ActionButton(
                          icon: Icons.star,
                          color: Colors.blue,
                          size: 50,
                          iconSize: 30,
                          onTap: () => _controller.swipe(CardSwiperDirection.top),
                        ),
                        const SizedBox(width: 20),
                        _ActionButton(
                          icon: Icons.favorite,
                          color: AppColors.success,
                          onTap: () => _controller.swipe(CardSwiperDirection.right),
                        ),
                      ],
                    ),
                  ).animate().scale(delay: 300.ms),
              ],
            ),
          ),

          // AI suggestion bubble
          if (swipeState.showAISuggestion == true) _buildAISuggestionBubble(context),

          // Draggable AI Bot
          if (_botX != null && _botY != null) _buildDraggableBot(context),
        ],
      ),
    );
  }

  Widget _buildDraggableBot(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double botSize = 75.0;

    return Positioned(
      left: _botX,
      top: _botY,
      child: GestureDetector(
        onTap: () => _showAIBotOptions(context),
        onPanStart: (_) => setState(() => _botDragging = true),
        onPanUpdate: (details) {
          setState(() {
            _botX = ((_botX ?? 0) + details.delta.dx).clamp(0.0, size.width - botSize);
            _botY = ((_botY ?? 0) + details.delta.dy).clamp(0.0, size.height - botSize - 40);
          });
        },
        onPanEnd: (_) => setState(() => _botDragging = false),
        child: AnimatedScale(
          scale: _botDragging ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: SizedBox(
            width: botSize,
            height: botSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // White circle background with thick border
                Container(
                  width: botSize,
                  height: botSize,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                // Floating shadow under bot
                Positioned(
                  bottom: 6,
                  child: Container(
                    width: 35,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ).animate(onPlay: (c) {
                    c.repeat(reverse: true);
                  })
                   .scale(
                     begin: const Offset(1, 1),
                     end: const Offset(0.6, 0.6),
                     duration: 2.seconds,
                     curve: Curves.easeInOutSine,
                   ),
                ),
                // Bot image (Pop-out effect)
                Image.asset(
                  'assets/images/bot_3d.png',
                  width: botSize * 1.15,
                  height: botSize * 1.15,
                  fit: BoxFit.contain,
                ).animate(onPlay: (c) {
                  c.repeat(reverse: true);
                })
                 .moveY(begin: -5, end: 5, duration: 2.seconds, curve: Curves.easeInOutSine)
                 .rotate(begin: -0.05, end: 0.05, duration: 2.5.seconds, curve: Curves.easeInOutSine),
              ],
            ),
          ).animate(onPlay: (c) {
            c.repeat(reverse: true);
          })
           .scale(
             begin: const Offset(0.97, 0.97),
             end: const Offset(1.03, 1.03),
             duration: 2.seconds,
             curve: Curves.easeInOutSine,
           ),
        ),
      ),
    );
  }

  Widget _buildAISuggestionBubble(BuildContext context) {
    if (_botX == null || _botY == null) return const SizedBox.shrink();

    // Calculate position to be above the bot
    // We want the bubble to be shifted to the left of the bot if the bot is on the right side
    final bubbleWidth = 260.0;
    final isRightSide = _botX! > MediaQuery.of(context).size.width / 2;

    return Positioned(
      left: isRightSide ? _botX! - bubbleWidth + 60 : _botX! + 20,
      top: _botY! - 110,
      child: GestureDetector(
        onTap: () {
          ref.read(swipeProvider.notifier).hideAISuggestion();
          context.pushNamed('dna-quiz');
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              alignment: isRightSide ? Alignment.bottomRight : Alignment.bottomLeft,
              child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
            );
          },
          child: Column(
            crossAxisAlignment: isRightSide ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: bubbleWidth),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.95),
                      Colors.white.withOpacity(0.9),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: isRightSide ? const Radius.circular(20) : const Radius.circular(4),
                    bottomRight: isRightSide ? const Radius.circular(4) : const Radius.circular(20),
                  ),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.auto_awesome, color: AppColors.primary, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            ref.watch(swipeProvider).aiSuggestionMessage,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Giải mã AI DNA Soulmate ngay!',
                            style: TextStyle(color: Colors.grey[600], fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 14, color: Colors.grey),
                      onPressed: () => ref.read(swipeProvider.notifier).hideAISuggestion(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: isRightSide ? 15 : 0,
                  left: isRightSide ? 0 : 15,
                ),
                child: CustomPaint(
                  painter: _TrianglePainter(
                    color: Colors.white.withOpacity(0.9),
                    isRight: isRightSide,
                  ),
                  size: const Size(12, 10),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  void _showAIBotOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Chọn trợ lý AI của bạn",
              style: AppTextStyles.headlineSmall.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Hãy chọn dịch vụ AI bạn muốn trải nghiệm ngay bây giờ",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _AIOptionCard(
              title: "Phân tích AI DNA Soulmate",
              description: "Giải mã DNA tình yêu của bạn để tìm đối tượng tương đồng 99% về lối sống và tư duy.",
              icon: Icons.biotech_outlined,
              color: Colors.purple,
              onTap: () {
                final parentContext = context;
                Navigator.pop(context);
                parentContext.pushNamed('dna-quiz');
              },
            ),
            const SizedBox(height: 16),
            _AIOptionCard(
              title: "Chat tự do tư vấn tình cảm",
              description: "Tư vấn mọi vấn đề từ cách bắt chuyện, nhắn tin đến giữ lửa tình yêu.",
              icon: Icons.chat_bubble_outline_rounded,
              color: AppColors.secondary,
              onTap: () {
                final parentContext = context;
                Navigator.pop(context);
                parentContext.pushNamed('ai_consultant');
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildIncompleteProfilePrompt() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_add_rounded, size: 80, color: Colors.white),
          ).animate(onPlay: (c) => c.repeat(reverse: true))
           .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2.seconds, curve: Curves.easeInOut),
          const SizedBox(height: 32),
          Text(
            'Hồ sơ của bạn còn trống',
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'Nhập thông tin hồ sơ cá nhân để tìm đối tượng phù hợp và để AI có thể hiểu bạn hơn nhé! ✨',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () => context.push('/profile-setup'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.3),
            ),
            child: const Text(
              "Hoàn tất hồ sơ ngay", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }
  Widget _buildEmptyDiscoveryState(bool hasFilter) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.6),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        alignment: Alignment.center,
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.explore_off_rounded,
                  size: 56,
                  color: Colors.white,
                ),
              ).animate().shake(duration: 1.seconds).scale(duration: 600.ms, curve: Curves.easeOutBack),
              const SizedBox(height: 20),
              const Text(
                'Bạn đã xem hết người dùng!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 22, 
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Đừng nản lòng. Bạn có thể làm bài test DNA để AI tìm kiếm những 'mảnh ghép' hoàn hảo nhất ẩn sâu trong hệ thống, hoặc tải thêm người dùng mới.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14, height: 1.4),
              ),
              const SizedBox(height: 28),
              
              // Suggestion Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/dna-quiz'),
                  icon: const Icon(Icons.auto_awesome, size: 20),
                  label: const Text("Làm DNA Test ngay", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 5,
                  ),
                ).animate().fadeIn(delay: 200.ms).moveY(begin: 20, end: 0),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Always fetch new users when clicking this button
                    ref.read(swipeProvider.notifier).fetchDiscovery();
                    // Show a quick toast to indicate action
                    ToastUtils.showModernToast(context, 'Đang tìm kiếm thêm...', type: ToastType.info);
                  },
                  icon: const Icon(Icons.person_search_rounded, size: 20),
                  label: const Text(
                    "Tải thêm người dùng", 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white70, width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ).animate().fadeIn(delay: 400.ms).moveY(begin: 20, end: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  final bool isRight;
  _TrianglePainter({required this.color, this.isRight = true});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    if (isRight) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(0, size.height);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double size;
  final double iconSize;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.size = 64,
    this.iconSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: iconSize),
      ),
    );
  }
}

class _AIOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AIOptionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('AI Option Selected: $title');
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: color.withOpacity(0.5), size: 16),
          ],
        ),
      ),
    );
  }
}
