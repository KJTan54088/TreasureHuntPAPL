
import 'package:flutter/material.dart';
import 'introduction.dart';
import 'main.dart';

class SpikeScreen extends StatefulWidget {
  @override
  _SpikeScreenState createState() => _SpikeScreenState();
}

class _SpikeScreenState extends State<SpikeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _grayScale;
  bool _showButtons = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _grayScale = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _showButtons = true;
          });
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ColorFilter _grayscaleFilter(double amount) {
    return ColorFilter.matrix(<double>[
      0.2126 + 0.7874 * (1 - amount), 0.7152 - 0.7152 * (1 - amount), 0.0722 - 0.0722 * (1 - amount), 0, 0,
      0.2126 - 0.2126 * (1 - amount), 0.7152 + 0.2848 * (1 - amount), 0.0722 - 0.0722 * (1 - amount), 0, 0,
      0.2126 - 0.2126 * (1 - amount), 0.7152 - 0.7152 * (1 - amount), 0.0722 + 0.9278 * (1 - amount), 0, 0,
      0, 0, 0, 1, 0,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _grayScale,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: ColorFiltered(
                  colorFilter: _grayscaleFilter(_grayScale.value),
                  child: Image.asset(
                    'assets/image/spikes.jpg',
                    fit: BoxFit.cover,
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
                    "You have died from falling into the pitfall trap",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              if (_showButtons)
                Positioned(
                  bottom: 120,
                  left: MediaQuery.of(context).size.width * 0.25,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => IntroScreen()),
                      );
                    },
                    child: Text("Start a new game"),
                  ),
                ),
              if (_showButtons)
                Positioned(
                  bottom: 120,
                  right: MediaQuery.of(context).size.width * 0.25,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => GameStartScreen()),
                      );
                    },
                    child: Text("Go back to main screen"),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
