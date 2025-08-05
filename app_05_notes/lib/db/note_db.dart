import 'package:app_05_notes/models/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDb {
  static final NoteDb _instance = NoteDb._internal();
  factory NoteDb() => _instance;
  NoteDb._internal();

  late Isar _isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // Get All Notes
  Future<List<Note>> allNotes() async {
    return await _isar.notes.where().findAll();
  }

  // Create Note
  Future<void> createNote(Note note) async {
    await _isar.writeTxn(() async {
      await _isar.notes.put(note);
    });
  }

  // Update Note
  Future<void> updateNote(Note note) async {
    await _isar.writeTxn(() async {
      await _isar.notes.put(note);
    });
  }

  // Delete Note
  Future<void> deleteNote(Note note) async {
    await _isar.writeTxn(() async {
      await _isar.notes.delete(note.id);
    });
  }
}
