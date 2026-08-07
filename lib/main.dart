import 'package:flutter/material.dart';

void main() {
  runApp(const FitVisionApp());
}

class FitVisionApp extends StatelessWidget {
  const FitVisionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitVision AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.cyanAccent,
          surface: Color(0xFF1E1E1E),
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}

// -------------------------------------------------------------
// 1. ONBOARDING SCREEN
// -------------------------------------------------------------
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Smart AI Workout Assistant',
      'subtitle': 'Personalized AI guidance tailored to your body and fitness goals.',
      'icon': 'auto_awesome',
    },
    {
      'title': 'Equipment & Home Routines',
      'subtitle': 'Discover real exercises with or without gym equipment.',
      'icon': 'fitness_center',
    },
    {
      'title': 'Find Nearby Gyms',
      'subtitle': 'Locate real fitness centers near you and reserve your sessions.',
      'icon': 'map',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              final item = _onboardingData[index];
              IconData iconData = Icons.auto_awesome;
              if (item['icon'] == 'fitness_center') iconData = Icons.fitness_center;
              if (item['icon'] == 'map') iconData = Icons.map;

              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blueAccent.withOpacity(0.15),
                      child: Icon(iconData, size: 70, color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      item['title']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      item['subtitle']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.blueAccent : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (_currentPage == _onboardingData.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const AuthScreen()),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    _currentPage == _onboardingData.length - 1 ? 'GET STARTED' : 'CONTINUE',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

// -------------------------------------------------------------
// 2. AUTHENTICATION SCREEN (LOGIN / REGISTER)
// -------------------------------------------------------------
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  void _submit() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Login to FitVision' : 'Create Account')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.lock_outline, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 30),
              if (!isLogin) ...[
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: _submit,
                child: Text(isLogin ? 'LOG IN' : 'REGISTER NOW'),
              ),
              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(isLogin
                    ? "Don't have an account? Register"
                    : 'Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 3. MAIN NAVIGATION SCREEN
// -------------------------------------------------------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    WorkoutsScreen(),
    GymSearchScreen(),
    ProfileAndSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Gym Finder'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 4. WORKOUTS & REAL EXERCISES SCREEN (EQUIPMENT vs NO EQUIPMENT)
// -------------------------------------------------------------
class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> exercises = [
    {
      'title': 'Push-Ups',
      'muscle': 'Chest & Triceps',
      'equipment': false,
      'description': 'Classic bodyweight movement for upper body power.',
      'steps': ['Keep hands shoulder-width apart.', 'Lower body until chest almost touches floor.', 'Push back up smoothly.']
    },
    {
      'title': 'Dumbbell Bench Press',
      'muscle': 'Chest',
      'equipment': true,
      'description': 'Targeted pectoral growth using dumbbells.',
      'steps': ['Lie flat on bench holding dumbbells.', 'Press weights upward over chest.', 'Lower slowly with control.']
    },
    {
      'title': 'Bodyweight Squats',
      'muscle': 'Legs',
      'equipment': false,
      'description': 'Fundamental lower body strength exercise.',
      'steps': ['Stand feet hip-width apart.', 'Bend knees and sit back like on a chair.', 'Keep chest upright and return.']
    },
    {
      'title': 'Barbell Deadlift',
      'muscle': 'Back & Legs',
      'equipment': true,
      'description': 'Full body compound lift for maximum strength.',
      'steps': ['Stand with feet under barbell.', 'Hinge hips back and grip bar.', 'Drive through heels to stand straight.']
    },
    {
      'title': 'Plank Hold',
      'muscle': 'Abs',
      'equipment': false,
      'description': 'Isometric core stability and abdominal strength.',
      'steps': ['Hold forearm plank position.', 'Keep body straight from head to heels.', 'Engage core for 45-60 seconds.']
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredExercises = exercises.where((ex) {
      if (selectedFilter == 'Equipment') return ex['equipment'] == true;
      if (selectedFilter == 'No Equipment') return ex['equipment'] == false;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('FitVision Exercises')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['All', 'Equipment', 'No Equipment'].map((filter) {
                final isSelected = selectedFilter == filter;
                return ChoiceChip(
                  label: Text(filter),
                  selected: isSelected,
                  selectedColor: Colors.blueAccent,
                  onSelected: (val) => setState(() => selectedFilter = filter),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredExercises.length,
              itemBuilder: (context, index) {
                final ex = filteredExercises[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: ex['equipment'] ? Colors.orangeAccent : Colors.greenAccent,
                      child: Icon(ex['equipment'] ? Icons.fitness_center : Icons.accessibility_new, color: Colors.black),
                    ),
                    title: Text(ex['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${ex['muscle']} • ${ex['equipment'] ? "Gym Equipment" : "Bodyweight"}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseDetailScreen(exercise: ex),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> exercise;
  const ExerciseDetailScreen({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> steps = List<String>.from(exercise['steps']);

    return Scaffold(
      appBar: AppBar(title: Text(exercise['title'])),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              label: Text(exercise['equipment'] ? 'Requires Equipment' : 'No Equipment Needed'),
              backgroundColor: exercise['equipment'] ? Colors.orange.withOpacity(0.2) : Colors.green.withOpacity(0.2),
            ),
            const SizedBox(height: 16),
            Text(exercise['description'], style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 24),
            const Text('Instructions:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...steps.map((step) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.blueAccent, size: 20),
                      const SizedBox(width: 10),
                      Expanded(child: Text(step, style: const TextStyle(fontSize: 15))),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 5. GYM SEARCH & MAP RESERVATIONS SCREEN
// -------------------------------------------------------------
class GymSearchScreen extends StatefulWidget {
  const GymSearchScreen({Key? key}) : super(key: key);

  @override
  State<GymSearchScreen> createState() => _GymSearchScreenState();
}

class _GymSearchScreenState extends State<GymSearchScreen> {
  final List<Map<String, String>> gyms = [
    {'name': 'Olympic Power Gym', 'city': 'City Center', 'rating': '4.9 ★', 'distance': '1.2 km'},
    {'name': 'Fitness First Club', 'city': 'North District', 'rating': '4.7 ★', 'distance': '2.5 km'},
    {'name': 'Iron Paradise Gym', 'city': 'West Park', 'rating': '4.8 ★', 'distance': '3.8 km'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find & Book Gyms')),
      body: Column(
        children: [
          Container(
            height: 140,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade900,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 40, color: Colors.blueAccent),
                  SizedBox(height: 8),
                  Text('Map Location View Active', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Showing Gyms Nearby', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search gym name or area...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: gyms.length,
              itemBuilder: (context, index) {
                final gym = gyms[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.storefront, color: Colors.cyanAccent),
                    title: Text(gym['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${gym['city']} • ${gym['distance']}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Reserved session at ${gym['name']}!')),
                        );
                      },
                      child: const Text('Book'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 6. PROFILE, FITNESS GOALS & APP CONTROL / FEEDBACK SETTINGS
// -------------------------------------------------------------
class ProfileAndSettingsScreen extends StatefulWidget {
  const ProfileAndSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileAndSettingsScreen> createState() => _ProfileAndSettingsScreenState();
}

class _ProfileAndSettingsScreenState extends State<ProfileAndSettingsScreen> {
  final _weightController = TextEditingController(text: '75');
  final _heightController = TextEditingController(text: '178');
  String _selectedGoal = 'Weight Loss';
  final _feedbackController = TextEditingController();

  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Error / Feedback'),
        content: TextField(
          controller: _feedbackController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Describe issue or app feedback here...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feedback submitted to developers!')),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & App Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const ListTile(
            leading: CircleAvatar(radius: 30, child: Icon(Icons.person, size: 36)),
            title: Text('FitVision Athlete', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('Premium Member'),
          ),
          const Divider(height: 30),
          const Text('Fitness Profile & Goals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedGoal,
            decoration: const InputDecoration(labelText: 'Fitness Goal', border: OutlineInputBorder()),
            items: ['Weight Loss', 'Muscle Gain', 'Endurance & Cardio', 'General Fitness']
                .map((goal) => DropdownMenuItem(value: goal, child: Text(goal)))
                .toList(),
            onChanged: (val) => setState(() => _selectedGoal = val!),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Body statistics & goals updated!')),
              );
            },
            child: const Text('SAVE GOALS'),
          ),
          const Divider(height: 40),
          const Text('App Controls & Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.star_rate, color: Colors.amber),
            title: const Text('Rate FitVision App'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you for rating 5 stars!')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bug_report, color: Colors.redAccent),
            title: const Text('Report an Error / Send Message'),
            onTap: _showFeedbackDialog,
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.grey),
            title: const Text('App Version'),
            subtitle: const Text('v2.4.0 (Latest Release)'),
          ),
        ],
      ),
    );
  }
}
