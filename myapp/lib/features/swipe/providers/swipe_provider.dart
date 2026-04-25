import 'package:geolocator/geolocator.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/utils/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user_model.dart';
import '../../../models/gamification_model.dart';

class DiscoveryFilter {
  final double minAge;
  final double maxAge;
  final double maxDistance;
  final bool useInterests;

  DiscoveryFilter({
    this.minAge = 18,
    this.maxAge = 100,
    this.maxDistance = 20000,
    this.useInterests = false,
  });

  DiscoveryFilter copyWith({
    double? minAge,
    double? maxAge,
    double? maxDistance,
    bool? useInterests,
  }) {
    return DiscoveryFilter(
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      maxDistance: maxDistance ?? this.maxDistance,
      useInterests: useInterests ?? this.useInterests,
    );
  }

  Map<String, String> toQueryParams() {
    final params = {
      'minAge': minAge.toInt().toString(),
      'maxAge': maxAge.toInt().toString(),
      'maxDistance': maxDistance.toInt().toString(),
      'useInterests': useInterests.toString(),
    };
    return params;
  }
}

class SwipeState {
  final List<User> users;
  final List<User> likedUsers;
  final List<User> nopedUsers;
  final bool isLoading;
  final String? error;
  final int consecutiveNopeCount;
  final bool showAISuggestion;
  final String aiSuggestionMessage;
  final DiscoveryFilter filter;

  SwipeState({
    this.users = const [],
    this.likedUsers = const [],
    this.nopedUsers = const [],
    this.isLoading = false,
    this.error,
    this.consecutiveNopeCount = 0,
    this.showAISuggestion = false,
    this.aiSuggestionMessage = '',
    DiscoveryFilter? filter,
  }) : filter = filter ?? DiscoveryFilter();

  SwipeState copyWith({
    List<User>? users,
    List<User>? likedUsers,
    List<User>? nopedUsers,
    bool? isLoading,
    String? error,
    int? consecutiveNopeCount,
    bool? showAISuggestion,
    String? aiSuggestionMessage,
    DiscoveryFilter? filter,
  }) {
    return SwipeState(
      users: users ?? this.users,
      likedUsers: likedUsers ?? this.likedUsers,
      nopedUsers: nopedUsers ?? this.nopedUsers,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      consecutiveNopeCount: consecutiveNopeCount ?? this.consecutiveNopeCount,
      showAISuggestion: showAISuggestion ?? this.showAISuggestion,
      aiSuggestionMessage: aiSuggestionMessage ?? this.aiSuggestionMessage,
      filter: filter ?? this.filter,
    );
  }
}


class SwipeNotifier extends StateNotifier<SwipeState> {
  final Ref _ref;

  SwipeNotifier(this._ref) : super(SwipeState()) {
    fetchDiscovery();
  }

