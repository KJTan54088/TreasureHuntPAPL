
import 'package:flutter/material.dart';
import 'game_screen_8.dart';

class GameScreen7 extends StatefulWidget {
  const GameScreen7({Key? key}) : super(key: key);

  @override
  _GameScreen7State createState() => _GameScreen7State();
}

class _GameScreen7State extends State<GameScreen7> {
  bool hasReceivedTalisman = false;
  bool isHovering = false;

  void _navigateToNext() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => GameScreen8(hasReceivedTalisman:hasReceivedTalisman),
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
              'assets/image/fallen_forest.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.width * 0.4,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  hasReceivedTalisman = true;
                });
              },
              child: Image.asset(
                'assets/image/fallen_knight.png',
                width: 400,
                fit: BoxFit.contain
              ),
            ),
          ),

          // Bottom text box
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
                hasReceivedTalisman
                    ? "Received talisman and knife. On the knife writes ""After a rest, go left, right, up, up""(write it somewhere or memorize this)"
                    : "Seems like someone died here.. rest in piece bro.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Move on button
          Positioned(
            bottom: 80,
            right: MediaQuery.of(context).size.width * 0.1,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => isHovering = true),
              onExit: (_) => setState(() => isHovering = false),
              child: ElevatedButton(
                onPressed: _navigateToNext,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                  backgroundColor:
                      isHovering ? Colors.white : Colors.white70,
                  shadowColor: Colors.black,
                  elevation: 6,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
