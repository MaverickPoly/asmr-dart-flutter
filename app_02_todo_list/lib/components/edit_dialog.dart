import 'package:app_02_todo_list/models/todo.dart';
import 'package:app_02_todo_list/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDialog extends StatelessWidget {
  final Todo todo;
  const EditDialog({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: todo.title);

    void handleSave() {
      if (controller.text.isEmpty) return;
      todo.title = controller.text;
      Provider.of<TodoProvider>(context, listen: false).updateTodo(todo);
      controller.clear();
      Navigator.of(context).pop();
    }

    return AlertDialog(
      title: Text("Edit Todo"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primaryFixed.withAlpha(100),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: handleSave,
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          child: Text("Save"),
        ),
        OutlinedButton(
          onPressed: Navigator.of(context).pop,
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          child: Text("Cancel"),
        ),
      ],
    );
  }
}
