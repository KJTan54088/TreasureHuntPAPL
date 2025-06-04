import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_screen_10.dart'; 

class GameScreen9 extends StatefulWidget {
  @override
  _GameScreen9State createState() => _GameScreen9State();
}

class _GameScreen9State extends State<GameScreen9> {
  int stabCount = 0;
  bool snakeDefeated = false;
  double cursorX = 0;
  double cursorY = 0;
  bool isHoveringSnake = false;

  void _stabSnake() {
    setState(() {
      stabCount++;
      if (stabCount >= 5) {
        snakeDefeated = true;
      }
    });
  }

  void _updateCursorPosition(Offset position) {
    setState(() {
      cursorX = position.dx;
      cursorY = position.dy;
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
                cursor: SystemMouseCursors.none, // Hide default cursor
                onEnter: (_) => setState(() => isHoveringSnake = true),
                onExit: (_) => setState(() => isHoveringSnake = false),
                onHover: (event) => _updateCursorPosition(event.position),
                child: GestureDetector(
                  onTap: _stabSnake,
                  child: Image.asset(
                    'assets/image/giant_snake.png',
                    width: 600,
                    fit: BoxFit.cover
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
          // Custom knife cursor overlay
          if (!snakeDefeated && isHoveringSnake)
            Positioned(
              left: cursorX - 5, 
              top: cursorY - 5,  
              child: IgnorePointer(
                child: Image.asset(
                  'assets/image/holding_knife.png',
                  width: 100, // Adjust size as needed
                  height: 100, // Adjust size as needed
                ),
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
                    : "Click the snake to stab it. You need ${5 - stabCount} more hits to defeat it.",
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