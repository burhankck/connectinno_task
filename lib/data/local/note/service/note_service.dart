import 'package:hive/hive.dart';
import '../model/note_model.dart';

class NoteService {
  final Box<Note> _noteBox = Hive.box<Note>('notes');

  // CREATE / ADD
  Future<void> addNote(Note note) async {
    await _noteBox.put(note.id, note);
  }

  // READ / LIST
  List<Note> getNotes() {
    return _noteBox.values.toList();
  }

  // UPDATE
  Future<void> updateNote(Note note) async {
    await _noteBox.put(note.id, note);
  }

  // DELETE
  Future<void> deleteNote(String id) async {
    await _noteBox.delete(id);
  }

  // PIN TOGGLE
  Future<void> togglePin(String id) async {
    final note = _noteBox.get(id);
    if (note != null) {
      note.isPinned = !note.isPinned;
      await note.save();
    }
  }

  // CLEAR ALL (opsiyonel)
  Future<void> clearAll() async {
    await _noteBox.clear();
  }
}

