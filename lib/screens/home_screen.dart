import 'package:flutter/material.dart';
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
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFD054), // Parlak sarı
                  Color(0xFFFFC042), // Daha koyu sarı
                  Color(0xFFF07724), // Turuncu
                ],
                stops: [0.0, 0.5, 1.0],
              ),
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
                              color: Colors.white,
                              fontSize: 56,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 3),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Ok? Nok?',
                            style: AppTheme.textTheme.headlineMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 3,
                            ),
                          ),
                          
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
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2D2D2D), Color(0xFF1A1A1A)],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PlayerSetupScreen(),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          _buildMenuButton(
                            context,
                            icon: Icons.shopping_basket,
                            title: AppStrings.mixedBasket(lang),
                            subtitle: 'Premium ✨',
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2D2D2D), Color(0xFF1A1A1A)],
                            ),
                            isPremium: true,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const BasketSetupScreen(),
                                ),
                              );
                            },
                          ),

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
                              colors: [Color(0xFF424242), Color(0xFF2D2D2D)],
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
                          ),
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
                        color: Colors.white.withOpacity(0.6),
                      ),
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

  Widget _buildHeader(LanguageService langService) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
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
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: AppTheme.textTheme.labelLarge?.copyWith(
            color: isActive ? AppTheme.backgroundDark : Colors.white.withOpacity(0.7),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            
            const SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            Icon(
              isPremium ? Icons.workspace_premium : Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}