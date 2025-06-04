import 'dart:async';
import 'package:flutter/material.dart';
import 'introduction.dart';

class GameEnd extends StatefulWidget {
  const GameEnd({super.key});

  @override
  _GameEndState createState() => _GameEndState();
}

class _GameEndState extends State<GameEnd> {
  final String fullText = 
      "You have found the treasure chest. Using the key obtained from the other treasure chest, you opened the chest. In it, you found a ball that grants wishes. However, it is only part of a collection. And you embark into another journey and begins your adventure.\n\nDo you want to start a new game?";

  String _displayedText = "";
  int _charIndex = 0;
  bool _isTyping = false;
  bool _showPrompt = false;
  Timer? _typeTimer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _isTyping = true;
    _charIndex = 0;
    _displayedText = "";
    _typeTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_charIndex < fullText.length) {
        setState(() {
          _displayedText += fullText[_charIndex];
          _charIndex++;
        });
      } else {
        _typeTimer?.cancel();
        _isTyping = false;
        setState(() {
          _showPrompt = true;
        });
      }
    });
  }

  void _completeText() {
    _typeTimer?.cancel();
    setState(() {
      _displayedText = fullText;
      _isTyping = false;
      _showPrompt = true;
    });
  }

  void _handleTap() {
    if (_isTyping) {
      _completeText();
    } else if (_showPrompt) {
      // Start new game
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1200),
          pageBuilder: (context, animation, secondaryAnimation) => IntroScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: Container(color: Colors.black, child: child),
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _typeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _handleTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/image/chest.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  _displayedText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'BlackBeard',
                    fontSize: 32,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black87,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}