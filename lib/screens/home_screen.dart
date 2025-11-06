import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../services/language_service.dart';
import '../widgets/halley_avatar.dart';
import 'player_setup_screen.dart';
import 'basket_setup_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  // Header
                  _buildHeader(langService),
                  
                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          // Halley Avatar
                          HalleyAvatar(
                            mood: HalleyMood.happy,
                            size: 140,
                            speechBubble: langService.translate(
                              'Merhaba! Ben Halley 🐧\nİlişki Doktorun!',
                              'Hello! I\'m Halley 🐧\nYour Relationship Doctor!',
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // App Title
                          Text(
                            'Halley',
                            style: AppTheme.textTheme.displayLarge?.copyWith(
                              foreground: Paint()
                                ..shader = AppTheme.primaryGradient.createShader(
                                  const Rect.fromLTWH(0, 0, 300, 100),
                                ),
                            ),
                          ).animate().fadeIn(delay: const Duration(milliseconds: 200)),
                          
                          const SizedBox(height: 8),
                          
                          Text(
                            'Ok? Nok?',
                            style: AppTheme.textTheme.headlineMedium?.copyWith(
                              color: AppTheme.textSecondary,
                              letterSpacing: 3,
                            ),
                          ).animate().fadeIn(delay: const Duration(milliseconds: 300)),
                          
                          const SizedBox(height: 50),
                          
                          // Menu Buttons
                          _buildMenuButton(
                            context,
                            icon: Icons.play_arrow_rounded,
                            title: AppStrings.newGame(lang),
                            subtitle: langService.translate(
                              'Klasik mod',
                              'Classic mode',
                            ),
                            gradient: AppTheme.primaryGradient,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PlayerSetupScreen(),
                                ),
                              );
                            },
                          ).animate().fadeIn(delay: const Duration(milliseconds: 400)).slideX(begin: -0.2),
                          
                          const SizedBox(height: 16),
                          
                          _buildMenuButton(
                            context,
                            icon: Icons.shopping_basket,
                            title: AppStrings.mixedBasket(lang),
                            subtitle: 'Premium ✨',
                            gradient: AppTheme.primaryGradient,
                            isPremium: true,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const BasketSetupScreen(),
                                ),
                              );
                            },
                          ).animate().fadeIn(delay: const Duration(milliseconds: 500)).slideX(begin: -0.2),
                          
                          const SizedBox(height: 16),
                          
                          _buildMenuButton(
                            context,
                            icon: Icons.settings_rounded,
                            title: AppStrings.settings(lang),
                            subtitle: langService.translate(
                              'Ayarlar',
                              'Settings',
                            ),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF616161), Color(0xFF424242)],
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    langService.translate(
                                      'Yakında!',
                                      'Coming soon!',
                                    ),
                                  ),
                                  backgroundColor: AppTheme.halleyYellow,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                          ).animate().fadeIn(delay: const Duration(milliseconds: 600)).slideX(begin: -0.2),
                        ],
                      ),
                    ),
                  ),
                  
                  // Footer
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'v1.0.0 • Made with 🐧',
                      style: AppTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 700)),
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppTheme.softShadow,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLangButton('TR', langService.isTurkish, () {
                  langService.setLanguage('tr');
                }),
                const SizedBox(width: 4),
                _buildLangButton('EN', langService.isEnglish, () {
                  langService.setLanguage('en');
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLangButton(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isActive ? AppTheme.primaryGradient : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: AppTheme.textTheme.labelLarge?.copyWith(
            color: isActive ? AppTheme.backgroundDark : AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
    bool isPremium = false,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.0),
      duration: const Duration(milliseconds: 100),
      builder: (context, scale, child) {
        return GestureDetector(
          onTapDown: (_) {
            // Scale down animation başlat
          },
          onTapUp: (_) {
            // Scale up animation başlat
          },
          onTapCancel: () {
            // Scale up animation başlat
          },
          onTap: onTap,
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24), // Duolingo tarzı daha büyük padding
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(24), // Daha yuvarlak köşeler
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 3, // Kalın border
                ),
                boxShadow: [
                  BoxShadow(
                    color: gradient.colors.first.withOpacity(0.4),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                    spreadRadius: 2,
                  ),
                  // İkinci shadow katmanı - daha derinlik
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 32, // Daha büyük icon
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTheme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800, // Daha bold
                            fontSize: 20,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: AppTheme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPremium ? Icons.workspace_premium : Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}