import 'dart:math';
import 'package:flutter/material.dart';
import 'game_screen_7.dart';

class GameScreen6 extends StatefulWidget {
  const GameScreen6({Key? key}) : super(key: key);

  @override
  _GameScreen6State createState() => _GameScreen6State();
}

class _GameScreen6State extends State<GameScreen6> {
  final Random _random = Random();
  List<int> _diceValues = [1, 1, 1];
  bool _showArrow = false;

  void _rollDice() {
    setState(() {
      _diceValues = List.generate(3, (_) => _random.nextInt(6) + 1);
      _showArrow = _diceValues.where((value) => value == 6).length >= 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/straight_road2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _diceValues.map((value) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/image/dice/dice_$value.png',
                    width: 50,
                    height: 50,
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 140,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: ElevatedButton(
              onPressed: _rollDice,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(16),
              ),
              child: Icon(Icons.casino, size: 40),
            ),
          ),
          if (_showArrow)
            Positioned(
              bottom: 80,
              left: MediaQuery.of(context).size.width / 2 - 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => GameScreen7()),
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
                "Map says only 2 or more 6s will I be allowed to proceed further",
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
