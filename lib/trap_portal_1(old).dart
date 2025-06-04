

import 'package:flutter/material.dart';
import 'game_screen_1.dart';

class TrapPortal1 extends StatefulWidget {
  const TrapPortal1({super.key});

  @override
  State<TrapPortal1> createState() => _TrapPortal1State();
}

class _TrapPortal1State extends State<TrapPortal1>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _startFadeOut = false;

  String text = "You found a portal and were mesmerized by it. "
      "An unknown energy pulled you closer and closer, "
      "and finally, you walked into the portal...";

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _goToNextScreen() async {
    setState(() {
      _startFadeOut = true;
    });
    await _fadeController.reverse();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => GameScreen1()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _goToNextScreen,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/image/portal1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _fadeController,
                builder: (context, child) {
                return Container(
                  color: Colors.black.withAlpha(
                    ((_startFadeOut ? _fadeAnimation.value : 1.0 - _fadeAnimation.value) * 255).toInt(),
                  ),
                );
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 26,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    height: 1.4,
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
