import 'package:flutter/material.dart';
import 'hint_1.dart';
import 'game_screen_3.dart';

class GameScreen2 extends StatefulWidget {
  final bool chestWasOpened;
  final bool hasHint;
  const GameScreen2({Key? key, required this.chestWasOpened, required this.hasHint}) : super(key: key);

  @override
  _GameScreen2State createState() => _GameScreen2State();
}

class _GameScreen2State extends State<GameScreen2> {
  bool _isHoveringLeft = false;
  bool _isHoveringRight = false;
  late bool chestOpened;

  @override
  void initState() {
    super.initState();
    chestOpened = widget.chestWasOpened;
  }
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
    required void Function(bool) setHover,
    required VoidCallback onPressed,
    String? label,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setHover(true),
      onExit: (_) => setHover(false),
      child: Column(
        children: [
          ElevatedButton(
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
          if (label != null)
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
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
              'assets/image/game_screen-junction1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.1,
            bottom: MediaQuery.of(context).size.height * 0.4,
            child: _styledButton(
              icon: Icons.arrow_back,
              isHovering: _isHoveringLeft,
              setHover: (val) => setState(() => _isHoveringLeft = val),
              onPressed: () => _navigate(context, GameScreen3(chestWasOpened: widget.chestWasOpened,hasHint: widget.hasHint),),
              label: "Correct path",
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.1,
            bottom: MediaQuery.of(context).size.height * 0.4,
            child: _styledButton(
              icon: Icons.arrow_forward,
              isHovering: _isHoveringRight,
              setHover: (val) => setState(() => _isHoveringRight = val),
              onPressed: () => _navigate(context, GameHint1()),
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
                "According to map, Left seems to be the correct path, but going right seems to have something there..",
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
