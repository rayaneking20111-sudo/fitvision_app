import 'package:flutter/material.dart';

void main() {
  runApp(const FitVisionGlobalApp());
}

class AppTranslations {
  static const Map<String, Map<String, String>> _localizedValues = {
    'ar': {
      'app_title': 'فيت فيجن | Rg apps',
      'profile': 'الملف والهدف',
      'workouts': 'العضلات والتمارين',
      'ai_scanner': 'مسح الوجبة',
      'booking': 'الحجوزات',
      'wearables': 'الأجهزة',
      'select_muscle': 'اختر عضلة الجسم للبدء بالتمرين',
      'abs': 'عضلات البطن (Abs)',
      'legs': 'الأرجل والفخذ (Legs)',
      'chest': 'الصدر (Chest)',
      'back': 'الظهر (Back)',
      'shoulders': 'الأكتاف (Shoulders)',
      'arms': 'الذراعين (Arms)',
      'scan_button': 'تصوير الوجبة وتحليل الماكروز',
      'dream_target': 'هدف الجسم المثالي (Dream Body)',
      'bmr_calc': 'معدل الحرق الأساسي (BMR)',
      'book_now': 'حجز الآن',
      'sync_watch': 'مزامنة الساعة الذكية',
    },
    'en': {
      'app_title': 'FitVision | Rg apps',
      'profile': 'Profile & Goal',
      'workouts': 'Workouts',
      'ai_scanner': 'AI Scanner',
      'booking': 'Booking',
      'wearables': 'Wearables',
      'select_muscle': 'Select Target Muscle Group',
      'abs': 'Abs',
      'legs': 'Legs',
      'chest': 'Chest',
      'back': 'Back',
      'shoulders': 'Shoulders',
      'arms': 'Arms',
      'scan_button': 'Snap Meal & Analyze Macros',
      'dream_target': 'Dream Body Target',
      'bmr_calc': 'Basal Metabolic Rate (BMR)',
      'book_now': 'Book Now',
      'sync_watch': 'Sync Smartwatch',
    },
    'fr': {
      'app_title': 'FitVision | Rg apps',
      'profile': 'Profil et Objectif',
      'workouts': 'Entraînements',
      'ai_scanner': 'Scanner IA',
      'booking': 'Réservation',
      'wearables': 'Appareils',
      'select_muscle': 'Sélectionnez le groupe musculaire',
      'abs': 'Abdominaux',
      'legs': 'Jambes',
      'chest': 'Poitrine',
      'back': 'Dos',
      'shoulders': 'Épaules',
      'arms': 'Bras',
      'scan_button': 'Prendre une photo du repas',
      'dream_target': 'Corps de Rêve',
      'bmr_calc': 'Taux Métabolique de Base (BMR)',
      'book_now': 'Réserver',
      'sync_watch': 'Synchroniser la montre',
    },
    'es': {
      'app_title': 'FitVision | Rg apps',
      'profile': 'Perfil y Objetivo',
      'workouts': 'Entrenamientos',
      'ai_scanner': 'Escáner IA',
      'booking': 'Reservas',
      'wearables': 'Dispositivos',
      'select_muscle': 'Selecciona el grupo muscular',
      'abs': 'Abdominales',
      'legs': 'Piernas',
      'chest': 'Pecho',
      'back': 'Espalda',
      'shoulders': 'Hombros',
      'arms': 'Brazos',
      'scan_button': 'Escanear comida y macros',
      'dream_target': 'Cuerpo Ideal Target',
      'bmr_calc': 'Tasa Metabólica Basal (BMR)',
      'book_now': 'Reservar',
      'sync_watch': 'Sincronizar reloj',
    }
  };

  static String getText(String languageCode, String key) {
    return _localizedValues[languageCode]?[key] ?? _localizedValues['en']![key] ?? key;
  }
}

class FitVisionGlobalApp extends StatefulWidget {
  const FitVisionGlobalApp({Key? key}) : super(key: key);

  @override
  State<FitVisionGlobalApp> createState() => _FitVisionGlobalAppState();
}

class _FitVisionGlobalAppState extends State<FitVisionGlobalApp> {
  String _currentLang = 'ar';

  void _changeLanguage(String langCode) {
    setState(() {
      _currentLang = langCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitVision | Rg apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFFA3E635),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFA3E635),
          secondary: Color(0xFF38BDF8),
        ),
      ),
      home: MainDashboardScreen(
        currentLang: _currentLang,
        onLangChange: _changeLanguage,
      ),
    );
  }
}

