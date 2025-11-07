import 'package:flutter/material.dart';
import '../models/question.dart';
import '../config/app_theme.dart';
import 'halley_avatar.dart';

class SwipeCard extends StatefulWidget {
  final Question question;
  final String language;

  const SwipeCard({
    super.key,
    required this.question,
    this.language = 'tr',
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String get _categoryEmoji {
    switch (widget.question.category) {
      case 'ok_not_ok':
        return '🔥';
      case 'kiskanc':
        return '😤';
      case 'aldatma':
        return '💔';
      case 'sevgilim_yapabilir':
        return '❓';
      case 'kac_kizarsin':
        return '😡';
      default:
        return '❓';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * 0.6,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryYellow.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(
          color: AppTheme.primaryYellow,
          width: 3,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _PatternPainter(),
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Category badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.halleyYellow,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: AppTheme.yellowGlow(0.4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _categoryEmoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getCategoryName(),
                          style: AppTheme.textTheme.labelLarge?.copyWith(
                            color: AppTheme.backgroundDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Question text
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.question.getText(widget.language),
                        style: AppTheme.textTheme.displaySmall?.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          height: 1.4,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Swipe hint
                  if (widget.question.isBinary && widget.question.options != null && widget.question.options!.length == 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ScaleTransition(
                          scale: _pulseAnimation,
                          child: _buildSwipeHint(
                            Icons.close_rounded,
                            widget.question.options![1], // Sol taraf (NOT OK, Kıskanmam, Değil, Yapamaz)
                            AppTheme.errorColor,
                            Icons.arrow_back_rounded,
                          ),
                        ),
                        ScaleTransition(
                          scale: _pulseAnimation,
                          child: _buildSwipeHint(
                            Icons.check_rounded,
                            widget.question.options![0], // Sağ taraf (OK, Kıskanırım, Aldatma, Yapabilir)
                            AppTheme.successColor,
                            Icons.arrow_forward_rounded,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwipeHint(
    IconData icon,
    String text,
    Color color,
    IconData arrowIcon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 3),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 36),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(arrowIcon, color: color, size: 18),
              const SizedBox(width: 6),
              Text(
                text,
                style: AppTheme.textTheme.labelLarge?.copyWith(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getCategoryName() {
    switch (widget.question.category) {
      case 'ok_not_ok':
        return widget.language == 'tr' ? 'OK mu NOT OK mu?' : 'OK or NOT OK?';
      case 'kiskanc':
        return widget.language == 'tr' ? 'Kıskanç mısın?' : 'Jealous?';
      case 'aldatma':
        return widget.language == 'tr' ? 'Aldatma mı?' : 'Cheating?';
      case 'sevgilim_yapabilir':
        return widget.language == 'tr' ? 'Yapabilir mi?' : 'Can they?';
      case 'kac_kizarsin':
        return widget.language == 'tr' ? 'Kaç Kızarsın?' : 'How Angry?';
      default:
        return '';
    }
  }
}

// Pattern painter for background
class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.halleyYellow.withOpacity(0.03)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const spacing = 30.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i, size.height),
        paint,
      );
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(
        Offset(0, i),
        Offset(size.width, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}