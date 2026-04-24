import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user_model.dart';
import '../../../core/utils/api_service.dart';

class AuthState {
  final bool isAuthenticated;
  final User? currentUser;
  final bool isLoading;
  final String? error;
  final String? token;

  AuthState({
    this.isAuthenticated = false,
    this.currentUser,
    this.isLoading = false,
    this.error,
    this.token,
  });

  bool get isProfileComplete {
    if (currentUser == null) return false;
    // Profile is complete if display_name has been set
    return currentUser!.name.isNotEmpty;
  }

  AuthState copyWith({
    bool? isAuthenticated,
    User? currentUser,
    bool? isLoading,
    String? error,
    bool clearError = false,
    String? token,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      currentUser: currentUser ?? this.currentUser,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      token: token ?? this.token,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final response = await ApiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      if (response.containsKey('token')) {
        final token = response['token'];
        
        // Fetch profile immediately to determine redirect
        User user;
        try {
          final profileResponse = await ApiService.get('/profile/me', token: token);
          if (profileResponse.containsKey('id') || profileResponse.containsKey('user_id')) {
            user = User.fromJson(profileResponse);
          } else {
            throw 'Invalid profile data';
          }
        } catch (e) {
          // Profile might not exist (404), which is fine for new users
          print('DEBUG: Profile not found or error during login, using empty user: $e');
          user = User(
            id: response['user']['id'].toString(),
            name: '',
            age: 0,
            bio: '',
            job: '',
            imageUrls: [],
            photos: [],
            interests: [],
            distanceKm: 0,
            email: email,
          );
        }

        state = state.copyWith(
          isAuthenticated: true,
          token: token,
          currentUser: user,
          isLoading: false,
          clearError: true,
        );
      } else {
        state = state.copyWith(isLoading: false, error: response['error'] ?? 'Đăng nhập thất bại');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final response = await ApiService.post('/auth/register', {
        'email': email,
        'password': password,
      });

      if (response.containsKey('token')) {
        final token = response['token'];
        
        // For new users, profile won't exist, but we still try to be consistent
        state = state.copyWith(
          isAuthenticated: true,
          token: token,
          currentUser: User(
            id: response['user']['id'].toString(),
            name: '',
            age: 0,
            bio: '',
            job: '',
            imageUrls: [],
            photos: [],
            interests: [],
            distanceKm: 0,
          ),
          isLoading: false,
          clearError: true,
        );
      } else {
        state = state.copyWith(isLoading: false, error: response['error'] ?? 'Đăng ký thất bại');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> fetchProfile() async {
    if (state.token == null) return;
    try {
      final response = await ApiService.get('/profile/me', token: state.token);
      if (response.containsKey('id') || response.containsKey('user_id')) {
        final user = User.fromJson(response);
        state = state.copyWith(currentUser: user);
      }
    } catch (e) {
      // Profile might not exist yet (new registration)
      print('Fetch profile error: $e');
    }
  }

  Future<void> loginWithSocial(String provider) async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false, error: 'Đăng nhập mạng xã hội chưa được hỗ trợ');
  }

  void updateProfile(User user) {
    state = state.copyWith(currentUser: user);
  }

  Future<void> updateAccount({String? email, String? phone}) async {
    if (state.token == null) return;
    try {
      final response = await ApiService.put(
        '/auth/update-account',
        {
          if (email != null) 'email': email,
          if (phone != null) 'phone': phone,
        },
        token: state.token,
      );

      if (response['status'] == 'success') {
        // Cập nhật lại user cục bộ
        if (state.currentUser != null) {
          final updatedUser = state.currentUser!.copyWith(
            email: email ?? state.currentUser!.email,
            phone: phone ?? state.currentUser!.phone,
          );
          state = state.copyWith(currentUser: updatedUser);
        }
      }
    } catch (e) {
      print('Update account error: $e');
      rethrow;
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    if (state.token == null) throw Exception('Vui lòng đăng nhập lại');
    try {
      await ApiService.put(
        '/auth/update-password',
        {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
        token: state.token,
      );
    } catch (e) {
      print('Change password error: $e');
      rethrow;
    }
  }

  void logout() {
    state = AuthState();
  }

  Future<void> deactivateAccount() async {
    if (state.token == null) return;
    try {
      await ApiService.delete('/auth/deactivate', token: state.token);
      logout();
    } catch (e) {
      print('Deactivate account error: $e');
      rethrow;
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
