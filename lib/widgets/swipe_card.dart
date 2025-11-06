import 'package:flutter/material.dart';
import '../models/question.dart';
import '../config/app_theme.dart';
import 'halley_avatar.dart';

class SwipeCard extends StatelessWidget {
  final Question question;
  final String language;

  const SwipeCard({
    super.key,
    required this.question,
    this.language = 'tr',
  });

  String get _categoryEmoji {
    switch (question.category) {
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.cardColor,
            AppTheme.cardColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: AppTheme.hardShadow,
        border: Border.all(
          color: AppTheme.halleyYellow.withOpacity(0.2),
          width: 2,
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
                        question.getText(language),
                        style: AppTheme.textTheme.displaySmall?.copyWith(
                          fontSize: 28,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Swipe hint
                  if (question.isBinary && question.options != null && question.options!.length == 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSwipeHint(
                          Icons.close,
                          question.options![1], // Sol taraf (NOT OK, Kıskanmam, Değil, Yapamaz)
                          AppTheme.errorColor,
                          Icons.arrow_back,
                        ),
                        _buildSwipeHint(
                          Icons.check,
                          question.options![0], // Sağ taraf (OK, Kıskanırım, Aldatma, Yapabilir)
                          AppTheme.successColor,
                          Icons.arrow_forward,
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
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(arrowIcon, color: color, size: 16),
            const SizedBox(width: 4),
            Text(
              text,
              style: AppTheme.textTheme.labelLarge?.copyWith(
                color: color,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getCategoryName() {
    switch (question.category) {
      case 'ok_not_ok':
        return language == 'tr' ? 'OK mu NOT OK mu?' : 'OK or NOT OK?';
      case 'kiskanc':
        return language == 'tr' ? 'Kıskanç mısın?' : 'Jealous?';
      case 'aldatma':
        return language == 'tr' ? 'Aldatma mı?' : 'Cheating?';
      case 'sevgilim_yapabilir':
        return language == 'tr' ? 'Yapabilir mi?' : 'Can they?';
      case 'kac_kizarsin':
        return language == 'tr' ? 'Kaç Kızarsın?' : 'How Angry?';
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