import 'package:app_02_todo_list/db/todo_db.dart';
import 'package:app_02_todo_list/models/todo.dart';
import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  final TodoDB _db = TodoDB();
  List<Todo> _todos = [];

  // Getters
  TodoDB get db => _db;
  List<Todo> get todos => _todos;

  void loadTodos() {
    _todos = _db.fetchTodos();
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    Todo todo = Todo(title: title);
    await _db.addTodo(todo);
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await _db.deleteTodo(todo);
    loadTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    await _db.updateTodo(todo);
    loadTodos();
  }

  Future<void> toggleTodo(Todo todo) async {
    todo.completed = !todo.completed;
    await _db.updateTodo(todo);
    loadTodos();
  }
}
