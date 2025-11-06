import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/app_theme.dart';
import '../widgets/halley_avatar.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
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
              const HalleyAvatar(
                mood: HalleyMood.happy,
                size: 240, // Daha büyük
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 400))
                  .scale(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.elasticOut,
                  )
                  .then() // Zincirleme animasyon
                  .shimmer(
                    duration: const Duration(milliseconds: 1200),
                    color: Colors.white.withOpacity(0.3),
                  )
                  .shake(
                    hz: 2,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 800),
                  ),

              const SizedBox(height: 50),

              // App Name - Duolingo tarzı büyük, bold başlık
              Text(
                'halley',
                style: AppTheme.textTheme.displayLarge?.copyWith(
                  fontSize: 64, // Daha büyük
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 3,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                    ),
                    // Glow efekti
                    Shadow(
                      color: AppTheme.halleyYellow.withOpacity(0.5),
                      offset: const Offset(0, 0),
                      blurRadius: 20,
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 300), duration: const Duration(milliseconds: 600))
                  .slideY(begin: 0.3, end: 0, curve: Curves.easeOutBack)
                  .then()
                  .shimmer(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 1500),
                    color: Colors.white.withOpacity(0.4),
                  ),

              const SizedBox(height: 12),

              // Subtitle - Duolingo tarzı pill şeklinde
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'Ok? Nok?',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3,
                    fontSize: 26,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 600), duration: const Duration(milliseconds: 600))
                  .scale(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.elasticOut,
                  )
                  .then()
                  .shimmer(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 1200),
                    color: Colors.white.withOpacity(0.5),
                  ),

              const Spacer(flex: 2),

              // Loading indicator - Duolingo tarzı
              Column(
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
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .fadeIn(delay: const Duration(milliseconds: 800)),

                  const SizedBox(height: 16),

                  Text(
                    'Yükleniyor...',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 1000)),
                ],
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}