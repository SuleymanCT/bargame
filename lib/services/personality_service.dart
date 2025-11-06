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
      nameTr: 'Zen Master Efendisi',
      nameEn: 'Ultimate Zen Master',
      descriptionTr: 'Vay be! Sen gerçekten hiçbir şey umurunda değil misin? Sevgilin evin önünde başkasıyla öpüşse bile "Eh, olsun" diyecek halde görünüyorsun. Ya gerçekten çok olgunsun, ya da... hiç umursamıyorsun? Bu kadar rahat olmak ya büyük bir hikmet, ya da tehlikeli bir kayıtsızlık. Hangisi olduğunu sen bil! 😌',
      descriptionEn: 'Wow! Do you really not care about anything? It seems like even if your partner kisses someone else in front of your house, you\'d be like "Meh, whatever." Either you\'re incredibly mature, or... you just don\'t care at all? Being this chill is either great wisdom or dangerous indifference. You decide! 😌',
      emoji: '😎',
      halleyMood: HalleyMood.cool,
    ),
    PersonalityType(
      id: 'volcano',
      nameTr: 'Patlayıcı Volkan',
      nameEn: 'Explosive Volcano',
      descriptionTr: 'Aman Tanrım! Senin sinirlerin kısa galiba. Her şey seni tetikliyor, her hareket şüpheli. Sevgilin telefonuna baktığında FBI ajanı gibi analiz yapıyorsun muhtemelen. Biraz nefes al, yoga yap, belki meditasyon? Yoksa ilişkin patlama riski altında... Boom! 💥',
      descriptionEn: 'Oh my God! You have a short fuse, don\'t you? Everything triggers you, every move is suspicious. You probably analyze your partner\'s phone like an FBI agent. Take a breath, do some yoga, maybe meditation? Otherwise your relationship is at risk of explosion... Boom! 💥',
      emoji: '🌋',
      halleyMood: HalleyMood.angry,
    ),
    PersonalityType(
      id: 'detective',
      nameTr: 'Sherlock Kıskanç',
      nameEn: 'Sherlock Jealous',
      descriptionTr: 'Tebrikler dedektif! Her mesajı, her bakışı, her gülümsemeyi not alıyorsun. Sevgilinin telefonundaki her noktama işaretini analiz ediyorsun. "Bu emoji ne anlama geliyor?" diye sorular soruyorsun. Belki de özel dedektif olmalıydın, ama ilişkide bu kadar şüphe sağlıklı değil dostum. 🔍',
      descriptionEn: 'Congratulations detective! You\'re taking notes on every text, every glance, every smile. You\'re analyzing every punctuation mark on your partner\'s phone. You\'re asking questions like "What does this emoji mean?" Maybe you should have been a private investigator, but this much suspicion isn\'t healthy in a relationship, buddy. 🔍',
      emoji: '🕵️',
      halleyMood: HalleyMood.shocked,
    ),
    PersonalityType(
      id: 'free_spirit',
      nameTr: 'Özgürlük Aşığı',
      nameEn: 'Freedom Lover',
      descriptionTr: 'Özgürlük senin için her şey! Sevgilinin ne yaptığı, kiminle takıldığı umurunda bile değil. "Herkes özgürdür" diyorsun. Güzel bir düşünce... ama bazen bu özgürlük meselesi "umursamıyorum" ile karışıyor. İlişkide özgürlük önemli ama ilgi de gerekli. Denge bul! 🦋',
      descriptionEn: 'Freedom is everything to you! You don\'t even care what your partner does, who they hang out with. You say "Everyone is free." Nice thought... but sometimes this freedom thing gets mixed up with "I don\'t care." Freedom is important in a relationship, but so is attention. Find balance! 🦋',
      emoji: '🦋',
      halleyMood: HalleyMood.happy,
    ),
    PersonalityType(
      id: 'balanced',
      nameTr: 'Dengeli Diplomat',
      nameEn: 'Balanced Diplomat',
      descriptionTr: 'Tebrikler, sen ilişkide dengeyi bulmuş nadir insanlardan birisin! Ne çok kıskanç, ne de çok umursamaz. Her şeyi mantıklı değerlendiriyorsun. Ama dikkat et, bazen bu "denge" aslında "kararsızlık" olabilir. Duygularını yaşamaktan çekinme! ⚖️',
      descriptionEn: 'Congratulations, you\'re one of those rare people who found balance in relationships! Neither too jealous nor too indifferent. You evaluate everything logically. But be careful, sometimes this "balance" can actually be "indecisiveness." Don\'t be afraid to live your emotions! ⚖️',
      emoji: '⚖️',
      halleyMood: HalleyMood.cool,
    ),
    PersonalityType(
      id: 'sensitive',
      nameTr: 'Kırılgan Kalp',
      nameEn: 'Fragile Heart',
      descriptionTr: 'Ah be! Sen çok duygusal bir insansın. Her şey seni üzüyor, her hareket kalbini kırıyor. Sevgilinin geç cevap vermesi bile seni günlerce düşündürüyor. Kalbin çok büyük ama biraz daha sağlam olmalı. Her şeye bu kadar takılma, yoksa kendini tüketirsin! 💔',
      descriptionEn: 'Oh man! You\'re a very emotional person. Everything hurts you, every action breaks your heart. Even your partner replying late makes you think for days. Your heart is very big but it needs to be a bit stronger. Don\'t get stuck on everything, or you\'ll burn yourself out! 💔',
      emoji: '💕',
      halleyMood: HalleyMood.crying,
    ),
    PersonalityType(
      id: 'tough',
      nameTr: 'Sert Kabuklu Fıstık',
      nameEn: 'Tough Nut',
      descriptionTr: 'Dışarıdan bakınca sert görünüyorsun ama içten içe çok yumuşaksın. "Hiçbir şey beni etkilemez" diyorsun ama gece yastığa kafanı koyunca düşüncelere dalıyorsun. Bu maskeni biraz indir, duygularını paylaş. İlişkide zayıflık göstermek güçlülüktür! 🛡️',
      descriptionEn: 'From the outside you look tough but deep down you\'re very soft. You say "Nothing affects me" but at night when you lay your head on the pillow, you sink into thoughts. Lower this mask a bit, share your feelings. Showing vulnerability in a relationship is strength! 🛡️',
      emoji: '🛡️',
      halleyMood: HalleyMood.angry,
    ),
    PersonalityType(
      id: 'drama_royalty',
      nameTr: 'Drama Kraliçesi/Kralı',
      nameEn: 'Drama Queen/King',
      descriptionTr: 'Her şeyi abartıyorsun! Sevgilin 5 dakika geç cevap verince "Bitti bu iş!" diyorsun. Bir Instagram beğenisi seni günlerce rahatsız ediyor. Hayat bir soap opera değil dostum. Biraz sakinleş, her şey bir drama konusu değil. Yoksa sevgilini yorarsın! 👑',
      descriptionEn: 'You exaggerate everything! When your partner replies 5 minutes late, you say "It\'s over!" An Instagram like bothers you for days. Life isn\'t a soap opera, buddy. Calm down a bit, not everything is a drama topic. Otherwise you\'ll tire out your partner! 👑',
      emoji: '👑',
      halleyMood: HalleyMood.shocked,
    ),
    PersonalityType(
      id: 'trust_expert',
      nameTr: 'Naif Güvenen',
      nameEn: 'Naive Truster',
      descriptionTr: 'Sen herkese güveniyorsun. Çok tatlı ama... bazen bu saf güven tehlikeli olabilir. Sevgilinin her dediğine inanıyorsun, hiç sorgulamıyorsun. Güven önemli ama körü körüne güvenmek de saflık. Biraz uyanık ol, gözlerini aç! 😇',
      descriptionEn: 'You trust everyone. Very sweet but... sometimes this naive trust can be dangerous. You believe everything your partner says, never question it. Trust is important but blind trust is also naivety. Wake up a bit, open your eyes! 😇',
      emoji: '🤝',
      halleyMood: HalleyMood.happy,
    ),
    PersonalityType(
      id: 'skeptic',
      nameTr: 'Paranoyak Şüpheci',
      nameEn: 'Paranoid Skeptic',
      descriptionTr: 'Her şeyi sorguluyorsun! "Neden bu saatte online?" "Bu kim?" "Neredesin?" Sürekli sorular, sürekli şüphe. Mantıklı olmak güzel ama bu kadar şüphe ilişkiyi zehirler. Biraz gevşe, her şey komploya bağlanmaz. İlişkide biraz güven gerekli! 🔍',
      descriptionEn: 'You question everything! "Why are you online at this hour?" "Who is this?" "Where are you?" Constant questions, constant suspicion. Being logical is good but this much suspicion poisons the relationship. Relax a bit, not everything is a conspiracy. You need some trust in a relationship! 🔍',
      emoji: '🔍',
      halleyMood: HalleyMood.shocked,
    ),
    PersonalityType(
      id: 'control_freak',
      nameTr: 'Kontrol Manyağı',
      nameEn: 'Control Freak',
      descriptionTr: 'Her şeyi kontrol etmek istiyorsun! Sevgilinin nerede olduğunu, kiminle konuştuğunu, ne yediğini bile bilmek istiyorsun. Haber: İlişki bir hapishane değil! İnsanlar özgürdür. Bu kontrol merakın ilişkini mahveder. Bırak biraz nefes alsın sevgilin! 🎮',
      descriptionEn: 'You want to control everything! You want to know where your partner is, who they\'re talking to, even what they\'re eating. News flash: A relationship isn\'t a prison! People are free. This control obsession will ruin your relationship. Let your partner breathe a bit! 🎮',
      emoji: '🎮',
      halleyMood: HalleyMood.angry,
    ),
    PersonalityType(
      id: 'passive_aggressive',
      nameTr: 'Pasif Agresif Usta',
      nameEn: 'Passive Aggressive Master',
      descriptionTr: '"Sorun yok" diyorsun ama belli ki sorun var! Sessizce kızıyorsun, ima ile konuşuyorsun. "İstersen yap" ama yaparsa da kızacaksın. Net ol dostum! Duyguları n açıkça ifade et. Bu pasif agresif tavır ilişkide toksik! 😤',
      descriptionEn: 'You say "No problem" but clearly there is a problem! You\'re silently angry, speaking with implications. "Do it if you want" but you\'ll be angry if they do. Be clear, buddy! Express your feelings openly. This passive aggressive attitude is toxic in a relationship! 😤',
      emoji: '😤',
      halleyMood: HalleyMood.angry,
    ),
    PersonalityType(
      id: 'overthinker',
      nameTr: 'Aşırı Düşünen Kafa',
      nameEn: 'Overthinker Brain',
      descriptionTr: 'Kafan sürekli çalışıyor! Sevgilinin bir mesajını 100 kez okuyorsun, her cümleyi analiz ediyorsun. "Bu ne demek?" "Neden bu emojyi kullandı?" Kafanı çok yoruyorsun. Bazen cümleler sadece cümledir, fazla anlam yükleme. Düşünmekten yaşamayı unutma! 🤯',
      descriptionEn: 'Your brain is constantly working! You read your partner\'s message 100 times, analyzing every sentence. "What does this mean?" "Why did they use this emoji?" You\'re tiring your brain too much. Sometimes sentences are just sentences, don\'t overload meaning. Don\'t forget to live while overthinking! 🤯',
      emoji: '🤯',
      halleyMood: HalleyMood.shocked,
    ),
    PersonalityType(
      id: 'people_pleaser',
      nameTr: 'Memnun Edici Robot',
      nameEn: 'People Pleasing Robot',
      descriptionTr: 'Herkesi memnun etmeye çalışıyorsun! Sevgilinin her isteğine "evet" diyorsun. Kendi sınırların yok mu? "Hayır" demekten korkuyorsun. Ama unutma: İlişkide sen de varsın! Kendi isteklerini, sınırlarını belirt. Kendini kaybetme! 🤖',
      descriptionEn: 'You\'re trying to please everyone! You say "yes" to every request from your partner. Don\'t you have your own boundaries? You\'re afraid to say "no". But remember: You exist in the relationship too! State your own wishes and boundaries. Don\'t lose yourself! 🤖',
      emoji: '🤖',
      halleyMood: HalleyMood.crying,
    ),
    PersonalityType(
      id: 'commitment_phobic',
      nameTr: 'Bağlılık Fobisi',
      nameEn: 'Commitment Phobic',
      descriptionTr: 'Her şey "evet" ama aslında hep bir ayağın kapıda! Sevgilin ciddi konuşmak istediğinde kaçıyorsun. "Henüz hazır değilim" diyorsun. Ama ne zaman hazır olacaksın? İlişki riske girmektir, biraz cesur ol! Yoksa hep yalnız kalırsın! 🏃',
      descriptionEn: 'Everything is "yes" but actually you always have one foot out the door! When your partner wants to talk seriously, you run away. You say "I\'m not ready yet." But when will you be ready? Relationships are about taking risks, be a bit brave! Otherwise you\'ll always be alone! 🏃',
      emoji: '🏃',
      halleyMood: HalleyMood.shocked,
    ),
    PersonalityType(
      id: 'jealousy_monster',
      nameTr: 'Kıskançlık Canavarı',
      nameEn: 'Jealousy Monster',
      descriptionTr: 'Kıskançlıktan yanıyorsun! Sevgilinin nefes bile almasını kıskanıyorsun. Her arkadaşı rakip, her gülümseme tehdit. Bu kadar kıskançlık sağlıksız dostum! İlişkide güven olmazsa hiçbir şey olmaz. Sakin ol, yoksa sevgilini kaçırırsın! 👹',
      descriptionEn: 'You\'re burning with jealousy! You\'re even jealous when your partner breathes. Every friend is a rival, every smile is a threat. This much jealousy is unhealthy, buddy! Without trust in a relationship, nothing works. Calm down, or you\'ll push your partner away! 👹',
      emoji: '👹',
      halleyMood: HalleyMood.angry,
    ),
    PersonalityType(
      id: 'hopeless_romantic',
      nameTr: 'Umutsuz Romantik',
      nameEn: 'Hopeless Romantic',
      descriptionTr: 'Ah, sen bir masal kahramanı mısın? Her şeyin mükemmel olmasını istiyorsun, pembe dünyada yaşıyorsun. Ama gerçek hayat masal değil! İlişkilerde sorunlar olur, mükemmel anlar kadar zorlu anlar da var. Biraz gerçekçi ol, yoksa hayal kırıklığına uğrarsın! 💖',
      descriptionEn: 'Ah, are you a fairy tale character? You want everything to be perfect, you live in a pink world. But real life isn\'t a fairy tale! There are problems in relationships, there are tough moments as well as perfect ones. Be a bit realistic, or you\'ll be disappointed! 💖',
      emoji: '💖',
      halleyMood: HalleyMood.happy,
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
    final nokPercentage = 100 - okPercentage;

    // Zen Master (95%+ OK)
    if (okPercentage >= 95) return _personalities[0]; // Zen Master

    // Naif Güvenen (85-95% OK)
    if (okPercentage >= 85) return _personalities[8]; // Trust Expert

    // Özgür Ruh (75-85% OK)
    if (okPercentage >= 75) return _personalities[3]; // Free Spirit

    // Umutsuz Romantik (65-75% OK, yüksek rating)
    if (okPercentage >= 65 && avgRating >= 7) return _personalities[16]; // Hopeless Romantic

    // Dengeli Diplomat (45-65% OK)
    if (okPercentage >= 45 && okPercentage <= 65) return _personalities[4]; // Balanced

    // Memnun Edici Robot (50-60% OK, çok dengeli)
    if (okPercentage >= 50 && okPercentage <= 60 && total > 15) return _personalities[13]; // People Pleaser

    // Aşırı Düşünen (35-50% OK)
    if (okPercentage >= 35 && okPercentage < 50) return _personalities[12]; // Overthinker

    // Hassas Kalp (25-35% OK)
    if (okPercentage >= 25 && okPercentage < 35) return _personalities[5]; // Sensitive

    // Sert Kabuklu (20-30% OK, düşük rating)
    if (okPercentage >= 20 && okPercentage < 30 && avgRating < 5) return _personalities[6]; // Tough

    // Kıskanç Dedektif (15-25% OK)
    if (okPercentage >= 15 && okPercentage < 25) return _personalities[2]; // Detective

    // Paranoyak Şüpheci (10-20% OK)
    if (okPercentage >= 10 && okPercentage < 20) return _personalities[9]; // Skeptic

    // Kıskançlık Canavarı (5-15% OK)
    if (okPercentage >= 5 && okPercentage < 15) return _personalities[15]; // Jealousy Monster

    // Kontrol Manyağı (<10% NOK ağırlıklı)
    if (nokPercentage >= 90) return _personalities[10]; // Control Freak

    // Pasif Agresif (çok dengesiz cevaplar)
    if (nokPercentage >= 80 && avgRating >= 6) return _personalities[11]; // Passive Aggressive

    // Drama Kraliçesi/Kralı (çok düşük OK, yüksek tepki)
    if (okPercentage < 20 && avgRating >= 7) return _personalities[7]; // Drama Royalty

    // Patlayıcı Volkan (<5% OK)
    if (okPercentage < 5) return _personalities[1]; // Volcano

    // Bağlılık Fobisi (çok yüksek OK ama kaçamak)
    if (okPercentage >= 70 && avgRating < 4) return _personalities[14]; // Commitment Phobic

    // Varsayılan: Dengeli
    return _personalities[4];
  }
}