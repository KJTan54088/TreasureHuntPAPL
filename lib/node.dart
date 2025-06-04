import 'package:hive/hive.dart';

part 'node.g.dart';

@HiveType(typeId: 0)
class Node extends HiveObject {
  @HiveField(0)
  String screen;

  @HiveField(1)
  String timestamp;

  Node({required this.screen, required this.timestamp});
}
