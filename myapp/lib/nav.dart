import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/splash_screen.dart';
import 'features/profile/screens/profile_setup_screen.dart';
import 'features/swipe/screens/home_swipe_screen.dart';
import 'features/chat/screens/chat_list_screen.dart';
import 'features/chat/screens/chat_detail_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/profile/screens/settings_screen.dart';
import 'features/profile/screens/account_settings_screen.dart';
import 'features/profile/screens/support_screen.dart';
import 'features/profile/screens/legal_screen.dart';
import 'features/profile/screens/user_detail_screen.dart';
import 'features/auth/screens/ai_onboarding_screen.dart';
import 'features/swipe/screens/survey_screen.dart';
import 'features/chat/screens/ai_consultant_screen.dart';
import 'features/chat/providers/ai_provider.dart';
import 'features/profile/screens/gamification_screen.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/notification/screens/notification_screen.dart';
import 'theme.dart';
import 'models/user_model.dart';
import 'features/match/providers/match_provider.dart';
import 'features/swipe/screens/dna_quiz_screen.dart';
import 'features/swipe/screens/dna_report_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Bottom Navigation Scaffold
final hasSeenMatchesProvider = StateProvider<bool>((ref) => false);

class ScaffoldWithNavBar extends ConsumerWidget {
  final Widget child;

  const ScaffoldWithNavBar({required this.child, super.key});

  static const List<String> _routes = ['/home', '/matches', '/gamification', '/profile'];

  int _indexFromLocation(String location) {
    if (location.startsWith('/matches')) return 1;
    if (location.startsWith('/gamification')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context, WidgetRef ref) {
    if (index == 1) {
      ref.read(hasSeenMatchesProvider.notifier).state = true;
    }
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _indexFromLocation(location);
    
    final matchState = ref.watch(matchProvider);
    final currentUserId = ref.watch(authProvider).currentUser?.id;
    final hasSeenMatches = ref.watch(hasSeenMatchesProvider);

    int unreadCount = 0;
    if (currentUserId != null) {
      unreadCount = matchState.matches.where((m) {
        if (m.lastMessage == null) return false;
        // Count unread messages where I am not the sender
        return m.lastMessage!.senderId != currentUserId && m.lastMessage!.isRead == false;
      }).length;
    }

    // Reset hasSeenMatches if unreadCount becomes 0 (all read)
    // or if a NEW message arrives (we'd need a more complex listener for that, 
    // but for now, let's keep it simple: if unreadCount > 0 and we haven't seen it yet)

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: Icons.explore_rounded,
                  label: 'Khám phá',
                  isSelected: currentIndex == 0,
                  onTap: () => _onItemTapped(0, context, ref),
                ),
                _NavBarItem(
                  icon: Icons.forum_rounded,
                  label: 'Tin nhắn',
                  isSelected: currentIndex == 1,
                  showBadge: unreadCount > 0 && hasSeenMatches == false,
                  onTap: () => _onItemTapped(1, context, ref),
                ),
                _NavBarItem(
                  icon: Icons.workspace_premium_rounded,
                  label: 'Thành tích',
                  isSelected: currentIndex == 2,
                  onTap: () => _onItemTapped(2, context, ref),
                ),
                _NavBarItem(
                  icon: Icons.account_circle_rounded,
                  label: 'Hồ sơ',
                  isSelected: currentIndex == 3,
                  onTap: () => _onItemTapped(3, context, ref),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool showBadge;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.showBadge = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : Colors.grey;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon, 
                  color: color, 
                  size: 28,
                  shadows: isSelected ? [
                    Shadow(
                      color: color.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ] : null,
                ),
                if (showBadge)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ).animate(target: isSelected ? 1 : 0).slideY(begin: 0, end: -0.1, duration: 200.ms),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn().slideY(begin: 0.2, end: 0),
            ],
          ],
        ),
      ).animate(target: isSelected ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 200.ms),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = ValueNotifier<bool>(false);
  
  ref.listen<AuthState>(authProvider, (previous, next) {
    if (previous?.isAuthenticated == true && next.isAuthenticated == false) {
      ref.read(aiProvider.notifier).reset();
    }
    // Notify router to re-evaluate redirect
    listenable.value = !listenable.value;
  });

  print('Router initialized/reloaded');

  return GoRouter(
    refreshListenable: listenable,
    initialLocation: '/splash',
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.isAuthenticated;
      final isProfileComplete = authState.isProfileComplete;
      final isLoggingIn = state.uri.toString() == '/login';
      final isSplash = state.uri.toString() == '/splash';
      final isAI = state.uri.toString().startsWith('/ai-consultant');
      final isDNA = state.uri.toString().startsWith('/dna-quiz');
      final isSettingUp = state.uri.toString() == '/profile-setup' || state.uri.toString() == '/ai-onboarding' || isAI || isDNA;

      if (!isLoggedIn) {
        return (isLoggingIn || isSplash) ? null : '/splash';
      }
      
      // Logged in cases
      if (isSplash || isLoggingIn) return '/home';

      // Allow access to home even if profile is incomplete
      // Users will be prompted within the Discovery screen instead

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => '/splash',
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: '/ai-onboarding',
        name: 'ai_interview',
        builder: (context, state) => const AIOnboardingScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(child: HomeSwipeScreen()),
          ),
          GoRoute(
            path: '/matches',
            pageBuilder: (context, state) => const NoTransitionPage(child: ChatListScreen()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => const NoTransitionPage(child: ProfileScreen()),
          ),
          GoRoute(
            path: '/notifications',
            name: 'notifications',
            builder: (context, state) => const NotificationScreen(),
          ),
          GoRoute(
            path: '/gamification',
            pageBuilder: (context, state) => const NoTransitionPage(child: GamificationScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/chat/:matchId',
        builder: (context, state) {
           final matchId = state.pathParameters['matchId']!;
           final user = state.extra as User;
           return ChatDetailScreen(matchId: matchId, user: user);
        },
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: 'account',
            name: 'settings_account',
            builder: (context, state) => const AccountSettingsScreen(),
          ),
          GoRoute(
            path: 'support',
            name: 'settings_support',
            builder: (context, state) => const SupportScreen(),
          ),
          GoRoute(
            path: 'terms',
            name: 'settings_terms',
            builder: (context, state) => LegalScreen.terms(),
          ),
          GoRoute(
            path: 'privacy',
            name: 'settings_privacy',
            builder: (context, state) => LegalScreen.privacy(),
          ),
          GoRoute(
            path: 'license',
            name: 'settings_license',
            builder: (context, state) => LegalScreen.license(),
          ),
        ],
      ),
      GoRoute(
        path: '/user-detail',
        name: 'user_detail',
        builder: (context, state) {
          final user = state.extra as User;
          return UserDetailScreen(user: user);
        },
      ),
      GoRoute(
        path: '/ai-consultant',
        name: 'ai_consultant',
        builder: (context, state) => const AIConsultantScreen(),
      ),
      GoRoute(
        path: '/survey',
        name: 'survey',
        builder: (context, state) => const SurveyScreen(),
      ),
      GoRoute(
        path: '/dna-quiz',
        name: 'dna-quiz',
        builder: (context, state) => const DNAQuizScreen(),
      ),
      GoRoute(
        path: '/dna-report',
        name: 'dna-report',
        builder: (context, state) => const DNAReportScreen(),
      ),
    ],
  );
});