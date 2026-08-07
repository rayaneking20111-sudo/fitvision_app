import 'package:flutter/material.dart';

void main() {
  runApp(const FitVisionApp());
}

class FitVisionApp extends StatelessWidget {
  const FitVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fit AI App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        primaryColor: Colors.redAccent,
        colorScheme: const ColorScheme.dark(
          primary: Colors.redAccent,
          secondary: Colors.red,
          surface: Color(0xFF1E1E1E),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    WorkoutsScreen(),
    FoodAiScannerScreen(),
    SleepTrackerScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF181818),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'AI Scanner'),
          BottomNavigationBarItem(icon: Icon(Icons.bedtime), label: 'Sleep Tracker'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ------------------- 1. WORKOUTS SCREEN WITH ANIMATIONS -------------------
class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  final List<Map<String, String>> exercises = const [
    {
      'title': 'Push-Ups',
      'subtitle': 'Chest & Triceps • Bodyweight',
      'gif': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExM3ZpdXo3eXB1eDV4OHF3MnRmMHNvZHFuZnBuaHFpcnlsbWZvZ2Y3ZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/uR0I8N61pB58k/giphy.gif',
    },
    {
      'title': 'Bodyweight Squats',
      'subtitle': 'Legs & Glutes • Bodyweight',
      'gif': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbnZneHZyc3h0OGY0MnJybXg5eW0yMnIxbWdvanp3N3ltbnQ4dnBvaCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7TKRBB3E7vh8NL3y/giphy.gif',
    },
    {
      'title': 'Plank Hold',
      'subtitle': 'Abs & Core • Endurance',
      'gif': 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbWg1OTNoc2N3M3JmNXF5Z3pzcXpmdm1xYnpvZms0bmY0dmZ2OHdyaCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l3vR1oraYIalJThTO/giphy.gif',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FitVision Workouts'), backgroundColor: const Color(0xFF181818)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final item = exercises[index];
          return Card(
            color: const Color(0xFF1E1E1E),
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item['gif']!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) => const Icon(Icons.fitness_center, size: 50, color: Colors.redAccent),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 6),
                        Text(item['subtitle']!, style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.redAccent, size: 18),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ------------------- 2. AI FOOD SCANNER SCREEN -------------------
class FoodAiScannerScreen extends StatelessWidget {
  const FoodAiScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Meal & Nutrition Scanner'), backgroundColor: const Color(0xFF181818)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_a_photo, size: 60, color: Colors.redAccent),
                  SizedBox(height: 12),
                  Text('Take or Upload Food Photo', style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: 4),
                  Text('AI will instantly calculate Calories, Protein & Vitamins', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.camera),
              label: const Text('Scan Meal Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- 3. SLEEP TRACKER SCREEN -------------------
class SleepTrackerScreen extends StatelessWidget {
  const SleepTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sleep Tracker'), backgroundColor: const Color(0xFF181818)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              color: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Last Night Sleep', style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 8),
                        Text('7h 45m', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                    Icon(Icons.nightlight_round, size: 48, color: Colors.purpleAccent),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- 4. PROFILE SCREEN (FIXED BUTTON TEXT) -------------------
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & App Settings'), backgroundColor: const Color(0xFF181818)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: CircleAvatar(backgroundColor: Colors.redAccent, child: Icon(Icons.person, color: Colors.white)),
              title: Text('FitVision Athlete', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text('Premium Member', style: TextStyle(color: Colors.redAccent)),
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder()),
              controller: TextEditingController(text: '52'),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder()),
              controller: TextEditingController(text: '169'),
            ),
            const SizedBox(height: 24),
            // FIXED BUTTON WITH VISIBLE TEXT
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Body statistics & goals updated!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Profile Settings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
