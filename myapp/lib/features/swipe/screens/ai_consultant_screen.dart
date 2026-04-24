import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme.dart';

class AIConsultantScreen extends ConsumerWidget {
  final Map<String, dynamic> dnaData;

  const AIConsultantScreen({super.key, required this.dnaData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selfAnalysis = dnaData['self_analysis'] ?? {};
    final idealPartner = dnaData['ideal_partner_profile'] ?? {};
    final topCategories = List<String>.from(dnaData['top_match_categories'] ?? []);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSection(selfAnalysis['summary'] ?? "Đang phân tích DNA của bạn..."),
                  const SizedBox(height: 24),
                  _buildSectionTitle("Bản sắc cá nhân (Persona)", Icons.psychology_outlined),
                  const SizedBox(height: 12),
                  _buildAnalysisCard(
                    title: "Điểm mạnh nổi bật",
                    items: List<String>.from(selfAnalysis['strengths'] ?? []),
                    color: Colors.green,
                    icon: Icons.auto_awesome,
                  ),
                  const SizedBox(height: 16),
                  _buildAnalysisCard(
                    title: "Vùng cần phát triển",
                    items: List<String>.from(selfAnalysis['growth_areas'] ?? []),
                    color: Colors.orange,
                    icon: Icons.trending_up,
                  ),
                  const SizedBox(height: 32),
                  _buildSectionTitle("Đối tượng lý tưởng", Icons.favorite_border),
                  const SizedBox(height: 12),
                  _buildIdealMatchCard(idealPartner),
                  const SizedBox(height: 32),
                  _buildActionButtons(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "AI CONSULTANT",
          style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        centerTitle: true,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildHeaderSection(String summary) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.auto_fix_high, color: Colors.white, size: 40),
          const SizedBox(height: 16),
          Text(
            summary,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textPrimary, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisCard({
    required String title,
    required List<String> items,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) => Chip(
              label: Text(item, style: const TextStyle(fontSize: 12)),
              backgroundColor: color.withOpacity(0.05),
              side: BorderSide(color: color.withOpacity(0.1)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            )).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildIdealMatchCard(Map<String, dynamic> ideal) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: const NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'),
          opacity: 0.05,
          colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ideal['description'] ?? "",
            style: GoogleFonts.outfit(
              fontSize: 16,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 12),
          Text(
            "Lời khuyên tương hợp:",
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            ideal['compatibility_advice'] ?? "",
            style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text("LÀM MỚI QUIZ"),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text("KHÁM PHÁ NGAY"),
          ),
        ),
      ],
    );
  }
}
