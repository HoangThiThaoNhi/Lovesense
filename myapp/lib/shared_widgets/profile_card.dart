import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/user_model.dart';
import '../../theme.dart';
import '../core/utils/api_service.dart';
import 'glass_container.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileCard extends StatelessWidget {
  final User user;

  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            // Main Image
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: ApiService.formatImageUrl(user.imageUrls.isNotEmpty ? user.imageUrls.first : null),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => CachedNetworkImage(
                  imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=1000&auto=format&fit=crop',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Gradient Overlay for Text Visibility
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.9),
                    ],
                    stops: const [0.5, 0.75, 1.0],
                  ),
                ),
              ),
            ),

            // User Info
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          user.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: AppTextStyles.displayMedium.copyWith(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Text(
                          '${user.age} tuổi',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white70, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Cách đây ${user.distanceKm} km${user.livingAt != null && user.livingAt!.isNotEmpty ? ' • ${user.livingAt}' : ''}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (user.job.isNotEmpty)
                  Row(
                    children: [
                      const Icon(Icons.work, color: Colors.white70, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          user.job,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Interest Chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      ...user.interests.take(3).map((interest) {
                        return GlassContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          child: Text(
                            interest,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            
            // Gamification Badge (Top Right)
            Positioned(
              top: 20,
              right: 20,
              child: _buildBadge(
                user.points >= 1000 ? 'assets/images/gold_badge_3d.png' :
                user.points >= 500 ? 'assets/images/silver_badge_3d.png' :
                'assets/images/bronze_badge_3d.png',
                user.points >= 1000 ? 'Gold Heart' :
                user.points >= 500 ? 'Silver Heart' :
                'Bronze Heart',
                Colors.blueAccent,
              ),
            ),

            // DNA Match Badges (Top Left)
            if (user.isDNAMatch == true || user.matchReason != null)
            Positioned(
              top: 20.0,
              left: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (user.isDNAMatch == true)
                  _buildBadge(
                    'assets/images/new_double_heart_3d.png',
                    'Soulmate Match',
                    Colors.pinkAccent,
                  ),
                  if (user.matchReason != null)
                  Container(
                    margin: EdgeInsets.only(top: user.isDNAMatch == true ? 8 : 0),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.stars_rounded, color: Colors.amber, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          user.matchReason!,
                          style: const TextStyle(
                            color: Colors.white, 
                            fontSize: 11, 
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // AI Basic Match (Alternative)
            if (user.isDNAMatch != true && (user.matchScore ?? 0) > 0)
            Positioned(
              top: 20.0,
              left: 20.0,
              child: _buildBadge(
                'assets/images/new_double_heart_3d.png',
                'AI Tương Hợp',
                AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String iconPath, String text, Color color, {bool showSparkle = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 24, height: 24, fit: BoxFit.contain),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black45, blurRadius: 2, offset: Offset(1, 1))],
            ),
          ),
        ],
      ),
    );
  }
}