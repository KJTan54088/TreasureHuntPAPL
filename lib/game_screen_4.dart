
import 'package:flutter/material.dart';
import 'game_screen_1.dart';
import 'game_screen_5.dart';
import 'game_screen_3.dart';

class GameScreen4 extends StatefulWidget {
  final bool hasHint;
  final bool chestWasOpened;
  GameScreen4({required this.hasHint, required this.chestWasOpened});

  @override
  _GameScreen4State createState() => _GameScreen4State();
}

class _GameScreen4State extends State<GameScreen4> {
  bool _isHoveringLeft = false;
  bool _isHoveringRight = false;
  bool _isHoveringBack = false;

  void _navigate(BuildContext context, Widget screen) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => screen,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Widget _styledButton({
    required IconData icon,
    required bool isHovering,
    required Function(bool) setHover,
    required VoidCallback onPressed,
    String? label,
  }) {
    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setHover(true),
          onExit: (_) => setHover(false),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(16),
              backgroundColor: isHovering ? Colors.white : Colors.white70,
              shadowColor: Colors.black,
              elevation: 6,
            ),
            child: Icon(icon, size: 40, color: Colors.black),
          ),
        ),
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(label, style: TextStyle(color: Colors.white)),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final showHintText = widget.hasHint;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/fork_road.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            left: screenSize.width * 0.11,
            bottom: screenSize.height * 0.68,
            child: _styledButton(
              icon: Icons.turn_left,
              isHovering: _isHoveringLeft,
              setHover: (val) => setState(() => _isHoveringLeft = val),
              onPressed: () => _navigate(context, GameScreen5()),
              label: showHintText ? "Correct path" : null,
            ),
          ),

          Positioned(
            left: screenSize.width * 0.72,
            bottom: screenSize.height * 0.75,
            child: _styledButton(
              icon: Icons.turn_right,
              isHovering: _isHoveringRight,
              setHover: (val) => setState(() => _isHoveringRight = val),
              onPressed: () => _navigate(context, GameScreen1(previousScreen: 'Screen4')),
            ),
          ),

          // Return Button (to screen 3)
          Positioned(
            bottom: screenSize.height * 0.12,
            left: screenSize.width * 0.57,
            child: _styledButton(
              icon: Icons.undo,
              isHovering: _isHoveringBack,
              setHover: (val) => setState(() => _isHoveringBack = val),
              onPressed: () => _navigate(context, GameScreen3(hasHint: widget.hasHint, chestWasOpened: true)),
            ),
          ),

          // Bottom text
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(102),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                showHintText
                    ? "Note obtained says when in doubt, go left."
                    : "Which way should I go? Map did not mention this.. Maybe there is a hint somewhere?",
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
