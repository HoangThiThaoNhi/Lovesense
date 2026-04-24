import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/api_service.dart';
import '../../auth/providers/auth_provider.dart';

final leaderboardProvider = StateNotifierProvider<LeaderboardNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return LeaderboardNotifier(ref);
});

class LeaderboardNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final Ref _ref;
  LeaderboardNotifier(this._ref) : super(const AsyncValue.loading()) {
    loadLeaderboard();
  }

  Future<void> loadLeaderboard() async {
    try {
      state = const AsyncValue.loading();
      final auth = _ref.read(authProvider);
      final token = auth.token;
      if (token == null) return;
      
      final data = await ApiService.get('/gamification/leaderboard', token: token);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
