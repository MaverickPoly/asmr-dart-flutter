import 'package:app_02_todo_list/components/add_dialog.dart';
import 'package:app_02_todo_list/components/todo_tile.dart';
import 'package:app_02_todo_list/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void openAddDialog() {
    showDialog(context: context, builder: (context) => AddDialog());
  }

  @override
  void initState() {
    Provider.of<TodoProvider>(context, listen: false).loadTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodoProvider>(context).todos;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return TodoTile(todo: todo);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddDialog,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
