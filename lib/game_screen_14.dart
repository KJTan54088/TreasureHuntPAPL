
import 'package:flutter/material.dart';
import 'trap_monster2.dart';
import 'trap_heaven.dart';
import 'game_end.dart';

class GameScreen14 extends StatelessWidget {
  const GameScreen14({super.key});

  void _navigate(BuildContext context, Widget screen) {
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
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/last_crossroad.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: screenSize.height * 0.2,
            left: screenSize.width * 0.1,
            child: ElevatedButton(
              onPressed: () => _navigate(context, TrapMonster2Screen()),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white70,
              ),
              child: const Icon(Icons.arrow_back, size: 40, color: Colors.black),
            ),
          ),
          Positioned(
            bottom: screenSize.height * 0.2,
            right: screenSize.width * 0.1,
            child: ElevatedButton(
              onPressed: () => _navigate(context, const TrapHeavenScreen()),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white70,
              ),
              child: const Icon(Icons.arrow_forward, size: 40, color: Colors.black),
            ),
          ),
          Positioned(
            bottom: screenSize.height * 0.35,
            left: screenSize.width / 2 - 30,
            child: ElevatedButton(
              onPressed: () => _navigate(context, const GameEnd()),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white70,
              ),
              child: const Icon(Icons.arrow_upward, size: 40, color: Colors.black),
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
                "Cross road again..",
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
