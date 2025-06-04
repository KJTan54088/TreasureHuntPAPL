import 'package:flutter/material.dart';
import 'game_end.dart';

class TrapMonster2Screen extends StatefulWidget {
  @override
  _TrapMonster2ScreenState createState() => _TrapMonster2ScreenState();
}

class _TrapMonster2ScreenState extends State<TrapMonster2Screen>
    with SingleTickerProviderStateMixin {
  int stabCount = 0;
  bool monsterDefeated = false;
  bool hovering = false;
  double cursorX = 0;
  double cursorY = 0;
  bool isHoveringMonster = false;
  final int requiredStabs = 10;

  void _handleStab() {
    if (!monsterDefeated) {
      setState(() {
        stabCount++;
        if (stabCount >= requiredStabs) {
          monsterDefeated = true;
        }
      });
    }
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
              'assets/image/beatable_monster_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          if (!monsterDefeated)
          Align(
            alignment: Alignment.bottomCenter, 
            child: MouseRegion(
              cursor: SystemMouseCursors.none,
              onEnter: (_) => setState(() => isHoveringMonster = true),
              onExit: (_) => setState(() => isHoveringMonster = false),
              onHover: (event) => _updateCursorPosition(event.position),
              child: GestureDetector(
                onTap: _handleStab,
                child: Image.asset(
                  'assets/image/beatable_monster.png',
                  height: 800, 
                ),
              ),
            ),
          ),
          // Custom knife cursor overlay
          if (!monsterDefeated && isHoveringMonster)
            Positioned(
              left: cursorX - 5, 
              top: cursorY - 5,  
              child: IgnorePointer(
                child: Image.asset(
                  'assets/image/holding_knife.png',
                  width: 100, 
                  height: 100,
                ),
              ),
            ),
          if (monsterDefeated)
            Positioned(
              bottom: 100,
              left: MediaQuery.of(context).size.width / 2 - 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 800),
                      pageBuilder: (_, __, ___) => GameEnd(),
                      transitionsBuilder: (_, animation, __, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                  backgroundColor: Colors.white70,
                ),
                child: Icon(Icons.arrow_upward, size: 40, color: Colors.black),
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
                monsterDefeated
                    ? "The monster is defeated. You may proceed."
                    : "Click the monster to stab it. You need ${requiredStabs - stabCount} more hits to defeat it.",
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