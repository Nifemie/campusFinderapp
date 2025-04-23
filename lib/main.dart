import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_step1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Optional: Hides the debug banner
      home: WelcomeScreen(),
      routes: {
        '/signup-step1': (context) => const SignUpStep1(),
      },

// Your WelcomeScreen is set as the home screen
    );

  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Color(0xFFBEC70C)),
                    SizedBox(width: 6),
                    Text(
                      'Campus Finder',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),

                // Placeholder image
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/welcome.jpg',
                      ), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                const Text(
                  'Welcome to Campus Finder',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                const Text(
                  'Discover and explore university campuses with ease. Find buildings, events, and connect with the community.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 30),

                // Icon row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Column(
                      children: [
                        Icon(Icons.search, size: 30, color: Color(0xFFBEC70C)),
                        SizedBox(height: 4),
                        Text('Search'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.map, size: 30, color: Color(0xFFBEC70C)),
                        SizedBox(height: 4),
                        Text('Maps'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.people, size: 30, color: Color(0xFFBEC70C)),
                        SizedBox(height: 4),
                        Text('Community'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 80),

                // Get Started Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lime,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(color: Colors.white),
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
