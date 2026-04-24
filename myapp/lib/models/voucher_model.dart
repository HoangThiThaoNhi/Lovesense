class Voucher {
  final int id;
  final String code;
  final String name;
  final String description;
  final String? badgeName;
  final String? badgeIcon;
  final bool isUsed;
  final DateTime? usedAt;
  final DateTime? earnedAt;
  final DateTime? expiryDate;

  Voucher({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    this.badgeName,
    this.badgeIcon,
    required this.isUsed,
    this.usedAt,
    this.earnedAt,
    this.expiryDate,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      code: json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      badgeName: json['badge']?['name']?.toString(),
      badgeIcon: json['badge']?['icon_url']?.toString(),
      isUsed: json['is_used'] == 1 || json['is_read'] == true || json['is_used'] == true,
      usedAt: json['used_at'] != null ? DateTime.tryParse(json['used_at'].toString()) : null,
      earnedAt: json['earned_at'] != null ? DateTime.tryParse(json['earned_at'].toString()) : null,
      expiryDate: json['expiry_date'] != null ? DateTime.tryParse(json['expiry_date'].toString()) : null,
    );
  }
}
