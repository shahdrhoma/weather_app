import 'package:flutter/material.dart';
import 'homeview.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/photo_2024-11-10_17-37-51.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Centered "Get Started" button at the bottom
          Positioned(
            bottom: 100.0, // Adjust the distance from the bottom
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF323E4F),
                  backgroundColor: Colors.white.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12), // Text color
                  textStyle: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                child: const Text('Get Started'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
