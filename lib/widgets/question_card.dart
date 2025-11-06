import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../models/question.dart';
import '../config/app_theme.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final Color categoryColor;
  final String language;

  const QuestionCard({
    super.key,
    required this.question,
    required this.categoryColor,
    this.language = 'tr',
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 350,  // ← DÜZELTİLDİ
      borderRadius: 24,
      blur: 20,
      alignment: Alignment.center,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          categoryColor.withOpacity(0.2),
          categoryColor.withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          categoryColor.withOpacity(0.5),
          categoryColor.withOpacity(0.2),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    categoryColor,
                    categoryColor.withOpacity(0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: categoryColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _getCategoryEmoji(question.category),
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              question.getText(language),
              style: AppTheme.textTheme.displaySmall?.copyWith(
                color: AppTheme.textPrimary,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: categoryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                question.isRating
                    ? '1-10 Puanlama'
                    : '${question.options?.join(' veya ')}',
                style: AppTheme.textTheme.bodyMedium?.copyWith(
                  color: categoryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryEmoji(String category) {
    switch (category) {
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
}