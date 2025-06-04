import 'package:flutter/material.dart';
import 'game_screen_2.dart';

class GameScreen1 extends StatefulWidget {
  final String? previousScreen;   
  const GameScreen1({Key? key, this.previousScreen}) : super(key: key);
  @override
  _GameScreen1State createState() => _GameScreen1State();
}

class _GameScreen1State extends State<GameScreen1> {
  bool _isHovering = false;

  void _onPathTap(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => GameScreen2(chestWasOpened: false, hasHint: false),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: Duration(milliseconds: 1200),
      ),
    );
  }

  String _getInstructionText() {
    switch (widget.previousScreen) {
      case 'IntroScreen':
        return "Following the treasure map, you entered the forest. Click the button to move forward";
      case 'Screen4':
        return "looks like i am back again";
      default:
        return "Following the treasure map, you entered the forest. Click the button to move forward";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/image/game_screen-straight.jpg',
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              left: screenSize.width * 0.475,
              bottom: screenSize.height * 0.28,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isHovering = true),
                onExit: (_) => setState(() => _isHovering = false),
                child: ElevatedButton(
                  onPressed: () => _onPathTap(context),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                    backgroundColor: _isHovering ? Colors.white : Colors.white70,
                    shadowColor: Colors.black,
                    elevation: 6,
                  ),
                  child: Icon(
                    Icons.arrow_upward,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

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
                  _getInstructionText(), 
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
      ),
    );
  }
}