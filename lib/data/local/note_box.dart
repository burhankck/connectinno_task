import 'package:hive/hive.dart';
import 'note/model/note_model.dart';

class NoteBox {
  static const String boxName = "notes";

  static Future<void> openBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<Note>(boxName);
    }
  }

  static Box<Note> getBox() => Hive.box<Note>(boxName);
}
