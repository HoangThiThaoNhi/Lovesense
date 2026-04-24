import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared_widgets/glass_container.dart';
import '../../../theme.dart';

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Trợ giúp & Hỗ trợ'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: ListView(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 100, bottom: 16),
          children: [
            _buildContactSection(),
            const SizedBox(height: 24),
            _buildFAQSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(Icons.headset_mic, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text(
            'Bạn cần hỗ trợ trực tiếp?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Đội ngũ của chúng tôi luôn sẵn sàng giúp đỡ bạn.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.phone, color: AppColors.primary, size: 20),
                SizedBox(width: 10),
                Text(
                  '0367659288',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            'CÂU HỎI THƯỜNG GẶP',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
        ),
        _buildFAQItem(
          'Làm thế nào để tăng lượt tương hợp?',
          'Hãy đảm bảo hồ sơ của bạn có ít nhất 3 ảnh rõ nét và điền đầy đủ thông tin sở thích. Những hồ sơ chi tiết thường nhận được nhiều lượt quẹt phải hơn 70%.',
        ),
        _buildFAQItem(
          'Tôi bị làm phiền bởi một người dùng khác?',
          'Bạn có thể chọn "Hủy ghép đôi" hoặc "Báo cáo" người dùng đó ngay trong trang chat. Chúng tôi sẽ xem xét và xử lý trong vòng 24h.',
        ),
        _buildFAQItem(
          'Làm sao để xác thực tài khoản?',
          'Bạn có thể vào cài đặt hồ sơ và chọn mục "Xác thực danh tính". Việc xác thực sẽ giúp bạn nhận được huy hiệu xanh và tăng độ tin cậy.',
        ),
        _buildFAQItem(
          'Tại sao tôi không thấy người dùng ở gần?',
          'Hãy kiểm tra xem bạn đã cấp quyền truy cập vị trí cho ứng dụng chưa. Bạn cũng có thể mở rộng bán kính tìm kiếm trong phần bộ lọc.',
        ),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Text(
              answer,
              style: const TextStyle(color: Colors.grey, height: 1.5, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
