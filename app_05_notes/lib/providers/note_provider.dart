import 'package:app_05_notes/db/note_db.dart';
import 'package:app_05_notes/models/note.dart';
import 'package:flutter/material.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> notes = [];
  final NoteDb _db = NoteDb();

  NoteDb get db => _db;

  NoteProvider() {
    init();
  }

  Future<void> init() async {
    await _db.init();
    await fetchNotes();
  }

  // Fetch All Notes
  Future<void> fetchNotes() async {
    notes = await db.allNotes();
    notifyListeners();
  }

  // Create Note
  Future<void> createNote(String title, String content) async {
    Note newNote = Note()
      ..title = title
      ..content = content;
    await _db.createNote(newNote);
    await fetchNotes();
  }

  // Update Note
  Future<void> updateNote(Note note) async {
    await _db.updateNote(note);
    await fetchNotes();
  }

  // Delete Note
  Future<void> deleteNote(Note note) async {
    await _db.deleteNote(note);
    await fetchNotes();
  }
}
