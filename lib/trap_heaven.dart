
import 'package:flutter/material.dart';
import 'introduction.dart';
import 'main.dart';

class TrapHeavenScreen extends StatelessWidget {
  const TrapHeavenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/near_end_game_over.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(102),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "I am tired, I am seeing light, please guide me the path to you..",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
           Positioned(
            bottom: 120,
            left: MediaQuery.of(context).size.width * 0.25,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => IntroScreen()),
                );
              },
              child: Text("Start a new game"),
            ),
          ),
          Positioned(
            bottom: 120,
            right: MediaQuery.of(context).size.width * 0.25,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => GameStartScreen()),
                );
              },
              child: Text("Go back to main screen"),
            ),
          ),
        ],
      ),
    );
  }
}
