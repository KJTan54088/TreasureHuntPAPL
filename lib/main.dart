import 'package:flutter/material.dart';
import 'introduction.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'node.dart';
import 'game_screen_5.dart';
import 'game_screen_10.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // from hive_flutter package
  Hive.registerAdapter(NodeAdapter());

  if (Hive.isBoxOpen('progressBox')) {
    await Hive.box<Node>('progressBox').close();
  }

  await Hive.openBox<Node>('progressBox');

  runApp(GameStartApp());
}

class GameStartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: GameStartScreen());
  }
}

class GameStartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/start_screen.jpg',
              fit: BoxFit.cover,
            ),
          ),

          _ClickableArea(
            left: 120,
            top: 200,
            width: 350,
            height: 50,
            text: "New Adventure",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => IntroScreen()),
              );
            },
          ),

          _ClickableArea(
            left: 120,
            top: 280,
            width: 350,
            height: 50,
            text: "Load Adventure",
            onTap: () async {
                print('Reached before box open');
                final box = Hive.box<Node>('progressBox');
                print('Box opened');

                print('Box length: ${box.length}');
                print('Box isEmpty: ${box.isEmpty}');
                print('Box keys: ${box.keys.toList()}');
                
                if (box.isNotEmpty) {
                  final allSaves = box.values.toList();
                  print('All saves:');
                  for (int i = 0; i < allSaves.length; i++) {
                    print('  [$i] Screen: ${allSaves[i].screen}, Timestamp: ${allSaves[i].timestamp}');
                  }
                }
                
                final latestSave = box.values.lastOrNull;
                print('Latest save: ${latestSave?.screen ?? 'null'}');

                if (latestSave != null) {
                  debugPrint('Loading from ${latestSave.screen}');

                  Widget next;
                  switch (latestSave.screen) {
                    case 'GameScreen5':
                      next = GameScreen5();
                      break;
                    case 'GameScreen10':
                      next = GameScreen10();
                    default:
                      next = IntroScreen(); // fallback
                  }
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (_, __, ___) => next,
                      transitionsBuilder: (_, animation, __, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("No saved adventure found.")),
                );
              }
            },
          ),


        ],
      ),
    );
  }
}

class _ClickableArea extends StatefulWidget {
  final double left, top, width, height;
  final VoidCallback onTap;
  final String? text;

  const _ClickableArea({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.onTap,
    this.text
  });

  @override
  State<_ClickableArea> createState() => _ClickableAreaState();
}

class _ClickableAreaState extends State<_ClickableArea> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      width: widget.width,
      height: widget.height,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha((0.3 * 255).toInt()),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hovering ? Colors.greenAccent : Colors.lightGreen,
                width: 2,
              ),
              boxShadow: _hovering
                  ? [
                      BoxShadow(
                        color: Colors.greenAccent.withAlpha((0.6 * 255).toInt()),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: widget.text != null
              ? Text(
                    widget.text!,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'BlackBeard', // Make sure this font is in pubspec.yaml
                      color: Colors.lightGreenAccent,
                      shadows: [
                        Shadow(
                          blurRadius: _hovering ? 12 : 6,
                          color: Colors.greenAccent,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                )
              : null,
            ),
        ),
      ),
    );
  }
}
