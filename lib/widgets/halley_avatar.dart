import 'package:flutter/material.dart';
import '../config/app_theme.dart';

enum HalleyMood {
  happy,
  cool,
  drunk,
  angry,
  crying,
  shocked,
}

class HalleyAvatar extends StatefulWidget {
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

  @override
  State<HalleyAvatar> createState() => _HalleyAvatarState();
}

class _HalleyAvatarState extends State<HalleyAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      );

      _fadeAnimation = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      );

      _scaleAnimation = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      );

      _controller.forward();
    }
  }

  @override
  void dispose() {
    if (widget.animate) {
      _controller.dispose();
    }
    super.dispose();
  }

  String get _imagePath {
    // Arka plan olmayan versiyonlar kullan
    switch (widget.mood) {
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
          width: widget.size,
          height: widget.size,
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

        if (widget.speechBubble != null) ...[
          const SizedBox(height: 16),
          Container(
            constraints: BoxConstraints(maxWidth: widget.size * 2.5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: AppTheme.primaryYellow,
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppTheme.softShadow,
            ),
            child: Text(
              widget.speechBubble!,
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

    if (widget.animate) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(_scaleAnimation),
          child: avatar,
        ),
      );
    }

    return avatar;
  }
}