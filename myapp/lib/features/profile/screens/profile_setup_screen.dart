import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/user_model.dart';
import '../../../shared_widgets/gradient_button.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../theme.dart';
import '../../../core/utils/api_service.dart';
import '../../../core/utils/cloudinary_service.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/utils/toast_utils.dart';

class PhotoItem {
  final String? id;
  final String? url;
  final XFile? localFile;

  PhotoItem({this.id, this.url, this.localFile});

  bool get isRemote => url != null;
  bool get isLocal => localFile != null;
}

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _livingController = TextEditingController();
  
  String _purpose = '';
  String _gender = '';
  String _lookingFor = '';

  final List<String> _selectedInterests = [];
  final List<String> _customInterests = [];
  final List<PhotoItem> _photos = [];
  final List<String> _deletedPhotoIds = [];
  final ImagePicker _picker = ImagePicker();

  final List<String> _availableInterests = [
    'Âm nhạc', 'Du lịch', 'Ẩm thực', 'Phim ảnh', 'Nghệ thuật', 'Công nghệ', 
    'Thể hình', 'Sách', 'Chơi game', 'Thiên nhiên', 'Thú cưng', 'Thời trang'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(authProvider).currentUser;
      if (user != null) {
        setState(() {
          _nameController.text = user.name;
          _bioController.text = user.bio;
          _ageController.text = (user.age > 0) ? user.age.toString() : '';
          _jobController.text = user.job;
          _heightController.text = user.height != null ? user.height.toString() : '';
          _livingController.text = user.livingAt ?? '';
          _purpose = user.purpose ?? '';
          _gender = user.gender;
          _lookingFor = user.lookingFor.isNotEmpty ? user.lookingFor.first : '';
          
          if (user.interests.isNotEmpty) {
            _selectedInterests.addAll(user.interests);
            // Identify custom interests
            for (var interest in user.interests) {
              if (!_availableInterests.contains(interest)) {
                _customInterests.add(interest);
              }
            }
          }

          // Load existing photos
          for (var p in user.photos) {
            _photos.add(PhotoItem(
              id: p['id']?.toString(),
              url: p['image_url']?.toString(),
            ));
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    _jobController.dispose();
    _heightController.dispose();
    _livingController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_photos.length >= 6) return;
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          _photos.add(PhotoItem(localFile: image));
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _removePhoto(int index) {
    setState(() {
      final photo = _photos[index];
      if (photo.isRemote && photo.id != null) {
        _deletedPhotoIds.add(photo.id!);
      }
      _photos.removeAt(index);
    });
  }

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        if (_selectedInterests.length < 5) {
          _selectedInterests.add(interest);
        } else {
          ToastUtils.showModernToast(context, 'Chỉ chọn tối đa 5 sở thích', type: ToastType.warning);
        }
      }
    });
  }

  void _showAddInterestDialog() {
    final TextEditingController customController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Sở thích mới', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Thêm sở thích riêng của bạn (tối đa 3 từ)', style: TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 16),
            TextField(
              controller: customController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'VD: Chụp ảnh phim, Leo núi...',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              maxLength: 25,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Hủy', style: TextStyle(color: Colors.grey[600])),
          ),
          TextButton(
            onPressed: () {
              final text = customController.text.trim();
              if (text.isEmpty) return;
              
              // Validate word count (max 3 words)
              final words = text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
              if (words.length > 3) {
                 ToastUtils.showModernToast(context, 'Sở thích không quá 3 từ', type: ToastType.warning);
                 return;
              }

              if (_availableInterests.contains(text) || _customInterests.contains(text)) {
                 ToastUtils.showModernToast(context, 'Sở thích này đã có rồi', type: ToastType.warning);
                 return;
              }

              setState(() {
                _customInterests.add(text);
                _toggleInterest(text);
              });
              Navigator.pop(ctx);
            },
            child: const Text('Thêm', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<Position?> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    
    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    if (_photos.isEmpty) {
       ToastUtils.showModernToast(context, 'Vui lòng thêm ít nhất 1 ảnh', type: ToastType.warning);
       return;
    }
    if (_gender.isEmpty) {
       ToastUtils.showModernToast(context, 'Vui lòng chọn giới tính', type: ToastType.warning);
       return;
    }

    final token = ref.read(authProvider).token;
    if (token == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // 1. Delete marked photos
      for (var id in _deletedPhotoIds) {
        await ApiService.delete('/profile/photos/$id', token: token);
      }

      // 2. Upload new local photos
      List<String> newUrls = [];
      for (var photo in _photos) {
        if (photo.isLocal) {
          final url = await CloudinaryService.uploadImage(photo.localFile!.path, token);
          if (url != null) newUrls.add(url);
        }
      }

      if (newUrls.isNotEmpty) {
        await ApiService.post('/profile/photo-urls', {'urls': newUrls}, token: token);
      }

      // 3. XP Calculation
      final oldUser = ref.read(authProvider).currentUser;
      int xpGained = 0;
      
      // Photo XP: +10 for first, +5 for others
      final oldPhotoCount = oldUser?.photos.length ?? 0;
      final newPhotoCount = _photos.length;
      if (oldPhotoCount == 0 && newPhotoCount > 0) {
        xpGained += 10;
        if (newPhotoCount > 1) xpGained += (newPhotoCount - 1) * 5;
      } else if (newPhotoCount > oldPhotoCount) {
        xpGained += (newPhotoCount - oldPhotoCount) * 5;
      }

      // Field XP: +10 for each newly filled field
      void checkXP(dynamic oldVal, dynamic newVal) {
        bool wasEmpty = (oldVal == null || (oldVal is String && oldVal.isEmpty) || (oldVal is List && oldVal.isEmpty) || (oldVal == 0));
        bool isNotEmpty = (newVal != null && ((newVal is String && newVal.isNotEmpty) || (newVal is List && newVal.isNotEmpty) || (newVal is num && newVal > 0)));
        if (wasEmpty && isNotEmpty) xpGained += 10;
      }

      checkXP(oldUser?.name, _nameController.text.trim());
      checkXP(oldUser?.age, int.tryParse(_ageController.text));
      checkXP(oldUser?.job, _jobController.text.trim());
      checkXP(oldUser?.bio, _bioController.text.trim());
      checkXP(oldUser?.interests, _selectedInterests);
      checkXP(oldUser?.height, int.tryParse(_heightController.text));
      checkXP(oldUser?.purpose, _purpose);
      checkXP(oldUser?.livingAt, _livingController.text.trim());
      checkXP(null, _gender); // assuming always counts if set now
      checkXP(oldUser?.lookingFor, _lookingFor.isEmpty ? [] : [_lookingFor]);

      // 4. Update profile info
      final position = await _handleLocationPermission();
      final lat = position?.latitude ?? 10.762622;
      final lng = position?.longitude ?? 106.660172;

      await ApiService.post('/profile/update', {
        'display_name': _nameController.text.trim(),
        'age': int.tryParse(_ageController.text.trim()) ?? 18,
        'gender': _gender,
        'occupation': _jobController.text.trim(),
        'bio': _bioController.text.trim(),
        'interests': _selectedInterests,
        'height': int.tryParse(_heightController.text.trim()),
        'purpose': _purpose,
        'living_at': _livingController.text.trim(),
        'looking_for': _lookingFor,
        'lat': lat,
        'lng': lng,
      }, token: token);

      // 5. Award XP in backend
      if (xpGained > 0) {
        try {
          await ApiService.post('/gamification/award', {
            'points': xpGained,
            'action': 'Hoàn thành thông tin hồ sơ',
          }, token: token);
        } catch (e) {
          debugPrint('Gamification award failed: $e');
        }
      }

      // 6. Refresh profile
      final wasComplete = ref.read(authProvider).isProfileComplete;
      final updatedProfile = await ApiService.get('/profile/me', token: token);
      final user = User.fromJson(updatedProfile);
      ref.read(authProvider.notifier).updateProfile(user);

      if (mounted) {
        Navigator.pop(context); // Close loading
        
        if (wasComplete) {
          ToastUtils.showModernToast(context, 'Cập nhật thành công! +$xpGained XP', type: ToastType.success);
          context.pop();
        } else {
          // Success dialog for initial setup
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => _BuildWelcomeDialog(points: xpGained),
          );
          context.go('/home');
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ToastUtils.showModernToast(context, 'Lỗi: $e', type: ToastType.error);
      }
    }
  }

  void _handleBack() {
    final isComplete = ref.read(authProvider).isProfileComplete;
    if (isComplete) {
      context.pop();
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('⚠️ Hồ sơ chưa hoàn thiện', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
          'Hồ sơ sơ sài sẽ làm bạn mất đi cơ hội “ghép đôi” thành công và AI cũng không thể tìm được người phù hợp nhất cho bạn.\n\nBạn có chắc chắn muốn quay lại màn hình đăng nhập không?',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tiếp tục điền hồ sơ', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Phải logout trước khi quay lại đăng nhập, nếu không Router sẽ tự động redirect về /home
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
            child: Text('Quay lại Đăng nhập', style: TextStyle(color: Colors.grey[600])),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          ref.watch(authProvider).currentUser?.name.isEmpty ?? true ? 'Thiết lập hồ sơ' : 'Cập nhật thông tin',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: _handleBack,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              _buildLoveSenseGuide(),
            const SizedBox(height: 10),
            
            // Photos Section
            _buildSectionHeader('Hình ảnh của bạn', trailingXP: '+10 XP (ảnh đầu)'),
            SizedBox(
              height: 180,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  if (index < _photos.length) {
                    return _buildImageCard(index);
                  } else if (index == _photos.length) {
                    return _buildAddButton();
                  } else {
                    return _buildEmptyCard();
                  }
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Thông tin cá nhân', trailingXP: '+10 XP mỗi mục'),
                    _buildCard([
                      _buildTextField(
                        controller: _nameController,
                        label: 'Họ và tên',
                        icon: Icons.person_outline,
                        validator: (v) => v!.isEmpty ? 'Vui lòng nhập tên' : null,
                      ),
                      const Divider(height: 1),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _ageController,
                              label: 'Tuổi',
                              icon: Icons.cake_outlined,
                              keyboardType: TextInputType.number,
                              validator: (v) => v!.isEmpty ? '!' : null,
                            ),
                          ),
                          Container(width: 1, height: 40, color: Colors.grey[200]),
                          Expanded(
                            flex: 2,
                            child: _buildTextField(
                              controller: _jobController,
                              label: 'Nghề nghiệp',
                              icon: Icons.work_outline,
                              validator: (v) => v!.isEmpty ? 'Vui lòng nhập nghề' : null,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 1),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _heightController,
                              label: 'Chiều cao (cm)',
                              icon: Icons.height,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Container(width: 1, height: 40, color: Colors.grey[200]),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  value: _purpose.isEmpty ? null : _purpose,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.favorite_border, color: Colors.grey[400], size: 20),
                                    labelText: 'Mục đích',
                                    border: InputBorder.none,
                                  ),
                                  items: ['Người yêu', 'Bạn bè', 'Bất kỳ']
                                      .map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14))))
                                      .toList(),
                                  onChanged: (v) => setState(() => _purpose = v ?? ''),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 1),
                      _buildTextField(
                        controller: _livingController,
                        label: 'Đang sống tại',
                        icon: Icons.location_on_outlined,
                      ),
                    ]),
                    
                    const SizedBox(height: 24),
                    _buildSectionHeader('Giới tính'),
                    _buildChoiceGroup(
                      ['Nữ', 'Nam', 'Khác'],
                      _gender,
                      (val) => setState(() => _gender = val),
                    ),

                    const SizedBox(height: 24),
                    _buildSectionHeader('Tìm kiếm đối tượng'),
                    _buildChoiceGroup(
                      ['Nam', 'Nữ', 'Tất cả'],
                      _lookingFor,
                      (val) => setState(() => _lookingFor = val),
                    ),
                    
                    const SizedBox(height: 24),
                    _buildSectionHeader('Về bản thân', trailingXP: '+10 XP'),
                    _buildCard([
                      _buildTextField(
                        controller: _bioController,
                        label: 'Giới thiệu bản thân',
                        hint: 'Hãy viết gì đó về bạn để mọi người hiểu hơn...',
                        maxLines: 4,
                        validator: (v) => v!.isEmpty ? 'Vui lòng chia sẻ đôi chút' : null,
                      ),
                    ]),
                    
                    const SizedBox(height: 24),
                    _buildSectionHeader('Sở thích (Chọn tối đa 5)', trailingXP: '+10 XP'),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ..._availableInterests.map((interest) {
                          final isSelected = _selectedInterests.contains(interest);
                          return ChoiceChip(
                            label: Text(interest),
                            selected: isSelected,
                            onSelected: (_) => _toggleInterest(interest),
                            selectedColor: AppColors.primary.withOpacity(0.1),
                            checkmarkColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color: isSelected ? AppColors.primary : Colors.black54,
                              fontSize: 13,
                            ),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: isSelected ? AppColors.primary : Colors.grey[300]!),
                            ),
                          );
                        }),
                        ..._customInterests.map((interest) {
                          final isSelected = _selectedInterests.contains(interest);
                          return ChoiceChip(
                            label: Text(interest),
                            selected: isSelected,
                            onSelected: (_) => _toggleInterest(interest),
                            selectedColor: AppColors.primary.withOpacity(0.1),
                            checkmarkColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color: isSelected ? AppColors.primary : Colors.black54,
                              fontSize: 13,
                            ),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: isSelected ? AppColors.primary : Colors.grey[300]!),
                            ),
                          );
                        }),
                        // Add button
                        ActionChip(
                          avatar: const Icon(Icons.add, size: 16, color: AppColors.primary),
                          label: const Text('Tùy chỉnh'),
                          onPressed: _showAddInterestDialog,
                          backgroundColor: Colors.white,
                          labelStyle: const TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: AppColors.primary, style: BorderStyle.solid),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 48),
                    GradientButton(
                      text: 'Hoàn tất & Nhận XP',
                      onPressed: _saveProfile,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoveSenseGuide() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(seconds: 1),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: 0.8 + (value * 0.2),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: const Icon(Icons.auto_awesome, color: AppColors.primary, size: 30),
                ),
              );
            },
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LoveSense AI 🤖',
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
                SizedBox(height: 4),
                Text(
                  'Hãy điền đầy đủ thông tin để nhận thêm điểm XP và giúp tôi tìm được "mảnh ghép" hoàn hảo nhất cho bạn nhé!',
                  style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceGroup(List<String> options, String current, Function(String) onSelect) {
    return Wrap(
      spacing: 10,
      children: options.map((opt) {
        final selected = current == opt.toLowerCase() || current == opt;
        return ChoiceChip(
          label: Text(opt),
          selected: selected,
          onSelected: (_) => onSelect(opt.toLowerCase()),
          selectedColor: AppColors.primary.withOpacity(0.1),
          labelStyle: TextStyle(color: selected ? AppColors.primary : Colors.grey[600], fontWeight: selected ? FontWeight.bold : FontWeight.normal),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        );
      }).toList(),
    );
  }

  Widget _buildSectionHeader(String title, {String? trailingXP}) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12, right: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(color: Colors.grey[600], fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.1),
          ),
          if (trailingXP != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Text(trailingXP, style: const TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    IconData? icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon, color: Colors.grey[400], size: 18) : null,
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }

  Widget _buildImageCard(int index) {
    final photo = _photos[index];
    return Stack(
      children: [
        Container(
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
            image: DecorationImage(
              image: photo.isLocal 
                ? FileImage(File(photo.localFile!.path)) 
                : CachedNetworkImageProvider(photo.url!) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => _removePhoto(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 14, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withOpacity(0.3), style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(Icons.add_a_photo, color: AppColors.primary, size: 24),
            ),
            const SizedBox(height: 8),
            const Text('Thêm ảnh', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(_photos.isEmpty ? '+10 XP' : '+5 XP', style: const TextStyle(color: AppColors.primary, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCard() {
    return Container(
      width: 120,
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16)),
      child: Icon(Icons.photo_library_outlined, color: Colors.grey[200]),
    );
  }
}

class _BuildWelcomeDialog extends StatefulWidget {
  final int points;
  const _BuildWelcomeDialog({required this.points});

  @override
  State<_BuildWelcomeDialog> createState() => _BuildWelcomeDialogState();
}

class _BuildWelcomeDialogState extends State<_BuildWelcomeDialog> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RotationTransition(
            turns: _ctrl,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(Icons.star, color: AppColors.primary, size: 50),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Tuyệt vời! 🎉', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(
            widget.points > 0
                ? 'Chúc mừng! Bạn vừa nhận được +${widget.points} XP!\nHồ sơ của bạn đã sẵn sàng để "tỏa sáng".'
                : 'Hồ sơ đã được cập nhật thành công.\nHãy bắt đầu khám phá ngay nhé!',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black87, fontSize: 15, height: 1.5),
          ),
        ],
      ),
      actions: [
        GradientButton(
          text: 'Khám phá ngay',
          onPressed: () => Navigator.pop(context),
          width: double.infinity,
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
    );
  }
}
