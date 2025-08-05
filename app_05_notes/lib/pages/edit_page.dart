import 'package:app_05_notes/models/note.dart';
import 'package:app_05_notes/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final Note note;
  const EditPage({super.key, required this.note});

  @override
  State<EditPage> createState() => EditPageState();
}

class EditPageState extends State<EditPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
    super.initState();
  }

  Future<void> handleEdit() async {
    final title = titleController.text;
    final content = contentController.text;
    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Title or content is missing!")));
    }
    widget.note.title = title;
    widget.note.content = content;
    await Provider.of<NoteProvider>(
      context,
      listen: false,
    ).updateNote(widget.note);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(title: Text("Edit Note")),
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
                onTap: handleEdit,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
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
