import 'package:app_05_notes/components/my_drawer.dart';
import 'package:app_05_notes/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> handleCreate() async {
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Note title or content is missing!")),
      );
      return;
    }

    await Provider.of<NoteProvider>(
      context,
      listen: false,
    ).createNote(titleController.text, contentController.text);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Note created successfully!")));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text("Create Todo")),
        drawer: MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Title",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: contentController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: "Content",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: handleCreate,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Create",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
