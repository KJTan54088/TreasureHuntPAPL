
import 'package:flutter/material.dart';
import 'game_screen_10.dart'; // Ensure this file exists and contains GameScreen10

class GameScreen9 extends StatefulWidget {
  @override
  _GameScreen9State createState() => _GameScreen9State();
}

class _GameScreen9State extends State<GameScreen9> {
  int stabCount = 0;
  bool snakeDefeated = false;

  void _stabSnake() {
    setState(() {
      stabCount++;
      if (stabCount >= 5) {
        snakeDefeated = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/giant_snake_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          if (!snakeDefeated)
            Center(
              child: MouseRegion(
                cursor: SystemMouseCursors.precise,
                child: GestureDetector(
                  onTap: _stabSnake,
                  child: Image.asset(
                    'assets/image/giant_snake.png',
                    width: 400,
                  ),
                ),
              ),
            ),
          if (snakeDefeated)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.2,
              right: MediaQuery.of(context).size.width * 0.45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.white70,
                ),
                child: const Icon(Icons.arrow_upward, size: 40, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 800),
                      pageBuilder: (_, __, ___) => GameScreen10(),
                      transitionsBuilder: (_, animation, __, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  );
                },
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
              child: Text(
                snakeDefeated
                    ? "The snake has been defeated. You may proceed."
                    : "Click the snake to stab it. You need 5 hits to defeat it.",
                style: const TextStyle(
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
