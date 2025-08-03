import 'package:app_02_todo_list/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    void handleAdd() {
      if (controller.text.isEmpty) return;
      Provider.of<TodoProvider>(
        context,
        listen: false,
      ).addTodo(controller.text);
      controller.clear();
      Navigator.of(context).pop();
    }

    return AlertDialog(
      title: Text("New todo"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primaryFixed,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
          hintText: "Todo title...",
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: handleAdd,
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          child: Text("Add"),
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
