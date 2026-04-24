import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/gamification_model.dart';
import '../../../core/utils/api_service.dart';
import '../../auth/providers/auth_provider.dart';

final gamificationProvider = StateNotifierProvider<GamificationNotifier, AsyncValue<GamificationStatus>>((ref) {
  return GamificationNotifier(ref);
});

class GamificationNotifier extends StateNotifier<AsyncValue<GamificationStatus>> {
  final Ref _ref;
  GamificationNotifier(this._ref) : super(const AsyncLoading()) {
    loadStatus();
  }

  Future<void> loadStatus() async {
    // Only block if we are already fetching data to avoid duplicate requests
    // but allow the initial load to proceed.

    try {
      final auth = _ref.read(authProvider);
      final token = auth.token;
      if (token == null) {
        state = AsyncData(GamificationStatus.empty());
        return;
      }
      
      // If we don't have data yet, show loading
      if (!state.hasValue) {
        state = const AsyncLoading();
      }

      final data = await ApiService.get('/gamification/status', token: token);
      state = AsyncData(GamificationStatus.fromJson(data));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final lastSeenVoucherCountProvider = StateProvider<int>((ref) => 0);
