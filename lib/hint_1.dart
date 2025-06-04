import 'package:flutter/material.dart';
import 'game_screen_2.dart';

class GameHint1 extends StatefulWidget {
  @override
  _GameHint1State createState() => _GameHint1State();
}

class _GameHint1State extends State<GameHint1> {
  bool _isHoveringBack = false;
  bool hasHint = false;
  bool _isHoveringSpot = false;

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
              'assets/image/not_dead_end.jpg',
              fit: BoxFit.cover,
            ),
          ),

          if (!hasHint)
            Positioned(
              left: screenSize.width * 0.65,
              top: screenSize.height * 0.5,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    hasHint = true;
                  });
                },
                child: AnimatedOpacity(
                  opacity: _isHoveringSpot ? 0.2 : 1.0,
                  duration: Duration(milliseconds: 500),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => setState(() => _isHoveringSpot = true),
                    onExit: (_) => setState(() => _isHoveringSpot = false),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.white70, blurRadius: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          if (hasHint)
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
                  "You have obtained a hint.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          if (!hasHint)
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
                  "Something seems to be glittering..",
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
            bottom: MediaQuery.of(context).size.height * 0.9,
            left: MediaQuery.of(context).size.width * 0.43,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isHoveringBack = true),
              onExit: (_) => setState(() => _isHoveringBack = false),
              child: ElevatedButton(
                onPressed: () => _navigate(context, GameScreen2(chestWasOpened: false,hasHint:hasHint)),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                  backgroundColor:
                      _isHoveringBack ? Colors.white : Colors.white70,
                  shadowColor: Colors.black,
                  elevation: 6,
                ),
                child: Icon(Icons.undo, size: 40, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
