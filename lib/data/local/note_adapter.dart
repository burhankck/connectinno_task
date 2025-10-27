
// Manuel adapter
import 'package:connectinno_task/data/local/note/model/note_model.dart';
import 'package:hive/hive.dart';

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0;

  @override
  Note read(BinaryReader reader) {
    return Note(
      id: reader.readString(),
      title: reader.readString(),
      content: reader.readString(),
      isPinned: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.content);
    writer.writeBool(obj.isPinned);
  }
}