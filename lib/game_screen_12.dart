
import 'package:flutter/material.dart';
import 'trap_monster.dart';
import 'game_screen_13.dart';

class GameScreen12 extends StatelessWidget {
  const GameScreen12({super.key});

  void _navigate(BuildContext context, Widget screen) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => screen,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
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
              'assets/image/night_cross_road2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5,
            right: MediaQuery.of(context).size.width * 0.1,
            child: ElevatedButton(
              onPressed: () => _navigate(context, const GameScreen13()),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white70,
              ),
              child: const Icon(Icons.arrow_forward, size: 40, color: Colors.black),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5,
            left: MediaQuery.of(context).size.width * 0.1,
            child: ElevatedButton(
              onPressed: () => _navigate(context, const TrapMonsterScreen()),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white70,
              ),
              child: const Icon(Icons.arrow_back, size: 40, color: Colors.black),
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
                'Another junction..',
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
