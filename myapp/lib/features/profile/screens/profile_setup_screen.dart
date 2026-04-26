import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/user_model.dart';
import '../../../shared_widgets/gradient_button.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/gamification_provider.dart';
import '../../../theme.dart';
import '../../../core/utils/api_service.dart';
import '../../../core/utils/cloudinary_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
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
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _livingController = TextEditingController();
  
  String _purpose = '';
  String _gender = '';
  String _lookingFor = '';

  final List<String> _selectedInterests = [];
  final List<String> _customInterests = [];
  final List<PhotoItem> _photos = [];
  final List<String> _deletedPhotoIds = [];
  final ImagePicker _picker = ImagePicker();
  bool _isSaving = false;
  double? _latitude;
  double? _longitude;
  bool _isFetchingLocation = false;

  final Map<String, List<String>> _vietnamLocations = {
    'Hà Nội': ['Ba Đình', 'Hoàn Kiếm', 'Tây Hồ', 'Long Biên', 'Cầu Giấy', 'Đống Đa', 'Hai Bà Trưng', 'Thanh Xuân', 'Sóc Sơn', 'Đông Anh', 'Gia Lâm', 'Nam Từ Liêm', 'Bắc Từ Liêm', 'Thanh Trì', 'Mê Linh', 'Hà Đông', 'Sơn Tây', 'Ba Vì', 'Phúc Thọ', 'Đan Phượng', 'Hoài Đức', 'Quốc Oai', 'Thạch Thất', 'Chương Mỹ', 'Thanh Oai', 'Thường Tín', 'Phú Xuyên', 'Ứng Hòa', 'Mỹ Đức'],
    'Hồ Chí Minh': ['Quận 1', 'Quận 3', 'Quận 4', 'Quận 5', 'Quận 6', 'Quận 7', 'Quận 8', 'Quận 10', 'Quận 11', 'Quận 12', 'Bình Tân', 'Bình Thạnh', 'Gò Vấp', 'Phú Nhuận', 'Tân Bình', 'Tân Phú', 'Thủ Đức', 'Bình Chánh', 'Cần Giờ', 'Củ Chi', 'Hóc Môn', 'Nhà Bè'],
    'Đà Nẵng': ['Hải Châu', 'Thanh Khê', 'Sơn Trà', 'Ngũ Hành Sơn', 'Liên Chiểu', 'Hòa Vang', 'Cẩm Lệ', 'Hoàng Sa'],
    'Hải Phòng': ['Hồng Bàng', 'Lê Chân', 'Ngô Quyền', 'Kiến An', 'Hải An', 'Đồ Sơn', 'Dương Kinh', 'An Dương', 'An Lão', 'Bạch Long Vĩ', 'Cát Hải', 'Kiến Thụy', 'Thủy Nguyên', 'Tiên Lãng', 'Vĩnh Bảo'],
    'Cần Thơ': ['Ninh Kiều', 'Bình Thủy', 'Cái Răng', 'Ô Môn', 'Thốt Nốt', 'Phong Điền', 'Cờ Đỏ', 'Vĩnh Thạnh', 'Thới Lai'],
    'An Giang': ['Long Xuyên', 'Châu Đốc', 'An Phú', 'Tân Châu', 'Phú Tân', 'Tịnh Biên', 'Tri Tôn', 'Châu Phú', 'Châu Thành', 'Thoại Sơn'],
    'Bà Rịa - Vũng Tàu': ['Vũng Tàu', 'Bà Rịa', 'Xuyên Mộc', 'Long Điền', 'Đất Đỏ', 'Châu Đức', 'Tân Thành', 'Côn Đảo'],
    'Bắc Giang': ['Bắc Giang', 'Yên Thế', 'Tân Yên', 'Lạng Giang', 'Lục Nam', 'Lục Ngạn', 'Sơn Động', 'Yên Dũng', 'Việt Yên', 'Hiệp Hòa'],
    'Bắc Kạn': ['Bắc Kạn', 'Pác Nặm', 'Ba Bể', 'Ngân Sơn', 'Chợ Đồn', 'Chợ Mới', 'Na Rì'],
    'Bạc Liêu': ['Bạc Liêu', 'Hồng Dân', 'Phước Long', 'Vĩnh Lợi', 'Giá Rai', 'Đông Hải', 'Hòa Bình'],
    'Bắc Ninh': ['Bắc Ninh', 'Yên Phong', 'Quế Võ', 'Tiên Du', 'Từ Sơn', 'Thuận Thành', 'Gia Bình', 'Lương Tài'],
    'Bến Tre': ['Bến Tre', 'Châu Thành', 'Chợ Lách', 'Mỏ Cày Nam', 'Giồng Trôm', 'Bình Đại', 'Ba Tri', 'Thạnh Phú', 'Mỏ Cày Bắc'],
    'Bình Định': ['Quy Nhơn', 'An Lão', 'Hoài Nhơn', 'Hoài Ân', 'Phù Mỹ', 'Vĩnh Thạnh', 'Tây Sơn', 'Phù Cát', 'An Nhơn', 'Tuy Phước', 'Vân Canh'],
    'Bình Dương': ['Thủ Dầu Một', 'Bàu Bàng', 'Dầu Tiếng', 'Bến Cát', 'Phú Giáo', 'Tân Uyên', 'Dĩ An', 'Thuận Uyên', 'Bắc Tân Uyên'],
    'Bình Phước': ['Phước Long', 'Đồng Xoài', 'Bình Long', 'Chơn Thành', 'Đồng Phú', 'Bù Đăng', 'Lộc Ninh', 'Bù Đốp', 'Hớn Quản', 'Bù Gia Mập', 'Phú Riềng'],
    'Bình Thuận': ['Phan Thiết', 'La Gi', 'Tuy Phong', 'Bắc Bình', 'Hàm Thuận Bắc', 'Hàm Thuận Nam', 'Tánh Linh', 'Đức Linh', 'Hàm Tân', 'Phú Quý'],
    'Cà Mau': ['Cà Mau', 'U Minh', 'Thới Bình', 'Trần Văn Thời', 'Cái Nước', 'Đầm Dơi', 'Năm Căn', 'Phú Tân', 'Ngọc Hiển'],
    'Cao Bằng': ['Cao Bằng', 'Bảo Lâm', 'Bảo Lạc', 'Thông Nông', 'Hà Quảng', 'Trà Lĩnh', 'Trùng Khánh', 'Hạ Lang', 'Quảng Uyên', 'Phục Hòa', 'Hòa An', 'Nguyên Bình', 'Thạch An'],
    'Đắk Lắk': ['Buôn Ma Thuột', 'Buôn Hồ', 'Ea H\'leo', 'Krông Năng', 'Krông Búk', 'Ea Súp', 'Buôn Đôn', 'Cư M\'gar', 'Krông Pắc', 'Krông Bông', 'Krông Ana', 'Lắk', 'Ea Kar', 'M\'Đrắk', 'Krông Rắc'],
    'Đắk Nông': ['Gia Nghĩa', 'Đăk Glong', 'Đăk Mil', 'Đăk Gnập', 'Đăk Song', 'Krông Nô', 'Tuy Đức'],
    'Điện Biên': ['Điện Biên Phủ', 'Mường Lay', 'Mường Nhé', 'Mường Chà', 'Tủa Chùa', 'Tuần Giáo', 'Điện Biên', 'Điện Biên Đông', 'Mường Áng', 'Nậm Pồ'],
    'Đồng Nai': ['Biên Hòa', 'Long Khánh', 'Tân Phú', 'Định Quán', 'Xuân Lộc', 'Thống Nhất', 'Cẩm Mỹ', 'Long Thành', 'Nhơn Trạch', 'Vĩnh Cửu', 'Trảng Bom'],
    'Đồng Tháp': ['Cao Lãnh', 'Sa Đéc', 'Hồng Ngự', 'Tân Hồng', 'Tháp Mười', 'Thanh Bình', 'Lấp Vò', 'Lai Vung'],
    'Gia Lai': ['Pleiku', 'An Khê', 'Ayun Pa', 'Chư Păh', 'Chư Prông', 'Chư Sê', 'Đức Cơ', 'Ia Grai', 'Kbang', 'Kông Chro', 'Krông Pa', 'Mang Yang', 'Ia Pa', 'Đăk Pơ', 'Chư Pưh'],
    'Hà Giang': ['Hà Giang', 'Đồng Văn', 'Mèo Vạc', 'Yên Minh', 'Quản Bạ', 'Vị Xuyên', 'Bắc Mê', 'Hoàng Su Phì', 'Xín Mần', 'Bắc Quang', 'Quang Bình'],
    'Hà Nam': ['Phủ Lý', 'Duy Tiên', 'Kim Bảng', 'Thanh Liêm', 'Bình Lục', 'Lý Nhân'],
    'Hà Tĩnh': ['Hà Tĩnh', 'Hồng Lĩnh', 'Kỳ Anh', 'Hương Sơn', 'Đức Thọ', 'Vũ Quang', 'Nghi Xuân', 'Can Lộc', 'Hương Khê', 'Thạch Hà', 'Cẩm Xuyên', 'Lộc Hà'],
    'Hải Dương': ['Hải Dương', 'Chí Linh', 'Nam Sách', 'Kinh Môn', 'Kim Thành', 'Thanh Hà', 'Cẩm Giàng', 'Bình Giang', 'Gia Lộc', 'Tứ Kỳ', 'Ninh Giang', 'Thanh Miện'],
    'Hậu Giang': ['Vị Thanh', 'Ngã Bảy', 'Châu Thành', 'Châu Thành A', 'Long Mỹ', 'Phụng Hiệp', 'Vị Thủy'],
    'Hòa Bình': ['Hòa Bình', 'Đà Bắc', 'Kỳ Sơn', 'Lương Sơn', 'Kim Bôi', 'Cao Phong', 'Tân Lạc', 'Mai Châu', 'Lạc Sơn', 'Yên Thủy', 'Lạc Thủy'],
    'Hưng Yên': ['Hưng Yên', 'Văn Lâm', 'Văn Giang', 'Yên Mỹ', 'Mỹ Hào', 'Ân Thi', 'Khoái Châu', 'Kim Động', 'Tiên Lữ', 'Phù Cừ'],
    'Khánh Hòa': ['Nha Trang', 'Cam Ranh', 'Cam Lâm', 'Vạn Ninh', 'Ninh Hòa', 'Khánh Vĩnh', 'Diên Khánh', 'Khánh Sơn', 'Trường Sa'],
    'Kiên Giang': ['Rạch Giá', 'Hà Tiên', 'Kiên Lương', 'Hòn Đất', 'Tân Hiệp', 'Châu Thành', 'Giồng Riềng', 'Gò Quao', 'An Biên', 'An Minh', 'Vĩnh Thuận', 'Phú Quốc', 'Kiên Hải', 'U Minh Thượng', 'Giang Thành'],
    'Kon Tum': ['Kon Tum', 'Đăk Glei', 'Ngọc Hồi', 'Đăk Tô', 'Kon Plông', 'Kon Rẫy', 'Đăk Hà', 'Sa Thầy', 'Tu Mơ Rông', 'Ia H\' Drai'],
    'Lai Châu': ['Lai Châu', 'Tam Đường', 'Mường Tè', 'Sìn Hồ', 'Phong Thổ', 'Than Uyên', 'Tân Uyên', 'Nậm Nhùn'],
    'Lâm Đồng': ['Đà Lạt', 'Bảo Lộc', 'Đức Trọng', 'Di Linh', 'Đơn Dương', 'Lạc Dương', 'Đạ Huoai', 'Đạ Tẻh', 'Cát Tiên', 'Lâm Hà', 'Bảo Lâm', 'Đam Rông'],
    'Lạng Sơn': ['Lạng Sơn', 'Tràng Định', 'Bình Gia', 'Văn Lãng', 'Cao Lộc', 'Văn Quan', 'Bắc Sơn', 'Hữu Lũng', 'Chi Lăng', 'Lộc Bình', 'Đình Lập'],
    'Lào Cai': ['Lào Cai', 'Bát Xát', 'Mường Khương', 'Si Ma Cai', 'Bắc Hà', 'Bảo Thắng', 'Bảo Yên', 'Sa Pa', 'Văn Bàn'],
    'Long An': ['Tân An', 'Kiến Tường', 'Tân Hưng', 'Vĩnh Hưng', 'Mộc Hóa', 'Tân Thạnh', 'Thạnh Hóa', 'Đức Huệ', 'Đức Hòa', 'Bến Lức', 'Thủ Thừa', 'Tân Trụ', 'Cần Đước', 'Cần Giuộc', 'Châu Thành'],
    'Nam Định': ['Nam Định', 'Mỹ Lộc', 'Vụ Bản', 'Ý Yên', 'Nghĩa Hưng', 'Nam Trực', 'Trực Ninh', 'Xuân Trường', 'Giao Thủy', 'Hải Hậu'],
    'Nghệ An': ['Vinh', 'Cửa Lò', 'Thái Hòa', 'Quế Phong', 'Quỳ Châu', 'Kỳ Sơn', 'Tương Dương', 'Nghĩa Đàn', 'Quỳ Hợp', 'Quỳnh Lưu', 'Con Cuông', 'Tân Kỳ', 'Anh Sơn', 'Diễn Châu', 'Yên Thành', 'Đô Lương', 'Thanh Chương', 'Nghi Lộc', 'Nam Đàn', 'Hưng Nguyên', 'Hoàng Mai'],
    'Ninh Bình': ['Ninh Bình', 'Tam Điệp', 'Nho Quan', 'Gia Viễn', 'Hoa Lư', 'Yên Khánh', 'Kim Sơn', 'Yên Mô'],
    'Ninh Thuận': ['Phan Rang-Tháp Chàm', 'Bác Ái', 'Ninh Sơn', 'Ninh Hải', 'Ninh Phước', 'Thuận Bắc', 'Thuận Nam'],
    'Phú Thọ': ['Việt Trì', 'Phú Thọ', 'Đoan Hùng', 'Hạ Hòa', 'Thanh Ba', 'Phù Ninh', 'Yên Lập', 'Cẩm Khê', 'Tam Nông', 'Thanh Sơn', 'Thanh Thủy', 'Tân Sơn', 'Lâm Thao'],
    'Phú Yên': ['Tuy Hòa', 'Sông Cầu', 'Đông Hòa', 'Đồng Xuân', 'Tuy An', 'Sơn Hòa', 'Sông Hinh', 'Tây Hòa', 'Phú Hòa'],
    'Quảng Bình': ['Đồng Hới', 'Ba Đồn', 'Minh Hóa', 'Tuyên Hóa', 'Quảng Trạch', 'Bố Trạch', 'Quảng Ninh', 'Lệ Thủy'],
    'Quảng Nam': ['Tam Kỳ', 'Hội An', 'Tây Giang', 'Đông Giang', 'Nam Giang', 'Phước Sơn', 'Bắc Trà My', 'Nam Trà My', 'Hiệp Đức', 'Tiên Phước', 'Bắc Trà My', 'Điện Bàn'],
    'Quảng Ngãi': ['Quảng Ngãi', 'Bình Sơn', 'Trà Bồng', 'Tây Trà', 'Sơn Tịnh', 'Tư Nghĩa', 'Sơn Hà', 'Sơn Tây', 'Nghĩa Hành', 'Mộ Đức', 'Đức Phổ', 'Ba Tơ', 'Minh Long', 'Lý Sơn'],
    'Quảng Ninh': ['Hạ Long', 'Móng Cái', 'Cẩm Phả', 'Uông Bí', 'Bình Liêu', 'Tiên Yên', 'Đầm Hà', 'Quảng Yên', 'Đông Triều', 'Vân Đồn', 'Cô Tô'],
    'Quảng Trị': ['Đông Hà', 'Quảng Trị', 'Vĩnh Linh', 'Hướng Hóa', 'Gio Linh', 'Đa Krông', 'Cam Lộ', 'Triệu Phong', 'Hải Lăng', 'Cồn Cỏ'],
    'Sóc Trăng': ['Sóc Trăng', 'Châu Thành', 'Kế Sách', 'Mỹ Tú', 'Cù Lao Dung', 'Long Phú', 'Mỹ Xuyên', 'Ngã Năm', 'Thạnh Trị', 'Vĩnh Châu', 'Trần Đề'],
    'Sơn La': ['Sơn La', 'Quỳnh Nhai', 'Thuận Châu', 'Mường La', 'Bắc Yên', 'Phù Yên', 'Mộc Châu', 'Yên Châu', 'Mai Sơn', 'Sông Mã', 'Sốp Cộp', 'Vân Hồ'],
    'Tây Ninh': ['Tây Ninh', 'Tân Biên', 'Tân Châu', 'Dương Minh Châu', 'Châu Thành', 'Hòa Thành', 'Gò Dầu', 'Bến Cầu', 'Trảng Bàng'],
    'Thái Bình': ['Thái Bình', 'Quỳnh Phụ', 'Hưng Hà', 'Đông Hưng', 'Thái Thụy', 'Tiền Hải', 'Kiến Xương', 'Vũ Thư'],
    'Thái Nguyên': ['Thái Nguyên', 'Sông Công', 'Định Hóa', 'Phú Lương', 'Đồng Hỷ', 'Võ Nhai', 'Đại Từ', 'Phổ Yên', 'Phú Bình'],
    'Thanh Hóa': ['Thanh Hóa', 'Bỉm Sơn', 'Sầm Sơn', 'Mường Lát', 'Quan Hóa', 'Bá Thước', 'Quan Sơn', 'Lang Chánh', 'Ngọc Lặc', 'Cẩm Thủy', 'Thạch Thành', 'Hà Trung', 'Vĩnh Lộc', 'Yên Định', 'Thọ Xuân', 'Thường Xuân', 'Triệu Sơn', 'Thiệu Hóa', 'Hoằng Hóa', 'Hậu Lộc', 'Nga Sơn', 'Quảng Xương', 'Nông Cống', 'Tĩnh Gia', 'Đông Sơn', 'An Định'],
    'Thừa Thiên Huế': ['Huế', 'Phong Điền', 'Quảng Điền', 'Hương Trà', 'Phú Vang', 'Hương Thủy', 'Phú Lộc', 'Nam Đông', 'A Lưới'],
    'Tiền Giang': ['Mỹ Tho', 'Gò Công', 'Cai Lậy', 'Tân Phước', 'Cái Bè', 'Châu Thành', 'Chợ Gạo', 'Gò Công Tây', 'Gò Công Đông', 'Tân Phú Đông'],
    'Trà Vinh': ['Trà Vinh', 'Càng Long', 'Cầu Kè', 'Tiểu Cần', 'Châu Thành', 'Trà Cú', 'Cầu Ngang', 'Duyên Hải'],
    'Tuyên Quang': ['Tuyên Quang', 'Lâm Bình', 'Na Hang', 'Chiêm Hóa', 'Hàm Yên', 'Yên Sơn', 'Sơn Dương'],
    'Vĩnh Long': ['Vĩnh Long', 'Long Hồ', 'Mang Thít', 'Vũng Liêm', 'Tam Bình', 'Trà Ôn', 'Bình Minh', 'Bình Tân'],
    'Vĩnh Phúc': ['Vĩnh Yên', 'Phúc Yên', 'Lập Thạch', 'Tam Dương', 'Tam Đảo', 'Bình Xuyên', 'Yên Lạc', 'Vĩnh Tường', 'Sông Lô'],
    'Yên Bái': ['Yên Bái', 'Nghĩa Lộ', 'Lục Yên', 'Văn Yên', 'Mù Cang Chải', 'Trấn Yên', 'Trạm Tấu', 'Văn Chấn', 'Yên Bình'],
  };

  final List<String> _availableInterests = [
    'Âm nhạc', 'Du lịch', 'Ẩm thực', 'Phim ảnh', 'Nghệ thuật', 'Công nghệ', 
    'Thể hình', 'Sách', 'Chơi game', 'Thiên nhiên', 'Thú cưng', 'Thời trang'
  ];

  void _populateFromUser(User user) {
    setState(() {
      _nameController.text = user.name;
      _bioController.text = user.bio;
      _ageController.text = (user.age > 0) ? user.age.toString() : '';
      _jobController.text = user.job;
      _heightController.text = user.height != null ? user.height.toString() : '';
      _cityController.text = user.city ?? '';
      _districtController.text = user.district ?? '';
      _addressController.text = user.address ?? '';
      _livingController.text = user.livingAt ?? '';
      _purpose = user.purpose ?? '';
      _gender = user.gender;
      _lookingFor = user.lookingFor.isNotEmpty ? user.lookingFor.first : '';
      
      if (user.interests.isNotEmpty) {
        _selectedInterests.clear();
        _selectedInterests.addAll(user.interests);
        _customInterests.clear();
        for (var interest in user.interests) {
          if (!_availableInterests.contains(interest)) {
            _customInterests.add(interest);
          }
        }
      }

      // Load existing photos (only if not already loaded)
      if (_photos.isEmpty) {
        for (var p in user.photos) {
          _photos.add(PhotoItem(
            id: p['id']?.toString(),
            url: p['image_url']?.toString(),
          ));
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // First populate with cached data (instant)
      final cachedUser = ref.read(authProvider).currentUser;
      if (cachedUser != null) {
        _populateFromUser(cachedUser);
      }

      // Then fetch fresh data from server (overrides with latest)
      final token = ref.read(authProvider).token;
      if (token != null) {
        try {
          final profileResponse = await ApiService.get('/profile/me', token: token);
          if (profileResponse.containsKey('id') || profileResponse.containsKey('user_id')) {
            final freshUser = User.fromJson(profileResponse);
            // Update auth state with fresh data
            ref.read(authProvider.notifier).updateProfile(freshUser);
            // Re-populate form with fresh server data
            _populateFromUser(freshUser);
          }
        } catch (e) {
          debugPrint('Profile setup: failed to fetch fresh profile: $e');
        }
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
    _cityController.dispose();
    _districtController.dispose();
    _addressController.dispose();
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

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 5),
      );
    } catch (e) {
      debugPrint('Location error: $e');
      return null;
    }
  }

  Future<void> _updateCoordinatesFromSelection() async {
    if (_cityController.text.isEmpty || _districtController.text.isEmpty) return;
    
    final fullAddress = '${_districtController.text}, ${_cityController.text}, Việt Nam';
    try {
      List<Location> locations = await locationFromAddress(fullAddress);
      if (locations.isNotEmpty) {
        setState(() {
          _latitude = locations.first.latitude;
          _longitude = locations.first.longitude;
        });
        debugPrint('Coordinates resolved from dropdown: $_latitude, $_longitude');
      }
    } catch (e) {
      debugPrint('Geocoding dropdown selection error: $e');
    }
  }

  Future<void> _fetchCurrentLocation() async {
    setState(() => _isFetchingLocation = true);
    try {
      final position = await _handleLocationPermission();
      if (position != null) {
        _latitude = position.latitude;
        _longitude = position.longitude;
        
        // Reverse Geocoding to get City/District
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(_latitude!, _longitude!);
          if (placemarks.isNotEmpty) {
            final p = placemarks.first;
            _cityController.text = p.administrativeArea ?? '';
            _districtController.text = p.subAdministrativeArea ?? p.locality ?? '';
            _addressController.text = [p.name, p.subLocality].where((s) => s != null && s.isNotEmpty).join(', ');
            
            _livingController.text = '${_districtController.text}, ${_cityController.text}'.trim();
            if (_livingController.text.startsWith(',')) _livingController.text = _livingController.text.substring(1).trim();
          }
        } catch (e) {
          debugPrint('Geocoding error: $e');
        }
        
        if (mounted) {
          ToastUtils.showModernToast(context, 'Đã cập nhật vị trí của bạn!', type: ToastType.success);
        }
      } else {
        if (mounted) {
          ToastUtils.showModernToast(context, 'Không thể lấy vị trí. Hãy bật GPS và quyền truy cập.', type: ToastType.warning);
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isFetchingLocation = false);
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_isSaving) return;
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

    setState(() => _isSaving = true);

    try {
      // 0. Manual Address Geocoding (If user typed but didn't click auto-fetch)
      if (_latitude == null && (_cityController.text.isNotEmpty || _districtController.text.isNotEmpty)) {
        final fullAddress = '${_addressController.text}, ${_districtController.text}, ${_cityController.text}'.trim();
        try {
          List<Location> locations = await locationFromAddress(fullAddress);
          if (locations.isNotEmpty) {
            _latitude = locations.first.latitude;
            _longitude = locations.first.longitude;
            debugPrint('Manual address resolved: $_latitude, $_longitude');
          }
        } catch (e) {
          debugPrint('Geocoding manual address error: $e');
        }
      }

      // 1. Parallelize independent tasks: Deletions, Uploads, and Location
      
      // Prepare deletion tasks
      final deleteTasks = _deletedPhotoIds.map((id) => ApiService.delete('/profile/photos/$id', token: token));
      
      // Prepare upload tasks
      final uploadTasks = _photos
          .where((p) => p.isLocal)
          .map((p) => CloudinaryService.uploadImage(p.localFile!.path, token))
          .toList();

      // Start location fetching if not already fetched
      final locationFuture = (_latitude == null) ? _handleLocationPermission() : Future.value(null);

      // Wait for all deletions and uploads
      final results = await Future.wait([
        Future.wait(deleteTasks),
        Future.wait(uploadTasks),
        locationFuture,
      ]);

      final List<String?> uploadedUrls = results[1] as List<String?>;
      final List<String> newUrls = uploadedUrls.whereType<String>().toList();
      final Position? position = results[2] as Position?;
      
      if (position != null) {
        _latitude = position.latitude;
        _longitude = position.longitude;
      }

      // 2. Add uploaded photo URLs to profile if any
      if (newUrls.isNotEmpty) {
        await ApiService.post('/profile/photo-urls', {'urls': newUrls}, token: token);
      }

      // 3. XP Calculation
      final oldUser = ref.read(authProvider).currentUser;
      int xpGained = 0;
      
      final oldPhotoCount = oldUser?.photos.length ?? 0;
      final newPhotoCount = _photos.length;
      if (oldPhotoCount == 0 && newPhotoCount > 0) {
        xpGained += 10;
        if (newPhotoCount > 1) xpGained += (newPhotoCount - 1) * 5;
      } else if (newPhotoCount > oldPhotoCount) {
        xpGained += (newPhotoCount - oldPhotoCount) * 5;
      }

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
      checkXP(oldUser?.gender, _gender);
      checkXP(oldUser?.lookingFor, _lookingFor.isEmpty ? [] : [_lookingFor]);

      // 4. Update profile info
      await ApiService.post('/profile/update', {
        'display_name': _nameController.text.trim(),
        'age': int.tryParse(_ageController.text.trim()) ?? 18,
        'gender': _gender,
        'occupation': _jobController.text.trim(),
        'bio': _bioController.text.trim(),
        'interests': _selectedInterests,
        'height': int.tryParse(_heightController.text.trim()),
        'purpose': _purpose,
        'city': _cityController.text.trim(),
        'district': _districtController.text.trim(),
        'address': _addressController.text.trim(),
        'living_at': '${_districtController.text.trim()}, ${_cityController.text.trim()}',
        'looking_for': _lookingFor,
        'lat': _latitude,
        'lng': _longitude,
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
      
      // Refresh gamification status to show new XP/badges
      ref.read(gamificationProvider.notifier).loadStatus();

      if (mounted) {
        setState(() => _isSaving = false);
        
        if (wasComplete) {
          ToastUtils.showModernToast(context, 'Cập nhật thành công! +$xpGained XP', type: ToastType.success);
          context.pop();
        } else {
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
        setState(() => _isSaving = false);
        ToastUtils.showModernToast(context, 'Lỗi: $e', type: ToastType.error);
      }
    }
  }

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/home');
    }
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
                    _buildSectionHeader('Thông tin cơ bản'),
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
                      _buildDropdownField(
                        label: 'Tỉnh / Thành phố',
                        icon: Icons.location_city,
                        value: _cityController.text.isEmpty ? null : _cityController.text,
                        items: _vietnamLocations.keys.toList(),
                        onChanged: (val) {
                          setState(() {
                            _cityController.text = val ?? '';
                            _districtController.text = ''; // Reset district when city changes
                            _livingController.text = _cityController.text;
                          });
                        },
                      ),
                      const Divider(height: 1),
                      _buildDropdownField(
                        label: 'Quận / Huyện',
                        icon: Icons.map_outlined,
                        value: (_cityController.text.isNotEmpty && _vietnamLocations[_cityController.text]!.contains(_districtController.text)) 
                            ? _districtController.text 
                            : null,
                        items: _cityController.text.isEmpty ? [] : _vietnamLocations[_cityController.text]!,
                        onChanged: (val) {
                          setState(() {
                            _districtController.text = val ?? '';
                            _livingController.text = '${_districtController.text}, ${_cityController.text}';
                          });
                          _updateCoordinatesFromSelection(); // Automatically update lat/lng
                        },
                      ),
                      const Divider(height: 1),
                      _buildTextField(
                        controller: _addressController,
                        label: 'Địa chỉ cụ thể / Phường xã',
                        icon: Icons.home_outlined,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 52, bottom: 8, right: 16),
                        child: _isFetchingLocation 
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : GestureDetector(
                              onTap: _fetchCurrentLocation,
                              child: const Text(
                                '📍 Tự động lấy vị trí chính xác',
                                style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
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
                      isLoading: _isSaving,
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

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: items.contains(value) ? value : null,
          decoration: InputDecoration(
            icon: Icon(icon, color: Colors.grey[400], size: 18),
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
          ),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 15)))).toList(),
          onChanged: onChanged,
          validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng chọn' : null,
        ),
      ),
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
