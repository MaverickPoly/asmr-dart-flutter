import 'package:hive_flutter/hive_flutter.dart';

part "todo.g.dart";

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool completed;

  Todo({required this.title, this.completed = false});
}
