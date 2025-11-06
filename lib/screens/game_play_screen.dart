import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../services/game_service.dart';
import '../services/language_service.dart';
import '../config/app_theme.dart';
import '../widgets/swipe_card.dart';
import '../widgets/rating_slider.dart';
import '../widgets/halley_avatar.dart';
import 'game_result_screen.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  final CardSwiperController _swiperController = CardSwiperController();
  bool _isAnswering = false;
  double? _selectedRating;
  bool _showRatingDialog = false;

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  void _handleSwipe(GameService gameService, int index, CardSwiperDirection direction) {
    if (_isAnswering) return;

    final question = gameService.currentQuestion;
    if (question == null) return;

    setState(() => _isAnswering = true);

    String? answer;
    
    if (question.isBinary) {
      if (direction == CardSwiperDirection.right) {
        answer = question.options![0]; // OK
        HapticFeedback.mediumImpact();
      } else if (direction == CardSwiperDirection.left) {
        answer = question.options![1]; // NOT OK
        HapticFeedback.mediumImpact();
      }

      if (answer != null) {
        gameService.submitAnswer(binaryAnswer: answer);
        _checkGameStatus(gameService);
      }
    } else if (question.isRating) {
      setState(() {
        _showRatingDialog = true;
        _isAnswering = false;
      });
      return;
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _isAnswering = false);
      }
    });
  }

  void _checkGameStatus(GameService gameService) {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (gameService.isGameFinished && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const GameResultScreen(),
          ),
        );
      }
    });
  }

  void _submitRating(GameService gameService) {
    if (_selectedRating == null) return;
    
    HapticFeedback.lightImpact();
    gameService.submitAnswer(ratingAnswer: _selectedRating);
    
    setState(() {
      _showRatingDialog = false;
      _selectedRating = null;
    });
    
    _checkGameStatus(gameService);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GameService, LanguageService>(
      builder: (context, gameService, langService, child) {
        final question = gameService.currentQuestion;
        final player = gameService.currentPlayer;
        
        if (question == null || player == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.darkGradient,
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      _buildHeader(gameService, player, langService),

                      const SizedBox(height: 20),

                      _buildDynamicHalleyAvatar(gameService, player),

                      const SizedBox(height: 20),
                      
                      Expanded(
                        child: question.isBinary
                            ? _buildSwipeCards(gameService, langService)
                            : _buildRatingCard(question, langService),
                      ),
                      
                      const SizedBox(height: 20),
                    ],
                  ),
                  
                  if (_showRatingDialog)
                    _buildRatingDialog(gameService, question, langService),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDynamicHalleyAvatar(GameService gameService, dynamic player) {
    // Mevcut oyuncunun istatistiklerini al
    final stats = gameService.currentSession?.getPlayerStats(player.id) ?? {};
    final okCount = stats['okCount'] ?? 0;
    final nokCount = stats['nokCount'] ?? 0;

    // Mood'u belirle
    HalleyMood mood = HalleyMood.happy;

    if (nokCount > okCount && nokCount >= 3) {
      // Çok fazla "nok" varsa sinirli penguen
      mood = HalleyMood.angry;
    } else if (okCount > nokCount && okCount >= 4) {
      // Çok fazla "ok" varsa sarhoş penguen
      mood = HalleyMood.drunk;
    } else if (okCount == nokCount && okCount >= 2) {
      // Eşit ve birkaç cevap varsa cool penguen
      mood = HalleyMood.cool;
    }

    return HalleyAvatar(
      mood: mood,
      size: 80,
      animate: true,
    );
  }

  Widget _buildHeader(GameService gameService, dynamic player, LanguageService langService) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: _showExitDialog,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${gameService.currentQuestionNumber}/${gameService.totalQuestions}',
                      style: AppTheme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: gameService.progress,
                        backgroundColor: AppTheme.cardColor,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.halleyYellow,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppTheme.yellowGlow(0.3),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      player.name[0].toUpperCase(),
                      style: AppTheme.textTheme.headlineSmall?.copyWith(
                        color: AppTheme.backgroundDark,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      langService.translate('Sıra', 'Turn'),
                      style: AppTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      player.name,
                      style: AppTheme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwipeCards(GameService gameService, LanguageService langService) {
  final questions = gameService.currentSession!.questions;
  final currentIndex = gameService.currentQuestionNumber - 1;
  
  final visibleQuestions = questions
      .skip(currentIndex)
      .take(3)
      .toList();

  // En az 1 kart olmalı
  if (visibleQuestions.isEmpty) {
    return const Center(child: Text('Sorular yükleniyor...'));
  }

  return CardSwiper(
    controller: _swiperController,
    cardsCount: visibleQuestions.length,
    numberOfCardsDisplayed: visibleQuestions.length > 1 ? 2 : 1, // ← DÜZELTİLDİ
    allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
      horizontal: true,
    ),
    onSwipe: (previousIndex, currentIndex, direction) {
      _handleSwipe(gameService, previousIndex, direction);
      return true;
    },
    cardBuilder: (context, index, horizontalOffset, verticalOffset) {
      if (index >= visibleQuestions.length) return const SizedBox();
      
      return SwipeCard(
        question: visibleQuestions[index],
        language: langService.currentLanguage,
      );
    },
  );
}

  Widget _buildRatingCard(dynamic question, LanguageService langService) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: AppTheme.cardGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: AppTheme.hardShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              question.getText(langService.currentLanguage),
              style: AppTheme.textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showRatingDialog = true;
                  _selectedRating = 5;
                });
              },
              child: Text(langService.translate('Puanla', 'Rate')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingDialog(GameService gameService, dynamic question, LanguageService langService) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: AppTheme.cardGradient,
            borderRadius: BorderRadius.circular(30),
            boxShadow: AppTheme.hardShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                question.getText(langService.currentLanguage),
                style: AppTheme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              RatingSlider(
                min: question.minRating ?? 1,
                max: question.maxRating ?? 10,
                value: _selectedRating ?? 5,
                onChanged: (value) {
                  setState(() => _selectedRating = value);
                },
              ),
              
              const SizedBox(height: 40),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _submitRating(gameService),
                  child: Text(langService.translate('Gönder', 'Submit')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Oyundan Çık?',
          style: AppTheme.textTheme.headlineMedium,
        ),
        content: Text(
          'İlerleme kaydedilmeyecek.',
          style: AppTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Devam Et',
              style: AppTheme.textTheme.labelLarge?.copyWith(
                color: AppTheme.halleyYellow,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              context.read<GameService>().resetGame();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Çık'),
          ),
        ],
      ),
    );
  }
}