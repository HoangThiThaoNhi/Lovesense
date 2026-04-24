import 'package:flutter/material.dart';
import '../../../theme.dart';

class LegalScreen extends StatelessWidget {
  final String title;
  final String content;

  const LegalScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Cập nhật lần cuối: 15 tháng 4, 2026',
                style: TextStyle(color: Colors.grey[500], fontSize: 13),
              ),
              const Divider(height: 40),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.8,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Helper factory for Terms of Service
  static LegalScreen terms() => const LegalScreen(
        title: 'Điều khoản dịch vụ',
        content: '''
1. Chấp nhận Điều khoản
Bằng cách sử dụng ứng dụng LoveSense, bạn đồng ý tuân thủ các điều khoản và điều kiện này. Nếu bạn không đồng ý, vui lòng không sử dụng dịch vụ.

2. Điều kiện tham gia
Bạn phải ít nhất 18 tuổi để tạo tài khoản. Bằng cách đăng ký, bạn cam kết rằng tất cả thông tin cung cấp là chính xác và trung thực.

3. Quy tắc ứng xử
- Không đăng tải nội dung khiêu dâm, bạo lực hoặc xúc phạm.
- Không sử dụng ứng dụng để lừa đảo hoặc quấy rối người khác.
- Tôn trọng quyền riêng tư của các thành viên khác.

4. Tài khoản của bạn
Bạn có trách nhiệm bảo mật mật khẩu và các thông tin truy cập tài khoản. Chúng tôi có quyền tạm khóa hoặc xóa tài khoản nếu phát hiện vi phạm quy tắc cộng đồng.
        ''',
      );

  // Helper factory for Privacy Policy
  static LegalScreen privacy() => const LegalScreen(
        title: 'Chính sách quyền riêng tư',
        content: '''
Chúng tôi tại LoveSense coi trọng quyền riêng tư của bạn. Chính sách này giải thích cách chúng tôi thu thập và sử dụng dữ liệu của bạn.

1. Thông tin chúng tôi thu thập
- Thông tin hồ sơ: Tên, tuổi, giới thiệu, ảnh.
- Dữ liệu vị trí: Để gợi ý những người dùng ở gần bạn.
- Tin nhắn: Được mã hóa để bảo vệ nội dung hội thoại giữa các thành viên.

2. Cách chúng tôi sử dụng thông tin
Dữ liệu của bạn được sử dụng để cải thiện thuật toán ghép đôi và đảm bảo môi trường hẹn hò an toàn, lành mạnh.

3. Chia sẻ dữ liệu
Chúng tôi không bao giờ bán dữ liệu cá nhân của bạn cho bên thứ ba. Thông tin chỉ được chia sẻ công khai theo cấu hình hồ sơ bạn thiết lập.

4. Quyền của bạn
Bạn có quyền truy cập, sửa đổi hoặc yêu cầu xóa dữ liệu cá nhân của mình bất kỳ lúc nào thông qua phần cài đặt tài khoản.
        ''',
      );

  // Helper factory for Licenses
  static LegalScreen license() => const LegalScreen(
        title: 'Giấy phép',
        content: '''
Bản quyền © 2026 LoveSense Inc. Bảo lưu mọi quyền.

Hệ thống sử dụng các thư viện mã nguồn mở sau:
- Flutter: Google Inc. (BSD License)
- Riverpod: Remi Rousselet (MIT License)
- Cloudinary: Cloudinary Ltd.
- Gemini AI: Google AI technology.

Mọi hành vi sao chép, sử dụng trái phép mã nguồn hoặc hình ảnh thuộc sở hữu của LoveSense mà không có sự đồng ý của chúng tôi đều bị coi là vi phạm pháp luật.
        ''',
      );
}
