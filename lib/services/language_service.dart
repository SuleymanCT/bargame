import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static final LanguageService _instance = LanguageService._internal();
  factory LanguageService() => _instance;
  LanguageService._internal();

  String _currentLanguage = 'tr';
  
  String get currentLanguage => _currentLanguage;
  bool get isTurkish => _currentLanguage == 'tr';
  bool get isEnglish => _currentLanguage == 'en';

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('language') ?? 'tr';
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    if (language != 'tr' && language != 'en') return;
    
    _currentLanguage = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    notifyListeners();
  }

  String translate(String tr, String en) {
    return _currentLanguage == 'tr' ? tr : en;
  }
}

// Translations
class AppStrings {
  static String newGame(String lang) => 
      lang == 'tr' ? 'Yeni Oyun Başlat' : 'Start New Game';
  
  static String history(String lang) => 
      lang == 'tr' ? 'Geçmiş Oyunlar' : 'Game History';
  
  static String settings(String lang) => 
      lang == 'tr' ? 'Ayarlar' : 'Settings';
  
  static String addPlayers(String lang) => 
      lang == 'tr' ? 'Oyuncuları Ekle' : 'Add Players';
  
  static String howMany(String lang) => 
      lang == 'tr' ? 'Kaç Kişi Oynayacak?' : 'How Many Players?';
  
  static String player(String lang) => 
      lang == 'tr' ? 'Oyuncu' : 'Player';
  
  static String continue_(String lang) => 
      lang == 'tr' ? 'Devam Et' : 'Continue';
  
  static String selectCategory(String lang) => 
      lang == 'tr' ? 'Kategori Seç' : 'Select Category';
  
  static String startGame(String lang) => 
      lang == 'tr' ? 'Oyunu Başlat' : 'Start Game';
  
  static String gameFinished(String lang) => 
      lang == 'tr' ? 'Oyun Bitti!' : 'Game Finished!';
  
  static String homeMenu(String lang) => 
      lang == 'tr' ? 'Ana Menü' : 'Home Menu';
  
  static String shareResults(String lang) => 
      lang == 'tr' ? 'Sonuçları Paylaş' : 'Share Results';
  
  static String questionCount(String lang) => 
      lang == 'tr' ? 'Soru Sayısı' : 'Question Count';
  
  static String mixedBasket(String lang) => 
      lang == 'tr' ? 'Karışık Sepet' : 'Mixed Basket';
  
  static String premium(String lang) => 
      lang == 'tr' ? 'Premium' : 'Premium';
  
  static String unlock(String lang) => 
      lang == 'tr' ? 'Kilidi Aç' : 'Unlock';
  
  static String close(String lang) => 
      lang == 'tr' ? 'Kapat' : 'Close';
}