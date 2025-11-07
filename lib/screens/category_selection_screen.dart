import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../models/player.dart';
import '../services/game_service.dart';
import '../services/language_service.dart';
import 'game_play_screen.dart';

class CategorySelectionScreen extends StatefulWidget {
  final List<Player> players;
  final int questionCount;

  const CategorySelectionScreen({
    super.key,
    required this.players,
    required this.questionCount,
  });

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  String? _selectedCategory;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'ok_not_ok',
      'name_tr': 'OK mu NOT OK mu?',
      'name_en': 'OK or NOT OK?',
      'emoji': '🔥',
      'color': AppTheme.okNotOkColor,
      'description_tr': 'İlişkide sınırları belirle',
      'description_en': 'Define relationship boundaries',
    },
    {
      'id': 'kiskanc',
      'name_tr': 'Ne Kadar Kıskanç?',
      'name_en': 'How Jealous?',
      'emoji': '😤',
      'color': AppTheme.jealousColor,
      'description_tr': 'Kıskançlık seviyeni test et',
      'description_en': 'Test your jealousy level',
    },
    {
      'id': 'aldatma',
      'name_tr': 'Aldatma mı Değil mi?',
      'name_en': 'Is it Cheating?',
      'emoji': '💔',
      'color': AppTheme.cheatingColor,
      'description_tr': 'Aldatma sınırlarını çiz',
      'description_en': 'Draw cheating boundaries',
    },
    {
      'id': 'sevgilim_yapabilir',
      'name_tr': 'Sevgilim Yapabilir mi?',
      'name_en': 'Can My Partner Do?',
      'emoji': '❓',
      'color': AppTheme.canDoColor,
      'description_tr': 'İzin verebileceğin şeyleri keşfet',
      'description_en': 'Discover what you allow',
    },
    {
      'id': 'kac_kizarsin',
      'name_tr': 'Kaç Kızarsın?',
      'name_en': 'How Angry?',
      'emoji': '😡',
      'color': AppTheme.angerColor,
      'description_tr': '1\'den 10\'a öfke seviyeni bul',
      'description_en': 'Find your anger level 1-10',
    },
  ];

  Future<void> _startGame() async {
    if (_selectedCategory == null) {
      final langService = context.read<LanguageService>();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            langService.translate(
              'Lütfen bir kategori seçin!',
              'Please select a category!',
            ),
          ),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final gameService = context.read<GameService>();
      await gameService.startNewGame(
        players: widget.players,
        category: _selectedCategory!,
        questionCount: widget.questionCount,
      );

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const GamePlayScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, langService, _) {
        final lang = langService.currentLanguage;
        
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.backgroundGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: AppTheme.textPrimary),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.selectCategory(lang),
                                style: AppTheme.darkTextTheme.headlineMedium,
                              ),
                              Text(
                                '${widget.players.length} ${langService.translate("oyuncu", "players")} • ${widget.questionCount} ${langService.translate("soru", "questions")}',
                                style: AppTheme.darkTextTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = _selectedCategory == category['id'];
                        final name = lang == 'tr' 
                            ? category['name_tr'] 
                            : category['name_en'];
                        final description = lang == 'tr'
                            ? category['description_tr']
                            : category['description_en'];
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category['id'];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? LinearGradient(
                                        colors: [
                                          category['color'],
                                          category['color'].withOpacity(0.8),
                                        ],
                                      )
                                    : null,
                                color: isSelected ? null : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? category['color']
                                      : AppTheme.mediumGray,
                                  width: 2,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: category['color'].withOpacity(0.4),
                                          blurRadius: 20,
                                          offset: const Offset(0, 8),
                                        ),
                                      ]
                                    : AppTheme.softShadow,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white.withOpacity(0.2)
                                          : category['color'].withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        category['emoji'],
                                        style: const TextStyle(fontSize: 32),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: AppTheme.textTheme.headlineSmall
                                              ?.copyWith(
                                            color: isSelected
                                                ? Colors.white
                                                : AppTheme.textPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          description,
                                          style:
                                              AppTheme.textTheme.bodyMedium?.copyWith(
                                            color: isSelected
                                                ? Colors.white70
                                                : AppTheme.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _startGame,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.play_arrow, size: 28),
                        label: Text(_isLoading 
                            ? langService.translate('Hazırlanıyor...', 'Preparing...')
                            : AppStrings.startGame(lang)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                        ),
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
}