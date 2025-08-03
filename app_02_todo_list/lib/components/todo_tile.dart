import 'package:app_02_todo_list/components/edit_dialog.dart';
import 'package:app_02_todo_list/models/todo.dart';
import 'package:app_02_todo_list/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    void onChanged() {
      Provider.of<TodoProvider>(context, listen: false).toggleTodo(todo);
    }

    void handleDelete() {
      Provider.of<TodoProvider>(context, listen: false).deleteTodo(todo);
    }

    void handleUpdate() {
      showDialog(
        context: context,
        builder: (context) => EditDialog(todo: todo),
      );
    }

    return GestureDetector(
      onTap: onChanged,
      child: Padding(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withAlpha(150),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: todo.completed,
                    onChanged: (_) => onChanged(),
                  ),
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      decoration: todo.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),

              PopupMenuButton(
                icon: Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == "update") {
                    handleUpdate();
                  } else if (value == "delete") {
                    handleDelete();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "delete",
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 5),
                        Text("Delete"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: "update",
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 5),
                        Text("Update"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
