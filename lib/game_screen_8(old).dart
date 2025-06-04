import 'package:flutter/material.dart';
//import 'dart:async';
import 'trap_spike.dart';
import 'game_screen_9.dart';

class GameScreen8 extends StatefulWidget {
  final bool hasReceivedTalisman;

  const GameScreen8({super.key, required this.hasReceivedTalisman});

  @override
  State<GameScreen8> createState() => _GameScreen8State();
}

class _GameScreen8State extends State<GameScreen8> with TickerProviderStateMixin {
  bool showTalismanButton = false;
  bool pitFilled = false;
  bool showZombie = false;
  bool zombieFinished = false;
  String bottomText = "Looks like nothing is here, let's continue forward";
  late AnimationController _zombieController;
  late Animation<Offset> _zombieOffset;

  @override
  void initState() {
    super.initState();
    _zombieController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _zombieOffset = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0.3, 0),
    ).animate(
      CurvedAnimation(parent: _zombieController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _zombieController.dispose();
    super.dispose();
  }

  void _onArrowTap() {
    if (!widget.hasReceivedTalisman) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SpikeScreen()));
    } else if (!pitFilled) {
      setState(() {
        bottomText = "Wait, the talisman is reacting";
        showTalismanButton = true;
      });
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => GameScreen9()));
    }
  }

  void _useTalisman() {
    setState(() {
      showTalismanButton = false;
      showZombie = true;
    });
    _zombieController.forward().then((_) {
      setState(() {
        zombieFinished = true;
        pitFilled = true;
        bottomText = "The pit is now filled. I can move on safely.";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/pitfall_trap.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Wooden plank appears
          if (zombieFinished)
            Positioned(
              left: MediaQuery.of(context).size.width * 0.38,
              bottom: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset(
                'assets/image/wooden_prank.png',
                width: 600,
                fit: BoxFit.contain
              ),
            ),

          // Zombie animation
          if (showZombie)
            SlideTransition(
              position: _zombieOffset,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/image/zombie_shovel.png',
                  height: 300,
                  fit: BoxFit.contain
                ),
              ),
            ),

          // Arrow button (positioned height: 0.7, right: 0.2)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.7,
            right: MediaQuery.of(context).size.width * 0.2,
            child: ElevatedButton(
              onPressed: _onArrowTap,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white70,
              ),
              child: const Icon(Icons.arrow_upward, size:40, color: Colors.black),
            ),
          ),

          // Use talisman button
          if (showTalismanButton)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: ElevatedButton(
                  onPressed: _useTalisman,
                  child: const Text("Use talisman"),
                ),
              ),
            ),

          // Bottom text
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
                bottomText,
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
