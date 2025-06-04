import 'dart:async';
import 'package:flutter/material.dart';
import 'game_screen_1.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final List<String> paragraphs = [
    "After a long week of employee days, where you were slaving your life off for peanuts,\n you came to the beach..",
    "Setting your eyes off into the horizon, you wished that something interesting can just happen to your life..",
    "At this moment, a bottle riding the waves hits your feet..",
    "Inside it is a treasure map...",
    "With the treausre map in hand, you travel to the island"
  ];

  final List<String> images = [
    'assets/image/game_intro/game_intro-office.png',
    'assets/image/game_intro/game_intro-beach.webp',
    'assets/image/game_intro/game_intro-bottle.jpg',
    'assets/image/game_intro/game_intro-map.jpg',
    'assets/image/game_intro/game_intro-travel.gif'
  ];

  int _currentIndex = 0;
  String _displayedText = "";
  int _charIndex = 0;
  bool _isTyping = false;
  bool _showImage = false;
  double _imageOpacity = 0.0;
  double _textOpacity = 1.0;
  Timer? _typeTimer;

  @override
  void initState() {
    super.initState();
    _startSequence();
  }

  void _startSequence() async {
    setState(() => _showImage = true);
    await Future.delayed(Duration(milliseconds: 100));
    setState(() => _imageOpacity = 1.0);
    await Future.delayed(Duration(milliseconds: 800));
    _startTyping();
  }

  void _startTyping() {
    _isTyping = true;
    _charIndex = 0;
    _displayedText = "";
    _typeTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_charIndex < paragraphs[_currentIndex].length) {
        setState(() {
          _displayedText += paragraphs[_currentIndex][_charIndex];
          _charIndex++;
        });
      } else {
        _typeTimer?.cancel();
        _isTyping = false;
      }
    });
  }

  void _completeParagraph() {
    _typeTimer?.cancel();
    setState(() {
      _displayedText = paragraphs[_currentIndex];
      _isTyping = false;
    });
  }

void _nextSequence() async {
  if (_isTyping) {
    _completeParagraph();
    return;
  }

  setState(() => _textOpacity = 0.0);
  await Future.delayed(Duration(milliseconds: 500));
  setState(() => _imageOpacity = 0.0);
  await Future.delayed(Duration(milliseconds: 500));

  if (_currentIndex < paragraphs.length - 1) {
    setState(() {
      _currentIndex++;
      _displayedText = "";
      _textOpacity = 1.0;
      _imageOpacity = 1.0;
    });
    _startTyping();
  
} else {
  setState(() {
    _textOpacity = 0.0;
    _imageOpacity = 0.0;
  });

  await Future.delayed(Duration(milliseconds: 800));

  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1200),
      pageBuilder: (context, animation, secondaryAnimation) => GameScreen1(),
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
        onTap: _nextSequence,
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: _showImage ? _imageOpacity : 0.0,
              duration: Duration(milliseconds: 800),
              child: Image.asset(
                images[_currentIndex],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Center(
              child: AnimatedOpacity(
                opacity: _textOpacity,
                duration: Duration(milliseconds: 500),
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
                            offset: Offset(2, 2)),
                      ],
                    ),
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