  Future<void> fetchDiscovery({bool silent = false}) async {
    if (state.isLoading && !silent) return;
    
    if (!silent) {
      state = state.copyWith(isLoading: true, error: null);
    }
    try {
      final token = _ref.read(authProvider).token;
      
      // Lấy vị trí hiện tại để gửi lên server (giúp tính khoảng cách chính xác)
      double? currentLat;
      double? currentLng;
      
      try {
        final user = _ref.read(authProvider).currentUser;
        if (user?.lat != null && user?.lng != null) {
          currentLat = user!.lat;
          currentLng = user!.lng;
        } else {
          bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
          LocationPermission permission = await Geolocator.checkPermission();
          
          if (serviceEnabled && (permission == LocationPermission.always || permission == LocationPermission.whileInUse)) {
            final position = await Geolocator.getCurrentPosition();
            currentLat = position.latitude;
            currentLng = position.longitude;
          }
        }
      } catch (e) {
        print('Location fetch error for discovery: $e');
      }

      final queryParams = state.filter.toQueryParams();
      queryParams['useInterests'] = 'true';
      if (currentLat != null && currentLng != null) {
        queryParams['lat'] = currentLat.toString();
        queryParams['lng'] = currentLng.toString();
      }

      final responseBody = await ApiService.get(
        '/swipes/discovery', 
        token: token,
        queryParams: queryParams,
      );
      
      if (responseBody is List) {
        final List<User> fetchedUsers = (responseBody as List).map<User>((u) {
          return User.fromJson(u as Map<String, dynamic>);
        }).toList();

        state = state.copyWith(
          users: fetchedUsers, 
          isLoading: false,
          error: fetchedUsers.isEmpty ? 'Không tìm thấy hồ sơ nào phù hợp' : null,
        );
      } else {
        state = state.copyWith(isLoading: false, error: 'Dữ liệu không hợp lệ');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void updateFilters(DiscoveryFilter filter) {
    state = state.copyWith(filter: filter);
    fetchDiscovery();
  }

  void resetFilters() {
    state = state.copyWith(filter: DiscoveryFilter());
    fetchDiscovery();
  }

  Future<bool> likeUser(User user) async {
    final token = _ref.read(authProvider).token;
    
    // Optimistic update
    state = state.copyWith(
      likedUsers: [...state.likedUsers, user],
      users: state.users.where((u) => u.id != user.id).toList(),
    );

    try {
      final response = await ApiService.post('/swipes', {
        'swipedId': user.id,
        'type': 'like',
      }, token: token);
      
      return response['isMatch'] ?? false;
    } catch (e) {
      print('Like Error: $e');
      return false;
    }
  }

  Future<bool> superLikeUser(User user) async {
    final token = _ref.read(authProvider).token;
    
    // Optimistic update
    state = state.copyWith(
      likedUsers: [...state.likedUsers, user],
      users: state.users.where((u) => u.id != user.id).toList(),
    );

    try {
      final response = await ApiService.post('/swipes', {
        'swipedId': user.id,
        'type': 'superlike',
      }, token: token);
      
      return response['isMatch'] ?? false;
    } catch (e) {
      print('Super Like Error: $e');
      return false;
    }
  }

  Future<void> nopeUser(User user) async {
    final token = _ref.read(authProvider).token;
    
    state = state.copyWith(
      nopedUsers: [...state.nopedUsers, user],
      users: state.users.where((u) => u.id != user.id).toList(),
    );

    try {
      await ApiService.post('/swipes', {
        'swipedId': user.id,
        'type': 'nope',
      }, token: token);
      
      final newCount = state.consecutiveNopeCount + 1;
      
      // AI milestone messages - triggered at specific nope counts
      const milestones = {
        5: 'Lướt hoài không thấy ưng? Để AI DNA Soulmate giúp bạn tìm nửa kia nha! 😉',
        10: 'Ê ê, 10 cái rồi đó! Hay thử để AI "giải mã DNA" xem sao? 🧬💕',
        15: 'Khó tính dữ ha! DNA AI có thể tìm người tương đồng 99% đó! 😏',
        25: 'Bạn ơi tay mỏi chưa? 😅 Để AI DNA Soulmate tìm "chân ái" cho nè!',
        35: 'Huyền thoại quẹt trái! 🏆 Thử DNA AI để đổi vận xem sao?',
      };
      
      final message = milestones[newCount];
      state = state.copyWith(
        consecutiveNopeCount: newCount,
        showAISuggestion: message != null,
        aiSuggestionMessage: message ?? state.aiSuggestionMessage,
      );
    } catch (e) {
      print('Nope Error: $e');
    }
  }

  Future<Map<String, dynamic>> saveSurveyResults(List<dynamic> answers) async {
    state = state.copyWith(isLoading: true);
    try {
      final token = _ref.read(authProvider).token;
      final response = await ApiService.post('/swipes/survey', {'answers': answers}, token: token);

      // Extract points awarded from backend response (Check both gamification and points_added fallback)
      final pointsAwarded = response['gamification']?['pointsAwarded'] as int? ?? response['points_added'] as int? ?? 0;
      final aiAnalysis = response['ai_analysis'];

      // After saving, reset count and refresh discovery to get prioritized list
      state = state.copyWith(isLoading: false, consecutiveNopeCount: 0, showAISuggestion: false);
      await fetchDiscovery();
      
      // Parse newly earned badges if any
      final List<dynamic> newBadgesRaw = response['gamification']?['newlyEarnedBadges'] ?? [];
      final List<BadgeModel> newlyEarnedBadges = newBadgesRaw.map((b) => BadgeModel.fromJson(b)).toList();

      return {
        'points': pointsAwarded,
        'ai_analysis': aiAnalysis,
        'new_badges': newlyEarnedBadges,
      };
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return {'points': 0, 'ai_analysis': null};
    }
  }
  
  void loadAIRecommendations(List<User> recommendedUsers) {
    state = state.copyWith(users: recommendedUsers, isLoading: false);
  }

  void reset() {
    state = state.copyWith(consecutiveNopeCount: 0, showAISuggestion: false);
    fetchDiscovery();
  }

  Future<void> resetSwipes() async {
    state = state.copyWith(isLoading: true);
    try {
      final token = _ref.read(authProvider).token;
      await ApiService.post('/swipes/reset', {}, token: token);
      state = state.copyWith(consecutiveNopeCount: 0, showAISuggestion: false);
      await fetchDiscovery();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void hideAISuggestion() {
    state = state.copyWith(showAISuggestion: false);
  }
}

extension NumX on num {
  int skip(int n) => this ~/ 1000; // Simplified for km conversion
}

final swipeProvider = StateNotifierProvider<SwipeNotifier, SwipeState>((ref) {
  return SwipeNotifier(ref);
});