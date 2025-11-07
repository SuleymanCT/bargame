import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../models/player.dart';
import '../services/language_service.dart';
import 'category_selection_screen.dart';
import 'premium_modal.dart';

class PlayerSetupScreen extends StatefulWidget {
  const PlayerSetupScreen({super.key});

  @override
  State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  final List<TextEditingController> _controllers = [];
  int _playerCount = 2;
  int _questionCount = 10;
  final bool _isPremium = false; // TODO: Premium kontrolü

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startGame(LanguageService langService) {
    final players = <Player>[];
    
    for (int i = 0; i < _playerCount; i++) {
      final name = _controllers[i].text.trim();
      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              langService.translate(
                'Lütfen ${i + 1}. oyuncunun ismini girin!',
                'Please enter player ${i + 1} name!',
              ),
            ),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }
      players.add(Player(name: name, order: i + 1));
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategorySelectionScreen(
          players: players,
          questionCount: _questionCount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, langService, _) {
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
                        Text(
                          AppStrings.addPlayers(langService.currentLanguage),
                          style: AppTheme.darkTextTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Oyuncu Sayısı
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: AppTheme.softShadow,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  AppStrings.howMany(langService.currentLanguage),
                                  style: AppTheme.textTheme.titleLarge,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(4, (index) {
                                    final count = index + 1;
                                    final isSelected = _playerCount == count;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() => _playerCount = count);
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          gradient: isSelected
                                              ? AppTheme.primaryGradient
                                              : null,
                                          color: isSelected
                                              ? null
                                              : AppTheme.backgroundLight,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected
                                                ? AppTheme.primaryColor
                                                : AppTheme.textTertiary,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '$count',
                                            style: AppTheme.textTheme.headlineMedium
                                                ?.copyWith(
                                              color: isSelected
                                                  ? Colors.white
                                                  : AppTheme.textSecondary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                          
                          // Soru Sayısı
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: AppTheme.softShadow,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  AppStrings.questionCount(langService.currentLanguage),
                                  style: AppTheme.textTheme.titleLarge,
                                ),
                                const SizedBox(height: 20),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  alignment: WrapAlignment.center,
                                  children: [5, 10, 15, 20, 30, 50].map((count) {
                                    final isSelected = _questionCount == count;
                                    final isLocked = count > 20 && !_isPremium;
                                    
                                    return GestureDetector(
                                      onTap: () {
                                        if (isLocked) {
                                          showModalBottomSheet(
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            isScrollControlled: true,
                                            builder: (_) => const PremiumModal(),
                                          );
                                          return;
                                        }
                                        setState(() => _questionCount = count);
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          gradient: isSelected && !isLocked
                                              ? AppTheme.primaryGradient
                                              : null,
                                          color: isSelected && !isLocked
                                              ? null
                                              : isLocked
                                                  ? AppTheme.primaryOrange.withOpacity(0.2)
                                                  : AppTheme.backgroundLight,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: isSelected && !isLocked
                                                ? AppTheme.primaryColor
                                                : isLocked
                                                    ? AppTheme.primaryOrange
                                                    : AppTheme.textTertiary,
                                            width: 2,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Text(
                                                '$count',
                                                style: AppTheme.textTheme.headlineMedium
                                                    ?.copyWith(
                                                  color: isSelected && !isLocked
                                                      ? Colors.white
                                                      : isLocked
                                                          ? AppTheme.primaryOrange
                                                          : AppTheme.textSecondary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            if (isLocked)
                                              Positioned(
                                                top: 4,
                                                right: 4,
                                                child: Icon(
                                                  Icons.lock,
                                                  color: AppTheme.primaryOrange,
                                                  size: 16,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                          
                          // Oyuncu İsimleri
                          ...List.generate(_playerCount, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextField(
                                controller: _controllers[index],
                                style: AppTheme.textTheme.bodyLarge?.copyWith(
                                  color: AppTheme.textPrimary,
                                ),
                                decoration: InputDecoration(
                                  labelText: '${index + 1}. ${AppStrings.player(langService.currentLanguage)}',
                                  labelStyle: AppTheme.textTheme.bodyMedium,
                                  hintText: langService.translate(
                                    'İsim girin',
                                    'Enter name',
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: AppTheme.getCategoryColor('ok_not_ok'),
                                  ),
                                ),
                              ),
                            );
                          }),
                          
                          const SizedBox(height: 30),
                          
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton.icon(
                              onPressed: () => _startGame(langService),
                              icon: const Icon(Icons.arrow_forward, size: 28),
                              label: Text(AppStrings.continue_(langService.currentLanguage)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                        ],
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