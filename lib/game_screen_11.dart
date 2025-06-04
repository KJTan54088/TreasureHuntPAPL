
import 'package:flutter/material.dart';
import 'game_screen_12.dart';
import 'trap_monster.dart';

class GameScreen11 extends StatelessWidget {
  const GameScreen11({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => screen,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/fork2.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5,
            left: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(
              onPressed: () => _navigateTo(context, const GameScreen12()),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white70,
              ),
              child: const Icon(Icons.arrow_upward, size: 40, color: Colors.black),
            ),
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.38,
            right: MediaQuery.of(context).size.width * 0.37,
            child: ElevatedButton(
              onPressed: () => _navigateTo(context, const TrapMonsterScreen()),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white70,
              ),
              child: const Icon(Icons.arrow_upward, size: 40, color: Colors.black),
            ),
          ),

          // Bottom text
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
                "What was the hint again? The hint on the knife....",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
