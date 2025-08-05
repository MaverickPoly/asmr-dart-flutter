import 'package:app_05_notes/models/note.dart';
import 'package:app_05_notes/pages/edit_page.dart';
import 'package:app_05_notes/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteTile extends StatefulWidget {
  final Note note;
  const NoteTile({super.key, required this.note});

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Future<void> handleDelete() async {
    await Provider.of<NoteProvider>(
      context,
      listen: false,
    ).deleteNote(widget.note);
  }

  void handleEdit() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditPage(note: widget.note)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(color: Colors.grey.shade300),
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withAlpha(20),
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 12, right: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
            title: Text(widget.note.title),
            leading: Icon(
              _isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
            ),
            trailing: PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case "delete":
                    handleDelete();
                  case "edit":
                    handleEdit();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "delete",
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 4),
                      Text("Delete"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "edit",
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 4),
                      Text("Edit"),
                    ],
                  ),
                ),
              ],
            ),
            onTap: _toggleExpanded,
          ),
          AnimatedCrossFade(
            firstChild: SizedBox.shrink(),
            secondChild: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.note.content),
                  ),
                ],
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
