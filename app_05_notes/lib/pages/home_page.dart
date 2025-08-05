import 'package:app_05_notes/components/my_drawer.dart';
import 'package:app_05_notes/components/note_tile.dart';
import 'package:app_05_notes/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NoteProvider>(context).notes;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return NoteTile(note: note);
          },
        ),
      ),
    );
  }
}
