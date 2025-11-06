import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../widgets/halley_avatar.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _avatarController;
  late AnimationController _titleController;
  late AnimationController _subtitleController;
  late AnimationController _loadingController;

  late Animation<double> _avatarScaleAnimation;
  late Animation<double> _avatarFadeAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _subtitleFadeAnimation;
  late Animation<double> _subtitleScaleAnimation;
  late Animation<double> _loadingFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Avatar animasyonu
    _avatarController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _avatarScaleAnimation = CurvedAnimation(
      parent: _avatarController,
      curve: Curves.elasticOut,
    );
    _avatarFadeAnimation = CurvedAnimation(
      parent: _avatarController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
    );

    // Title animasyonu
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _titleFadeAnimation = CurvedAnimation(
      parent: _titleController,
      curve: Curves.easeIn,
    );
    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _titleController,
      curve: Curves.easeOut,
    ));

    // Subtitle animasyonu
    _subtitleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _subtitleFadeAnimation = CurvedAnimation(
      parent: _subtitleController,
      curve: Curves.easeIn,
    );
    _subtitleScaleAnimation = CurvedAnimation(
      parent: _subtitleController,
      curve: Curves.easeOut,
    );

    // Loading animasyonu
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _loadingFadeAnimation = CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeIn,
    );

    // Animasyonları başlat
    _startAnimations();
    _navigateToHome();
  }

  void _startAnimations() async {
    _avatarController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _titleController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _subtitleController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _loadingController.forward();
  }

  @override
  void dispose() {
    _avatarController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Halley Avatar - Duolingo tarzı büyük karakter
              FadeTransition(
                opacity: _avatarFadeAnimation,
                child: ScaleTransition(
                  scale: _avatarScaleAnimation,
                  child: const HalleyAvatar(
                    mood: HalleyMood.happy,
                    size: 220,
                    animate: false,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // App Name - Duolingo tarzı büyük, bold başlık
              FadeTransition(
                opacity: _titleFadeAnimation,
                child: SlideTransition(
                  position: _titleSlideAnimation,
                  child: Text(
                    'halley',
                    style: AppTheme.textTheme.displayLarge?.copyWith(
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
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
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              FadeTransition(
                opacity: _subtitleFadeAnimation,
                child: ScaleTransition(
                  scale: _subtitleScaleAnimation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Ok? Nok?',
                      style: AppTheme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // Loading indicator - Duolingo tarzı
              FadeTransition(
                opacity: _loadingFadeAnimation,
                child: Column(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        strokeWidth: 4,
                        backgroundColor: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Yükleniyor...',
                      style: AppTheme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}