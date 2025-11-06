import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/game_service.dart';
import '../services/language_service.dart';
import '../services/personality_service.dart';
import '../config/app_theme.dart';
import '../widgets/halley_avatar.dart';
import 'home_screen.dart';

class GameResultScreen extends StatefulWidget {
  const GameResultScreen({super.key});

  @override
  State<GameResultScreen> createState() => _GameResultScreenState();
}

class _GameResultScreenState extends State<GameResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<GameService, LanguageService>(
      builder: (context, gameService, langService, _) {
        final results = gameService.getGameResults();
        
        if (results.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('Sonuç bulunamadı')),
          );
        }

        final general = results['general'] as Map<String, dynamic>;
        final session = gameService.currentSession!;
        final players = session.players;

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
                          // Halley Celebration
      const HalleyAvatar(
  mood: HalleyMood.happy,
  size: 100,
  animate: true,
),
                          
                          const SizedBox(height: 30),
                          
                          // Game Stats
                          _buildGameStats(general, langService),
                          
                          const SizedBox(height: 30),
                          
                          // Players Results
                          ...List.generate(players.length, (index) {
                            final player = players[index];
                            final playerStats = results[player.id]['stats'] as Map<String, dynamic>;
                            return _buildPlayerCard(
                              player,
                              playerStats,
                              index,
                              langService,
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  
                  _buildBottomButtons(gameService, langService),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(LanguageService langService) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        boxShadow: AppTheme.softShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              langService.translate('Sonuçlar', 'Results'),
              style: AppTheme.textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.3);
  }

  Widget _buildGameStats(Map<String, dynamic> general, LanguageService langService) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.halleyYellow.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        children: [
          Text(
            langService.translate('Oyun İstatistikleri', 'Game Statistics'),
            style: AppTheme.textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                icon: Icons.quiz,
                value: '${general['totalQuestions']}',
                label: langService.translate('Soru', 'Questions'),
              ),
              Container(
                width: 2,
                height: 40,
                color: AppTheme.textTertiary.withOpacity(0.2),
              ),
              _buildStatItem(
                icon: Icons.people,
                value: '${general['totalPlayers']}',
                label: langService.translate('Oyuncu', 'Players'),
              ),
              Container(
                width: 2,
                height: 40,
                color: AppTheme.textTertiary.withOpacity(0.2),
              ),
              _buildStatItem(
                icon: Icons.timer,
                value: _formatDuration(general['duration']),
                label: langService.translate('Süre', 'Time'),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2);
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.halleyYellow, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTheme.textTheme.headlineSmall?.copyWith(
            color: AppTheme.halleyYellow,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: AppTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerCard(
    dynamic player,
    Map<String, dynamic> stats,
    int index,
    LanguageService langService,
  ) {
    final okCount = stats['okCount'] as int;
    final nokCount = stats['nokCount'] as int;
    final avgRating = stats['averageRating'] as double;
    
    // Kişilik analizi
    final personality = PersonalityService.analyzePersonality(
      okCount: okCount,
      nokCount: nokCount,
      avgRating: avgRating,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.cardGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: index == 0 
              ? AppTheme.halleyYellow.withOpacity(0.5)
              : AppTheme.textTertiary.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: index == 0 ? AppTheme.yellowGlow(0.2) : AppTheme.softShadow,
      ),
      child: Column(
        children: [
          // Player Header
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.yellowGlow(0.3),
                    ),
                    child: Center(
                      child: Text(
                        player.name[0].toUpperCase(),
                        style: AppTheme.textTheme.displaySmall?.copyWith(
                          color: AppTheme.backgroundDark,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                  if (index == 0)
                    Positioned(
                      right: -5,
                      bottom: -5,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppTheme.halleyYellow,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '👑',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name,
                      style: AppTheme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      langService.translate(
                        '${okCount + nokCount} cevap',
                        '${okCount + nokCount} answers',
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
          
          const SizedBox(height: 24),
          
          // Personality Badge
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.halleyYellow.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.halleyYellow.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Text(
                  personality.emoji,
                  style: const TextStyle(fontSize: 48),
                ),
                const SizedBox(height: 12),
                Text(
                  personality.getName(langService.currentLanguage),
                  style: AppTheme.textTheme.headlineSmall?.copyWith(
                    color: AppTheme.halleyYellow,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  personality.getDescription(langService.currentLanguage),
                  style: AppTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Stats
          Row(
            children: [
              Expanded(
                child: _buildMiniStatCard(
                  icon: '✅',
                  value: '$okCount',
                  label: 'OK',
                  color: AppTheme.halleyYellow,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMiniStatCard(
                  icon: '❌',
                  value: '$nokCount',
                  label: 'NOT OK',
                  color: AppTheme.halleyGray,
                ),
              ),
            ],
          ),
          
          if (avgRating > 0) ...[
            const SizedBox(height: 12),
            _buildMiniStatCard(
              icon: '⭐',
              value: avgRating.toStringAsFixed(1),
              label: langService.translate('Ortalama', 'Average'),
              color: AppTheme.halleyOrange,
            ),
          ],
        ],
      ),
    ).animate(delay: (300 + 100 * index).ms).fadeIn().slideX(begin: -0.2);
  }

  Widget _buildMiniStatCard({
    required String icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTheme.textTheme.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(GameService gameService, LanguageService langService) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.backgroundDark,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  gameService.resetGame();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home_rounded, size: 24),
                label: Text(
                  langService.translate('Ana Menü', 'Home'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.halleyYellow,
                  foregroundColor: AppTheme.backgroundDark,
                ),
              ),
            ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.3),
            
            const SizedBox(height: 12),
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        langService.translate(
                          'Paylaşma özelliği yakında!',
                          'Share feature coming soon!',
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
                icon: const Icon(Icons.share_rounded, size: 24),
                label: Text(
                  langService.translate('Paylaş', 'Share'),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.halleyYellow,
                  side: BorderSide(
                    color: AppTheme.halleyYellow.withOpacity(0.5),
                    width: 2,
                  ),
                ),
              ),
            ).animate(delay: 700.ms).fadeIn().slideY(begin: 0.3),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}:${seconds.toString().padLeft(2, '0')}';
  }
}