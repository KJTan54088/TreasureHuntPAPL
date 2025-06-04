
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'game_screen_6.dart';
import 'node.dart';

class GameScreen5 extends StatefulWidget {
  const GameScreen5({Key? key}) : super(key: key);

  @override
  _GameScreen5State createState() => _GameScreen5State();
}

class _GameScreen5State extends State<GameScreen5> {
  bool _isHoveringSave = false;
  bool _isHoveringNext = false;


  Future<void> _saveProgress(BuildContext context) async {
    try {
      final box = Hive.box<Node>('progressBox');
      final timestamp = DateTime.now().toIso8601String();
      final newNode = Node(screen: 'GameScreen5', timestamp: timestamp);
      await box.add(newNode);

      debugPrint("Progress saved at $timestamp");
      debugPrint("Box now has ${box.length} items");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Progress saved successfully.")),
      );
    } catch (e) {
      debugPrint("Failed to save progress: \$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save progress.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/save_point.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Save icon positioned on the bench
          Positioned(
            bottom: screenSize.height * 0.1,
            right: screenSize.width * 0.2,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isHoveringSave = true),
              onExit: (_) => setState(() => _isHoveringSave = false),
              child: IconButton(
                icon: Icon(Icons.save, size: 50, color: _isHoveringSave ? Colors.yellow : Colors.white),
                onPressed: () => _saveProgress(context),
                tooltip: 'Save Progress',
              ),
            ),
          ),

          // Arrow button to go to GameScreen6
          Positioned(
            bottom: screenSize.height * 0.6,
            left: screenSize.width * 0.38,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isHoveringNext = true),
              onExit: (_) => setState(() => _isHoveringNext = false),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 800),
                      pageBuilder: (_, __, ___) => GameScreen6(),
                      transitionsBuilder: (_, animation, __, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                  backgroundColor: _isHoveringNext ? Colors.white : Colors.white70,
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
                "Wow, a bench! I will rest and create a save point here.",
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
