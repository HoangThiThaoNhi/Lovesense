import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/voucher_provider.dart';
import '../../../theme.dart';
import '../../../models/voucher_model.dart';
import 'dart:ui';

class VoucherScreen extends ConsumerWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voucherState = ref.watch(voucherProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kho Voucher của tôi', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: voucherState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Lỗi: $err')),
        data: (vouchers) {
          if (vouchers.isEmpty) {
            return _buildEmptyState();
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(voucherProvider.notifier).fetchVouchers(),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: vouchers.length,
              itemBuilder: (context, index) => _buildVoucherCard(context, vouchers[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.confirmation_number_outlined, size: 100, color: Colors.grey[200]),
          const SizedBox(height: 24),
          const Text(
            'Chưa có voucher nào',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          const Text(
            'Hãy tích cực tương tác để đạt huy hiệu\nvà nhận những phần quà hấp dẫn!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherCard(BuildContext context, Voucher voucher) {
    return _VoucherCard(voucher: voucher);
  }
}

class _VoucherCard extends StatefulWidget {
  final Voucher voucher;
  const _VoucherCard({required this.voucher});

  @override
  State<_VoucherCard> createState() => _VoucherCardState();
}

class _VoucherCardState extends State<_VoucherCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: SizedBox(
              height: 140, // Reduced base height to accommodate expansion
              child: Stack(
                children: [
                  Row(
                    children: [
                      // Left side: Badge & Icon
                      Container(
                        width: 90,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.secondary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            bottomLeft: Radius.circular(24),
                          ),
                        ),
                        child: Center(
                          child: widget.voucher.badgeIcon != null && widget.voucher.badgeIcon!.startsWith('http')
                              ? CachedNetworkImage(
                                  imageUrl: widget.voucher.badgeIcon!,
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.contain,
                                )
                              : const Icon(FontAwesomeIcons.ticket, color: Colors.white, size: 36),
                        ),
                      ),
                      
                      // Right side: Details
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.voucher.name,
                                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, letterSpacing: -0.5),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (widget.voucher.isUsed)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                                      child: const Text('ĐÃ DÙNG', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black45)),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.voucher.code,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900, 
                                  fontSize: 14, 
                                  color: AppColors.primary,
                                  letterSpacing: 1.5
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('HẾT HẠN', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.grey)),
                                      Text(
                                        widget.voucher.expiryDate != null 
                                            ? DateFormat('dd/MM/yyyy').format(widget.voucher.expiryDate!) 
                                            : 'VĨNH VIỄN',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  // "Điều khoản sử dụng" Toggle Link
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Điều khoản sử dụng',
                                        style: TextStyle(
                                          fontSize: 11, 
                                          fontWeight: FontWeight.bold, 
                                          color: Colors.grey[600],
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      Icon(
                                        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                        size: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Ticket dots indicator
                  Positioned(
                    left: 85,
                    top: -10,
                    child: Container(width: 10, height: 20, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                  ),
                  Positioned(
                    left: 85,
                    bottom: -10,
                    child: Container(width: 10, height: 20, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                  ),
                ],
              ),
            ),
          ),
          
          // Expanded Terms Section
          ClipRect(
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              heightFactor: _isExpanded ? 1.0 : 0.0,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    const Text(
                      'Chi tiết điều khoản:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.voucher.description.isNotEmpty 
                          ? widget.voucher.description 
                          : 'Không có điều khoản cụ thể cho voucher này.',
                      style: TextStyle(color: Colors.grey[700], fontSize: 12, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
