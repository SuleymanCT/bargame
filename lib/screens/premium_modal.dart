import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class PremiumModal extends StatelessWidget {
  const PremiumModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.darkGradient,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: AppTheme.textTertiary,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          
          const SizedBox(height: 30),
          
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primaryYellow, AppTheme.primaryOrange],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryOrange.withOpacity(0.5),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: const Icon(
              Icons.workspace_premium,
              size: 60,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 30),
          
          Text(
            'Premium Özellik',
            style: AppTheme.textTheme.displayMedium,
          ),

          const SizedBox(height: 16),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Bu özellik premium kullanıcılar için!\n20+ soru ve karışık sepet ile sınırsız eğlence.',
              style: AppTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 40),
          
          _buildFeature(
            icon: Icons.all_inclusive,
            title: 'Sınırsız Soru',
            description: '20+ soru seçeneği',
          ),

          _buildFeature(
            icon: Icons.shopping_basket,
            title: 'Karışık Sepet',
            description: '5 kategoriden karışık sorular',
          ),

          _buildFeature(
            icon: Icons.star,
            title: 'Premium Sorular',
            description: 'Özel premium soru havuzu',
          ),
          
          const SizedBox(height: 40),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryYellow, AppTheme.primaryOrange],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryOrange.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        // TODO: Premium satın alma
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Yakında aktif olacak!'),
                            backgroundColor: AppTheme.successColor,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.workspace_premium,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Premium Al - ₺49.99/ay',
                              style: AppTheme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Belki Sonra',
                    style: AppTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.textTheme.titleLarge,
                ),
                Text(
                  description,
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
}