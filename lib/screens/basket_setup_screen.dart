import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../models/player.dart';
import '../services/language_service.dart';
import 'player_setup_screen.dart';
import 'premium_modal.dart';

class BasketSetupScreen extends StatefulWidget {
  const BasketSetupScreen({super.key});

  @override
  State<BasketSetupScreen> createState() => _BasketSetupScreenState();
}

class _BasketSetupScreenState extends State<BasketSetupScreen> {
  final bool _isPremium = false; // TODO: Premium kontrolü eklenecek
  
  final Map<String, int> _basket = {
    'ok_not_ok': 0,
    'kiskanc': 0,
    'aldatma': 0,
    'sevgilim_yapabilir': 0,
    'kac_kizarsin': 0,
  };

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'ok_not_ok',
      'name_tr': 'OK mu NOT OK mu?',
      'name_en': 'OK or NOT OK?',
      'emoji': '🔥',
      'color': AppTheme.okNotOkColor,
    },
    {
      'id': 'kiskanc',
      'name_tr': 'Ne Kadar Kıskanç?',
      'name_en': 'How Jealous?',
      'emoji': '😤',
      'color': AppTheme.jealousColor,
    },
    {
      'id': 'aldatma',
      'name_tr': 'Aldatma mı Değil mi?',
      'name_en': 'Is it Cheating?',
      'emoji': '💔',
      'color': AppTheme.cheatingColor,
    },
    {
      'id': 'sevgilim_yapabilir',
      'name_tr': 'Sevgilim Yapabilir mi?',
      'name_en': 'Can My Partner Do?',
      'emoji': '❓',
      'color': AppTheme.canDoColor,
    },
    {
      'id': 'kac_kizarsin',
      'name_tr': 'Kaç Kızarsın?',
      'name_en': 'How Angry?',
      'emoji': '😡',
      'color': AppTheme.angerColor,
    },
  ];

  int get _totalQuestions => _basket.values.reduce((a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, langService, _) {
        final lang = langService.currentLanguage;
        
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.darkGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(langService),
                  
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildBasketInfo(langService),
                          
                          const SizedBox(height: 30),
                          
                          ...List.generate(_categories.length, (index) {
                            final category = _categories[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildCategoryCounter(
                                category,
                                langService,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  
                  _buildBottomBar(langService),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(LanguageService langService) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      langService.translate('Karışık Sepet', 'Mixed Basket'),
                      style: AppTheme.textTheme.headlineMedium,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.primaryYellow, AppTheme.primaryOrange],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'PREMIUM',
                        style: AppTheme.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  langService.translate(
                    '5 kategoriden soru seç',
                    'Choose from 5 categories',
                  ),
                  style: AppTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasketInfo(LanguageService langService) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.2),
            AppTheme.secondaryColor.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            langService.translate('Toplam Soru', 'Total Questions'),
            style: AppTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$_totalQuestions',
            style: AppTheme.textTheme.displayLarge?.copyWith(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = AppTheme.primaryGradient.createShader(
                  const Rect.fromLTWH(0, 0, 200, 70),
                ),
            ),
          ),
          if (_totalQuestions > 0) ...[
            const SizedBox(height: 8),
            Text(
              langService.translate(
                '5 kategoriden karışık',
                'Mixed from 5 categories',
              ),
              style: AppTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryCounter(
    Map<String, dynamic> category,
    LanguageService langService,
  ) {
    final categoryId = category['id'] as String;
    final count = _basket[categoryId] ?? 0;
    final color = category['color'] as Color;
    final name = langService.isTurkish 
        ? category['name_tr'] 
        : category['name_en'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: count > 0 
              ? color.withOpacity(0.5) 
              : AppTheme.textTertiary.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                category['emoji'],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: Text(
              name,
              style: AppTheme.textTheme.titleLarge,
            ),
          ),
          
          Row(
            children: [
              _buildCountButton(
                icon: Icons.remove,
                onTap: count > 0
                    ? () {
                        setState(() {
                          _basket[categoryId] = count - 1;
                        });
                      }
                    : null,
                color: color,
              ),
              
              const SizedBox(width: 12),
              
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: count > 0
                      ? LinearGradient(
                          colors: [color, color.withOpacity(0.7)],
                        )
                      : null,
                  color: count > 0 ? null : AppTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '$count',
                    style: AppTheme.textTheme.headlineMedium?.copyWith(
                      color: count > 0 ? Colors.white : AppTheme.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              _buildCountButton(
                icon: Icons.add,
                onTap: () {
                  setState(() {
                    _basket[categoryId] = count + 1;
                  });
                },
                color: color,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCountButton({
    required IconData icon,
    required VoidCallback? onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: onTap != null
              ? color.withOpacity(0.2)
              : AppTheme.textTertiary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: onTap != null ? color : AppTheme.textTertiary,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildBottomBar(LanguageService langService) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton.icon(
            onPressed: _totalQuestions > 0
                ? () {
                    if (!_isPremium) {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (_) => const PremiumModal(),
                      );
                      return;
                    }
                    
                    // Premium kullanıcı - oyuncu seçimine git
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PlayerSetupScreen(),
                      ),
                    );
                  }
                : null,
            icon: Icon(
              _isPremium ? Icons.arrow_forward : Icons.lock,
              size: 28,
            ),
            label: Text(
              _totalQuestions > 0
                  ? langService.translate('Devam Et', 'Continue')
                  : langService.translate(
                      'Soru seçin',
                      'Select questions',
                    ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isPremium
                  ? AppTheme.primaryColor
                  : AppTheme.primaryOrange,
            ),
          ),
        ),
      ),
    );
  }
}