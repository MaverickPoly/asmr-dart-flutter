import 'package:app_02_todo_list/models/todo.dart';
import 'package:hive/hive.dart';

class TodoDB {
  static const String boxName = "todo";

  static Box<Todo> get box => Hive.box<Todo>(boxName);

  // CREATE
  Future<void> addTodo(Todo todo) async {
    await box.add(todo);
  }

  // READ
  List<Todo> fetchTodos() {
    return box.values.toList();
  }

  // UPDATE
  Future<void> updateTodo(Todo todo) async {
    await todo.save();
  }

  // DELETE
  Future<void> deleteTodo(Todo todo) async {
    await todo.delete();
  }
}
