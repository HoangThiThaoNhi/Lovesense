import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/api_service.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../models/voucher_model.dart';

final voucherProvider = StateNotifierProvider<VoucherNotifier, AsyncValue<List<Voucher>>>((ref) {
  final token = ref.watch(authProvider).token;
  return VoucherNotifier(token);
});

class VoucherNotifier extends StateNotifier<AsyncValue<List<Voucher>>> {
  final String? _token;

  VoucherNotifier(this._token) : super(const AsyncValue.loading()) {
    if (_token != null) {
      fetchVouchers();
    }
  }

  Future<void> fetchVouchers() async {
    if (_token == null) return;
    
    state = const AsyncValue.loading();
    try {
      final response = await ApiService.get('/vouchers/my', token: _token);
      final List<dynamic> data = response;
      final vouchers = data.map((json) => Voucher.fromJson(json)).toList();
      state = AsyncValue.data(vouchers);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
