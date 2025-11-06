import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/app_theme.dart';

enum HalleyMood {
  happy,
  cool,
  drunk,
  angry,
  crying,
  shocked,
}

class HalleyAvatar extends StatelessWidget {
  final HalleyMood mood;
  final double size;
  final String? speechBubble;
  final bool animate;

  const HalleyAvatar({
    super.key,
    this.mood = HalleyMood.happy,
    this.size = 120,
    this.speechBubble,
    this.animate = true,
  });

  String get _imagePath {
    // Arka plan olmayan versiyonlar kullan
    switch (mood) {
      case HalleyMood.happy:
        return 'assets/images/halley/halley_happy.png';
      case HalleyMood.cool:
        return 'assets/images/halley/halley_cool.png';
      case HalleyMood.drunk:
        return 'assets/images/halley/halley_drunk.png';
      case HalleyMood.angry:
        return 'assets/images/halley/halley_angry.png';
      case HalleyMood.crying:
        return 'assets/images/halley/halley_crying.png';
      case HalleyMood.shocked:
        return 'assets/images/halley/halley_shocked.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: AppTheme.yellowGlow(0.2),
          ),
          child: Image.asset(
            _imagePath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.primaryGradient,
                ),
                child: const Icon(
                  Icons.pets,
                  size: 60,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
        
        if (speechBubble != null) ...[
          const SizedBox(height: 16),
          Container(
            constraints: BoxConstraints(maxWidth: size * 2.5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: AppTheme.primaryYellow,
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppTheme.softShadow,
            ),
            child: Text(
              speechBubble!,
              style: AppTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.backgroundDark,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );

    if (animate) {
      return avatar
          .animate()
          .fadeIn(duration: 400.ms)
          .scale(begin: const Offset(0.8, 0.8))
          .then()
          .shimmer(
            duration: 1500.ms,
            color: AppTheme.primaryYellow.withOpacity(0.3),
          );
    }

    return avatar;
  }
}