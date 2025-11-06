import '../widgets/halley_avatar.dart';
class PersonalityType {
  final String id;
  final String nameTr;
  final String nameEn;
  final String descriptionTr;
  final String descriptionEn;
  final String emoji;
  final HalleyMood halleyMood;

  PersonalityType({
    required this.id,
    required this.nameTr,
    required this.nameEn,
    required this.descriptionTr,
    required this.descriptionEn,
    required this.emoji,
    required this.halleyMood,
  });

  String getName(String lang) => lang == 'tr' ? nameTr : nameEn;
  String getDescription(String lang) => lang == 'tr' ? descriptionTr : descriptionEn;
}

class PersonalityService {
  static final List<PersonalityType> _personalities = [
    PersonalityType(
      id: 'chill_master',
      nameTr: 'Soğukkanlı Usta',
      nameEn: 'Chill Master',
      descriptionTr: 'Hiçbir şey seni rahatsız etmez. Sen tam bir zen ustasısın! 🧘',
      descriptionEn: 'Nothing bothers you. You\'re a true zen master! 🧘',
      emoji: '😎',
      halleyMood: HalleyMood.cool,
    ),
    PersonalityType(
      id: 'volcano',
      nameTr: 'Ateşli Volkan',
      nameEn: 'Fiery Volcano',
      descriptionTr: 'Duygularını yaşıyorsun! Patlamaya hazır bir volkan gibisin 🌋',
      descriptionEn: 'You live your emotions! Like a volcano ready to erupt 🌋',
      emoji: '🌋',
      halleyMood: HalleyMood.angry,
    ),
    PersonalityType(
      id: 'detective',
      nameTr: 'Kıskanç Dedektif',
      nameEn: 'Jealous Detective',
      descriptionTr: 'Her detayı fark ediyorsun. Sherlock Holmes misali! 🕵️',
      descriptionEn: 'You notice every detail. Like Sherlock Holmes! 🕵️',
      emoji: '🕵️',
      halleyMood: HalleyMood.shocked,
    ),
    PersonalityType(
      id: 'free_spirit',
      nameTr: 'Özgür Ruh',
      nameEn: 'Free Spirit',
      descriptionTr: 'Özgürlüğe değer veriyorsun. Uç kelebek, uç! 🦋',
      descriptionEn: 'You value freedom. Fly butterfly, fly! 🦋',
      emoji: '🦋',
      halleyMood: HalleyMood.happy,
    ),
    PersonalityType(
      id: 'balanced',
      nameTr: 'Dengeli Hakem',
      nameEn: 'Balanced Judge',
      descriptionTr: 'Her şeyde dengeyi buluyorsun. Mükemmel bir orta yol! ⚖️',
      descriptionEn: 'You find balance in everything. Perfect middle ground! ⚖️',
      emoji: '⚖️',
      halleyMood: HalleyMood.cool,
    ),
    PersonalityType(
      id: 'sensitive',
      nameTr: 'Hassas Kalp',
      nameEn: 'Sensitive Heart',
      descriptionTr: 'Duygusal ve empatiksin. Kalbin çok büyük! 💕',
      descriptionEn: 'You\'re emotional and empathetic. Your heart is huge! 💕',
      emoji: '💕',
      halleyMood: HalleyMood.crying,
    ),
    PersonalityType(
      id: 'tough',
      nameTr: 'Sert Kabuklı',
      nameEn: 'Tough Shell',
      descriptionTr: 'Dışardan sert, içerden yumuşaksın. Gerçek bir savaşçı! 🛡️',
      descriptionEn: 'Hard outside, soft inside. A true warrior! 🛡️',
      emoji: '🛡️',
      halleyMood: HalleyMood.angry,
    ),
    PersonalityType(
      id: 'drama_royalty',
      nameTr: 'Drama Kralı/Kraliçesi',
      nameEn: 'Drama Royalty',
      descriptionTr: 'Her şeyi büyütüyorsun ama bu senin tarzın! 👑',
      descriptionEn: 'You magnify everything but that\'s your style! 👑',
      emoji: '👑',
      halleyMood: HalleyMood.shocked,
    ),
    PersonalityType(
      id: 'trust_expert',
      nameTr: 'Güven Uzmanı',
      nameEn: 'Trust Expert',
      descriptionTr: 'İnsanlara güveniyorsun. Bu çok değerli! 🤝',
      descriptionEn: 'You trust people. That\'s very valuable! 🤝',
      emoji: '🤝',
      halleyMood: HalleyMood.happy,
    ),
    PersonalityType(
      id: 'skeptic',
      nameTr: 'Şüpheci Detektif',
      nameEn: 'Skeptic Detective',
      descriptionTr: 'Her şeyi sorguluyorsun. Mantık sende güçlü! 🔍',
      descriptionEn: 'You question everything. Logic is strong with you! 🔍',
      emoji: '🔍',
      halleyMood: HalleyMood.shocked,
    ),
  ];

  static PersonalityType analyzePersonality({
    required int okCount,
    required int nokCount,
    required double avgRating,
  }) {
    final total = okCount + nokCount;
    if (total == 0) return _personalities[4]; // Balanced
    
    final okPercentage = (okCount / total) * 100;
    
    // Soğukkanlı Usta (90%+ OK)
    if (okPercentage >= 90) return _personalities[0];
    
    // Özgür Ruh (80-90% OK)
    if (okPercentage >= 80) return _personalities[3];
    
    // Güven Uzmanı (70-80% OK)
    if (okPercentage >= 70) return _personalities[8];
    
    // Dengeli Hakem (40-70% OK)
    if (okPercentage >= 40 && okPercentage <= 70) return _personalities[4];
    
    // Hassas Kalp (30-40% OK)
    if (okPercentage >= 30) return _personalities[5];
    
    // Kıskanç Dedektif (20-30% OK)
    if (okPercentage >= 20) return _personalities[2];
    
    // Şüpheci Detektif (10-20% OK)
    if (okPercentage >= 10) return _personalities[9];
    
    // Ateşli Volkan (<10% OK)
    return _personalities[1];
  }
}