class MainDashboardScreen extends StatefulWidget {
  final String currentLang;
  final Function(String) onLangChange;

  const MainDashboardScreen({
    Key? key,
    required this.currentLang,
    required this.onLangChange,
  }) : super(key: key);

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      ProfileAndDreamGoalWidget(lang: widget.currentLang),
      MuscleWorkoutsWidget(lang: widget.currentLang),
      AIFoodScannerWidget(lang: widget.currentLang),
      GymBookingWidget(lang: widget.currentLang),
      WearablesWidget(lang: widget.currentLang),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.getText(widget.currentLang, 'app_title')),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.g_translate, color: Color(0xFFA3E635)),
            onSelected: widget.onLangChange,
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'ar', child: Text('العربية')),
              PopupMenuItem(value: 'en', child: Text('English')),
              PopupMenuItem(value: 'fr', child: Text('Français')),
              PopupMenuItem(value: 'es', child: Text('Español')),
            ],
          ),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFA3E635),
        unselectedItemColor: const Color(0xFF64748B),
        backgroundColor: const Color(0xFF1E293B),
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppTranslations.getText(widget.currentLang, 'profile'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fitness_center),
            label: AppTranslations.getText(widget.currentLang, 'workouts'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.camera_alt),
            label: AppTranslations.getText(widget.currentLang, 'ai_scanner'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month),
            label: AppTranslations.getText(widget.currentLang, 'booking'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.watch),
            label: AppTranslations.getText(widget.currentLang, 'wearables'),
          ),
        ],
      ),
    );
  }
}

class MuscleWorkoutsWidget extends StatelessWidget {
  final String lang;
  const MuscleWorkoutsWidget({Key? key, required this.lang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final muscleGroups = [
      {'key': 'abs', 'icon': Icons.fitness_center, 'color': const Color(0xFFF59E0B)},
      {'key': 'legs', 'icon': Icons.directions_run, 'color': const Color(0xFF38BDF8)},
      {'key': 'chest', 'icon': Icons.sports_gymnastics, 'color': const Color(0xFFEF4444)},
      {'key': 'back', 'icon': Icons.accessibility_new, 'color': const Color(0xFF10B981)},
      {'key': 'shoulders', 'icon': Icons.accessibility, 'color': const Color(0xFF8B5CF6)},
      {'key': 'arms', 'icon': Icons.sports_mma, 'color': const Color(0xFFEC4899)},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTranslations.getText(lang, 'select_muscle'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFA3E635)),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: muscleGroups.length,
              itemBuilder: (context, index) {
                final item = muscleGroups[index];
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: item['color'] as Color, width: 1.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item['icon'] as IconData, size: 40, color: item['color'] as Color),
                      const SizedBox(height: 10),
                      Text(
                        AppTranslations.getText(lang, item['key'] as String),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ProfileAndDreamGoalWidget extends StatelessWidget {
  final String lang;
  const ProfileAndDreamGoalWidget({Key? key, required this.lang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTranslations.getText(lang, 'dream_target'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFA3E635)),
          ),
          const SizedBox(height: 10),
          Card(
            color: const Color(0xFF1E293B),
            child: ListTile(
              leading: const Icon(Icons.star, color: Color(0xFFA3E635)),
              title: Text(AppTranslations.getText(lang, 'bmr_calc') + ": 1,850 kcal"),
              subtitle: const Text("Rg apps Target Physique Tracker"),
            ),
          ),
        ],
      ),
    );
  }
}

class AIFoodScannerWidget extends StatelessWidget {
  final String lang;
  const AIFoodScannerWidget({Key? key, required this.lang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.camera_alt),
        label: Text(AppTranslations.getText(lang, 'scan_button')),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA3E635),
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}

class GymBookingWidget extends StatelessWidget {
  final String lang;
  const GymBookingWidget({Key? key, required this.lang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppTranslations.getText(lang, 'booking'),
        style: const TextStyle(fontSize: 18, color: Color(0xFF38BDF8)),
      ),
    );
  }
}

class WearablesWidget extends StatelessWidget {
  final String lang;
  const WearablesWidget({Key? key, required this.lang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF38BDF8)),
        child: Text(AppTranslations.getText(lang, 'sync_watch')),
      ),
    );
  }
}
